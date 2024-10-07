import 'dart:convert';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/GridLayout.dart';
import 'package:assistant/widgets/ScrollableWidget.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/WidgetsModels.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:photo_view/photo_view.dart';

class dummyWithTable extends StatefulWidget {
  const dummyWithTable({super.key});

  @override
  State<dummyWithTable> createState() => _dummyWithTableState();
}

class _dummyWithTableState extends State<dummyWithTable> {
  // ############################ ####### ####### #############################
  // Variables de Ejecución
  // ############################ ####### ####### #############################
  var carouselController = CarouselSliderController();
  var scrollController = ScrollController();
  // ############################ ####### ####### #############################
  // Variables de Ejecución
  // ############################ ####### ####### #############################
  late List? values = [];
  Map<String, dynamic>? elementSelected;

  bool operationActivity = true; // Si true entonces REGISTER.register.
  String tittle = "Registro de imagenológicos del paciente";
  String idWidget = 'ID_Pace_GAB_RA';
  // TextController for search.
  var textDateController = TextEditingController();
  // ############################ ####### ####### #############################
  // Variables de Valores de Interés
  // ############################ ####### ####### #############################
  int? idOperacion = 0;

  var textDateEstudyController = TextEditingController();
  String? tipoEstudioValue = Imagenologias.typesEstudios[0];
  String? regionCorporalValue = Imagenologias.regiones[0][0];
  var hallazgosEstudioTextController = TextEditingController();
  var conclusionesTextController = TextEditingController();
  //
  String? stringImage = '';
  //
  String tipoEstudio = "Imagenologias";

