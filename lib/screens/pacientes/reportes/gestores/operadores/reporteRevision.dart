import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/analisisMedico.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/auxiliaresReportes.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/exploracionFisica.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/pronosticos.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ReporteRevision extends StatefulWidget {
  const ReporteRevision({super.key});

  @override
  State<ReporteRevision> createState() => _ReporteRevisionState();
}

class _ReporteRevisionState extends State<ReporteRevision> {
  @override
  void initState() {
    Repositorios.padecimientoActual();
    Vitales.ultimoRegistro();

    // INICIAR . . .
    setState(() {
      initialTextController.text = Pacientes.prosa(isTerapia: true, otherForm: true);
      patoloTextController.text = Pacientes.patologicos();
      padesTextController.text = Reportes.padecimientoActual;
      //
      Reportes.reportes['Datos_Generales_Simple'] =  Pacientes.prosa(isTerapia: true, otherForm: true);
      Reportes.reportes['Padecimiento_Actual'] = Reportes.padecimientoActual;
      //
      //
      Reportes.reportes['Antecedentes_Quirurgicos'] = Pacientes.hospitalarios()
          .toLowerCase(); // Contiene el antecedente de cirugias.
      //
      Reportes.reportes['Antecedentes_Patologicos_Ingreso'] = Pacientes.antecedentesIngresosPatologicos(saltoLinea: "");
      Reportes.reportes['Antecedentes_Patologicos'] =
          Pacientes.patologicos().toLowerCase();
      Reportes.reportes['Antecedentes_Relevantes'] = relevantesTextController.text =
          Pacientes.antecedentesRelevantes();

      Reportes.reportes['Antecedentes_Patologicos_Otros'] =
          Pacientes.antecedentesPatologicos();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ContainerDecoration.roundedDecoration(),
      child: Column(children: [
        Expanded(
          flex: isDesktop(context) ? 2 : 1,
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
                // GrandIcon(
                //     iconData: Icons.new_releases_outlined,
                //     labelButton: "Padecimiento Actual",
                //     weigth: wieghtRow / index,
                //     onPress: () {
                //       carouselController.jumpToPage(1);
                //     }),
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
        CrossLine(thickness: 3),
        Expanded(
          flex: isDesktop(context) ? 16 : 11,
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
                          numOfLines: 3,
                          withShowOption: true,
                          inputFormat: MaskTextInputFormatter()),
                      EditTextArea(
                          textController: patoloTextController,
                          labelEditText: "Antecedentes personales patológicos",
                          keyBoardType: TextInputType.multiline,
                          numOfLines: 12,
                          inputFormat: MaskTextInputFormatter()),
                      EditTextArea(
                          textController: relevantesTextController,
                          labelEditText: "Relevantes . . . ",
                          keyBoardType: TextInputType.multiline,
                          numOfLines: 5,
                          withShowOption: true,
                          inputFormat: MaskTextInputFormatter()),
                      EditTextArea(
                          textController: padesTextController,
                          labelEditText: "Padecimiento Actual",
                          keyBoardType: TextInputType.multiline,
                          numOfLines: 10,
                          withShowOption: true,
                          onChange: (value) {
                            Reportes.padecimientoActual = value;
                          },
                          inputFormat: MaskTextInputFormatter()),
                    ],
                  ),
                ),
                ExploracionFisica(),
                AuxiliaresExploracion(isIngreso: true),
                AnalisisMedico(),
                DiagnosticosAndPronostico(),
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
  var carouselController = CarouselController();
  // ######################### ### # ### ############################
  // Variables auxiliares de widget.
  // ######################### ### # ### ############################
  num index = 6;
  int wieghtRow = 50;
  // ######################### ### # ### ############################
  // Controladores de widgets tipo valores.
  // ######################### ### # ### ############################
  var initialTextController = TextEditingController();
  var padesTextController = TextEditingController();
  var relevantesTextController = TextEditingController();
  var patoloTextController = TextEditingController();
// ######################### ### # ### ############################
// INICIO DE LAS OPERACIONES STATE() Y BUILD().
// ######################### ### # ### ############################
}
