import 'package:assistant/conexiones/usuarios/Pacientes.dart';
import 'package:assistant/screens/pacientes/pacientes.dart';
import 'package:assistant/screens/pacientes/paraclinicos/Electrocardiogramas.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/GridLayout.dart';
import 'package:assistant/widgets/RoundedPanel.dart';
import 'package:assistant/widgets/ScrollableWidget.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/WidgetsModels.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:assistant/conexiones/conexiones.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';

class AuxiliaresDiagnosticos extends StatefulWidget {
  const AuxiliaresDiagnosticos({super.key});

  @override
  State<AuxiliaresDiagnosticos> createState() => _AuxiliaresDiagnosticosState();
}

class _AuxiliaresDiagnosticosState extends State<AuxiliaresDiagnosticos> {
  var textDateController = TextEditingController();
  var scrollController = ScrollController();
  var textResultController = TextEditingController();
  var textDateEstudyController = TextEditingController();

  bool operationActivity = true;
  String idWidget =
      'ID_Laboratorio'; // Index name for obtain element of Values.
  String tittle = "Registro de estudios paraclínicos del paciente";

  // ############################ ####### ####### #############################
  // Variables de Ejecución
  // ############################ ####### ####### #############################
  int? idOperacion = 0;

  String? tipoEstudioValue = Auxiliares.Categorias[0];
  String? estudioValue = Auxiliares.Laboratorios[Auxiliares.Categorias[0]][0];
  String? unidadMedidaValue = Auxiliares.Medidas[Auxiliares.Categorias[0]][0];
  // ############################ ####### ####### #############################
  late List? values = [];
  //   {
  //     "ID": 1,
  //     // "ID_Pace": 1,
  //     "Fecha_Registro": "2022/04/22",
  //     "Tipo_Estudio": Auxiliares.Categorias[0],
  //     "Estudio": "Hemoglobina",
  //     "Resultado": 14.3,
  //     "Unidad_Medida": "g/dL"
  //   },
  //   {
  //     "ID": 2,
  //     // "ID_Pace": 1,
  //     "Fecha_Registro": "2022/04/22",
  //     "Tipo_Estudio": Auxiliares.Categorias[1],
  //     "Estudio": "Glucosa",
  //     "Resultado": 103,
  //     "Unidad_Medida": "mg/dL"
  //   },
  //   {
  //     "ID": 3,
  //     // "ID_Pace": 1,
  //     "Fecha_Registro": "2022/01/15",
  //     "Tipo_Estudio": Auxiliares.Categorias[4],
  //     "Estudio": "Albumina",
  //     "Resultado": 31,
  //     "Unidad_Medida": "g/dL"
  //   }
  // ];

  Map<String, dynamic>? elementSelected;

  var carouselController = CarouselController();

  // ############################ ####### ####### #############################

  @override
  void initState() {
    final f = DateFormat('yyyy-MM-dd');
    textDateEstudyController.text = f.format(DateTime.now());

    Actividades.consultarAllById(
            Databases.siteground_database_reggabo,
            Auxiliares.auxiliares['consultByIdPrimaryQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      setState(() {
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

      tipoEstudioValue = Auxiliares.Categorias[0];
      estudioValue = Auxiliares.Laboratorios[Auxiliares.Categorias[0]][0];
      textResultController.text = "";
      unidadMedidaValue = Auxiliares.Medidas[Auxiliares.Categorias[0]][0];
    });
  }

