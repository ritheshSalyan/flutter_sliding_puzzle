import 'dart:async';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

class CacheFileManager {
  static Map<String, _Task> cacheFileTask = {};

  Future<String> downloadFile(String url) {
    if (cacheFileTask[url] == null) {
      cacheFileTask[url] = _Task(url);
    }
    return cacheFileTask[url]!.download();
  }
}

class _Task {
  final String url;
  String? downloadPath;
  // final Dio _dio = Dio();
  _Task(
    this.url,
  );

  Future<String> getDownloadPath() async {
    if (downloadPath != null) {
      return downloadPath!;
    }
    var dir = await getApplicationSupportDirectory();
    downloadPath = dir.path + "/" + url.split("/").last;
    return downloadPath!;
  }

  final Completer<String> _completer = Completer<String>();

  bool _isDownloadStarted = false;
  Future<String> download() async {
    if (_isDownloadStarted) {
      return _completer.future;
    }
    _isDownloadStarted = true;
    await DefaultCacheManager().getSingleFile(url).then((fileInfo) {
      downloadPath = fileInfo.path;
      _completer.complete(downloadPath);
    });
    // return _completer.future;

    // var path = await getDownloadPath();
    // var response =
    //     await _dio.download(url, path, onReceiveProgress: (received, total) {
    //   if (total != -1) {
    //     var d = (received / total * 100);
    //     print(d.toStringAsFixed(0) + "%");
    //     if (d == 100.0) {
    //       _completer.complete(path);
    //     }
    //   }
    // }
    // ,
    // );
    // print(response.data);
//  File file = File(path);
    // var raf = file.openSync(mode: FileMode.write);
    // response.data is List<int> type
    // raf.writeFromSync(response.data);
    return _completer.future;
  }
}
