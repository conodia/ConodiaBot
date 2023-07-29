import 'dart:async';
import 'dart:io';

import 'package:mineral/core/extras.dart';
import 'package:path/path.dart';


class ConfigManager with Console {

  Future<File> downloadFile(String url, String filename) async {
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    File file = new File(join(Directory.current.path, "config", filename));

    file.createSync(recursive: true);
    await file.writeAsBytes(bytes);
    console.success("Le fichier '$filename' a été créé");

    return file;
  }

  dynamic consolidateHttpClientResponseBytes(HttpClientResponse response) async {
    var bytes = <int>[];
    await for (var sublist in response.transform(Uint8ListTransformer())) {
      bytes.addAll(sublist);
    }
    return bytes;
  }
}

StreamTransformer<List<int>, dynamic> Uint8ListTransformer() {
  return StreamTransformer.fromHandlers(
    handleData: (List<int> data, EventSink sink) {
      sink.add(data);
    },
  );
}