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

class ReporteTraslado extends StatefulWidget {
  const ReporteTraslado({super.key});

  @override
  State<ReporteTraslado> createState() => _ReporteTrasladoState();
}

class _ReporteTrasladoState extends State<ReporteTraslado> {
  @override
  void initState() {
    Repositorios.padecimientoActual();
    Vitales.ultimoRegistro();

    // INICIAR . . .
    setState(() {
      motivoTextController.text = Reportes.reportes['Motivo_Traslado'];
      //
      Reportes.reportes['Datos_Generales_Simple'] = initialTextController.text =
          Pacientes.prosa(isTerapia: true, otherForm: true);
      Reportes.reportes['Padecimiento_Actual'] =
          padesTextController.text = Reportes.padecimientoActual;
      //
      //
      Reportes.reportes['Antecedentes_Quirurgicos'] = Pacientes.hospitalarios()
          .toLowerCase(); // Contiene el antecedente de cirugias.
      Reportes.reportes['Antecedentes_Patologicos_Ingreso'] =
          patoloTextController.text = Pacientes.antecedentesIngresosPatologicos(resumido: true);
      //
      Reportes.reportes['Antecedentes_Relevantes'] =
          relevantesTextController.text = Pacientes.antecedentesRelevantes();

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
        CrossLine(thickness: 3),
        Expanded(
          flex: isDesktop(context) ? 16 : 11,
          child: SingleChildScrollView(
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
                EditTextArea(
                    textController: motivoTextController,
                    labelEditText: "Motivo de Traslado",
                    keyBoardType: TextInputType.multiline,
                    numOfLines: 10,
                    withShowOption: true,
                    onChange: (value) {
                      setState(() {
                        Reportes.reportes['Motivo_Traslado'] = Reportes.motivoTraslado = value;
                      });
                    },
                    inputFormat: MaskTextInputFormatter()),
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
  var motivoTextController = TextEditingController();
// ######################### ### # ### ############################
// INICIO DE LAS OPERACIONES STATE() Y BUILD().
// ######################### ### # ### ############################
}
