import 'dart:convert';
import 'dart:io';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ParaclinicosExtractor extends StatefulWidget {
  const ParaclinicosExtractor({super.key});

  @override
  State<ParaclinicosExtractor> createState() => _ParaclinicosExtractorState();
}

class _ParaclinicosExtractorState extends State<ParaclinicosExtractor> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleIcon(
                iconed: Icons.file_copy_rounded,
                tittle: 'Cargar desde Dispositivo',
                onChangeValue: () async {
                  FilePickerResult? filePickerResult = await FilePicker.platform
                      .pickFiles(
                          type: FileType.custom, allowedExtensions: ['pdf']);

                  if (filePickerResult != null) {
                    if (kIsWeb) {
                      _pdfBytes = filePickerResult.files.single.bytes;
                    } else {
                      final PdfDocument document = PdfDocument(
                          inputBytes: File(filePickerResult.files.single.path!)
                              .readAsBytesSync());
                      //Find the text and get matched items.
                      //Extracts the text line collection from the document
                      final List<TextLine> textLine =
                          PdfTextExtractor(document).extractTextLines();

                      List<String> partes = [];
                      for (var item in textLine) {
                        String texto = item.text;
                        RegExp regExp = RegExp(r'(\D+|\d*\.?\d*)');
                        //^[a-zA-Z]+$
                        // \D+|\d*\.?\d*
                        // \d+|\D+
                        // ^
                        // r'^[+-]?([0-9]*[.])?[0-9]+$'
                        partes = regExp
                            .allMatches(texto)
                            .map((match) => match.group(0)!)
                            .toList();
                        // print(partes); // [abc, 123, def, 456]
                        //

                        for (var value in [
                          "Eritrocitos",
                          "Hemoglobina",
                          "Hematocrito",
                          "Ancho de Distribución Eritrocitaria",
                          "Plaquetas",
                          "Leucocitos",
                          "Neutrófilos #",
                          "Linfocitos #",
                          "Monocitos #",
                          "Eosinófilos #",
                          "Basófilos #",
                          "Bandas #",
                          // "Volumen Plaquetar Medio",
                          // "Ancho de Distribución Plaquetaria", // 17
                          // "Reticulocitos", // % _
                          // "Frotis de sangre periférica",
                          // "Volúmen Plaquetar Medio", "",
                        ]) {
                          if (partes[0].contains(value)) {
                            // Terminal.printSuccess(
                            //     message: "${partes.length}");
                            if (partes.length > 2) {
                              // Terminal.printSuccess(
                              //     message: "${partes}");
                              Terminal.printSuccess(
                                  message: "${partes[0]} "
                                      "${partes[1]} "
                                      "${partes[2]} "
                                      "");
                            }
                          }
                        }
                      }

                      //Dispose the document.
                      document.dispose();
                      // _pdfBytes =
                      // await File(filePickerResult.files.single.path!).readAsBytes();
                    }
                  }
                  setState(() {});
                }),
            // CircleIcon(
            //     iconed: Icons.file_copy_rounded,
            //     tittle: 'Cargar desde Dispositivo',
            //     onChangeValue: () async {
            //       var bytes = await Directorios
            //           .choiseFromDirectory();
            //       setState(() {
            //         stringImage = base64Encode(bytes);
            //       });
            //     }),
            GrandIcon(
              iconColor: Colors.black,
              iconData: Icons.new_releases_outlined,
              labelButton: 'Recargar . . . ',
              onPress: () {
                setState(() {
                  // stringImage = Paraclinicos.imagenActivo;
                });
              },
            ),
            CircleIcon(
                iconed: Icons.camera_alt_outlined,
                tittle: 'Cargar desde Cámara',
                onChangeValue: () async {
                  var bytes = await Directorios.choiseFromCamara();
                  setState(() {
                    stringImage = base64Encode(bytes);
                  });
                }),
          ],
        ))
      ],
    );
  }

  /// Open a PDF file from the local device's storage.
  // Future<String> _openFile() async {
  //   FilePickerResult? filePickerResult = await FilePicker.platform
  //       .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
  //
  //   if (filePickerResult != null) {
  //     if (kIsWeb) {
  //       _pdfBytes = filePickerResult.files.single.bytes;
  //     } else {
  //       return filePickerResult.files.single.path!;
  //       // _pdfBytes =
  //       // await File(filePickerResult.files.single.path!).readAsBytes();
  //     }
  //   }
  //   setState(() {});
  // }

  // VARIABLES
  String? stringImage = '';
  final PdfViewerController _pdfViewerController = PdfViewerController();
  Uint8List? _pdfBytes;
}