  // ############################ ####### ####### #############################
  var fileAssocieted = '${Pacientes.localRepositoryPath}/imagenologicos.json';

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
          Imagenologias.imagenologias['consultByIdPrimaryQuery'],
          Pacientes.ID_Paciente)
          .then((value) {
        setState(() {
          Archivos.createJsonFromMap(value, filePath: fileAssocieted);
          values = value;
        });
      });

    });
    Terminal.printOther(message: " . . . Actividad Iniciada");

    super.initState();

    toBaseImage();
  }

  void initAllElement() {
    setState(() {
      operationActivity = true;

      idOperacion = 0;
      final f = DateFormat('yyyy-MM-dd');
      textDateEstudyController.text = f.format(DateTime.now());
      //
      tipoEstudioValue = Imagenologias.typesEstudios[0];
      regionCorporalValue = Imagenologias.regiones[0][0];
      hallazgosEstudioTextController.text = "";
      conclusionesTextController.text = "";
      //
      toBaseImage();
    });
  }

  void updateElement(Map<String, dynamic> element) {
    setState(() {
      print("element $element");

      idOperacion = element[idWidget];
      textDateEstudyController.text = element['Pace_GAB_RA_Feca'];
      tipoEstudioValue = element['Pace_GAB_RA_typ'];
      regionCorporalValue = element['Pace_GAB_RA_reg'];
      hallazgosEstudioTextController.text =
          element['Pace_GAB_RA_hal'].toString();
      conclusionesTextController.text = element['Pace_GAB_RA_con'].toString();
      //
      stringImage = element['Pace_GAB_RA_IMG'];
    });
  }

  List<Widget> listOfComponents() {
    return [
      TittlePanel(color: Colores.backgroundWidget, textPanel: tittle),
      EditTextArea(
        keyBoardType: TextInputType.datetime,
        inputFormat: MaskTextInputFormatter(
            mask: '####/##/##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        numOfLines: 1,
        labelEditText: "Fecha de realización",
        textController: textDateEstudyController,
      ),
      Spinner(
          width: isDesktop(context)
              ? 400
              : isTablet(context)
                  ? 200
                  : isMobile(context)
                      ? 250
                      : 300,
          tittle: "Tipo de Estudios",
          initialValue: tipoEstudioValue!,
          items: Imagenologias.typesEstudios,
          onChangeValue: (String? newValue) {
            setState(() {
              tipoEstudioValue = newValue!;
            });
          }),
      Spinner(
          width: isDesktop(context)
              ? 400
              : isTablet(context)
                  ? 200
                  : isMobile(context)
                      ? 250
                      : 300,
          tittle: "Región Corporal",
          initialValue: regionCorporalValue!,
          items: Imagenologias.regiones[0],
          onChangeValue: (String? newValue) {
            setState(() {
              regionCorporalValue = newValue!;
            });
          }),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Hallazgos del Estudio",
        textController: hallazgosEstudioTextController,
        numOfLines: 7,
        onChange: (value) {
          setState(() {});
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var progress;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (isMobile(context)) {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: ((context) => const AuxiliaresDiagnosticos())));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => VisualPacientes(actualPage: 5))));
            }
          },
        ),
        backgroundColor: Theming.primaryColor,
        actions: isMobile(context) || isTablet(context)
            ? <Widget>[
                GrandIcon(
                  iconData: Icons.dataset_linked_outlined,
                  labelButton: "Registro de imagenológicos",
                  onPress: () {
                    carouselController.jumpToPage(0);
                  },
                ),
                GrandIcon(
                  iconData: Icons.browser_updated,
                  labelButton: "Gestion del Registro",
                  onPress: () {
                    carouselController.jumpToPage(1);
                  },
                ),
                GrandIcon(
                  iconData: Icons.photo_camera_back_outlined,
                  labelButton: 'Imagen del Electrocardiograma',
                  onPress: () {
                    Operadores.optionsActivity(
                      context: context,
                      tittle: 'Cargar imagen del Electrocardiograma',
                      onClose: () {
                        Navigator.of(context).pop();
                      },
                      textOptionA: 'Cargar desde Dispositivo',
                      optionA: () async {
                        var bytes = await Directorios.choiseFromDirectory();
                        setState(() {
                          stringImage = base64Encode(bytes);
                          Navigator.of(context).pop();
                        });
                      },
                      textOptionB: 'Cargar desde Cámara',
                      optionB: () async {
                        var bytes = await Directorios.choiseFromCamara();
                        setState(() {
                          stringImage = base64Encode(bytes);
                          Navigator.of(context).pop();
                        });
                      },
                    );
                  },
                ),
              ]
            : <Widget>[
                GrandIcon(
                  iconData: Icons.photo_camera_back_outlined,
                  labelButton: 'Imagen del Electrocardiograma',
                  onPress: () {
                    Operadores.optionsActivity(
                      context: context,
                      tittle: 'Cargar imagen del Electrocardiograma',
                      onClose: () {
                        Navigator.of(context).pop();
                      },
                      textOptionA: 'Cargar desde Dispositivo',
                      optionA: () async {
                        var bytes = await Directorios.choiseFromDirectory();
                        setState(() {
                          stringImage = base64Encode(bytes);
                          Navigator.of(context).pop();
                        });
                      },
                      textOptionB: 'Cargar desde Cámara',
                      optionB: () async {
                        var bytes = await Directorios.choiseFromCamara();
                        setState(() {
                          stringImage = base64Encode(bytes);
                          Navigator.of(context).pop();
                        });
                      },
                    );
                  },
                ),
              ],
      ),
      body: Column(
        children: [
          isMobile(context)
              ? Container()
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GrandButton(
                      weigth: 100,
                      labelButton: "Registro de imagenológicos",
                      onPress: () {
                        carouselController.jumpToPage(0);
                      }),
                  GrandButton(
                      weigth: 100,
                      labelButton: "Gestion del Registro",
                      onPress: () {
                        carouselController.jumpToPage(1);
                      }),
                  GrandButton(
                      weigth: 100,
                      labelButton: "Imagen del Registro",
                      onPress: () {
                        carouselController.jumpToPage(2);
                      }),
                  // GrandButton(
                  //     weigth: 100,
                  //     labelButton: "Gestion del Registro",
                  //     onPress: () {
                  //       carouselController.jumpToPage(2);
                  //     }),
                ],
              ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CarouselSlider(
                    carouselController: carouselController,
                    options: CarouselOptions(
                        height: isMobile(context)
                            ? 900
                            : isTablet(context)
                                ? 1000
                                : isDesktop(context)
                                    ? 900
                                    : 500,
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
                                    TittlePanel(textPanel: tittle),
                                    EditTextArea(
                                      keyBoardType: TextInputType.number,
                                      inputFormat: MaskTextInputFormatter(
                                          mask: '####/##/##',
                                          filter: {"#": RegExp(r'[0-9]')},
                                          type: MaskAutoCompletionType.lazy),
                                      labelEditText: "Fecha de realización",
                                      textController: textDateController,
                                      numOfLines: 1,
                                      onChange: (value) {
                                        setState(
                                          () {
                                            Valores.fechaElectrocardiograma =
                                                value;
                                          },
                                        );
                                      },
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
                        padding: const EdgeInsets.all(8.0),
                        controller: scrollController,
                        child: Expanded(
                          child: GridLayout(
                            childAspectRatio: isMobile(context) ? 0.63 : isTablet(context) ? 1.5 : 1.0,
                            columnCount: isMobile(context) || isTablet(context) ? 1 :2,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: listOfComponents()),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    EditTextArea(
                                        keyBoardType: TextInputType.number,
                                        inputFormat: MaskTextInputFormatter(),
                                        numOfLines: 15,
                                        labelEditText: "Conclusiones",
                                        textController:
                                            conclusionesTextController,
                                        prefixIcon: false),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GrandButton(
                                            weigth: isMobile(context)
                                                ? 30
                                                : 100,
                                            labelButton: operationActivity
                                                ? "Nuevo"
                                                : "Eliminar",
                                            onPress: () {
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
                                            : GrandButton(
                                            labelButton: "Nuevo",
                                            weigth: isMobile(context)
                                                ? 20
                                                : 100,
                                            onPress: () {
                                              initAllElement();
                                            }),
                                        GrandButton(
                                            weigth: isMobile(context) ||
                                                isTablet(context)
                                                ? 30
                                                : 100,
                                            labelButton: operationActivity
                                                ? "Agregar"
                                                : "Actualizar",
                                            onPress: () {
                                              if (operationActivity) {
                                                var aux = listOfValues();
                                                aux.removeAt(0);
                                                aux.removeLast();

                                                Actividades.registrar(
                                                  Databases
                                                      .siteground_database_reggabo,
                                                  Imagenologias
                                                      .imagenologias[
                                                  'registerQuery'],
                                                  aux,
                                                ).then((value) =>
                                                    showDialog(
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
                                                        builder:
                                                            (context) =>
                                                        const dummyWithTable()))));
                                              } else {
                                                Actividades.actualizar(
                                                    Databases
                                                        .siteground_database_reggabo,
                                                    Imagenologias
                                                        .imagenologias[
                                                    'updateQuery'],
                                                    listOfValues(),
                                                    idOperacion!)
                                                    .then((value) =>
                                                    showDialog(
                                                        context:
                                                        context,
                                                        builder:
                                                            (context) {
                                                          print(
                                                              "Imagenologias.imagenologias['updateQuery'] ${Imagenologias.imagenologias['updateQuery']}");
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
                                                        const dummyWithTable()))));
                                              }
                                            }),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      PhotoView(
                        imageProvider: MemoryImage(base64Decode(stringImage!)),
                        loadingBuilder: (context, progress) => Center(
                          child: SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: CircularProgressIndicator(
                              value: progress == null
                                  ? null
                                  : progress.cumulativeBytesLoaded /
                                  progress.expectedTotalBytes!,
                            ),
                          ),
                        ),
                      ),
                    ],
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
        DataColumn(label: labelText("Fecha de realización")),
        DataColumn(label: labelText("Tipo de Estudio")),
        DataColumn(label: labelText("Región Corporal")),
        // DataColumn(label: labelText("Frecuencia Cardiaca")),
        // DataColumn(label: labelText("Conclusiones")),
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
    listOfCells.add(dataCell(element['ID_Pace_GAB_RA'].toString(), onTapped: () {
      operationActivity = false;
      // ***************** ************* *****
      elementSelected = element;
      Pacientes.Imagenologias = element;
      carouselController.jumpToPage(1);
      // ***************** ************* *****
      updateElement(element);
    },));
    listOfCells.add(dataCell(element['Pace_GAB_RA_Feca'].toString(), onTapped: () {
      operationActivity = false;
      // ***************** ************* *****
      elementSelected = element;
      Pacientes.Imagenologias = element;
      carouselController.jumpToPage(1);
      // ***************** ************* *****
      updateElement(element);
    },));
    listOfCells.add(dataCell(element['Pace_GAB_RA_typ'].toString(), onTapped: () {
      operationActivity = false;
      // ***************** ************* *****
      elementSelected = element;
      Pacientes.Imagenologias = element;
      carouselController.jumpToPage(1);
      // ***************** ************* *****
      updateElement(element);
    },));
    listOfCells.add(dataCell(element['Pace_GAB_RA_reg'].toString(), onTapped: () {
      operationActivity = false;
      // ***************** ************* *****
      elementSelected = element;
      Pacientes.Imagenologias = element;
      carouselController.jumpToPage(1);
      // ***************** ************* *****
      updateElement(element);
    },));
    // listOfCells.add(dataCell(element['Pace_GAB_RA_hal'].toString()));
    // listOfCells.add(dataCell(element['Pace_EC_CON'].toString()));
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
                  Pacientes.Imagenologias = element;
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
                    Imagenologias.imagenologias['deleteQuery'],
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
                                const dummyWithTable()))));
          });
        });
  }

  List<String> listOfValues() {
    return [
      idOperacion!.toString(),
      Pacientes.ID_Paciente.toString(),
      textDateEstudyController.text,
      //
      tipoEstudioValue!,
      regionCorporalValue!,
      hallazgosEstudioTextController.text,
      conclusionesTextController.text,
      //
      stringImage!,
      tipoEstudio,
      //
      idOperacion!.toString(),
    ];
  }

  Future<void> toBaseImage() async {
    ByteData bytes = await rootBundle.load('assets/images/person.png');
    var buffer = bytes.buffer;

    setState(() {
      stringImage = base64.encode(Uint8List.view(buffer));
    });
  }
}
