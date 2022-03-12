import 'dart:async';
import 'dart:developer';
import 'dart:io';

class FileProvider {
  final Map<String, _EventQueue> _tasks = {};

  Future<File> copyFile(String source, String destination) async {
    log("FileProvider : copyFile $source To $destination");
    if (_tasks[source] == null) {
      _tasks[source] = _EventQueue();
    }
    _FileCopyingTask task = _tasks[source]!.addTask(source, destination);

    return task.future;
  }
}

///
///Execute one task At a Time
///
class _EventQueue {
  final List<_FileCopyingTask> _tasks = [];
  bool _isRunning = false;

  _FileCopyingTask addTask(String source, String destination) {
    log("_EventQueue : addTask $source To $destination");
    var fileCopyingTask = _FileCopyingTask(source, destination);
    _tasks.add(fileCopyingTask);
    _run();
    return fileCopyingTask;
  }

  void _run() {
    if (_isRunning || _tasks.isEmpty) return;
    _isRunning = true;

    _tasks.first.run().then((_) {
      _tasks.removeAt(0);
      _isRunning = false;
      _run();
    });
  }
}

///
///Task Which Performs Copy Operation
///
class _FileCopyingTask {
  final String source;
  final String destination;
  final Completer<File> completer = Completer<File>();
  _FileCopyingTask(
    this.source,
    this.destination,
  );

  bool get isComplete => completer.isCompleted;
  Future<File> get future => completer.future;

  Future<File> run() async {
    log("_FileCopyingTask : Started \n$source To \n$destination at \n${DateTime.now()}");
    // await compute(_copyFile, [source, destination]);
    File(source).copy(destination).then((File copiedFile) {
      log("_FileCopyingTask : Completed \n$source To \n$destination at \n${DateTime.now()}");

      completer.complete(copiedFile);
    });
    return future;
  }
}

// Future<void> _copyFile(List<String> args) async {
//   String source = args.first;
//   String destination = args.last;

//   await File(source).copy(destination);
// }