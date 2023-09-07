import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/auxiliares/hospitalarios/subjetivos.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/auxiliaresReportes.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/exploracionFisica.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
      initialTextController.text = Pacientes.prosa(isTerapia: true);
      // ********************************************
      diagoTextController.text = Pacientes.diagnosticos();
      subjetivoTextController.text = Pacientes.subjetivos();
      // ********************************************
      heredoTextController.text = Pacientes.heredofamiliares();
      hospiTextController.text = Pacientes.hospitalarios();
      patoloTextController.text = Pacientes.patologicos();

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
      decoration: ContainerDecoration.roundedDecoration(),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        CrossLine(height: 7, thickness: 3),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CarouselSlider(
            carouselController: carouselController,
            options: Carousel.carouselOptions(context: context, height: isMobile(context) ?  345 : 640),
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
                        numOfLines: 10,
                        onChange: ((value) {
                          Reportes.impresionesDiagnosticas = "$value.";
                          Reportes.reportes['Impresiones_Diagnosticas'] =
                              "$value.";
                        }),
                        inputFormat: MaskTextInputFormatter()),
                    EditTextArea(
                        textController: subjetivoTextController,
                        labelEditText: "Referidos del Paciente",
                        keyBoardType: TextInputType.multiline,
                        numOfLines: 5,
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
                              tittle:  'Subjetivo del paciente',
                            chyld: const Subjetivos());
                        },
                        onChange: ((value) {
                          Reportes.subjetivoHospitalizacion = "$value.";
                          Reportes.reportes['Subjetivo'] = "$value.";
                        }),
                        inputFormat: MaskTextInputFormatter()),
                  ],
                ),
              ),
              ExploracionFisica(),
              AuxiliaresExploracion(),
              AnalisisMedico(),
              DiagnosticosAndPronostico(
                isTerapia: true,
              ),
            ],
          ),
        ),
      ]),
    );
  }

  // ######################### ### # ### ############################
  // Controladores de widgets en general.
  // ######################### ### # ### ############################
  var carouselController = CarouselController();
  // ######################### ### # ### ############################
  // Variables auxiliares de widget.
  // ######################### ### # ### ############################
  num index = 6;
  int wieghtRow = 200;
  // ######################### ### # ### ############################
  // Controladores de widgets tipo valores.
  // ######################### ### # ### ############################
  var initialTextController = TextEditingController();
  var diagoTextController = TextEditingController();
  var subjetivoTextController = TextEditingController();
  var heredoTextController = TextEditingController();
  var hospiTextController = TextEditingController();
  var patoloTextController = TextEditingController();
// ######################### ### # ### ############################
// INICIO DE LAS OPERACIONES STATE() Y BUILD().
// ######################### ### # ### ############################
}