  void updateElement(Map<String, dynamic> element) {
    setState(() {
      print("element $element");

      idOperacion = element[idWidget];
      textDateEstudyController.text = element['Fecha_Registro'];
      tipoEstudioValue = element['Tipo_Estudio'];
      estudioValue = element['Estudio'];
      textResultController.text = element['Resultado'].toString();
      unidadMedidaValue = element['Unidad_Medida'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isMobile(context)
          ? AppBar(
              backgroundColor: Theming.primaryColor,
              leading: isMobile(context)
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        if (isMobile(context)) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) =>
                                  VisualPacientes(actualPage: 0))));
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) =>
                                  VisualPacientes(actualPage: 5))));
                        }
                      },
                    )
                  : null,
              actions: [
                GrandIcon(
                  labelButton: 'Registro de estudios de gabinete',
                  iconData: Icons.monitor_heart,
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const ElectrocardiogramasGestion()));
                  },
                ),
                GrandIcon(
                  labelButton: 'Registro de laboratorios',
                  iconData: Icons.list,
                  onPress: () {
                    carouselController.jumpToPage(0);
                  },
                ),
                GrandIcon(
                  labelButton: 'Gestion del Registro',
                  iconData: Icons.analytics,
                  onPress: () {
                    carouselController.jumpToPage(1);
                  },
                ),
              ],
            )
          : null,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: isMobile(context)
                ? RoundedPanel(
                    child: TittlePanel(
                        textPanel: 'Registro de Estudios de Laboratorio'))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GrandButton(
                          labelButton: "Registro de estudios de gabinete",
                          weigth: 500 / 3,
                          onPress: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ElectrocardiogramasGestion()));
                          }),
                      GrandButton(
                          labelButton: "Registro de laboratorios",
                          weigth: 500 / 3,
                          onPress: () {
                            carouselController.jumpToPage(0);
                          }),
                      GrandButton(
                          labelButton: "Gestion del Registro",
                          weigth: 500 / 3,
                          onPress: () {
                            carouselController.jumpToPage(1);
                          }),
                    ],
                  ),
          ),
          Expanded(
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
                SingleChildScrollView(
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
                                    type: MaskAutoCompletionType.lazy),
                                false,
                                "Fecha de realización",
                                textDateEstudyController,
                                false),
                            GridLayout(columnCount: 2, children: [
                              Spinner(
                                  width: 90,
                                  tittle: "Tipo de Estudio",
                                  initialValue: tipoEstudioValue!,
                                  items: Auxiliares.Categorias,
                                  onChangeValue: (String? newValue) {
                                    setState(() {
                                      tipoEstudioValue = newValue!;
                                    });
                                  }),
                              Spinner(
                                  width: 100,
                                  tittle: "Estudio",
                                  initialValue: estudioValue!,
                                  items:
                                      Auxiliares.Laboratorios[tipoEstudioValue],
                                  onChangeValue: (String? newValue) {
                                    setState(() {
                                      estudioValue = newValue!;
                                    });
                                  }),
                              editFormattedText(
                                  TextInputType.number,
                                  MaskTextInputFormatter(),
                                  false,
                                  "Resultado",
                                  textResultController,
                                  false),
                              Spinner(
                                  width: 100,
                                  tittle: "Unidad de Medida",
                                  initialValue: unidadMedidaValue!,
                                  items: Auxiliares.Medidas[tipoEstudioValue],
                                  onChangeValue: (String? newValue) {
                                    setState(() {
                                      unidadMedidaValue = newValue!;
                                    });
                                  }),
                            ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                grandButton(context,
                                    operationActivity ? "Nuevo" : "Eliminar",
                                    weigth: 100, () {
                                  if (operationActivity) {
                                    initAllElement();
                                    carouselController.jumpToPage(1);
                                  } else {
                                    try {
                                      deleteDialog(elementSelected!);
                                    } finally {
                                      carouselController.jumpToPage(0);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text("Eliminados"),
                                              content: Text(
                                                  listOfValues().toString()),
                                            );
                                          });
                                    }
                                  }
                                }),
                                operationActivity
                                    ? Container()
                                    : grandButton(context, "Nuevo", weigth: 50,
                                        () {
                                        initAllElement();
                                      }),
                                grandButton(
                                    context,
                                    operationActivity
                                        ? "Agregar"
                                        : "Actualizar", () {
                                  if (operationActivity) {
                                    var aux = listOfValues();
                                    aux.removeLast();

                                    Actividades.registrar(
                                      Databases.siteground_database_reggabo,
                                      Auxiliares.auxiliares['registerQuery'],
                                      aux,
                                    ).then((value) => showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title:
                                                    const Text("Registrados"),
                                                content: Text(
                                                    "Los registros \n${listOfValues().toString()} \n fueron actualizados"),
                                              );
                                            })
                                        .then((value) => Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    VisualPacientes(
                                                        actualPage: 5)))));
                                  } else {
                                    Actividades.actualizar(
                                            Databases
                                                .siteground_database_reggabo,
                                            Auxiliares
                                                .auxiliares['updateQuery'],
                                            listOfValues(),
                                            idOperacion!)
                                        .then((value) => showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title:
                                                    const Text("Actualizados"),
                                                content: Text(
                                                    "Los registros \n${listOfValues().toString()} \n fueron actualizados"),
                                              );
                                            }).then((value) => Navigator.of(
                                                context)
                                            .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    VisualPacientes(
                                                        actualPage: 5)))));
                                  }
                                }),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataTable dataTable() {
    return DataTable(
      columns: [
        DataColumn(label: labelText("ID")),
        DataColumn(
          label: labelText("Fecha de realización"),
        ),
        DataColumn(label: labelText("Tipo de Estudio")),
        DataColumn(label: labelText("Estudio")),
        DataColumn(label: labelText("Resultado")),
        DataColumn(label: labelText("Unidad de Medida")),
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
    element.forEach((key, value) {
      listOfCells.add(dataCell(value.toString()));
    });
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
            Actividades.eliminar(Databases.siteground_database_reggabo,
                    Auxiliares.auxiliares['deleteQuery'], element[idWidget])
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
                                VisualPacientes(actualPage: 5)))));
          });
        });
  }

  List<String> listOfValues() {
    return [
      idOperacion!.toString(),
      Pacientes.ID_Paciente.toString(),
      textDateEstudyController.text,
      tipoEstudioValue!,
      estudioValue!,
      textResultController.text,
      unidadMedidaValue!,
      idOperacion!.toString(),
    ];
  }
}
