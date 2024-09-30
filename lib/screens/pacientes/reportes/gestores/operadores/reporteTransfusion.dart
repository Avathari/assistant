import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/hospitalarios/globulares.dart';
import 'package:assistant/screens/pacientes/auxiliares/hospitalarios/subjetivos.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/auxiliaresReportes.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/exploracionFisica.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/seguimientoVitales.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/transfusion.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ReporteTransfusion extends StatefulWidget {
  const ReporteTransfusion({super.key});

  @override
  State<ReporteTransfusion> createState() => _ReporteTransfusionState();
}

class _ReporteTransfusionState extends State<ReporteTransfusion> {

  @override
  void initState() {
    Terminal.printOther(message: "TIPO DE REPORTE : ReporteTransfusion");
    // # # # ############## #### ########
    setState(() {
      initialTextController.text = Pacientes.prosa(isTerapia: true);
      //
      diagoTextController.text = Pacientes.diagnosticos();
      motivoTextController.text = Reportes.reportes['Motivo_Transfusion']; // Pacientes.subjetivos();
      edoGralTextController.text = Valores.estadoFinalTransfusion;
      //
      Reportes.reportes['Datos_Generales'] = Pacientes.prosa(isTerapia: true);
      Reportes.reportes['Impresiones_Diagnosticas'] =  Pacientes.diagnosticos();

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ContainerDecoration.roundedDecoration(),
      child: Column(children: [
        Expanded(
          flex: 2,
          child: Container(
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
                    iconData: Icons.bloodtype,
                    labelButton: "Datos Generales de la Transfusión",
                    weigth: wieghtRow / index,
                    onPress: () {
                      carouselController.jumpToPage(1);
                    }),
                GrandIcon(
                    iconData: Icons.blur_linear_sharp,
                    labelButton: "Seguimiento de Signos Vitales",
                    weigth: wieghtRow / index,
                    onPress: () {
                      carouselController.jumpToPage(2);
                    }),
              ],
            ),
          ),
        ),
        Expanded(
          flex: isDesktop(context) ? 16 : 9,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                  height: isMobile(context) ? 1000 : isTablet(context) ? 1200 : 450,
                  enableInfiniteScroll: false,
                  viewportFraction: 1.0),
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
                          numOfLines: 5,
                          onChange: ((value) {
                            Reportes.impresionesDiagnosticas = "$value.";
                            Reportes.reportes['Impresiones_Diagnosticas'] =
                            "$value.";
                          }),
                          inputFormat: MaskTextInputFormatter()),
                      EditTextArea(
                          textController: motivoTextController,
                          labelEditText: "Motivo de la Transfusión",
                          keyBoardType: TextInputType.multiline,
                          numOfLines: 5,
                          selection: true,
                          withShowOption: true,
                          onSelected: () {
                            Operadores.openDialog(
                                context: context,
                                chyldrim: const Hemoderivados(),
                                onAction: () {
                                  setState(() {
                                    motivoTextController.text =
                                   Formatos.transfusiones;
                                    Reportes.reportes['Motivo_Transfusion'] =
                                    "${motivoTextController.text}.";
                                  });
                                });
                          },
                          onChange: ((value) {
                            Valores.motivoTransfusion = "$value.";
                            Reportes.reportes['Motivo_Transfusion'] =
                            "$value.";
                          }),
                          inputFormat: MaskTextInputFormatter()),
                      EditTextArea(
                          textController: edoGralTextController,
                          labelEditText: "Estado General del Paciente",
                          keyBoardType: TextInputType.multiline,
                          numOfLines: 5,
                          onChange: ((value) {
                            Valores.estadoFinalTransfusion = "$value.";
                            Reportes.reportes['Estado_Final_Transfusion'] =
                            "$value.";
                          }),
                          inputFormat: MaskTextInputFormatter()),
                    ],
                  ),
                ),
                Transfusion(),
                SeguimientoVitales(),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  // ######################### ### # ### ############################
  // Controladores de widgets en general.
  // ######################### ### # ### ############################
  var carouselController = CarouselSliderController();

  // Variables auxiliares de widget. ************** ************ *****
  num index = 3;
  int wieghtRow = 50;

  // Controladores de widgets tipo valores. ************** ************ *****
  var initialTextController = TextEditingController();
  var diagoTextController = TextEditingController();
  var motivoTextController = TextEditingController();
  var edoGralTextController = TextEditingController();
// ######################### ### # ### ############################
// INICIO DE LAS OPERACIONES STATE() Y BUILD().
// ######################### ### # ### ############################
}
