import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/auxiliaresReportes.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/exploracionFisica.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandIcon.dart';
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
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(children: [
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
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                          keyBoardType: TextInputType.multiline,
                          numOfLines: 5,
                          withShowOption: true,
                          inputFormat: MaskTextInputFormatter()),
                      EditTextArea(
                          textController: diagoTextController,
                          labelEditText: "Impresiones diagnósticas",
                          keyBoardType: TextInputType.multiline,
                          numOfLines: !isMobile(context) ? 10 : 16,
                          onChange: ((value) {
                            Reportes.impresionesDiagnosticas = "$value.";
                            Reportes.reportes['Impresiones_Diagnosticas'] =
                                "$value.";
                          }),
                          inputFormat: MaskTextInputFormatter()),
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
      ]),
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
// ######################### ### # ### ############################
// INICIO DE LAS OPERACIONES STATE() Y BUILD().
// ######################### ### # ### ############################
}
