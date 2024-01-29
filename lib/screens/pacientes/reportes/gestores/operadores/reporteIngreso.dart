import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
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

class ReporteIngreso extends StatefulWidget {
  const ReporteIngreso({super.key});

  @override
  State<ReporteIngreso> createState() => _ReporteIngresoState();
}

class _ReporteIngresoState extends State<ReporteIngreso> {
  @override
  void initState() {
    //
    // Repositorios.consultarAnalisis();
    Vitales.ultimoRegistro();
    // INICIAR . . .
    setState(() {
      Reportes.reportes['Datos_Generales'] =
          initialTextController.text = Pacientes.prosa();
      Reportes.reportes['Padecimiento_Actual'] =
          padesTextController.text = Reportes.padecimientoActual;
      Reportes.reportes['Antecedentes_No_Patologicos'] =
          noPatolTextController.text = Pacientes.noPatologicosSimplificado();
      Reportes.reportes['Antecedentes_Heredofamiliares'] = heredoTextController
          .text = Pacientes.heredofamiliares().toLowerCase();
      Reportes.reportes['Antecedentes_Quirurgicos'] = hospiTextController.text =
          Pacientes.hospitalarios()
              .toLowerCase(); // Contiene el antecedente de cirugias.
      Reportes.reportes['Antecedentes_Patologicos_Otros'] = Reportes
              .reportes['Antecedentes_Patologicos_Ingreso'] =
          Reportes.reportes['Antecedentes_Patologicos'] =
              patoloTextController.text = Pacientes.patologicos();
      Reportes.reportes['Antecedentes_Alergicos'] =
          alergoTextController.text = Pacientes.alergicos().toLowerCase();
    });
    super.initState();
  }
//
//   void buscar() {
//     Archivos.readJsonToMap(
//             filePath: "${Pacientes.localRepositoryPath}/reportes/reportes.json")
//         .then((value) {
//       Pacientes.Notas = value;
//       // VALUE almacenado en Json : : "${Pacientes.localRepositoryPath}/reportes/reportes.json"
//       Terminal.printSuccess(
//           message: "VALUE reportes.json- ${value.last} "
//               ": ${value.runtimeType} "
//               ": : ${value.last.runtimeType}");
//       // Actualizar . . .
//       setState(() {
//         // Del Padecimiento **************************************************
//         Reportes.padecimientoActual = value.last['Padecimiento_Actual'] ?? '';
//         Valores.fechaPadecimientoActual =
//             value.last['Fecha_Padecimiento'] ?? '';
//         // Primeras Variables **************************************************
//         Reportes.impresionesDiagnosticas =
//             value.last['Diagnosticos_Hospital'] ?? '';
//         // Primeras Variables **************************************************
//         Reportes.exploracionFisica = value.last['Exploracion_Fisica'] ?? '';
//         Reportes.signosVitales = value.last['Signos_Vitales'] ?? '';
//         // Segundas Variables **************************************************
//         // Reportes.eventualidadesOcurridas =
//         //     value.last['Eventualidades'] ?? '';
//         // Reportes.terapiasPrevias = value.last['Terapias_Previas'] ?? '';
//         Reportes.analisisMedico = value.last['Analisis_Medico'] ?? '';
//         // Reportes.tratamientoPropuesto =
//         //     value.last['Tratamiento_Propuesto'] ?? '';
//         // Listados desde String  ************************************************
//         // Reportes.dieta = ;
//
//         // String aux = "";
//         // aux.replaceAll(", ", ",");
//         // print(""
//         //     // "Opción A - ${jsonDecode(value.last['Dietoterapia'])} - ${jsonDecode(value.last['Dietoterapia']).runtimeType}"
//         //     //"Opcion B - ${json.decode(value.last['Medidas_Generales']).cast<List<dynamic>>()}"
//         //     "Opcion C - ${Listas.listFromString(value.last['Medidas_Generales'].replaceAll(", ", ","))} : ${value.last['Medidas_Generales'].runtimeType}");
//
//         // Reportes.dieta = json
//         //     .decode(value.last['Dietoterapia'].toString())
//         //     .cast<String>();
//         //     .toList();
//         // Reportes.hidroterapia = json
//         //     .decode(value.last['Hidroterapia'].toString())
//         //     .cast<String>()
//         //     .toList();
//         // Reportes.insulinoterapia = json
//         //     .decode(value.last['Insulinoterapia'].toString())
//         //     .cast<String>()
//         //     .toList();
//         // Reportes.hemoterapia = json
//         //     .decode(value.last['Hemoterapia'].toString())
//         //     .cast<String>()
//         //     .toList();
//         // Reportes.oxigenoterapia = json
//         //     .decode(value.last['Oxigenoterapia'].toString())
//         //     .cast<String>()
//         //     .toList();
//         // Reportes.medicamentosIndicados = json
//         //     .decode(value.last['Medicamentos'].toString())
//         //     .cast<String>()
//         //     .toList();
//         // Reportes.medidasGenerales = json
//         //     .decode(value.last['Medidas_Generales'].toString())
//         //     .cast<String>()
//         //     .toList();
//         // Reportes.pendientes = json
//         //     .decode(value.last['Pendientes'].toString())
//         //     .cast<String>()
//         //     .toList();
//         // Crear Json desde Pacientes.Notas ***************************************
//       });
//     }).onError((error, stackTrace) {
//       Terminal.printAlert(
//           message: "ERROR - No fue posible acceder a "
//               "${"${Pacientes.localRepositoryPath}/reportes/reportes.json"} : $error : : $stackTrace");
// // Consultar Base de Datos : pace_hosp_repo : : Donde están todos los Análisis descritos
//       Repositorios.consultarAnalisis();
//     });
//   }

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
                      Row(
                        children: [
                          Expanded(
                            flex: 10,
                            child: EditTextArea(
                                textController: noPatolTextController,
                                labelEditText: "Antecedentes No Patológicos",
                                keyBoardType: TextInputType.multiline,
                                numOfLines: 8,
                                withShowOption: true,
                                inputFormat: MaskTextInputFormatter()),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GrandIcon(
                                    labelButton: 'No Patológicos',
                                    iconData: Icons.account_balance,
                                    onPress: () {
                                      noPatolTextController.text =
                                          Pacientes.noPatologicos();
                                      Reportes.reportes[
                                              'Antecedentes_No_Patologicos'] =
                                          Pacientes.noPatologicos();
                                    }),
                                CrossLine(
                                  isHorizontal: false,
                                  thickness: 4,
                                  color: Colors.white,
                                  height: 8,
                                ),
                                GrandIcon(
                                    labelButton: 'No Patológicos Simplificado',
                                    iconData: Icons.account_balance_outlined,
                                    onPress: () {
                                      noPatolTextController.text =
                                          Pacientes.noPatologicosSimple();
                                      Reportes.reportes[
                                              'Antecedentes_No_Patologicos'] =
                                          Pacientes.noPatologicosSimple();
                                    }),
                                CrossLine(
                                  isHorizontal: false,
                                  thickness: 4,
                                  color: Colors.white,
                                  height: 8,
                                ),
                                GrandIcon(
                                    labelButton: 'No Patológicos Resumido',
                                    iconData: Icons.account_balance_sharp,
                                    onPress: () {
                                      noPatolTextController.text =
                                          Pacientes.noPatologicosResumido();
                                      Reportes.reportes[
                                              'Antecedentes_No_Patologicos'] =
                                          Pacientes.noPatologicosResumido();
                                    }),
                                CrossLine(
                                  isHorizontal: false,
                                  thickness: 4,
                                  color: Colors.white,
                                  height: 8,
                                ),
                                GrandIcon(
                                    labelButton: 'No Patológicos Simplificado',
                                    iconData: Icons.account_balance_sharp,
                                    onPress: () {
                                      noPatolTextController.text =
                                          Pacientes.noPatologicosSimplificado();
                                      Reportes.reportes[
                                              'Antecedentes_No_Patologicos'] =
                                          Pacientes.noPatologicosSimplificado();
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                      EditTextArea(
                          textController: heredoTextController,
                          labelEditText: "Antecedentes heredofamiliares",
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
                          textController: hospiTextController,
                          labelEditText: "Antecedentes quirúrgicos",
                          keyBoardType: TextInputType.multiline,
                          numOfLines: 5,
                          selection: true,
                          withShowOption: true,
                          onSelected: () {
                            setState(() {
                              hospiTextController.text = "";
                              hospiTextController.text = "Negados. ";
                              Reportes.reportes['Antecedentes_Quirurgicos'] =
                                  hospiTextController.text;
                            });
                          },
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
  var heredoTextController = TextEditingController();
  var hospiTextController = TextEditingController();
  var patoloTextController = TextEditingController();
  var noPatolTextController = TextEditingController();
  var alergoTextController = TextEditingController();
// ######################### ### # ### ############################
// INICIO DE LAS OPERACIONES STATE() Y BUILD().
// ######################### ### # ### ############################
}
