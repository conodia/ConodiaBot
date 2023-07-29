import 'dart:io';

import 'package:path/path.dart';

class Debug {
  static bool isDebug = true;
  Future<void> log(dynamic message) async {
    if (isDebug) {
      print(message);
      await writeFile(message);
    }
  }

  Future<void> error(dynamic message) async {
    if (isDebug) {
      print("[ ERROR ]" + message);
      await writeFile("[ ERROR ]" +message);
    }
  }

  Future<void> writeFile(dynamic message) async {
      final today = DateTime.now();
      File file = File(join(Directory.current.path, 'logs', 'panda', '${today.day}-${today.month}-${today.year}.log'));

      if (!file.existsSync()) {
        file.createSync(recursive: true);
      }

      file.writeAsStringSync('[${today.hour}h ${today.minute}:${today.second}] $message\n', mode: FileMode.writeOnlyAppend);
  }
}