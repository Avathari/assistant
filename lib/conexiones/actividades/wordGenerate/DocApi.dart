import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:aspose_words_cloud/aspose_words_cloud.dart';
import 'package:open_file/open_file.dart';

class DocApi {
  static Future<void> openFileInWord(File pdfFile) async {
    final ur = pdfFile.path;
    print(ur);
    // ************************ *******************************
    final config = Configuration(
      "fe3a7c7a-1dc4-4329-b684-a4a7dd7038f2",
      "dd09828cf7e4801e527cb9bf9591a830",
    );
    final wordsApi = WordsApi(config);

    final doc = (await File(ur).readAsBytes()).buffer.asByteData();
    final request = ConvertDocumentRequest(doc, 'docx');
    final convert = await wordsApi.convertDocument(request);
  }

  static Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  static Future<void> openFile(File pdfFile) async {
    final ur = pdfFile.path;
    await OpenFile.open(ur);
  }
}
