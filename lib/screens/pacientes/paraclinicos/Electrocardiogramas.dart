import 'dart:math';
import 'dart:ui';

import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/pacientes.dart';
import 'package:assistant/screens/pacientes/paraclinicos/AuxiliaresDiagnosticos.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GridLayout.dart';
import 'package:assistant/widgets/ScrollableWidget.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/ThreeLabelText.dart';
import 'package:assistant/widgets/WidgetsModels.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ElectrocardiogramasGestion extends StatefulWidget {
  const ElectrocardiogramasGestion({super.key});

  @override
  State<ElectrocardiogramasGestion> createState() =>
      _ElectrocardiogramasGestionState();
}

class _ElectrocardiogramasGestionState
    extends State<ElectrocardiogramasGestion> {
  // ############################ ####### ####### #############################
  // Variables de Ejecución
  // ############################ ####### ####### #############################
  var carouselController = CarouselController();
  var scrollController = ScrollController();
  // ############################ ####### ####### #############################
  // Variables de Ejecución
  // ############################ ####### ####### #############################
  late List? values = [];
  Map<String, dynamic>? elementSelected;

  bool operationActivity = true; // Si true entonces REGISTER.register.
  String tittle = "Registro de electrocardiogramas del paciente";
  String idWidget = 'ID_Pace_GAB_EC';
  // TextController for search.
  var textDateController = TextEditingController();
  // ############################ ####### ####### #############################
  // Variables de Valores de Interés
  // ############################ ####### ####### #############################
  int? idOperacion = 0;

  String? ritmoCardiacoValue = Electrocardiogramas.ritmos[0];
  var textDateEstudyController = TextEditingController();
  var intervaloRRTextController = TextEditingController();
  var dopTextController = TextEditingController();
  var aopTextController = TextEditingController();
  var dprTextController = TextEditingController();
  var dqrsTextController = TextEditingController();
  var aqrsTextController = TextEditingController();
  var qrsiTextController = TextEditingController();
  var qrsaTextController = TextEditingController();
  var paceQrsTextController = TextEditingController();

  String? segmentoSTValue = Electrocardiogramas.ast[0];
  var stTextController = TextEditingController();
  var dqtTextController = TextEditingController();
  var dotTextController = TextEditingController();
  var aotTextController = TextEditingController();
  //
  var rv1TextController = TextEditingController();
  var sv6TextController = TextEditingController();
  var sv1TextController = TextEditingController();
  var rv6TextController = TextEditingController();
  var ravlTextController = TextEditingController();
  var sv3TextController = TextEditingController();
  //
  String? patronQRSValue = Electrocardiogramas.patronQRS[0];
  var deflexTextController = TextEditingController();
  var rdiTextController = TextEditingController();
  var sdiTextController = TextEditingController();
  var rdiiiTextController = TextEditingController();
  var sdiiiTextController = TextEditingController();
  var conclusionTextController = TextEditingController();
  //
  String tipoEstudio = "Electrocardiograma";

  // ############################ ####### ####### #############################

  @override
  void initState() {
    final f = DateFormat('yyyy-MM-dd');
    textDateEstudyController.text = f.format(DateTime.now());

    Actividades.consultarAllById(
            Databases.siteground_database_reggabo,
            Electrocardiogramas.electrocardiogramas['consultByIdPrimaryQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      setState(() {
        print("ELECTROS ${value[0]} ${Pacientes.ID_Paciente}");
        values = value;
      });
    });
    super.initState();
  }

  void initAllElement() {
    setState(() {
      operationActivity = true;

      idOperacion = 0;
      final f = DateFormat('yyyy-MM-dd');
      textDateEstudyController.text = f.format(DateTime.now());
      //
      ritmoCardiacoValue = Electrocardiogramas.ritmos[0];
      intervaloRRTextController.text = "";
      dopTextController.text = "";
      aopTextController.text = "";
      dprTextController.text = "";
      dqrsTextController.text = "";
      aqrsTextController.text = "";
      qrsiTextController.text = "";
      qrsaTextController.text = "";
      paceQrsTextController.text = "";
      //
      segmentoSTValue = Electrocardiogramas.ast[0];
      stTextController.text = "";
      dqtTextController.text = "";
      dotTextController.text = "";
      aotTextController.text = "";
      //
      rv1TextController.text = "";
      sv6TextController.text = "";
      sv1TextController.text = "";
      rv6TextController.text = "";
      ravlTextController.text = "";
      sv3TextController.text = "";
      //
      patronQRSValue = Electrocardiogramas.patronQRS[0];
      deflexTextController.text = "";
      rdiTextController.text = "";
      sdiTextController.text = "";
      rdiiiTextController.text = "";
      sdiiiTextController.text = "";
      conclusionTextController.text = "";
    });
  }

  void updateElement(Map<String, dynamic> element) {
    setState(() {
      print("element $element");

      idOperacion = element[idWidget];
      textDateEstudyController.text = element['Pace_GAB_EC_Feca'];
      ritmoCardiacoValue = element['Pace_EC_rit'];
      intervaloRRTextController.text = element['Pace_EC_rr'].toString();
      dopTextController.text = element['Pace_EC_dop'].toString();
      aopTextController.text = element['Pace_EC_aop'].toString();
      dprTextController.text = element['Pace_EC_dpr'].toString();
      dqrsTextController.text = element['Pace_EC_dqrs'].toString();
      aqrsTextController.text = element['Pace_EC_aqrs'].toString();
      qrsiTextController.text = element['Pace_EC_qrsi'].toString();
      qrsaTextController.text = element['Pace_EC_qrsa'].toString();
      paceQrsTextController.text = element['Pace_QRS']!.toString();
      //
      segmentoSTValue = element['Pace_EC_ast_'];
      stTextController.text = element['Pace_EC_st'].toString();
      dqtTextController.text = element['Pace_EC_dqt'].toString();
      dotTextController.text = element['Pace_EC_dot'].toString();
      aotTextController.text = element['Pace_EC_aot'].toString();
      //
      rv1TextController.text = element['EC_rV1'].toString();
      sv6TextController.text = element['EC_sV6'].toString();
      sv1TextController.text = element['EC_sV1'].toString();
      rv6TextController.text = element['EC_rV6'].toString();
      ravlTextController.text = element['EC_rAVL'].toString();
      sv3TextController.text = element['EC_sV3'].toString();
      //
      patronQRSValue = element['PatronQRS'];
      deflexTextController.text = element['DeflexionIntrinsecoide'].toString();
      rdiTextController.text = element['EC_rDI'].toString();
      sdiTextController.text = element['EC_sDI'].toString();
      rdiiiTextController.text = element['EC_rDIII'].toString();
      sdiiiTextController.text = element['EC_sDIII'].toString();
      conclusionTextController.text = element['Pace_EC_CON'];
    });
  }

  List<Widget> listOfComponents() {
    return [
      Spinner(
          width: 100,
          isRow: false,
          tittle: "Ritmo cardiaco",
          initialValue: ritmoCardiacoValue!,
          items: Electrocardiogramas.ritmos,
          onChangeValue: (String? newValue) {
            setState(() {
              ritmoCardiacoValue = newValue!;
            });
          }),
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Intervalo RR",
          textController: intervaloRRTextController,
          prefixIcon: false),
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Duración de la Onda P",
          textController: dopTextController,
          prefixIcon: false),
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Altura de la Onda P",
          textController: aopTextController,
          prefixIcon: false),
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Duración del Intervalo PR",
          textController: dprTextController,
          prefixIcon: false),
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Duración del QRS",
          textController: dqrsTextController,
          prefixIcon: false),
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Altura del QRS",
          textController: aqrsTextController,
          prefixIcon: false),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        obscureText: false,
        labelEditText: "QRS en DI",
        textController: qrsiTextController,
        prefixIcon: false,
        onChange: ((value) {
          paceQrsTextController.text = tan(int.parse(qrsaTextController.text) /
                  int.parse(qrsiTextController.text))
              .toStringAsFixed(1);
        }),
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        obscureText: false,
        labelEditText: "QRS en aVF",
        textController: qrsaTextController,
        prefixIcon: false,
        onChange: (value) {
          paceQrsTextController.text = atan(int.parse(qrsaTextController.text) /
                  int.parse(qrsiTextController.text))
              .toStringAsFixed(1);
        },
      ),
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Eje Cardiaco",
          textController: paceQrsTextController,
          prefixIcon: false),
      //
      Spinner(
          width: 110,
          isRow: false,
          tittle: "Segmento ST",
          initialValue: segmentoSTValue!,
          items: Electrocardiogramas.ast,
          onChangeValue: (String? newValue) {
            setState(() {
              segmentoSTValue = newValue!;
            });
          }),
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Altura del ST",
          textController: stTextController,
          prefixIcon: false),
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Duración de QT",
          textController: dqtTextController,
          prefixIcon: false),
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Duración Onda T",
          textController: dotTextController,
          prefixIcon: false),
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Altura Onda T",
          textController: aotTextController,
          prefixIcon: false),
      //
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Onda R en V1",
          textController: rv1TextController,
          prefixIcon: false),
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Onda R en V6",
          textController: rv6TextController,
          prefixIcon: false),
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Onda S en V1",
          textController: sv1TextController,
          prefixIcon: false),
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Onda S en V6",
          textController: sv6TextController,
          prefixIcon: false),
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Onda R en V6",
          textController: rv6TextController,
          prefixIcon: false),
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Onda R en aVL",
          textController: ravlTextController,
          prefixIcon: false),
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Onda S en V3",
          textController: sv3TextController,
          prefixIcon: false),
      //
      Spinner(
          width: 100,
          isRow: false,
          tittle: "Patrón QRS en DII",
          initialValue: patronQRSValue!,
          items: Electrocardiogramas.patronQRS,
          onChangeValue: (String? newValue) {
            setState(() {
              patronQRSValue = newValue!;
            });
          }),
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Deflexión Intrinsecoide",
          textController: deflexTextController,
          prefixIcon: false),
      //
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Onda S en DI",
          textController: sdiTextController,
          prefixIcon: false),
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          obscureText: false,
          labelEditText: "Onda S en DIII",
          textController: sdiiiTextController,
          prefixIcon: false),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (isMobile(context)) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const AuxiliaresDiagnosticos())));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => VisualPacientes(actualPage: 5))));
            }
          },
        ),
        backgroundColor: Theming.primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: isMobile(context)
                ? Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      grandButton(context, "Registro de electrocardiogramas",
                          () {
                        carouselController.jumpToPage(0);
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      grandButton(context, "Gestion del Registro", () {
                        carouselController.jumpToPage(1);
                      }),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      grandButton(context, "Registro de electrocardiogramas",
                          () {
                        carouselController.jumpToPage(0);
                      }),
                      grandButton(context, "Gestion del Registro", () {
                        carouselController.jumpToPage(1);
                      }),
                    ],
                  ),
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                      height: 500,
                      enableInfiniteScroll: false,
                      viewportFraction: 1.0),
                  items: [
                    SingleChildScrollView(
                      //flex: 2,
                      child: Card(
                        color: Colores.backgroundPanel,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  labelText(tittle),
                                  editFormattedText(
                                      TextInputType.datetime,
                                      MaskTextInputFormatter(
                                          mask: '####/##/##',
                                          filter: {"#": RegExp(r'[0-9]')},
                                          type: MaskAutoCompletionType.lazy),
                                      false,
                                      "Fecha de realización",
                                      textDateController,
                                      true),
                                  ScrollableWidget(child: dataTable()),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: SingleChildScrollView(
                            controller: ScrollController(),
                            child: Card(
                              color: Colores.backgroundPanel,
                              child: SingleChildScrollView(
                                controller: scrollController,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      labelText(tittle),
                                      editFormattedText(
                                          TextInputType.datetime,
                                          MaskTextInputFormatter(
                                              mask: '####/##/##',
                                              filter: {"#": RegExp(r'[0-9]')},
                                              type:
                                                  MaskAutoCompletionType.lazy),
                                          false,
                                          "Fecha de realización",
                                          textDateEstudyController,
                                          false),
                                      GridLayout(
                                          columnCount: 2,
                                          children: listOfComponents()),
                                      Column(
                                        children: [
                                          EditTextArea(
                                              keyBoardType:
                                                  TextInputType.number,
                                              inputFormat:
                                                  MaskTextInputFormatter(),
                                              obscureText: false,
                                              numOfLines: 5,
                                              labelEditText: "Conclusiones",
                                              textController:
                                                  conclusionTextController,
                                              prefixIcon: false),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              grandButton(
                                                  context,
                                                  operationActivity
                                                      ? "Nuevo"
                                                      : "Eliminar",
                                                  weigth: 100, () {
                                                if (operationActivity) {
                                                  initAllElement();
                                                  carouselController
                                                      .jumpToPage(1);
                                                } else {
                                                  try {
                                                    deleteDialog(
                                                        elementSelected!);
                                                  } finally {
                                                    carouselController
                                                        .jumpToPage(0);
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                "Eliminados"),
                                                            content: Text(
                                                                listOfValues()
                                                                    .toString()),
                                                          );
                                                        });
                                                  }
                                                }
                                              }),
                                              operationActivity
                                                  ? Container()
                                                  : grandButton(
                                                      context, "Nuevo",
                                                      weigth: 50, () {
                                                      initAllElement();
                                                    }),
                                              grandButton(
                                                  context,
                                                  operationActivity
                                                      ? "Agregar"
                                                      : "Actualizar", () {
                                                if (operationActivity) {
                                                  var aux = listOfValues();
                                                  aux.removeAt(0);
                                                  aux.removeLast();

                                                  Actividades.registrar(
                                                    Databases
                                                        .siteground_database_reggabo,
                                                    Electrocardiogramas
                                                            .electrocardiogramas[
                                                        'registerQuery'],
                                                    aux,
                                                  ).then((value) => showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: const Text(
                                                              "Registrados"),
                                                          content: Text(
                                                              "Los registros \n${listOfValues().toString()} \n fueron registrados"),
                                                        );
                                                      }).then((value) => Navigator
                                                          .of(context)
                                                      .push(MaterialPageRoute(
                                                          builder: (context) =>
                                                              const ElectrocardiogramasGestion()))));
                                                } else {
                                                  Actividades.actualizar(
                                                          Databases
                                                              .siteground_database_reggabo,
                                                          Electrocardiogramas
                                                                  .electrocardiogramas[
                                                              'updateQuery'],
                                                          listOfValues(),
                                                          idOperacion!)
                                                      .then((value) =>
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                print(
                                                                    "Electrocardiogramas.electrocardiogramas['updateQuery'] ${Electrocardiogramas.electrocardiogramas['updateQuery']}");
                                                                print(
                                                                    "LIST OF VLUES ${listOfValues()}");
                                                                return AlertDialog(
                                                                  title: const Text(
                                                                      "Actualizados"),
                                                                  content: Text(
                                                                      "Los registros \n${listOfValues().toString()} \n fueron actualizados"),
                                                                );
                                                              }).then((value) => Navigator
                                                                  .of(context)
                                                              .push(MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const ElectrocardiogramasGestion()))));
                                                }
                                              }),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        isDesktop(context)
                            ? Expanded(
                                flex: 2,
                                child: AnalisisElectrocardiograma(
                                    operationActivity: operationActivity),
                              )
                            : Container()
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  DataTable dataTable() {
    return DataTable(
      columns: [
        DataColumn(label: labelText("ID")),
        DataColumn(label: labelText("Fecha de realización")),
        DataColumn(label: labelText("Ritmo")),
        DataColumn(label: labelText("Intervalo RR")),
        DataColumn(label: labelText("Frecuencia Cardiaca")),
        DataColumn(label: labelText("Conclusiones")),
        DataColumn(label: labelText("Acciones")),
      ],
      rows: allRows(),
    );
  }

  List<DataRow> allRows() {
    List<DataRow> list = [];
    // Iteración del Listado List<Map<String, dynamic>> para desglose del Map().
    for (var element in values!) {
      list.add(DataRow(cells: listOfCells(element)));
    }
    //
    return list;
  }

  List<DataCell> listOfCells(Map<String, dynamic> element) {
    List<DataCell> listOfCells = [];

    // Desglose del Map() para colocación del value en DataCell()
    listOfCells.add(dataCell(element['ID_Pace_GAB_EC'].toString()));
    listOfCells.add(dataCell(element['Pace_GAB_EC_Feca'].toString()));
    listOfCells.add(dataCell(element['Pace_EC_rit'].toString()));
    listOfCells.add(dataCell(element['Pace_EC_rr'].toString()));
    listOfCells.add(dataCell((300 / element['Pace_EC_rr']).toStringAsFixed(0)));
    listOfCells.add(dataCell(element['Pace_EC_CON'].toString()));
    listOfCells.add(DataCell(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Tooltip(
            message: "Actualizar",
            textStyle: const TextStyle(color: Colors.white),
            child: IconButton(
                onPressed: () {
                  operationActivity = false;
                  // print("Element ${element[idWidget]}");
                  elementSelected = element;
                  Pacientes.Electrocardiogramas = element;
                  element.addAll({
                    "isl": (element['EC_sV1'] + element['EC_rV6']),
                    "igu": (element['EC_rDI'] + element['EC_sDIII']),
                    "il": (element['EC_rDI'] + element['EC_sDIII']) -
                        (element['EC_rDIII'] + element['EC_sDI']),
                    "vc": (element['EC_rAVL'] + element['EC_sV3'])
                  });
                  carouselController.jumpToPage(1);

                  updateElement(element);
                },
                color: Colors.white,
                icon: const Icon(Icons.update)),
          ),
          Tooltip(
            message: "Eliminar",
            textStyle: const TextStyle(color: Colors.white),
            child: IconButton(
                onPressed: () {
                  // print("Element ${element[idWidget]}");
                  deleteDialog(element);
                },
                color: Colors.white,
                icon: const Icon(Icons.delete)),
          )
        ],
      ),
    ));

    return listOfCells;
  }

  void deleteDialog(Map<String, dynamic> element) {
    showDialog(
        context: context,
        builder: (context) {
          return emergentDialog(context, "Eliminación del Registro",
              "¿Esta usted seguro de eliminar este registro?", () {
            Actividades.eliminar(
                    Databases.siteground_database_reggabo,
                    Electrocardiogramas.electrocardiogramas['deleteQuery'],
                    element[idWidget])
                .then((value) => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Eliminados"),
                            content: Text(listOfValues().toString()),
                          );
                        })
                    .then((value) => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                const ElectrocardiogramasGestion()))));
          });
        });
  }

  List<String> listOfValues() {
    return [
      idOperacion!.toString(),
      Pacientes.ID_Paciente.toString(),
      textDateEstudyController.text,
      //
      ritmoCardiacoValue!,
      // textDateEstudyController.text,
      intervaloRRTextController.text,
      //fc.toStringAsFixed(0),
      //
      dopTextController.text,
      aopTextController.text,
      dprTextController.text,
      dqrsTextController.text,
      aqrsTextController.text,
      qrsiTextController.text,
      qrsaTextController.text,
      //
      paceQrsTextController.text,
      //
      segmentoSTValue!,
      stTextController.text,
      dqtTextController.text,
      dotTextController.text,
      aotTextController.text,
      //
      rv1TextController.text,
      sv6TextController.text,
      sv1TextController.text,
      rv6TextController.text,
      ravlTextController.text,
      sv3TextController.text,
      //
      patronQRSValue!,
      deflexTextController.text,
      rdiTextController.text,
      sdiTextController.text,
      rdiiiTextController.text,
      sdiiiTextController.text,
      conclusionTextController.text,
      tipoEstudio,
      //
      idOperacion!.toString(),
    ];
  }
}

