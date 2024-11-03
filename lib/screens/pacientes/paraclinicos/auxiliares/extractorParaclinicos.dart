import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/pacientes/auxiliar/extractor.dart';
import 'package:assistant/screens/operadores/pdfViewer.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ParaclinicosExtractor extends StatefulWidget {
  const ParaclinicosExtractor({super.key});

  @override
  State<ParaclinicosExtractor> createState() => _ParaclinicosExtractorState();
}

class _ParaclinicosExtractorState extends State<ParaclinicosExtractor> {
  // int? idPaciente = 0;
  // List<List<dynamic>>? valoresLaboratorio = [];
  // String? nssPaciente, fechaResultado;
  // String? result, registroPrevio;

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
            onChangeValue: () {
                 AuxiliarExtractor(context);
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
                tittle: 'Cargar desde Memoria interna . . . ',
                onChangeValue: () async {
                  final path =
                      await Directorios.choiseFromInternalDocuments(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PDFViewerScreen(path!.files.single.path!),
                      // PDFViewerScreen(path!.first.path!),
                    ),
                  );
                }),
          ],
        ))
      ],
    );
  }

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
  // final PdfViewerController _pdfViewerController = PdfViewerController();
  // Uint8List? _pdfBytes;

  // void _incluirNSS(List<TextLine> textLine) {
  //   try {
  //     result = textLine.firstWhere((o) => o.text.contains('NSS')).text;
  //     fechaResultado =
  //         textLine.firstWhere((o) => o.text.contains('FECHA DE LA ORDEN')).text;
  //     Terminal.printExpected(message: "NSS : $result");
  //   } catch (e) {
  //     // En caso de no encontrarlo, asignamos "No Encontrado"
  //     result = "No Encontrado";
  //     Terminal.printAlert(
  //         message: "No Encontrado . "
  //             "$e");
  //   } finally {
  //     if (result != "No Encontrado") {
  //       RegExp regExpect = RegExp(r'(\D+|\d*\.?\d*)');
  //       List<String> nssFinder = regExpect
  //           .allMatches(result!)
  //           .map((match) => match.group(0)!)
  //           .toList();
  //       nssPaciente = nssFinder[1];
  //       Terminal.printSuccess(
  //           // message: "result ${result.split(" ")[1]} "
  //           message: "nssFinder ${nssFinder[1]}"
  //               "");
  //
  //       ///
  //       Actividades.consultar(Databases.siteground_database_regpace,
  //               "SELECT * FROM pace_iden_iden WHERE Pace_NSS = ${nssFinder[1]}")
  //           .then((onValue) {
  //         // Terminal.printSuccess(message: "$onValue");
  //         if (onValue.isEmpty) {
  //           registroPrevio = "NO ENCONTRADO";
  //           Operadores.alertActivity(
  //               context: context,
  //               tittle: "Paciente - NO ENCONTRADO",
  //               message: "$result\n"
  //                   "",
  //               onAcept: () {
  //                 Navigator.of(context).pop();
  //               });
  //         } else {
  //           idPaciente = int.parse(onValue[0]['ID_Pace'].toString());
  //           Terminal.printSuccess(message: "$idPaciente : $onValue");
  //         }
  //       }).onError((error, stackTrace) {
  //         Operadores.alertActivity(
  //             context: context,
  //             tittle: "ERROR al Conectar con Base de Datos . . . ",
  //             message: "$error : : $stackTrace");
  //       });
  //     }
  //   }
  // }
  //
  // List<String> _regresarPartesEncontradas(List<TextLine> textLine) {
  //   List<String> partes = [];
  //
  //   for (var item in textLine) {
  //     String texto = item.text;
  //
  //     RegExp regExp = RegExp(r'(?![\x95\#])(\D+|\d*\.?\d*)(?![\#]$)');
  //     // (?!\s[\x95#]$)
  //     //RegExp(r'(\D+|\d*\.?\d*)');
  //     // (?!#)[^#]+
  //     //^[a-zA-Z]+$
  //     // \D+|\d*\.?\d*
  //     // \d+|\D+
  //     // ^
  //     // r'^[+-]?([0-9]*[.])?[0-9]+$'
  //     partes += regExp
  //         .allMatches(texto)
  //         .map((match) => match.group(0) ?? 'No encontrado')
  //         .toList();
  //     // print(partes); // [abc, 123, def, 456]
  //     //
  //   }
  //   // Terminal.printData(message: partes.toString());
  //   return partes;
  // }
}
