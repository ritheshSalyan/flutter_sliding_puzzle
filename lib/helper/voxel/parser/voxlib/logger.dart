import 'dart:developer' as dev;

class Logger {
  final String lable;

  Logger(this.lable);
  void log(String message) {
    dev.log(lable + " :" + message);
  }
}