// ignore: must_be_immutable
class AnalisisElectrocardiograma extends StatefulWidget {
  bool operationActivity = true; // Si true entonces REGISTER.register.
  AnalisisElectrocardiograma({Key? key, required this.operationActivity})
      : super(key: key);

  @override
  State<AnalisisElectrocardiograma> createState() =>
      _AnalisisElectrocardiogramaState();
}

class _AnalisisElectrocardiogramaState
    extends State<AnalisisElectrocardiograma> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 58, 55, 55)),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(),
                child: const Text(
                  'Analisis de Electrocardiograma',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ThreeLabelTextAline(
                      firstText: "Fecha de realización",
                      secondText:
                          (Pacientes.Electrocardiogramas['Pace_GAB_EC_Feca']),
                      padding: 1,
                    ),
                    ThreeLabelTextAline(
                      firstText: "Ritmo Cardiaco",
                      secondText:
                          (Pacientes.Electrocardiogramas['Pace_EC_rit']),
                      padding: 1,
                    ),
                    ThreeLabelTextAline(
                      firstText: "Segmento ST",
                      secondText:
                          (Pacientes.Electrocardiogramas['Pace_EC_ast_']),
                      padding: 1,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: gridView(context, 5.0, children: [
                  ThreeLabelTextAline(
                    padding: 1,
                    firstText: "Frecuencia Cardica",
                    secondText:
                        (300 / Pacientes.Electrocardiogramas['Pace_EC_rr'])
                            .toStringAsFixed(0),
                    thirdText: "L/min",
                  ),
                  ThreeLabelTextAline(
                    padding: 1,
                    firstText: "Eje Cardiaco",
                    secondText: (Pacientes.Electrocardiogramas['Pace_QRS'])
                        .toStringAsFixed(0),
                    thirdText: "°",
                  ),
                  ThreeLabelTextAline(
                    padding: 1,
                    firstText: "Indice Sokolow-Lyon",
                    secondText: "${Pacientes.Electrocardiogramas['isl']}",
                    thirdText: "mV",
                  ),
                  ThreeLabelTextAline(
                    padding: 1,
                    firstText: "Indice de Gubner", //-Underleider",
                    secondText: "${Pacientes.Electrocardiogramas['igu']}",
                    thirdText: "mV",
                  ),
                  ThreeLabelTextAline(
                    padding: 1,
                    firstText: "Indice de Lewis",
                    secondText: "${Pacientes.Electrocardiogramas['il']}",
                    thirdText: "mV",
                  ),
                  ThreeLabelTextAline(
                    padding: 1,
                    firstText: "Voltaje de Cornell",
                    secondText: "${Pacientes.Electrocardiogramas['vc']}",
                    thirdText: "mV",
                  ),
                ]),
              ),
            ]),
          )),
    );
  }
}
