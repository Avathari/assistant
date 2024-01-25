import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/antropometricos.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/cardiovasculares.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/gasometricos.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/hematinicos.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/hidricos.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/metabolometrias.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/ventilatorios.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/analisisMedico.dart';
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
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ReporteTerapia extends StatefulWidget {
  const ReporteTerapia({super.key});

  @override
  State<ReporteTerapia> createState() => _ReporteTerapiaState();
}

class _ReporteTerapiaState extends State<ReporteTerapia> {

  @override
  void initState() {
    // # # # ############## #### ########
    // Llamado a ultimo registro agregado por fecha de bd_regpace.pace_sv, pace_antropo.
    // Asignación de la consulta en Vitales.Vital.
    // # # # ############## #### ########
    // Vitales.ultimoRegistro();
    // # # # ############## #### ########
    setState(() {
      initialTextController.text = Pacientes.prosa(isTerapia: true);
      //
      diagoTextController.text = Pacientes.diagnosticos();
      //
      consultaTextController.text = Reportes.motivoConsulta;
      heredoTextController.text = Pacientes.heredofamiliares();
      hospiTextController.text = Pacientes.hospitalarios();
      patoloTextController.text = Pacientes.patologicos();

      Reportes.reportes['Datos_Generales'] = Pacientes.prosa(isTerapia: true);
      Reportes.reportes['Motivo_Consulta'] = Reportes.motivoConsulta;
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
    return TittleContainer(
      tittle: 'Evaluación de Terapia Intensiva . . . ',
      color: Colors.black,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(children: [
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: ContainerDecoration.roundedDecoration(),
                    child: CarouselSlider(
                      carouselController: carouselController,
                      options: Carousel.carouselOptions(context: context),
                      items: [
                        SingleChildScrollView(
                          controller: ScrollController(),
                          child: Column(
                            children: [
                              EditTextArea(
                                  textController: initialTextController,
                                  labelEditText: "Datos generales",
                                  keyBoardType: TextInputType.text,
                                  numOfLines: 1,
                                  withShowOption: true,
                                  inputFormat: MaskTextInputFormatter()),
                              Row(
                                children: [
                                  Expanded(
                                    flex: isMobile(context) || isDesktop(context) ? 3 : 1,
                                    child: EditTextArea(
                                        textController: diagoTextController,
                                        labelEditText: "Impresiones diagnósticas",
                                        keyBoardType: TextInputType.multiline,
                                        numOfLines: 10,
                                        onChange: ((value) {
                                          Reportes.impresionesDiagnosticas =
                                          "$value.";
                                          Reportes.reportes[
                                          'Impresiones_Diagnosticas'] =
                                          "$value.";
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
                            ],
                          ),
                        ),
                        ExploracionFisica(
                          isTerapia: true,
                        ),
                        // const AuxiliaresExploracion(),
                         AnalisisMedico(),
                        DiagnosticosAndPronostico(
                          isTerapia: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CrossLine(thickness: 3),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
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
                          iconData: Icons.explore,
                          labelButton: "Análisis y propuestas",
                          weigth: wieghtRow / index,
                          onPress: () {
                            carouselController.jumpToPage(2);
                          }),
                      GrandIcon(
                          iconData: Icons.next_plan,
                          labelButton: "Diagnósticos y Pronóstico",
                          weigth: wieghtRow / index,
                          onPress: () {
                            carouselController.jumpToPage(3);
                          }),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          Expanded(
            flex: 3,
            child: _anylisis(context),
          ),
        ],
      ),
    );
  }

  // Controladores de widgets en general. ******************************
  var carouselController = CarouselController();
  // Variables auxiliares de widget. ***********************************
  num index = 6;
  int wieghtRow = 50;
  // Controladores de widgets tipo valores. *****************************
  var initialTextController = TextEditingController();
  var diagoTextController = TextEditingController();
  var consultaTextController = TextEditingController();
  var heredoTextController = TextEditingController();
  var hospiTextController = TextEditingController();
  var patoloTextController = TextEditingController();

  _optionals(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        direction: Axis.vertical,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
        spacing: 10,runSpacing: 0,
        children: [
          GrandIcon(
            iconData: Icons.water_drop,
            labelButton: 'Análisis Hidrico',
            onPress: () {
              Cambios.toNextActivity(context,
                  chyld: const Hidricos());
            },
          ),
          GrandIcon(
            iconData: Icons.bubble_chart,
            labelButton: 'Análisis Metabólico',
            onPress: () {
              Operadores.openDialog(
                  context: context,
                  chyldrim: const Metabolicos());
            },
          ),
          GrandIcon(
            iconData: Icons.horizontal_rule_sharp,
            labelButton: 'Análisis Antropométrico',
            onPress: () {
              Operadores.openDialog(
                  context: context,
                  chyldrim: const Antropometricos());
            },
          ),
          GrandIcon(
            iconData: Icons.monitor_heart_outlined,
            labelButton: 'Análisis Cardiovascular',
            onPress: () {
              Operadores.openDialog(
                  context: context,
                  chyldrim: const Cardiovasculares());
            },
          ),
          GrandIcon(
            iconData: Icons.all_inclusive_rounded,
            labelButton: 'Análisis Ventilatorio',
            onPress: () {
              Operadores.openDialog(
                  context: context,
                  chyldrim: const Ventilatorios());
            },
          ),
          GrandIcon(
            iconData: Icons.g_mobiledata,
            labelButton: 'Análisis Gasométrico',
            onPress: () {
              Cambios.toNextActivity(context,
                  chyld: const Gasometricos());
            },
          ),
          CrossLine(height: 20, thickness: 3),
          GrandIcon(
            iconData: Icons.accessibility,
            labelButton: 'Análisis de Hemáticos',
            onPress: () {
              Cambios.toNextActivity(context,
                  chyld: const Hematinicos());
            },
          ),
          GrandIcon(
            labelButton: 'Análisis Renal',
            onPress: () {
              Operadores.alertActivity(
                  context: context,
                  tittle: "¡Disculpas!",
                  message: "Actividad en construcción");
              // Operadores.openDialog(
              //     context: context, chyldrim: const Hidricos());
            },
          ),
          GrandIcon(
            labelButton: 'Análisis Sanguíneo Circulante',
            onPress: () {
              Operadores.alertActivity(
                  context: context,
                  tittle: "¡Disculpas!",
                  message: "Actividad en construcción");
              // Operadores.openDialog(
              //     context: context, chyldrim: const Hidricos());
            },
          ),
          GrandIcon(
            labelButton: 'Análisis Pulmonar',
            onPress: () {
              Operadores.alertActivity(
                  context: context,
                  tittle: "¡Disculpas!",
                  message: "Actividad en construcción");
              // Operadores.openDialog(
              //     context: context, chyldrim: const Hidricos());
            },
          ),
          GrandIcon(
            labelButton: 'Edad Corregida',
            onPress: () {
              Operadores.alertActivity(
                  context: context,
                  tittle: "¡Disculpas!",
                  message: "Actividad en construcción");
              // Operadores.openDialog(
              //     context: context, chyldrim: const Hidricos());
            },
          ),
        ],
      ),
    );
  }
// ######################### ### # ### ############################
// INICIO DE LAS OPERACIONES STATE() Y BUILD().
// ######################### ### # ### ############################
}

_anylisis(BuildContext context) {
  return Container(
    decoration: ContainerDecoration.roundedDecoration(),
    child: const Cardiovasculares(),
  );
}
