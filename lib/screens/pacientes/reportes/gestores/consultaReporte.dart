import 'package:assistant/conexiones/usuarios/Pacientes.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'auxiliares/auxiliaresReportes.dart';

class ReporteConsulta extends StatefulWidget {
  const ReporteConsulta({super.key});

  @override
  State<ReporteConsulta> createState() => _ReporteConsultaState();
}

class _ReporteConsultaState extends State<ReporteConsulta> {
  // ######################### ### # ### ############################
  // Controladores de widgets en general.
  // ######################### ### # ### ############################
  var carouselController = CarouselController();
  // ######################### ### # ### ############################
  // Variables auxiliares de widget.
  // ######################### ### # ### ############################
  num index = 6;
  int wieghtRow = 400;
  // ######################### ### # ### ############################
  // Controladores de widgets tipo valores.
  // ######################### ### # ### ############################
  var initialTextController = TextEditingController();
  var consultaTextController = TextEditingController();
  var heredoTextController = TextEditingController();
  var hospiTextController = TextEditingController();
  var patoloTextController = TextEditingController();
  // ######################### ### # ### ############################
  // INICIO DE LAS OPERACIONES STATE() Y BUILD().
  // ######################### ### # ### ############################

  @override
  void initState() {
    // # # # ############## #### ########
    // Llamado a ultimo registro agregado por fecha de bd_regpace.pace_sv, pace_antropo.
    // Asignación de la consulta en Vitales.Vital.
    // # # # ############## #### ########
    Vitales.ultimoRegistro();
    // # # # ############## #### ########
    setState(() {
      initialTextController.text = Pacientes.prosa();
      consultaTextController.text = Reportes.motivoConsulta;
      heredoTextController.text = Pacientes.heredofamiliares();
      hospiTextController.text = Pacientes.hospitalarios();
      patoloTextController.text = Pacientes.patologicos();

      Reportes.reportes['Datos_Generales'] = Pacientes.prosa();
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
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              controller: ScrollController(),
              scrollDirection: Axis.horizontal,
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
                height: 450,
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
                        textController: consultaTextController,
                        labelEditText: "Motivo de Consulta",
                        keyBoardType: TextInputType.multiline,
                        numOfLines: 5,
                        onChange: (value) {
                          setState(() {
                            Reportes.motivoConsulta = "$value.";
                            Reportes.reportes['Motivo_Consulta'] = "$value.";
                          });
                        },
                        inputFormat: MaskTextInputFormatter()),
                    EditTextArea(
                        textController: heredoTextController,
                        labelEditText: "Antecedentes heredofamiliares",
                        keyBoardType: TextInputType.multiline,
                        numOfLines: 5,
                        inputFormat: MaskTextInputFormatter()),
                    EditTextArea(
                        textController: hospiTextController,
                        labelEditText: "Antecedentes hospitalarios",
                        keyBoardType: TextInputType.multiline,
                        numOfLines: 5,
                        inputFormat: MaskTextInputFormatter()),
                    EditTextArea(
                        textController: patoloTextController,
                        labelEditText: "Antecedentes personales patológicos",
                        keyBoardType: TextInputType.multiline,
                        numOfLines: 5,
                        inputFormat: MaskTextInputFormatter()),
                  ],
                ),
              ),
              const ExploracionFisica(),
              const AuxiliaresExploracion(),
              const AnalisisMedico(),
              const DiagnosticosAndPronostico(),
            ],
          ),
        ),
      ]),
    );
  }
}

class ReporteEvolucion extends StatefulWidget {
  const ReporteEvolucion({super.key});

  @override
  State<ReporteEvolucion> createState() => _ReporteEvolucionState();
}

class _ReporteEvolucionState extends State<ReporteEvolucion> {
  // ######################### ### # ### ############################
  // Controladores de widgets en general.
  // ######################### ### # ### ############################
  var carouselController = CarouselController();
  // ######################### ### # ### ############################
  // Variables auxiliares de widget.
  // ######################### ### # ### ############################
  num index = 6;
  int wieghtRow = 400;
  // ######################### ### # ### ############################
  // Controladores de widgets tipo valores.
  // ######################### ### # ### ############################
  var initialTextController = TextEditingController();
  var heredoTextController = TextEditingController();
  var hospiTextController = TextEditingController();
  var patoloTextController = TextEditingController();
  // ######################### ### # ### ############################
  // INICIO DE LAS OPERACIONES STATE() Y BUILD().
  // ######################### ### # ### ############################

  @override
  void initState() {
    // # # # ############## #### ########
    setState(() {
      initialTextController.text = Pacientes.prosa();
      heredoTextController.text = Pacientes.heredofamiliares();
      hospiTextController.text = Pacientes.hospitalarios();
      patoloTextController.text = Pacientes.patologicos();

      Reportes.reportes['Datos_Generales'] = Pacientes.prosa();
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
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              controller: ScrollController(),
              scrollDirection: Axis.horizontal,
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
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
                height: 450,
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
                        textController: heredoTextController,
                        labelEditText: "Antecedentes heredofamiliares",
                        keyBoardType: TextInputType.multiline,
                        numOfLines: 5,
                        inputFormat: MaskTextInputFormatter()),
                    EditTextArea(
                        textController: hospiTextController,
                        labelEditText: "Antecedentes hospitalarios",
                        keyBoardType: TextInputType.multiline,
                        numOfLines: 5,
                        inputFormat: MaskTextInputFormatter()),
                    EditTextArea(
                        textController: patoloTextController,
                        labelEditText: "Antecedentes personales patológicos",
                        keyBoardType: TextInputType.multiline,
                        numOfLines: 5,
                        inputFormat: MaskTextInputFormatter()),
                  ],
                ),
              ),
              const ExploracionFisica(),
              const AuxiliaresExploracion(),
              const AnalisisMedico(),
              const DiagnosticosAndPronostico(),
            ],
          ),
        ),
      ]),
    );
  }
}
