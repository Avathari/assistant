import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class AuxiliarExtractor {
  static int? idPaciente = 0;
  static List<List<dynamic>>? valoresLaboratorio = [];
  static String? nssPaciente, agregadoPaciente, fechaResultado;
  static String? result, registroPrevio = "NO ENCONTRADO";

  // String? stringImage = '';
  // final PdfViewerController _pdfViewerController = PdfViewerController();
  static Uint8List? _pdfBytes;

  AuxiliarExtractor(BuildContext context) {
    obtenerInformacionDesdeInstitucional(context);
  }

  static obtenerInformacionDesdeInstitucional(BuildContext context) async {
    valoresLaboratorio!.clear();
    List listaArchivosSeleccionados = [];

    /// Aqui se agregan los Archivos que contienen algún valor, para posteriormente eliminarse.
    final filePickerResult =
        await Directorios.choiseSeveralFromInternalDocuments(context);

    if (filePickerResult != null) {
      if (kIsWeb) {
        _pdfBytes = filePickerResult.single.bytes;
        // . . .
      } else {
        filePickerResult
            .forEach((action) => Terminal.printSuccess(message: "${action}"));

        /// Iterar filePickerResult para obtener cada uno de los Path's
        for (int index = 0; index < filePickerResult.length; index++) {
          //
          Terminal.printWarning(message: filePickerResult[index].path!);
          final PdfDocument document = PdfDocument(
              inputBytes:
                  File(filePickerResult[index].path!).readAsBytesSync());

          /// Extrae una lista de lineas de texto.
          final List<TextLine> textLine =
              PdfTextExtractor(document).extractTextLines();

          await _incluirNSS(context, textLine).whenComplete(() {
            // List<String> partes = _regresarPartesEncontradas(textLine);
            List<String> partes = [];
            //
            for (var item in textLine) {
              String texto = item.text;

              RegExp regExp = RegExp(
                  r'([A-Z]+),\s?(\d),\s?(-)|(?![\x95\s\#])(\D+|\d*\.?\d*)(?![\s\#]$)');

              // RegExp(r'(?![\x95\s\#])(\D+|\d*\.?\d*)(?![\s\#]$)');
              // (?!\s[\x95#]$)
              //RegExp(r'(\D+|\d*\.?\d*)');
              // (?!#)[^#]+
              //^[a-zA-Z]+$
              // \D+|\d*\.?\d*
              // \d+|\D+
              // ^
              // r'^[+-]?([0-9]*[.])?[0-9]+$'
              partes = regExp
                  .allMatches(texto)
                  .map((match) => match.group(0) ?? 'No encontrado')
                  .toList();
              //
              for (var value in Auxiliares.paraclinicosInstitucionales) {
                // Terminal.printSuccess(message: "${partes[0].replaceAll(RegExp(r'^(.*)\s<'), "").trim()}");
                if (partes[0].contains(value)) {
                  // Terminal.printSuccess(message: "${partes}");
                  // Terminal.printSuccess(message: "${partes.length}");
                  // Terminal.printExpected(message: "${partes} : : $value");
                  if ((partes[0] == "HIVAb-Ag No reactivo" &&
                          value == "HIVAb-Ag No reactivo") ||
                      (partes[0] == "HIVAb-Ag Reactivo" &&
                          value == "HIVAb-Ag Reactivo")) {
                    valoresLaboratorio!.add([
                      0,
                      idPaciente,
                      Calendarios.fromTextoLlano(
                              fechaResultado!.trim().split("N: ")[1].trim())
                          .toString(),
                      Auxiliares.queCategoriaPertenece(partes[0]
                          .trim()
                          .replaceAll(RegExp(r'\<[^<>]*\>'), '')),
                      "HIVAb-Ag",
                      if (partes[0] == "HIVAb-Ag No reactivo")
                        "No reactivo"
                      else
                        "Reactivo",
                      "",
                    ]);
                    // AGREGAR A LISTAS DE ARCHIVOS SELECCIONADOS
                    listaArchivosSeleccionados
                        .add(filePickerResult[index].path!);
                  } else {
                    if (partes.length > 2) {
                      // Terminal.printSuccess(message: "${partes[0]}");
                      if (partes[0].trim() == value || partes[0] == value) {
                        // Terminal.printSuccess(
                        //     message: // "ITEM ENCONTRADO "
                        //     "${partes[0]} . "
                        //         "${partes[1]} . "
                        //         "${partes[2]} . "
                        //         "");
                        valoresLaboratorio!.add([
                          0,
                          idPaciente,
                          Calendarios.fromTextoLlano(
                                  fechaResultado!.trim().split("N: ")[1].trim())
                              .toString(),
                          Auxiliares.queCategoriaPertenece(partes[0]
                              .trim()
                              .replaceAll(RegExp(r'\<[^<>]*\>'), '')),
                          // partes[0].split("#")[0].trim()), // Tipo_Estudio
                          Auxiliares.queLaboratorioPertenece(partes[0]
                              .trim()), // .replaceAll(RegExp(r'^(.*)\s<'), '').trimRight()
                          // partes[0].split("#")[0].trim()), // Laboratorio
                          partes[1].trim(),
                          if (partes[2] == "S/U Reactivo > = " ||
                              partes[2] == "S/CO Reactivo > = ")
                            "S/U"
                          else if (partes[2] == "IU/mL Reactivo > = " ||
                              partes[2] == "IU/mLReactivo>=")
                            "UI/mL"
                          else
                            partes[2]
                                .trim()
                                .replaceAll(RegExp(r'[\s.*\s\*\.\!¯]'), ''),
                        ]);
                        // AGREGAR A LISTAS DE ARCHIVOS SELECCIONADOS
                        listaArchivosSeleccionados
                            .add(filePickerResult[index].path!);
                      }
                    }
                  }
                }
              }
              //
            }

            //Dispose the document.
            document.dispose();
          });
        }

        // _pdfBytes =
        // await File(filePickerResult.files.single.path!).readAsBytes();
        if (valoresLaboratorio!.isNotEmpty) {
          LaboratoryStream.addValues(valoresLaboratorio!);
        }
        //
      }
    }
    if (registroPrevio != "NO ENCONTRADO") {
      Operadores.optionsActivity(
        context: context,
        tittle: "Finalizar proceso - ",
        message: "Estos fueron los resultados de la Lectura : \n"
            "FECHA DE RESULTADO ${Calendarios.fromTextoLlano(fechaResultado!.trim().split("N: ")[1].trim())} \n"
            "NSS $nssPaciente $agregadoPaciente . (ID Paciente $idPaciente . $registroPrevio) : : \n\n"
            "RESULADOS  (${valoresLaboratorio!.length} valores): \n"
            "${Listas.fromEachListToString(valoresLaboratorio!)} \n"
            "¿Deseas ingresar Información a la Base de Datos de Auxiliares?",
        onClose: () => Navigator.of(context).pop(),
        textOptionA: "Ingresar información obtenida . . . ",
        optionB: null,
        optionA: () {
          //
          if (registroPrevio != "NO ENCONTRADO") {
            Actividades.registrarAnidados(
              Databases.siteground_database_reggabo,
              Auxiliares.auxiliares['registerQuery'],
              valoresLaboratorio!,
            )
                .then((onValue) => Operadores.notifyActivity(
                    context: context,
                    tittle: "Respuesta de Consulta a Base de Datos . . . ",
                    message: onValue.toString(),
                    onAcept: () {
                      // var listado = Listas.listWithoutRepitedValues(
                      //     listaArchivosSeleccionados);
                      // Terminal.printNotice(
                      //     message:
                      //         "LISTA DE ARCHIVOS SELECCIONADOS : : $listado");
                      //
                      Listas.listWithoutRepitedValues(
                              listaArchivosSeleccionados)
                          .forEach((filePath) =>
                        Archivos.deleteFile(filePath: filePath)
                      );
                      //
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      //
                    }))
                .onError((onError, stackTrace) => Operadores.alertActivity(
                      context: context,
                      tittle: "Error al Consultar Base de Datos . . . ",
                      message: "$onError : $stackTrace",
                      onAcept: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      onClose: () => Navigator.of(context).pop(),
                    ));
          } else {
            Navigator.of(context).pop();
          }
        },
      );
    }
  }

  static Future<void> _incluirNSS(
      BuildContext context, List<TextLine> textLine) async {
    try {
      result = textLine.firstWhere((o) => o.text.contains('NSS')).text;
      fechaResultado =
          textLine.firstWhere((o) => o.text.contains('FECHA DE LA ORDEN')).text;
      Terminal.printExpected(message: "NSS : $result");
    } catch (e) {
      // En caso de no encontrarlo, asignamos "No Encontrado"
      result = "No Encontrado";
      // Terminal.printAlert(
      //     message: "No Encontrado . "
      //         "$e");
    } finally {
      if (result != "No Encontrado") {
        RegExp regExpect = RegExp(r'(\D+|\d*\.?\d*)');
        List<String> nssFinder = regExpect
            .allMatches(result!)
            .map((match) => match.group(0)!)
            .toList();
        nssPaciente = nssFinder[1];
        agregadoPaciente =
            nssFinder[3] + nssFinder[4] + nssFinder[5] + nssFinder[6];
        Terminal.printSuccess(
            // message: "result ${result.split(" ")[1]} "
            message: "nssFinder ${nssFinder}"
                "");

        ///
        await Actividades.consultar(
                Databases.siteground_database_regpace,
                "SELECT "
                "ID_Pace, Pace_Nome_PI, Pace_Nome_SE, "
                "Pace_Ape_Pat, Pace_Ape_Mat "
                "FROM pace_iden_iden "
                "WHERE Pace_NSS = '${Pacientes.formatearNSS(nssPaciente)}' "
                "AND Pace_AGRE = '$agregadoPaciente'")
            .then((onValue) {
          Terminal.printSuccess(message: "$onValue");
          if (onValue.isEmpty) {
            registroPrevio = "NO ENCONTRADO";
            Operadores.alertActivity(
                context: context,
                tittle: "Paciente - NO ENCONTRADO",
                message: "$result\n"
                    "",
                onAcept: () {
                  Navigator.of(context).pop();
                });
          } else {
            registroPrevio = ""
                "${onValue[0]['Pace_Ape_Pat']} "
                "${onValue[0]['Pace_Ape_Mat']} "
                "${onValue[0]['Pace_Nome_PI']} "
                "${onValue[0]['Pace_Nome_SE']} "
                "";
            idPaciente = int.parse(onValue[0]['ID_Pace'].toString());
            // Terminal.printSuccess(message: "$idPaciente : $onValue");
          }
        }).onError((error, stackTrace) {
          Operadores.alertActivity(
            context: context,
            tittle: "ERROR al Conectar con Base de Datos . . . ",
            message: "$error : : $stackTrace",
            onAcept: () => Navigator.of(context).pop(),
          );
        });
      }
    }
  }
}

class LaboratoryStream {
  static final _controller = StreamController<List<List<dynamic>>>.broadcast();

  static Stream<List<List<dynamic>>> get stream => _controller.stream;

  static void addValues(List<List<dynamic>> values) {
    _controller.add(values);
  }

  static void dispose() {
    _controller.close();
  }
}

class LaboratoryValuesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<List<dynamic>>>(
      stream: LaboratoryStream.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hay datos disponibles'));
        }

        final values = snapshot.data!;
        return ListView.builder(
          itemCount: values.length,
          itemBuilder: (context, index) {
            final item = values[index];
            return ListTile(
              title: Text('Laboratorio: ${item[4]}'),
              subtitle: Text('Resultado: ${item[5]}'),
            );
          },
        );
      },
    );
  }
}