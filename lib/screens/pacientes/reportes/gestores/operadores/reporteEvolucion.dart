import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/auxiliares/hospitalarios/subjetivos.dart';

import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/analisisMedico.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/auxiliaresReportes.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/exploracionFisica.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/pronosticos.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';

import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/DialogSelector.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandIcon.dart';

class ReporteEvolucion extends StatefulWidget {
  const ReporteEvolucion({super.key});

  @override
  State<ReporteEvolucion> createState() => _ReporteEvolucionState();
}

class _ReporteEvolucionState extends State<ReporteEvolucion> {
  @override
  void initState() {
    // # # # ############## #### ########
    setState(() {
      Repositorios.tipo_Analisis = Items.tiposAnalisis[1];
      //
      initialTextController.text = Pacientes.prosa(isTerapia: true);
      // ********************************************
      diagoTextController.text = Reportes.impresionesDiagnosticas.isNotEmpty
          ? Reportes.impresionesDiagnosticas
          : Pacientes.diagnosticos();
      //
      subjetivoTextController.text =
          Reportes.reportes['Subjetivo']; // Pacientes.subjetivos();
      // ********************************************
      // ********************************************
      Reportes.reportes['Datos_Generales'] = Pacientes.prosa(isTerapia: true);
      Reportes.reportes['Antecedentes_Heredofamiliares'] =
          Pacientes.heredofamiliares();
      Reportes.reportes['Antecedentes_Hospitalarios'] =
          Pacientes.hospitalarios();
      Reportes.reportes['Antecedentes_Patologicos'] = Pacientes.patologicos();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ContainerDecoration.roundedDecoration(
          colorBackground: Theming.cuaternaryColor),
      child: Column(children: [
        Expanded(
          flex: isDesktop(context)
              ? 16
              : isMobile(context)
                  ? 18
                  : 11,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: isLargeDesktop(context) || isDesktop(context) ? 14 : 4,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: ContainerDecoration.roundedDecoration(
                        colorBackground: Theming.cuaternaryColor),
                    child: CarouselSlider(
                      items: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            EditTextArea(
                                textController: initialTextController,
                                labelEditText: "Datos generales",
                                keyBoardType: TextInputType.text,
                                numOfLines: 1,
                                inputFormat: MaskTextInputFormatter()),
                            if (isTablet(context)) const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  flex: isMobile(context) || isDesktop(context)
                                      ? 3
                                      : isLargeDesktop(context)
                                          ? 4
                                          : isTablet(context)
                                              ? 2
                                              : 1,
                                  child: EditTextArea(
                                      textController: diagoTextController,
                                      labelEditText: "Impresiones diagnósticas",
                                      keyBoardType: TextInputType.multiline,
                                      numOfLines: 10,
                                      limitOfChars: 700,
                                      onChange: ((value) {
                                        setState(() {
                                          Reportes
                                              .impresionesDiagnosticas =
                                          Reportes
                                              .reportes[
                                          'Impresiones_Diagnosticas'] =
                                          Reportes
                                              .reportes[
                                          'Diagnosticos_Hospital'] =
                                          "$value.";
                                          // Terminal.printData(message: Reportes.impresionesDiagnosticas);
                                        });
                                      }),
                                      inputFormat: MaskTextInputFormatter()),
                                ),
                                Expanded(
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    spacing: 10,
                                    children: [
                                      CircleIcon(
                                          iconed: Icons.abc,
                                          onChangeValue: () {
                                            setState(() {
                                              diagoTextController.text =
                                                  Sentences.capitalizeAll(
                                                      diagoTextController.text);
                                            });
                                          }),
                                      CircleIcon(
                                          radios: 30,
                                          iconed: Icons.home_mini_outlined,
                                          onChangeValue: () {
                                            setState(() {
                                              diagoTextController.text =
                                                  Reportes
                                                      .impresionesDiagnosticas;
                                            });
                                          }),
                                      CircleIcon(
                                          iconed: Icons.list_alt_sharp,
                                          onChangeValue: () {
                                            Operadores.openDialog(
                                                context: context,
                                                chyldrim: DialogSelector(
                                                  onSelected: ((value) {
                                                    setState(() {
                                                      Diagnosticos
                                                              .selectedDiagnosis =
                                                          value;
                                                      diagoTextController.text =
                                                          "${diagoTextController.text}\n${Diagnosticos.selectedDiagnosis}";
                                                    });
                                                  }),
                                                ));
                                          })
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (isTablet(context)) const SizedBox(height: 10),
                            EditTextArea(
                                textController: subjetivoTextController,
                                labelEditText: "Referidos del Paciente",
                                keyBoardType: TextInputType.text,
                                numOfLines: 1,
                                selection: true,
                                withShowOption: true,
                                onSelected: () {
                                  Cambios.toNextActivity(context, onClose: () {
                                    setState(() {
                                      subjetivoTextController.text =
                                          Reportes.subjetivoHospitalizacion;
                                      Reportes.reportes['Subjetivo'] =
                                          "${subjetivoTextController.text}.";
                                      // *******************************
                                      Navigator.pop(context);
                                    });
                                  },
                                      tittle: 'Subjetivo del paciente',
                                      chyld: const Subjetivos());
                                },
                                onChange: ((value) {
                                  setState(() {
                                    Reportes.subjetivoHospitalizacion = Reportes.reportes['Subjetivo'] = "$value.";
                                  });
                                }),
                                inputFormat: MaskTextInputFormatter()),
                          ],
                        ),
                        ExploracionFisica(),
                        AuxiliaresExploracion(),
                        AnalisisMedico(),
                        DiagnosticosAndPronostico(
                          isTerapia: true,
                        ),
                      ],
                      carouselController: carouselController,
                      options: Carousel.carouselOptions(
                          context: context,
                          height: isMobile(context)
                              ? 500 // 345
                              : isDesktop(context)
                                  ? 527
                                  : 640),
                    ),
                  ),
                ),
                // Expanded(
                //   flex: isLargeDesktop(context) ? 1 : 1,
                //   child: SingleChildScrollView(
                //     controller: ScrollController(),
                //     child: Column(
                //       mainAxisAlignment: isLargeDesktop(context)
                //           ? MainAxisAlignment.start
                //           : MainAxisAlignment.end,
                //       children: [
                //         CrossLine(
                //             height: isLargeDesktop(context) ? 10 : 20,
                //             thickness: 3),
                //         GrandIcon(
                //           iconData: Icons.water_drop,
                //           labelButton: 'Análisis Hidrico',
                //           onPress: () {
                //             Cambios.toNextActivity(context,
                //                 chyld:  Hidricos());
                //           },
                //         ),
                //         GrandIcon(
                //           iconData: Icons.bubble_chart,
                //           labelButton: 'Análisis Metabólico',
                //           onPress: () {
                //             Operadores.openDialog(
                //                 context: context,
                //                 chyldrim: const Metabolicos());
                //           },
                //         ),
                //         GrandIcon(
                //           iconData: Icons.horizontal_rule_sharp,
                //           labelButton: 'Análisis Antropométrico',
                //           onPress: () {
                //             Operadores.openDialog(
                //                 context: context,
                //                 chyldrim: const Antropometricos());
                //           },
                //         ),
                //         GrandIcon(
                //           iconData: Icons.monitor_heart_outlined,
                //           labelButton: 'Análisis Cardiovascular',
                //           onPress: () {
                //             Operadores.openDialog(
                //                 context: context,
                //                 chyldrim: const Cardiovasculares());
                //           },
                //         ),
                //         GrandIcon(
                //           iconData: Icons.all_inclusive_rounded,
                //           labelButton: 'Análisis Ventilatorio',
                //           onPress: () {
                //             Operadores.openDialog(
                //                 context: context,
                //                 chyldrim: const Ventilatorios());
                //           },
                //         ),
                //         GrandIcon(
                //           iconData: Icons.g_mobiledata,
                //           labelButton: 'Análisis Gasométrico',
                //           onPress: () {
                //             Cambios.toNextActivity(context,
                //                 chyld: const Gasometricos());
                //           },
                //         ),
                //         // if (isLargeDesktop(context))
                //           CrossLine(height: 4, thickness: 3),
                //         // if (!isLargeDesktop(context)) const SizedBox(height: 10),
                //         GrandIcon(
                //           iconData: Icons.accessibility,
                //           labelButton: 'Análisis de Hemáticos',
                //           onPress: () {
                //             Cambios.toNextActivity(context,
                //                 chyld: const Hematinicos());
                //           },
                //         ),
                //         GrandIcon(
                //           labelButton: 'Análisis Renal',
                //           onPress: () {
                //             Operadores.alertActivity(
                //                 context: context,
                //                 tittle: "¡Disculpas!",
                //                 message: "Actividad en construcción");
                //             // Operadores.openDialog(
                //             //     context: context, chyldrim: const Hidricos());
                //           },
                //         ),
                //         GrandIcon(
                //           labelButton: 'Análisis Sanguíneo Circulante',
                //           onPress: () {
                //             Operadores.alertActivity(
                //                 context: context,
                //                 tittle: "¡Disculpas!",
                //                 message: "Actividad en construcción");
                //             // Operadores.openDialog(
                //             //     context: context, chyldrim: const Hidricos());
                //           },
                //         ),
                //         GrandIcon(
                //           labelButton: 'Análisis Pulmonar',
                //           onPress: () {
                //             Operadores.alertActivity(
                //                 context: context,
                //                 tittle: "¡Disculpas!",
                //                 message: "Actividad en construcción");
                //             // Operadores.openDialog(
                //             //     context: context, chyldrim: const Hidricos());
                //           },
                //         ),
                //         GrandIcon(
                //           labelButton: 'Edad Corregida',
                //           onPress: () {
                //             Operadores.alertActivity(
                //                 context: context,
                //                 tittle: "¡Disculpas!",
                //                 message: "Actividad en construcción");
                //             // Operadores.openDialog(
                //             //     context: context, chyldrim: const Hidricos());
                //           },
                //         ),
                //         CrossLine(height: 20, thickness: 3),
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
        CrossLine(thickness: 3),
        Expanded(
          flex: 2,
          child: Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GrandIcon(
                  iconData: Icons.person,
                  labelButton: "Información General",
                  weigth: wieghtRow / index,
                  onPress: () {
                    carouselController.jumpToPage(0);
                  },
                ),
                GrandIcon(
                    iconData: Icons.explicit,
                    labelButton: "Exploración Física",
                    weigth: wieghtRow / index,
                    onPress: () {
                      carouselController.jumpToPage(1);
                    }),
                GrandIcon(
                    iconData: Icons.medical_information,
                    labelButton: "Auxiliares Diagnósticos",
                    weigth: wieghtRow / index,
                    onPress: () {
                      carouselController.jumpToPage(2);
                    }),
                GrandIcon(
                    iconData: Icons.explore,
                    labelButton: "Análisis y propuestas",
                    weigth: wieghtRow / index,
                    onPress: () {
                      carouselController.jumpToPage(3);
                    }),
                GrandIcon(
                    iconData: Icons.next_plan,
                    labelButton: "Diagnósticos y Pronóstico",
                    weigth: wieghtRow / index,
                    onPress: () {
                      carouselController.jumpToPage(4);
                    }),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  // Controladores de widgets en general. ######################### ### # ### ############################
  var carouselController = CarouselSliderController();
  // Variables auxiliares de widget. ######################### ### # ### ############################
  num index = 6;
  int wieghtRow = 200;
  // Controladores de widgets tipo valores. ######################### ### # ### ###########################
  var initialTextController = TextEditingController();
  var diagoTextController = TextEditingController();
  var subjetivoTextController = TextEditingController();

// INICIO DE LAS OPERACIONES STATE() Y BUILD(). ######################### ### # ### ###############
}
