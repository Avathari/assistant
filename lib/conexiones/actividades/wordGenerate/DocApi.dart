import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class DocApi {
  static Future<void> openFileInWord() async {
    // Load test image for inserting in docx

  }

  static Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  static Future<File> saveDocument(
      {required String name, }) async {
    var dir, file;

    try {
      dir = await getApplicationDocumentsDirectory();
      file = File('${dir.path}/$name');
//       //
// //
//       final docx = await DocxTemplate.fromBytes(await file.readAsBytes());
//       final docGenerated = await docx.generate(content);
//       await file.writeAsBytes(docGenerated);
//       /*
//     Or in the case of Flutter, you can use rootBundle.load, then get bytes
//
//     final data = await rootBundle.load('lib/assets/users.docx');
//     final bytes = data.buffer.asUint8List();
//
//     final docx = await DocxTemplate.fromBytes(bytes);
//   */
//       // final fileGenerated = File('generated.docx');
//       // if (docGenerated != null) await fileGenerated.writeAsBytes(docGenerated);
//       //
//       //
//
//       return file;
    } catch (e) {
      Alertas.showAlert(context: Contextos.contexto, error: 'Error $e');
      print('Error $e');
    } finally {
      // Alertas.showAlert(context: Contextos.contexto, error: 'Creado en ${dir.path}/$name');
      return file;
    }
  }

  static Future<void> openFile(File pdfFile) async {
    final ur = pdfFile.path;
    await OpenFile.open(ur);
  }
}
