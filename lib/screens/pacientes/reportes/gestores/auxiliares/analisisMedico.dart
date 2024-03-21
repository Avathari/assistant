import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/analisis.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AnalisisMedico extends StatefulWidget {
  bool? isPrequirurgica;

  double? fontSize = 8.0;

  AnalisisMedico({super.key, this.isPrequirurgica = false});

  @override
  State<AnalisisMedico> createState() => _AnalisisMedicoState();
}

class _AnalisisMedicoState extends State<AnalisisMedico> {
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
      eventualidadesTextController.text = Reportes.eventualidadesOcurridas;
      terapiasTextController.text = Reportes.terapiasPrevias;
      analisisTextController.text = Reportes.analisisMedico;
      tratamientoTextController.text = Reportes.tratamientoPropuesto;

      // Se reinicia Reportes.pendientes porque resulta acumulativo * * * * * * * * * * * * * * *
      Reportes.pendientes.clear();
      if (Pacientes.Pendiente!.isNotEmpty) {
        String pendientes = "";
        Pacientes.Pendiente!.forEach((element) {
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
        });

        tratamientoTextController.text =
            "${tratamientoTextController.text}. \nPLAN: \n"
            "$pendientes";
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                            limitOfChars: 5000,
                            fontSize: widget.fontSize!, // isTablet(context) ? 9 : 9,
                            labelEditText: "Análisis médico",
                            keyBoardType: TextInputType.multiline,
                            numOfLines: isLargeDesktop(context)
                                ? 28
                                : isTablet(context)
                                    ? 32
                                    : isMobile(context)
                                        ? 15
                                        : 22,
                            onChange: ((value) {
                              Reportes.analisisMedico = "$value.";
                              Reportes.reportes['Analisis_Medico'] =
                                  "${Reportes.eventualidadesOcurridas} ${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                              Reportes.reportes['Analisis_Terapia'] =
                                  "${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
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
                        value: widget.fontSize!, onChanged: (double value) => setState(() => widget.fontSize = value)),
                    ),
                  ),
                  Expanded(flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleIcon(
                        iconed: Icons.add,
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
                      GrandIcon(
                          labelButton: "Bibliográfico . . . ",
                          onPress: () {
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
                      CircleIcon(
                          iconed: Icons.add,
                          tittle: "Comentarios Previos . . . ",
                          onChangeValue: () {
                            Operadores.selectOptionsActivity(context: context,
                                options: Items.comentariosPrevios.map((e) =>
                                e['Diagnostico']).toList(),
                                onClose: (valar) {
                                  Terminal.printWarning(message: "$valar");

                                  Items.comentariosPrevios.forEach((e) {
                                    //
                                    if (e['Diagnostico'] == valar) {
                                      analisisTextController.text = "${analisisTextController.text}\n${e['Comentario']!}";
                                    }
                                  });
                                  Navigator.of(context).pop();
                                });
                          }),
                    ],
                  ))
                ],
              ))
      ],
    );
  }
}
