import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/dummy/Electrocardiogramas.dart';
import 'package:assistant/dummy/dummyWithTable.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/widgets/CrossLine.dart';

import 'package:assistant/widgets/EditTextArea.dart';
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

  Map<String, dynamic>? elementSelected;

  var carouselController = CarouselController();

  int index = 0, secondIndex = 0;

  // ############################ ####### ####### #############################
  var fileAssocieted = '${Pacientes.localRepositoryPath}/paraclinicos.json';

  @override
  void initState() {

    Terminal.printWarning(message: " . . . Iniciando Actividad - Repositorio Paraclinicos del Pacientes");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        values = value;
        Terminal.printSuccess(message: 'Repositorio Paraclinicos del Pacientes Obtenido');
      });
    }).onError((error, stackTrace) {
      final f = DateFormat('yyyy-MM-dd');
      textDateEstudyController.text = f.format(DateTime.now());

      Actividades.consultarAllById(
          Databases.siteground_database_reggabo,
          Auxiliares.auxiliares['consultByIdPrimaryQuery'],
          Pacientes.ID_Paciente)
          .then((value) {
        setState(() {
          values = value;
          Archivos.createJsonFromMap(values!, filePath: fileAssocieted);
        });
      });

    });
    Terminal.printOther(message: " . . . Actividad Iniciada");

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
      appBar: isMobile(context) || isTablet(context)
          ? AppBar(
              backgroundColor: Theming.primaryColor,
              leading: isMobile(context)|| isTablet(context)
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        if (isMobile(context)|| isTablet(context)) {
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
                  labelButton: 'Registro de estudios de imagen',
                  iconData: Icons.image_aspect_ratio_sharp,
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ImagenologiasGestion()));
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
                : SingleChildScrollView(
                    controller: ScrollController(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GrandButton(
                            labelButton: "Registro de electrocardiogramas",
                            weigth: 500 / 4,
                            onPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ElectrocardiogramasGestion()));
                            }),
                        GrandButton(
                            labelButton: "Registro de estudios imagenológicos",
                            weigth: 500 / 4,
                            onPress: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ImagenologiasGestion()));
                            }),
                        GrandButton(
                            labelButton: "Registro de laboratorios",
                            weigth: 500 / 4,
                            onPress: () {
                              carouselController.jumpToPage(0);
                            }),
                        GrandButton(
                            labelButton: "Gestion del Registro",
                            weigth: 500 / 4,
                            onPress: () {
                              carouselController.jumpToPage(1);
                            }),
                      ],
                    ),
                  ),
          ),
          Expanded(
            child: CarouselSlider(
              carouselController: carouselController,
              options: CarouselOptions(
                  height: isTablet(context)
                      ? 900
                      : isMobile(context)
                          ? 1200
                          : 500,
                  enableInfiniteScroll: false,
                  viewportFraction: 1.0),
              items: [
                SingleChildScrollView(
                  controller: ScrollController(),
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
                              TittlePanel(textPanel: tittle),
                              EditTextArea(
                                labelEditText: "Fecha de realización",
                                numOfLines: 1,
                                keyBoardType: TextInputType.datetime,
                                textController: textDateController,
                                inputFormat: MaskTextInputFormatter(
                                    mask: '####/##/##',
                                    filter: {"#": RegExp(r'[0-9]')},
                                    type: MaskAutoCompletionType.lazy),
                              ),
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
                            TittlePanel(textPanel: tittle),
                            EditTextArea(
                              labelEditText: "Fecha de realización",
                              numOfLines: 1,
                              textController: textDateEstudyController,
                              keyBoardType: TextInputType.datetime,
                              inputFormat: MaskTextInputFormatter(
                                  mask: '####/##/##',
                                  filter: {"#": RegExp(r'[0-9]')},
                                  type: MaskAutoCompletionType.lazy),
                            ),
                            GridLayout(
                                childAspectRatio: isMobile(context) ? 3.3 : 5.0,
                                columnCount: isMobile(context) ? 1 : 2,
                                children: [
                                  Spinner(
                                      width: isTabletAndDesktop(context)
                                          ? 190
                                          : 170, // 90
                                      tittle: "Tipo de Estudio",
                                      initialValue: tipoEstudioValue!,
                                      items: Auxiliares.Categorias,
                                      onChangeValue: (String? newValue) {
                                        setState(() {
                                          tipoEstudioValue = newValue!;
                                          // *************** *********** **************
                                          // Actualización del Indice
                                          // *************** *********** **************
                                          index = Auxiliares.Categorias.indexOf(newValue);
                                          // *************** *********** **************
                                          estudioValue = Auxiliares.Laboratorios[Auxiliares.Categorias[index]][0];
                                          unidadMedidaValue = Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
                                          // *************** *********** **************
                                        });
                                      }),
                                  Spinner(
                                      width: isTabletAndDesktop(context)
                                          ? 120
                                          : 170, // 90
                                      tittle: "Estudio",
                                      initialValue: estudioValue!,
                                      items: Auxiliares
                                          .Laboratorios[tipoEstudioValue],
                                      onChangeValue: (String? newValue) {
                                        setState(() {
                                          estudioValue = newValue!;
                                          //
                                        });
                                      }),
                                  EditTextArea(
                                    textController: textResultController,
                                    keyBoardType: TextInputType.number,
                                    inputFormat: MaskTextInputFormatter(),
                                    labelEditText: "Resultado",
                                    numOfLines: 1,
                                  ),
                                  Spinner(
                                      width: isTabletAndDesktop(context)
                                          ? 120
                                          : 170, // 90
                                      tittle: "Unidad de Medida",
                                      initialValue: unidadMedidaValue!,
                                      items:
                                          Auxiliares.Medidas[tipoEstudioValue],
                                      onChangeValue: (String? newValue) {
                                        setState(() {
                                          unidadMedidaValue = newValue!;
                                        });
                                      }),
                                ]),
                            CrossLine(),
                            GridLayout(
                              childAspectRatio: isMobile(context) ? 3.0 : 5.0,
                              columnCount: isMobile(context) ? 2 : 3,
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GrandButton(
                                    labelButton: operationActivity
                                        ? "Nuevo"
                                        : "Eliminar",
                                    weigth: 100,
                                    onPress: () {
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
                                                  title:
                                                      const Text("Eliminados"),
                                                  content: Text(listOfValues()
                                                      .toString()),
                                                );
                                              });
                                        }
                                      }
                                    }),
                                operationActivity
                                    ? Container()
                                    : GrandButton(
                                        labelButton: "Nuevo",
                                        weigth: 50,
                                        onPress: () {
                                          initAllElement();
                                        }),
                                GrandButton(
                                    weigth: isTablet(context) ? 200 : 500,
                                    labelButton: operationActivity
                                        ? "Agregar"
                                        : "Actualizar",
                                    onPress: () {
                                      if (operationActivity) {
                                        var aux = listOfValues();
                                        aux.removeLast();

                                        Actividades.registrar(
                                          Databases.siteground_database_reggabo,
                                          Auxiliares
                                              .auxiliares['registerQuery'],
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
                                            }).then((value) => Navigator.of(
                                                context)
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
                                                    title: const Text(
                                                        "Actualizados"),
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
      listOfCells.add(dataCell(
        value.toString(),
        onTapped: () {
          operationActivity = false;
          // print("Element ${element[idWidget]}");
          elementSelected = element;
          carouselController.jumpToPage(1);

          updateElement(element);
        },
      ));
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
