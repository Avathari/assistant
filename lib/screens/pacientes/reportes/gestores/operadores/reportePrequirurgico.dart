import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/auxiliaresReportes.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/exploracionFisica.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/DialogSelector.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ReportePrequirurgico extends StatefulWidget {
  const ReportePrequirurgico({super.key});

  @override
  State<ReportePrequirurgico> createState() => _ReportePrequirurgicoState();
}

class _ReportePrequirurgicoState extends State<ReportePrequirurgico> {
  @override
  void initState() {
    // # # # ############## #### ########
    setState(() {
      initialTextController.text = Pacientes.prosa();
      // padesTextController.text = Reportes.padecimientoActual;
      noPatolTextController.text = Pacientes.noPatologicosAnalisis();

      typQuiroTextController.text = Valores.tipoCirugia;
      motivoQuiroTextController.text = Valores.motivoCirugia;

      Reportes.reportes['Motivo_Prequirurgico'] = Pacientes.motivoPrequirurgico();
      Reportes.reportes['Datos_Generales'] = Pacientes.prosa();
      Reportes.reportes['Padecimiento_Actual'] = Reportes.padecimientoActual;
      //
      Reportes.reportes['noPatologicosAnalisis'] =
          noPatolTextController.text;
          // Pacientes.noPatologicosAnalisis(); // .toLowerCase();

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
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                  height: isMobile(context) || isTablet(context) ? 900 : 600,
                  enableInfiniteScroll: false,
                  viewportFraction: 1.0),
              items: [
                SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      Spinner(
                        tittle: "Tipo de Interrogatorio",
                          width: SpinnersValues.mediumWidth(context: context),
                          onChangeValue: (value) {
                        setState(() {
                          Valores.tipoInterrogatorio = value;
                          Reportes.reportes['Motivo_Prequirurgico'] = Pacientes.motivoPrequirurgico();
                        });
                      }, items: Items.tipoInterrogatorio, initialValue: Valores.tipoInterrogatorio),
                      Row(
                        children: [
                          Expanded(
                            child: EditTextArea(
                                textController: motivoQuiroTextController,
                                labelEditText: "Motivo de la Cirugía",
                                keyBoardType: TextInputType.multiline,
                                numOfLines: 1,
                                onChange: (value) {
                                  setState(() {
                                    Valores.motivoCirugia = value;
                                    Reportes.reportes['Motivo_Prequirurgico'] = Pacientes.motivoPrequirurgico();
                                  });
                                },
                                inputFormat: MaskTextInputFormatter()),
                          ),
                          Expanded(
                            flex: 2,
                            child: EditTextArea(
                                textController: typQuiroTextController,
                                labelEditText: "Tipo de Cirugía",
                                keyBoardType: TextInputType.multiline,
                                numOfLines: 1,
                                selection: true,
                                withShowOption: true,
                                onSelected: () {
                                  Operadores.openDialog(
                                      context: context,
                                      chyldrim: DialogSelector(
                                        tittle: 'Elemento quirúrgico',
                                        searchCriteria: 'Buscar por',
                                        typeOfDocument: 'txt',
                                        pathForFileSource:
                                            'assets/diccionarios/Cirugias.txt',
                                        onSelected: ((value) {
                                          setState(() {
                                            Valores.tipoCirugia = value;
                                            typQuiroTextController.text =
                                                Valores.tipoCirugia;
                                            Reportes.reportes['Motivo_Prequirurgico'] = Pacientes.motivoPrequirurgico();
                                          });
                                        }),
                                      ));
                                },
                                inputFormat: MaskTextInputFormatter()),
                          ),
                        ],
                      ),
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
                          numOfLines: 15,
                          withShowOption: true,
                          inputFormat: MaskTextInputFormatter()),

                    ],
                  ),
                ),
                ExploracionFisica(),
                const AuxiliaresExploracion(),
                AnalisisMedico(isPrequirurgica: true,),
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
  var typQuiroTextController = TextEditingController();
  var motivoQuiroTextController = TextEditingController();
  // ********* ********* ******** ************** *
  var initialTextController = TextEditingController();
  var noPatolTextController = TextEditingController();
  // var padesTextController = TextEditingController();
  // var heredoTextController = TextEditingController();
  // var hospiTextController = TextEditingController();
  // var patoloTextController = TextEditingController();

  // var alergoTextController = TextEditingController();
// ######################### ### # ### ############################
// INICIO DE LAS OPERACIONES STATE() Y BUILD().
// ######################### ### # ### ############################
}
