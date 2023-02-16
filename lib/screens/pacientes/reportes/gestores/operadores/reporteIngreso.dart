import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/auxiliaresReportes.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/exploracionFisica.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ReporteIngreso extends StatefulWidget {
  const ReporteIngreso({super.key});

  @override
  State<ReporteIngreso> createState() => _ReporteIngresoState();
}

class _ReporteIngresoState extends State<ReporteIngreso> {

  @override
  void initState() {
    Actividades.consultarId(
        Databases.siteground_database_reghosp,
        Repositorios.repositorio['consultPadecimientoQuery'],
        Pacientes.ID_Hospitalizacion)
        .then((response) {
      // print("RESPUESTA $response");
      setState(() {
        Reportes.padecimientoActual = "Inicia padecimiento actual el dia ${response['FechaPadecimiento']}, ${response['Contexto']}";
        padesTextController.text = Reportes.padecimientoActual;
      });
    });
    // # # # ############## #### ########
    setState(() {
      initialTextController.text = Pacientes.prosa();
      padesTextController.text = Reportes.padecimientoActual;
      noPatolTextController.text = Pacientes.noPatologicos();
      heredoTextController.text = Pacientes.heredofamiliares();
      hospiTextController.text = Pacientes.hospitalarios();
      patoloTextController.text = Pacientes.patologicos();
      alergoTextController.text = Pacientes.alergicos();

      Reportes.reportes['Datos_Generales'] = Pacientes.prosa();
      Reportes.reportes['Padecimiento_Actual'] = Reportes.padecimientoActual;
      //
      Reportes.reportes['Antecedentes_No_Patologicos'] =Pacientes.noPatologicos(); // .toLowerCase();

      Reportes.reportes['Antecedentes_Heredofamiliares'] =
          Pacientes.heredofamiliares().toLowerCase();
      Reportes.reportes['Antecedentes_Quirurgicos'] =
          Pacientes.hospitalarios().toLowerCase(); // Contiene el antecedente de cirugias.
      Reportes.reportes['Antecedentes_Patologicos'] = Pacientes.patologicos().toLowerCase();
      Reportes.reportes['Antecedentes_Alergicos'] = Pacientes.alergicos().toLowerCase();

      Reportes.reportes['Antecedentes_Patologicos_Otros'] =Pacientes.antecedentesPatologicos();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                      iconData: Icons.new_releases_outlined,
                      labelButton: "Padecimiento Actual",
                      weigth: wieghtRow / index,
                      onPress: () {
                        carouselController.jumpToPage(1);
                      }),

                  GrandIcon(
                      iconData: Icons.explicit,
                      labelButton: "Exploración Física",
                      weigth: wieghtRow / index,
                      onPress: () {
                        carouselController.jumpToPage(2);
                      }),
                  GrandIcon(
                      iconData: Icons.medical_information,
                      labelButton: "Auxiliares Diagnósticos",
                      weigth: wieghtRow / index,
                      onPress: () {
                        carouselController.jumpToPage(3);
                      }),
                  GrandIcon(
                      iconData: Icons.explore,
                      labelButton: "Análisis y propuestas",
                      weigth: wieghtRow / index,
                      onPress: () {
                        carouselController.jumpToPage(4);
                      }),
                  GrandIcon(
                      iconData: Icons.next_plan,
                      labelButton: "Diagnósticos y Pronóstico",
                      weigth: wieghtRow / index,
                      onPress: () {
                        carouselController.jumpToPage(5);
                      }),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                  height: isMobile(context) || isTablet(context) ? 900: 450,
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
                          textController: noPatolTextController,
                          labelEditText: "Antecedentes No Patológicos",
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
                          labelEditText: "Antecedentes quirúrgicos",
                          keyBoardType: TextInputType.multiline,
                          numOfLines: 5,
                          inputFormat: MaskTextInputFormatter()),
                      EditTextArea(
                          textController: patoloTextController,
                          labelEditText: "Antecedentes personales patológicos",
                          keyBoardType: TextInputType.multiline,
                          numOfLines: 5,
                          inputFormat: MaskTextInputFormatter()),
                      EditTextArea(
                          textController: alergoTextController,
                          labelEditText: "Antecedentes alérgicos",
                          keyBoardType: TextInputType.multiline,
                          numOfLines: 5,
                          inputFormat: MaskTextInputFormatter()),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      EditTextArea(
                          textController: padesTextController,
                          labelEditText: "Padecimiento Actual",
                          keyBoardType: TextInputType.multiline,
                          numOfLines: 20,
                          withShowOption: true,
                          inputFormat: MaskTextInputFormatter()),
                    ],
                  ),
                ),
                ExploracionFisica(),
                AuxiliaresExploracion(),
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
  var heredoTextController = TextEditingController();
  var hospiTextController = TextEditingController();
  var patoloTextController = TextEditingController();
  var noPatolTextController = TextEditingController();
  var alergoTextController = TextEditingController();
// ######################### ### # ### ############################
// INICIO DE LAS OPERACIONES STATE() Y BUILD().
// ######################### ### # ### ############################

}
