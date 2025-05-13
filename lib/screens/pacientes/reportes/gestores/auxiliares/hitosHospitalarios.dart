import 'dart:async';
import 'dart:io';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/operadores/pdfViewer.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/ViewDocument.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Hitoshospitalarios extends StatefulWidget {
  String analisisTemporalFile =
      "${Pacientes.localReportsPath}hitosHospitlarios.txt";

  double? fontSize = 14.0;

  Hitoshospitalarios({super.key});

  @override
  State<Hitoshospitalarios> createState() => _HitoshospitalariosState();
}

class _HitoshospitalariosState extends State<Hitoshospitalarios> {
  Timer? _timer; // Definir un temporizador
  String? filePath;
  static Uint8List? _pdfBytes;
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    setState(() {
      hitosTextController.text = Reportes.reportes['Hitos_Hospitalarios'] != ""
          ? Reportes.reportes['Hitos_Hospitalarios']
          : Reportes.hitosHospitalarios;
    });
    //
    _timer = Timer.periodic(
        Duration(seconds: 7), (timer) => _saveToFile(hitosTextController.text));
    super.initState();
    _pdfViewerController = PdfViewerController();
  }

  @override
  Widget build(BuildContext context) {
    if (isMobile(context)) {
      return Column(
        children: [
          if (filePath != null)
            SfPdfViewer.file(
              File(filePath!),
              controller: _pdfViewerController,
              onTextSelectionChanged: (details) {
                // if (details.selectedText != null && details.selectedText!.isNotEmpty) {
                //   setState(() {
                //     textoAcumulado += details.selectedText! + "\n";
                //     _notaController.text = textoAcumulado;
                //   });
                //   _pdfViewerController.clearSelection(); // Oculta el botón "Copy"
                // }
              },
            ),
          Expanded(
              flex: 4,
              child: EditTextArea(
                  textController: hitosTextController,
                  labelEditText: "Hitos de la Hospitalización",
                  keyBoardType: TextInputType.multiline,
                  numOfLines: 35,
                  limitOfChars: 3000,
                  fontSize: widget.fontSize!,
                  withShowOption: true,
                  onSelected: () => _readFromFile(),
                  onChange: (value) => setState(() =>
                  Reportes.hitosHospitalarios =
                  Reportes.reportes['Hitos_Hospitalarios'] = value),
                  inputFormat: MaskTextInputFormatter())),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
              flex: 4,
              child: EditTextArea(
                  textController: hitosTextController,
                  labelEditText: "Hitos de la Hospitalización",
                  keyBoardType: TextInputType.multiline,
                  numOfLines: 25,
                  limitOfChars: 3000,
                  fontSize: widget.fontSize!,
                  withShowOption: false,
                  onSelected: () => _readFromFile(),
                  onChange: (value) => setState(() =>
                      Reportes.hitosHospitalarios =
                          Reportes.reportes['Hitos_Hospitalarios'] = value),
                  inputFormat: MaskTextInputFormatter())),
          Expanded(
            child: RotatedBox(
              quarterTurns: 1,
              child: Slider(
                  label: widget.fontSize!.toString(),
                  min: 2,
                  max: 20,
                  value: widget.fontSize!,
                  onChanged: (double value) =>
                      setState(() => widget.fontSize = value)),
            ),
          ),
          Expanded(
              flex: 6,
              child: Column(
                children: [
                  filePath != null
                      ? Expanded(
                          flex: 6, child: SfPdfViewer.file(File(filePath!)))
                      : Expanded(flex: 6, child: Container()),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: GrandButton(
                            labelButton: "Cargar archivo de Historial . . . ",
                            onPress: () async {
                              final path =
                                  await Directorios.choiseFromInternalDocuments(
                                      context);
                              //
                              setState(() {
                                filePath = path!.files.single.path!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: GrandIcon(
                            iconData: Icons.update,
                            labelButton:
                                "Actualizar Hitos de la Hospitalización . . . ",
                            onPress: () async {
                              //TODO
                              Repositorios.actualizarHitos(
                                context: context,
                              );
                              // .onError((onError, stackTrace) =>
                              // Operadores.alertActivity(
                              //   context: context,
                              //   tittle:
                              //       "ERROR  Al Actualizar registro de Nota",
                              //   message: "ERROR : $onError : : $stackTrace",
                              //   onAcept: () => Navigator.of(context).pop(),
                              // ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      );
    }
  }

  // VARIABLES **********************************************
  var hitosTextController = TextEditingController();

  // FUNCIONES *********************************************
  Future<void> _saveToFile(String text) async {
    // final path = await _getFilePath();
    if (text.isNotEmpty) {
      Archivos.writeInFile(text, filePath: widget.analisisTemporalFile);

      // final file = File(widget.analisisTemporalFile);
      // await file.writeAsString(text).whenComplete(
      //     () => null); // print("Texto guardado automáticamente cada 10 segundos"));
    }
  }

  // Función opcional para leer el contenido del archivo (si quieres cargarlo después)
  Future<String> _readFromFile() async {
    return Archivos.readFromFile(filePath: widget.analisisTemporalFile);
    // return await File(widget.analisisTemporalFile).readAsString();
  }
}
