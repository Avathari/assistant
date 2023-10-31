import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/hidrometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/metabolometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/DialogSelector.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class IndicacionesHospital extends StatefulWidget {
  const IndicacionesHospital({super.key});

  @override
  State<IndicacionesHospital> createState() => _IndicacionesHospitalState();
}

class _IndicacionesHospitalState extends State<IndicacionesHospital> {
  var dietaTextController = TextEditingController();
  var liquidosTextController = TextEditingController();
  var medicamentosTextController = TextEditingController();
  var medidasTextController = TextEditingController();
  var insulinoterapiaTextController = TextEditingController();
  var oxigenoterapiaTextController = TextEditingController();
  var hemoterapiaTextController = TextEditingController();
  var pendientesTextController = TextEditingController();

  //
  var carouselController = CarouselController();
  //
  double? inSodio = 0,
      inPotasio = 0,
      inCloro = 0,
      inCloruro = 0,
      inLactato = 0,
      inOsmolaridad = 0,
      inGlucosa = 0,
      inCalcio = 0;

  @override
  void initState() {
    dietaTextController.text = Listas.traduceToString(Reportes.dieta);
    liquidosTextController.text = Listas.traduceToString(Reportes.hidroterapia);
    medicamentosTextController.text = Listas.traduceToString(Reportes.medicamentosIndicados);
    medidasTextController.text = Listas.traduceToString(Reportes.medidasGenerales);
    insulinoterapiaTextController.text = Listas.traduceToString(Reportes.insulinoterapia);
    oxigenoterapiaTextController.text = Listas.traduceToString(Reportes.oxigenoterapia);
    hemoterapiaTextController.text = Listas.traduceToString(Reportes.hemoterapia);
    pendientesTextController.text = Listas.traduceToString(Reportes.pendientes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: ContainerDecoration.containerDecoration(),
      child: Column(
        children: [
          TittlePanel(
            color: Colores.backgroundPanel,
            textPanel: 'Indicaciones de la Hospitalización',
          ),
          Expanded(
            child: CarouselSlider(
              carouselController: carouselController,
              options: Carousel.carouselOptions(context: context),
              items: [
                Container(
                  decoration: ContainerDecoration.roundedDecoration(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(5),
                          decoration: ContainerDecoration.roundedDecoration(),
                          child: GridView(
                            padding: const EdgeInsets.all(5.0),
                            controller: ScrollController(),
                            gridDelegate: GridViewTools.gridDelegate(
                                crossAxisCount: isMobile(context) ? 4 : 1,
                                mainAxisExtent:
                                    isDesktop(context) ? 66 : 65), //46
                            children: [
                              ValuePanel(
                                firstText: 'Gasto Energético Basal',
                                secondText: Metabolometrias.gastoEnergeticoBasal
                                    .toStringAsFixed(2),
                                thirdText: 'kCal/Día',
                              ),
                              ValuePanel(
                                firstText: 'Metabolismo Basal',
                                secondText:
                                Metabolometrias.metabolismoBasal.toStringAsFixed(2),
                                thirdText: 'kCal/Día',
                              ),
                              ValuePanel(
                                firstText: 'E.T.A.',
                                secondText: Metabolometrias.efectoTermicoAlimentos
                                    .toStringAsFixed(2),
                                thirdText: 'kCal/Día',
                              ),
                              ValuePanel(
                                firstText: 'Gasto Energético Total',
                                secondText: Metabolometrias.gastoEnergeticoTotal
                                    .toStringAsFixed(2),
                                thirdText: 'kCal/Día',
                              ),
                              Container(),
                              ValuePanel(
                                firstText: 'Fibra Total',
                                secondText:
                                Metabolometrias.fibraDietaria.toStringAsFixed(2),
                                thirdText: 'gr/Día',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: ContainerDecoration.roundedDecoration(),
                          child: Column(
                            children: [
                              EditTextArea(
                                  textController: dietaTextController,
                                  labelEditText: "Dieta",
                                  keyBoardType: TextInputType.multiline,
                                  numOfLines: 7,
                                  inputFormat: MaskTextInputFormatter()),
                              CrossLine(),
                              Row(
                                children: [
                                  Expanded(
                                    child: ValuePanel(
                                      firstText: 'Peso Corporal Total',
                                      secondText: Valores.pesoCorporalTotal!
                                          .toStringAsFixed(2),
                                      thirdText: 'Kg',
                                    ),
                                  ),
                                  Expanded(
                                    child: ValuePanel(
                                      firstText: 'Estatura',
                                      secondText: Valores.alturaPaciente!
                                          .toStringAsFixed(2),
                                      thirdText: 'mts',
                                    ),
                                  ),
                                  Expanded(
                                    child: ValuePanel(
                                      firstText: 'Requerimiento Hídrico',
                                      secondText: Hidrometrias.requerimientoHidrico
                                          .toStringAsFixed(0),
                                      thirdText: 'mL',
                                      withEditMessage: true,
                                      onEdit: (value) {
                                        Operadores.editActivity(
                                            context: context,
                                            keyBoardType: TextInputType.number,
                                            tittle: "Editar . . . ",
                                            message:
                                                "¿Constante hídrica? . . . ",
                                            onAcept: (value) {
                                              Terminal.printSuccess(
                                                  message: "recieve $value");
                                              setState(() {
                                                Hidrometrias.constanteRequerimientos =
                                                    double.parse(value);
                                                Navigator.of(context).pop();
                                              });
                                            });
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: ValuePanel(
                                      firstText: 'Peso Predicho',
                                      secondText: Antropometrias.pesoCorporalPredicho
                                          .toStringAsFixed(2),
                                      thirdText: 'Kg',
                                    ),
                                  )
                                ],
                              ),
                              CrossLine(),
                              Row(
                                children: [
                                  Expanded(
                                    child: GrandButton(
                                      labelButton: "A.H.N.O.",
                                      onPress: () {
                                        Reportes.dieta.clear();
                                        dietaTextController.text =
                                            Formatos.dietasAyuno;
                                        Reportes.dieta
                                            .add(Formatos.dietasAyuno);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: GrandButton(
                                      labelButton: "Dieta",
                                      onPress: () {
                                        Reportes.dieta.clear();
                                        dietaTextController.text =
                                            Formatos.dietas;
                                        Reportes.dieta.add(Formatos.dietas);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: GrandButton(
                                      labelButton: "Dieta Completa",
                                      onPress: () {
                                        Reportes.dieta.clear();
                                        dietaTextController.text =
                                            Formatos.dietasCompletas;
                                        Reportes.dieta
                                            .add(Formatos.dietasCompletas);
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      // ValuePanel(
                      //   firstText: "",
                      //   secondText: Valores.fechaVitales.toString(),
                      //   thirdText: "",
                      // ),
                      // CrossLine(),
                    ],
                  ),
                ),
                Container(
                  decoration: ContainerDecoration.roundedDecoration(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(5),
                          decoration: ContainerDecoration.roundedDecoration(),
                          child: GridView(
                            padding: const EdgeInsets.all(5.0),
                            controller: ScrollController(),
                            gridDelegate: GridViewTools.gridDelegate(
                                crossAxisCount: isMobile(context) ? 4 : 2,
                                mainAxisExtent:
                                    isDesktop(context) ? 66 : 65), //46
                            children: [
                              ValuePanel(
                                firstText: "Sodio Sérico",
                                secondText: Valores.sodio.toString(),
                                thirdText: "mEq/L",
                                withEditMessage: true,
                                onEdit: (value) {
                                  Operadores.editActivity(
                                      context: context,
                                      tittle: "Editar . . . ",
                                      message: "¿Sodio Sérico? . . . ",
                                      onAcept: (value) {
                                        Terminal.printSuccess(
                                            message: "recieve $value");
                                        setState(() {
                                          Valores.sodio = double.parse(value);
                                          Navigator.of(context).pop();
                                        });
                                      });
                                },
                              ),
                              ValuePanel(
                                firstText: "Potasio Sérico",
                                secondText: Valores.potasio.toString(),
                                thirdText: "mEq/L",
                                withEditMessage: true,
                                onEdit: (value) {
                                  Operadores.editActivity(
                                      context: context,
                                      tittle: "Editar . . . ",
                                      message: "¿Potasio Sérico? . . . ",
                                      onAcept: (value) {
                                        Terminal.printSuccess(
                                            message: "recieve $value");
                                        setState(() {
                                          Valores.potasio = double.parse(value);
                                          Navigator.of(context).pop();
                                        });
                                      });
                                },
                              ),
                              ValuePanel(
                                firstText: "Cloro Sérico",
                                secondText: Valores.cloro.toString(),
                                thirdText: "mg/dL",
                                withEditMessage: true,
                                onEdit: (value) {
                                  Operadores.editActivity(
                                      context: context,
                                      tittle: "Editar . . . ",
                                      message: "¿Cloro Sérico? . . . ",
                                      onAcept: (value) {
                                        Terminal.printSuccess(
                                            message: "recieve $value");
                                        setState(() {
                                          Valores.cloro = double.parse(value);
                                          Navigator.of(context).pop();
                                        });
                                      });
                                },
                              ),
                              ValuePanel(
                                firstText: "Calcio Sérico",
                                secondText: Valores.calcio.toString(),
                                thirdText: "mg/gL",
                                withEditMessage: true,
                                onEdit: (value) {
                                  Operadores.editActivity(
                                      context: context,
                                      tittle: "Editar . . . ",
                                      message: "¿Calcio Sérico? . . . ",
                                      onAcept: (value) {
                                        Terminal.printSuccess(
                                            message: "recieve $value");
                                        setState(() {
                                          Valores.calcio = double.parse(value);
                                          Navigator.of(context).pop();
                                        });
                                      });
                                },
                              ),
                              ValuePanel(
                                firstText: "Fósforo Sérico",
                                secondText: Valores.fosforo.toString(),
                                thirdText: "mg/dL",
                                withEditMessage: true,
                                onEdit: (value) {
                                  Operadores.editActivity(
                                      context: context,
                                      tittle: "Editar . . . ",
                                      message: "¿Fósforo Sérico? . . . ",
                                      onAcept: (value) {
                                        Terminal.printSuccess(
                                            message: "recieve $value");
                                        setState(() {
                                          Valores.fosforo = double.parse(value);
                                          Navigator.of(context).pop();
                                        });
                                      });
                                },
                              ),
                              ValuePanel(
                                firstText: "Magnesio Sérico",
                                secondText: Valores.magnesio.toString(),
                                thirdText: "mg/gL",
                                withEditMessage: true,
                                onEdit: (value) {
                                  Operadores.editActivity(
                                      context: context,
                                      tittle: "Editar . . . ",
                                      message: "¿Magnesio Sérico? . . . ",
                                      onAcept: (value) {
                                        Terminal.printSuccess(
                                            message: "recieve $value");
                                        setState(() {
                                          Valores.magnesio =
                                              double.parse(value);
                                          Navigator.of(context).pop();
                                        });
                                      });
                                },
                              ),
                              // ********** ****** **** ***  ** *
                              ValuePanel(
                                firstText: 'Déficit de Sodio',
                                secondText:
                                Hidrometrias.deficitSodio.toStringAsFixed(0),
                                thirdText: 'mEq/L',
                              ),
                              ValuePanel(
                                firstText: 'Reposición de Sodio',
                                secondText:
                                Hidrometrias.reposicionSodio.toStringAsFixed(0),
                                thirdText: 'mEq/L',
                              ),
                              ValuePanel(
                                firstText: 'Requerimiento Basal Potasio',
                                secondText: Hidrometrias.requerimientoBasalPotasio
                                    .toStringAsFixed(0),
                                thirdText: 'mEq/L',
                              ),
                              ValuePanel(
                                firstText: 'Requerimiento Potasio',
                                secondText: Hidrometrias.requerimientoPotasio
                                    .toStringAsFixed(0),
                                thirdText: 'mEq/L',
                              ),
                              ValuePanel(
                                firstText: 'Reposición Potasio',
                                secondText: Hidrometrias.reposicionPotasio
                                    .toStringAsFixed(0),
                                thirdText: 'mEq/L',
                              ),
                              ValuePanel(
                                firstText: 'Delta Potasio',
                                secondText:
                                Hidrometrias.deltaPotasio.toStringAsFixed(0),
                                thirdText: 'mEq/L',
                              ),
                              ValuePanel(
                                firstText: 'pH / Potasio',
                                secondText:
                                Hidrometrias.pHKalemia.toStringAsFixed(0),
                                thirdText: 'mEq/L',
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(10),
                          decoration: ContainerDecoration.roundedDecoration(),
                          child: Column(
                            children: [
                              EditTextArea(
                                  textController: liquidosTextController,
                                  labelEditText: "Hidroterapia",
                                  keyBoardType: TextInputType.multiline,
                                  numOfLines: 7,
                                  withShowOption: true,
                                  selection: true,
                                  onSelected: () {
                                    Operadores.selectOptionsActivity(
                                      context: context,
                                      options: Parenterales.parenterales,
                                    );
                                  },
                                  onChange: ((value) {
                                    Reportes.hidroterapia = Listas.traslateFromString(value);
                                    Reportes.reportes['Hidroterapia'] =
                                        Reportes.hidroterapia;
                                  }),
                                  inputFormat: MaskTextInputFormatter()),
                              CrossLine(),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GridView.builder(
                                          gridDelegate: GridViewTools.gridDelegate(crossAxisSpacing: 0.1,
                                              childAspectRatio: 0.5,
                                              mainAxisExtent: 70, crossAxisCount: 2, mainAxisSpacing: 0.1),
                                          itemCount:
                                              Parenterales.parenterales.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GrandButton(
                                              fontSize: 10,
                                              labelButton: Parenterales
                                                  .parenterales[index],
                                              onPress: () {
                                                setState(() {
                                                  inSodio = Parenterales
                                                      .composiciones[
                                                  index]['Sodio'];
                                                  inPotasio = Parenterales
                                                      .composiciones[
                                                  index]['Potasio'];
                                                  inCloro = Parenterales
                                                      .composiciones[
                                                  index]['Cloro'];
                                                  inCloruro = Parenterales
                                                      .composiciones[
                                                  index]['Cloruro'];
                                                  inLactato = Parenterales
                                                      .composiciones[
                                                  index]['Lactato'];
                                                  inOsmolaridad = Parenterales
                                                      .composiciones[
                                                  index]['Osmolaridad'];
                                                  inGlucosa = Parenterales
                                                      .composiciones[
                                                  index]['Glucosa'];
                                                  inCalcio = Parenterales
                                                      .composiciones[
                                                  index]['Calcio'];
                                                });
                                              },
                                            );
                                          }),
                                    ),
                                    Expanded(
                                        child: Container(
                                      decoration: ContainerDecoration
                                          .roundedDecoration(),
                                      child: GridView(
                                        padding: const EdgeInsets.all(5),
                                        gridDelegate: GridViewTools.gridDelegate(mainAxisExtent: 70),
                                        children: [
                                          ValuePanel(
                                              firstText: "Sodio",
                                              secondText: '$inSodio',
                                              thirdText: 'mEq/L'),
                                          ValuePanel(
                                              firstText: "Potasio",
                                              secondText: '$inPotasio',
                                              thirdText: 'mEq/L'),
                                          ValuePanel(
                                              firstText: "Cloro",
                                              secondText: '$inCloro',
                                              thirdText: 'mEq/L'),

                                          ValuePanel(
                                              firstText: "Cloruro",
                                              secondText: '$inCloruro',
                                              thirdText: 'mEq/L'),
                                          ValuePanel(
                                              firstText: "Lactato",
                                              secondText: '$inLactato',
                                              thirdText: 'mEq/L'),
                                          ValuePanel(
                                              firstText: "Osmolaridad",
                                              secondText: '$inOsmolaridad',
                                              thirdText: 'mOsm/L'),

                                          ValuePanel(
                                              firstText: "Glucosa",
                                              secondText: '$inGlucosa',
                                              thirdText: 'mg/dL'),
                                          ValuePanel(
                                              firstText: "Calcio",
                                              secondText: '$inCalcio',
                                              thirdText: 'mEq/L')
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // ValuePanel(
                      //   firstText: "",
                      //   secondText: Valores.fechaVitales.toString(),
                      //   thirdText: "",
                      // ),
                      // CrossLine(),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      EditTextArea(
                          textController: medicamentosTextController,
                          labelEditText: "Medicamentos",
                          keyBoardType: TextInputType.multiline,
                          numOfLines: 10,
                          withShowOption: true,
                          selection: true,
                          onSelected: () {
                            Operadores.openDialog(
                                context: context,
                                chyldrim: DialogSelector(
                                  tittle: 'Medicamentos',
                                  pathForFileSource:
                                      'assets/diccionarios/Farmacos.txt',
                                  typeOfDocument: 'txt',
                                  onSelected: ((value) {
                                    setState(() {
                                      Reportes.medicamentosIndicados.add(value);
                                      medicamentosTextController.text =
                                          "${medicamentosTextController.text}$value\n";
                                    });
                                  }),
                                ));
                          },
                          onChange: ((value) {
                            Reportes.medicamentosIndicados = Listas.traslateFromString(value);
                            Reportes.reportes['Medicamentos'] =
                                Reportes.medicamentosIndicados;
                          }),
                          inputFormat: MaskTextInputFormatter()),
                    ],
                  ),
                ),
                // ************** ****** * * *  *
                SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      EditTextArea(
                          textController: medidasTextController,
                          labelEditText: "Medidas Generales",
                          keyBoardType: TextInputType.multiline,
                          numOfLines: 10,
                          withShowOption: true,
                          selection: true,
                          onSelected: () {
                            showDialog(
                                useSafeArea: true,
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                      child: DialogSelector(
                                    tittle: 'Medidas Generales',
                                    pathForFileSource:
                                        'assets/diccionarios/Medidas.txt',
                                    typeOfDocument: 'txt',
                                    onSelected: ((value) {
                                      setState(() {
                                        Reportes.medidasGenerales.add(value);
                                        medidasTextController.text =
                                            "${medidasTextController.text}$value\n";
                                      });
                                    }),
                                  ));
                                });
                          },
                          onChange: ((value) {
                            Reportes.medidasGenerales = Listas.traslateFromString(value);
                            Reportes.reportes['Medidas_Generales'] =
                                Reportes.medidasGenerales;
                          }),
                          inputFormat: MaskTextInputFormatter()),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      EditTextArea(
                          textController: oxigenoterapiaTextController,
                          labelEditText: "Oxígenoterapia",
                          keyBoardType: TextInputType.multiline,
                          numOfLines: 10,
                          withShowOption: true,
                          selection: true,
                          onSelected: () {},
                          onChange: ((value) {
                            Reportes.oxigenoterapia = Listas.traslateFromString(value);
                            Reportes.reportes['Oxígenoterapia'] =
                                Reportes.oxigenoterapia;
                          }),
                          inputFormat: MaskTextInputFormatter()),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      EditTextArea(
                          textController: insulinoterapiaTextController,
                          labelEditText: "Insulinoterapia",
                          keyBoardType: TextInputType.multiline,
                          numOfLines: 10,
                          withShowOption: true,
                          selection: true,
                          onSelected: () {},
                          onChange: ((value) {
                            Reportes.insulinoterapia = Listas.traslateFromString(value);
                            Reportes.reportes['Insulinoterapia'] =
                                Reportes.insulinoterapia;
                          }),
                          inputFormat: MaskTextInputFormatter()),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      EditTextArea(
                          textController: hemoterapiaTextController,
                          labelEditText: "Hemoterapia",
                          keyBoardType: TextInputType.multiline,
                          numOfLines: 10,
                          withShowOption: true,
                          selection: true,
                          onSelected: () {},
                          onChange: ((value) {
                            Reportes.hemoterapia = Listas.traslateFromString(value);
                            Reportes.reportes['Hemoterapia'] =
                                Reportes.hemoterapia;
                          }),
                          inputFormat: MaskTextInputFormatter()),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(children: [
                    //
                    EditTextArea(
                        textController: pendientesTextController,
                        labelEditText: "Pendientes",
                        keyBoardType: TextInputType.multiline,
                        numOfLines: 10,
                        withShowOption: true,
                        selection: true,
                        onSelected: () {
                          showDialog(
                              useSafeArea: true,
                              context: context,
                              builder: (context) {
                                return Dialog(
                                    child: DialogSelector(
                                  tittle: 'Pendientes en la Atención',
                                  pathForFileSource:
                                      'assets/diccionarios/Pendientes.txt',
                                  typeOfDocument: 'txt',
                                  onSelected: ((value) {
                                    setState(() {
                                      Reportes.pendientes.add(value);
                                      pendientesTextController.text =
                                          "${pendientesTextController.text}$value\n";
                                    });
                                  }),
                                ));
                              });
                        },
                        onChange: ((value) {
                          Reportes.pendientes = Listas.traslateFromString(value);
                          Reportes.reportes['Pendientes'] = Reportes.pendientes;
                        }),
                        inputFormat: MaskTextInputFormatter()),
                  ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class IndicacionesConsulta extends StatefulWidget {
  const IndicacionesConsulta({super.key});

  @override
  State<IndicacionesConsulta> createState() => _IndicacionesConsultaState();
}

class _IndicacionesConsultaState extends State<IndicacionesConsulta> {
  var medicamentosTextController = TextEditingController();
  var licenciasTextController = TextEditingController();
  var pendientesTextController = TextEditingController();
  var citasTextController = TextEditingController();
  var recomendacionesTextController = TextEditingController();

  @override
  void initState() {
    medicamentosTextController.text = Listas.traduceToString(Reportes.medicamentosIndicados);
    licenciasTextController.text = Listas.traduceToString(Reportes.licenciasMedicas);
    pendientesTextController.text = Listas.traduceToString(Reportes.pendientes);
    citasTextController.text = Listas.traduceToString(Reportes.citasMedicas);
    recomendacionesTextController.text =
        Listas.traduceToString(Reportes.recomendacionesGenerales);
    // tratamientoTextController.text = Reportes.tratamientoPropuesto;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.black,
      child: Column(
        children: [
          TittlePanel(textPanel: 'Indicaciones'),
          Expanded(
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(children: [
                  EditTextArea(
                      textController: medicamentosTextController,
                      labelEditText: "Medicamentos",
                      keyBoardType: TextInputType.multiline,
                      numOfLines: 5,
                      withShowOption: true,
                      selection: true,
                      onSelected: () {
                        showDialog(
                            useSafeArea: true,
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  child: DialogSelector(
                                    tittle: 'Medicamentos',
                                    pathForFileSource:
                                    'assets/diccionarios/Farmacos.txt',
                                    typeOfDocument: 'txt',
                                    onSelected: ((value) {
                                      setState(() {
                                        Reportes.medicamentosIndicados.add(value);
                                        medicamentosTextController.text =
                                        "${medicamentosTextController.text}$value\n";
                                      });
                                    }),
                                  ));
                            });
                      },
                      onChange: ((value) {
                        Reportes.medicamentosIndicados = Listas.traslateFromString(value);
                        Reportes.reportes['Medicamentos'] =
                            Reportes.medicamentosIndicados;
                      }),
                      inputFormat: MaskTextInputFormatter()),
                  EditTextArea(
                      textController: licenciasTextController,
                      labelEditText: "Licencias médicas",
                      keyBoardType: TextInputType.multiline,
                      numOfLines: 5,
                      withShowOption: true,
                      selection: true,
                      onSelected: () {
                        showDialog(
                            useSafeArea: true,
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  child: DialogSelector(
                                    tittle: 'Licencias Médicas Otorgadas',
                                    pathForFileSource:
                                    'assets/diccionarios/Farmacos.txt',
                                    typeOfDocument: 'txt',
                                    onSelected: ((value) {
                                      setState(() {
                                        Reportes.licenciasMedicas.add(value);
                                        licenciasTextController.text =
                                        "${licenciasTextController.text}$value\n";
                                      });
                                    }),
                                  ));
                            });
                      },
                      onChange: ((value) {
                        Reportes.licenciasMedicas = Listas.traslateFromString(value);
                        Reportes.reportes['Licencia_Medica'] =
                            Reportes.licenciasMedicas;
                      }),
                      inputFormat: MaskTextInputFormatter()),
                  EditTextArea(
                      textController: pendientesTextController,
                      labelEditText: "Pendientes",
                      keyBoardType: TextInputType.multiline,
                      numOfLines: 5,
                      withShowOption: true,
                      selection: true,
                      onSelected: () {
                        showDialog(
                            useSafeArea: true,
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  child: DialogSelector(
                                    tittle: 'Pendientes en la Atención',
                                    pathForFileSource:
                                    'assets/diccionarios/Pendientes.txt',
                                    typeOfDocument: 'txt',
                                    onSelected: ((value) {
                                      setState(() {
                                        Reportes.pendientes.add(value);
                                        pendientesTextController.text =
                                        "${pendientesTextController.text}$value\n";
                                      });
                                    }),
                                  ));
                            });
                      },
                      onChange: ((value) {
                        Reportes.pendientes = Listas.traslateFromString(value);
                        Reportes.reportes['Pendientes'] = Reportes.pendientes;
                      }),
                      inputFormat: MaskTextInputFormatter()),
                  EditTextArea(
                      textController: citasTextController,
                      labelEditText: "Citas médicas",
                      keyBoardType: TextInputType.multiline,
                      numOfLines: 5,
                      withShowOption: true,
                      onChange: ((value) {
                        Reportes.citasMedicas = Listas.traslateFromString(value);
                        Reportes.reportes['Citas'] = Reportes.citasMedicas;
                      }),
                      inputFormat: MaskTextInputFormatter()),
                  EditTextArea(
                      textController: recomendacionesTextController,
                      labelEditText: "Recomendaciones generales",
                      keyBoardType: TextInputType.multiline,
                      numOfLines: 5,
                      withShowOption: true,
                      selection: true,
                      onSelected: () {
                        showDialog(
                            useSafeArea: true,
                            context: context,
                            builder: (context) {
                              return Dialog(
                                  child: DialogSelector(
                                    tittle: 'Recomendaciones Generales',
                                    pathForFileSource:
                                    'assets/diccionarios/Recomendaciones.txt',
                                    typeOfDocument: 'txt',
                                    onSelected: ((value) {
                                      setState(() {
                                        Reportes.recomendacionesGenerales.add(value);
                                        recomendacionesTextController.text =
                                        "${recomendacionesTextController.text}$value\n";
                                      });
                                    }),
                                  ));
                            });
                      },
                      onChange: ((value) {
                        Reportes.recomendacionesGenerales = Listas.traslateFromString(value);
                        Reportes.reportes['Recomendaciones'] =
                            Reportes.recomendacionesGenerales;
                      }),
                      inputFormat: MaskTextInputFormatter()),
                ]),
              ))
        ],
      ),
    );
  }
}


