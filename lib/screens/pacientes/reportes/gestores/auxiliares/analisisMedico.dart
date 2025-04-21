import 'dart:async';
import 'dart:io';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/conexiones/controladores/interprete/iachat.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/analisis.dart';
import 'package:assistant/screens/pacientes/reportes/info/reportesAuxiliares.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AnalisisMedico extends StatefulWidget {
  bool? isPrequirurgica;
  int? actualPage;
  double? fontSize = 8.0;

  String analisisTemporalFile = "${Pacientes.localReportsPath}analisis.txt";

  AnalisisMedico(
      {super.key, this.actualPage = 1, this.isPrequirurgica = false});

  @override
  State<AnalisisMedico> createState() => _AnalisisMedicoState();
}

class _AnalisisMedicoState extends State<AnalisisMedico> {
  Timer? _timer; // Definir un temporizador

  var eventualidadesTextController = TextEditingController();
  var terapiasTextController = TextEditingController();
  var analisisTextController = TextEditingController();
  var tratamientoTextController = TextEditingController();

  @override
  void initState() {
    if (widget.isPrequirurgica!) {
      Reportes.tratamientoPropuesto = Formatos.indicacionesPreoperatorias;
      Reportes.reportes['Recomendaciones_Generales'] =
          Reportes.tratamientoPropuesto;

      eventualidadesTextController.text = "";
      terapiasTextController.text = "";
      analisisTextController.text = "";
      tratamientoTextController.text = Reportes.tratamientoPropuesto;
    } else {
      // eventualidadesTextController.text = Reportes.eventualidadesOcurridas;
      // terapiasTextController.text = Reportes.terapiasPrevias;
      analisisTextController.text = Reportes.reportes['Analisis_Medico'] != ""
          ? Reportes.reportes['Analisis_Medico']
          : Reportes.reportes['Analisis_Terapia'] != ""
              ? Reportes.reportes['Analisis_Terapia']
              : Reportes.analisisMedico;
      // tratamientoTextController.text = Reportes.tratamientoPropuesto;

      // Se reinicia Reportes.pendientes porque resulta acumulativo * * * * * * * * * * * * * * *
      Reportes.pendientes.clear();
      if (Pacientes.Pendiente!.isNotEmpty) {
        String pendientes = "";
        for (var element in Pacientes.Pendiente!) {
          //Pace_PEN
          if (pendientes == "") {
            pendientes =
                "          ${element['Pace_Desc_PEN'].replaceAll("\n", "")}. \n";
            // Añadir a Reportes.pendientes para Anexión a Indicaciones : Pendientes * * * * * * * *
            Reportes.pendientes.add(
                "          ${element['Pace_PEN']} - ${element['Pace_Desc_PEN'].replaceAll("\n", "")}. "); // Sin salto de linea, ya ...
          } else {
            pendientes = "$pendientes"
                "          ${element['Pace_Desc_PEN'].replaceAll("\n", "")}. \n";
            // Añadir a Reportes.pendientes para Anexión a Indicaciones : Pendientes * * * * * * * *
            Reportes.pendientes.add(
                "          ${element['Pace_PEN']} - ${element['Pace_Desc_PEN'].replaceAll("\n", "")}. ");
          }
        }

        tratamientoTextController.text =
            "${tratamientoTextController.text}. \nPLAN: \n"
            "$pendientes";
      }
    }

    // Añadir un Listener a analisisTextController
    // analisisTextController
    //     .addListener(() => _saveToFile(analisisTextController.text));
    // Configurar un Timer que llame a _saveToFile cada 10 segundos
    _timer = Timer.periodic(Duration(seconds: 7),
        (timer) => _saveToFile(analisisTextController.text));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isMobile(context)) {
      widget.fontSize = 12.0;
    } else {
      widget.fontSize = 8.0;
    }
    //
    return Column(
      children: [
        widget.isPrequirurgica == true
            ? Expanded(
                child: SingleChildScrollView(
                child: Column(children: [
                  EditTextArea(
                      textController: tratamientoTextController,
                      labelEditText: "Recomendaciones",
                      keyBoardType: TextInputType.multiline,
                      numOfLines: 20,
                      withShowOption: true,
                      onChange: ((value) {
                        Reportes.tratamientoPropuesto = "$value.";
                        Reportes.reportes['Analisis_Medico'] =
                            "${Reportes.eventualidadesOcurridas} ${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                        Reportes.reportes['Analisis_Terapia'] =
                            "${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                        Reportes.reportes['Recomendaciones_Generales'] =
                            Reportes.tratamientoPropuesto;
                      }),
                      inputFormat: MaskTextInputFormatter()),
                ]),
              ))
            : Expanded(
                child: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        // EditTextArea(
                        //     textController: eventualidadesTextController,
                        //     labelEditText: "Eventualidades sucitadas",
                        //     keyBoardType: TextInputType.text,
                        //     numOfLines: isTablet(context) ? 8 : 5,
                        //     withShowOption: true,
                        //     onChange: ((value) {
                        //       eventualidadesTextController.text = value;
                        //       // ************ ******* *****************
                        //       Reportes.eventualidadesOcurridas = "$value.";
                        //       Reportes.reportes['Eventualidades'] = "$value.";
                        //       // ************ ******* *****************
                        //       Reportes.reportes['Analisis_Medico'] =
                        //       "${Reportes.eventualidadesOcurridas} ${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                        //       Reportes.reportes['Analisis_Terapia'] =
                        //       "${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                        //     }),
                        //     inputFormat: MaskTextInputFormatter()),
                        // EditTextArea(
                        //     textController: terapiasTextController,
                        //     labelEditText: "Terapias previas",
                        //     keyBoardType: TextInputType.multiline,
                        //     numOfLines: isTablet(context) ? 8 : 5,
                        //     withShowOption: true,
                        //     onChange: ((value) {
                        //       Reportes.terapiasPrevias = "$value.";
                        //       Reportes.reportes['Analisis_Medico'] =
                        //       "${Reportes.eventualidadesOcurridas} ${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                        //       Reportes.reportes['Analisis_Terapia'] =
                        //       "${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                        //     }),
                        //     inputFormat: MaskTextInputFormatter()),
                        EditTextArea(
                            textController: analisisTextController,
                            limitOfChars: 3000,
                            fontSize:
                                widget.fontSize!, // isTablet(context) ? 9 : 9,
                            labelEditText: "Análisis médico",
                            keyBoardType: TextInputType.multiline,
                            numOfLines: isLargeDesktop(context)
                                ? 28
                                : isTablet(context)
                                    ? 32
                                    : isMobile(context)
                                        ? 25
                                        : 22,
                            onChange: ((value) {
                              setState(() {
                                Reportes.analisisMedico =
                                    Reportes.reportes['Analisis_Terapia'] =
                                        Reportes.reportes['Analisis_Medico'] =
                                            value;
                                // Reportes.reportes['Analisis_Medico'] =
                                //     "${Reportes.eventualidadesOcurridas} ${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                                // Reportes.reportes['Analisis_Terapia'] =
                                //     "${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                              });
                            }),
                            inputFormat: MaskTextInputFormatter()),

                        // EditTextArea(
                        //     textController: tratamientoTextController,
                        //     labelEditText: "Terapéutica propuesta",
                        //     keyBoardType: TextInputType.multiline,
                        //     numOfLines: isTablet(context) ? 8 : 5,
                        //     withShowOption: true,
                        //     onChange: ((value) {
                        //       Reportes.tratamientoPropuesto = "$value.";
                        //       Reportes.reportes['Analisis_Medico'] =
                        //       "${Reportes.eventualidadesOcurridas} ${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                        //       Reportes.reportes['Analisis_Terapia'] =
                        //       "${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                        //     }),
                        //     inputFormat: MaskTextInputFormatter()),
                      ]),
                    ),
                  ),
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
                      flex: isMobile(context)? 4: 2,
                      child: Wrap(alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.spaceBetween,runSpacing: 5,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleIcon(
                              radios: 30,
                              iconed: Icons.roller_shades_closed_outlined,
                              onChangeValue: () async {
                                analisisTextController.text = Reportes
                                        .analisisMedico =
                                    await IAChat.sendMessage(
                                        Reportes.copiarReporte(
                                            tipoReporte:
                                                ReportsMethods.getTypeReport(
                                                    actualPage:
                                                        widget.actualPage!)));
                              }),
                          CircleIcon(
                            radios: 40,
                              iconed: Icons.library_books_outlined,
                              tittle: "Bibliográfico . . . ",
                              onChangeValue: () {
                                Operadores.openDialog(
                                    context: context,
                                    chyldrim: const Bibliografico(),
                                    onAction: () {
                                      setState(() {
                                        analisisTextController.text =
                                            Reportes.analisisMedico;
                                      });
                                    });
                              }),
                          // GrandIcon(
                          //     labelButton: "Bibliográfico . . . ",
                          //     onPress: () {
                          //       Operadores.openDialog(
                          //           context: context,
                          //           chyldrim: const Bibliografico(),
                          //           onAction: () {
                          //             setState(() {
                          //               analisisTextController.text =
                          //                   Reportes.analisisMedico;
                          //             });
                          //           });
                          //     }),
                          CircleIcon(
                              radios: 50,
                              iconed: Icons.comment_bank_outlined,
                              tittle: "Comentarios Previos . . . ",
                              onChangeValue: () {
                                Operadores.selectOptionsActivity(
                                    context: context,
                                    options: Items.comentariosPrevios
                                        .map((e) => e['Diagnostico'])
                                        .toList(),
                                    onClose: (valar) {
                                      Terminal.printWarning(message: valar);

                                      for (var e in Items.comentariosPrevios) {
                                        //
                                        if (e['Diagnostico'] == valar) {
                                          analisisTextController.text =
                                              "${analisisTextController.text}\n${e['Comentario']!}";
                                        }
                                      }
                                      Navigator.of(context).pop();
                                    });
                              }),
                          CrossLine(),
                          CircleIcon(
                              iconed: Icons.file_open_outlined,
                              tittle: "Memoria temporal . . . ",
                              onChangeValue: () => _readFromFile().then(
                                  (onValue) => Operadores.optionsActivity(
                                      context: context,
                                      tittle: "Memoria temporal . . . ",
                                      message: onValue.toString(),
                                      onClose: () =>
                                          Navigator.of(context).pop(),
                                      textOptionA: "¿Sobre-escribir memoria?",
                                      optionA: () {
                                        analisisTextController.text = onValue;
                                        Navigator.of(context).pop();
                                      }))),
                        ],
                      ))
                ],
              ))
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancelar el temporizador al cerrar la pantalla
    analisisTextController.dispose();
    super.dispose();
  }

  // FUNCIONES ******************************
  // Función para guardar el texto en un archivo
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
