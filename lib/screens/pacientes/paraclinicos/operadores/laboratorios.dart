import 'dart:convert';
import 'dart:typed_data';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/screens/pacientes/paraclinicos/paraclinicos.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/WidgetsModels.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:photo_view/photo_view.dart';

class LaboratoriosGestion extends StatefulWidget {
  const LaboratoriosGestion({super.key});

  @override
  State<LaboratoriosGestion> createState() => _LaboratoriosGestionState();
}

class _LaboratoriosGestionState extends State<LaboratoriosGestion> {
  // ############################ ####### ####### #############################
  var fileAssocieted = Auxiliares.fileAssocieted;

  @override
  void initState() {
    iniciar();
    super.initState();
  }

  void iniciar() {
    Terminal.printWarning(
        message:
            " . . . Iniciando Actividad - Repositorio Paraclinicos del Pacientes");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        values = value;
        Terminal.printSuccess(
            message: 'Repositorio Paraclinicos del Pacientes Obtenido$values');
      });
    }).onError((error, stackTrace) {
      final f = DateFormat('yyyy-MM-dd');
      textDateEstudyController.text = f.format(DateTime.now());

      reiniciar();
    });
    Terminal.printOther(message: " . . . Actividad Iniciada");
  }

  Future<void> reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");
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
  }

  @override
  Widget build(BuildContext context) {
    var _progress;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (isMobile(context)) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const Paraclinicos())));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => VisualPacientes(actualPage: 5))));
            }
          },
        ),
        backgroundColor: Theming.primaryColor,
        title: Text(
          tittle,
          style: Styles.textSyleGrowth(fontSize: 14),
        ),
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
      body: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        decoration: ContainerDecoration.roundedDecoration(),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(5),
              decoration: ContainerDecoration.roundedDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GrandButton(
                        weigth: 100,
                        labelButton: "Registro de imagenológicos",
                        onPress: () {
                          carouselController.jumpToPage(0);
                        }),
                  ),
                  Expanded(
                    child: GrandButton(
                        weigth: 100,
                        labelButton: "Gestion del Registro",
                        onPress: () {
                          carouselController.jumpToPage(1);
                        }),
                  ),
                  Expanded(
                    child: GrandButton(
                        weigth: 100,
                        labelButton: "Imagen del Registro",
                        onPress: () {
                          carouselController.jumpToPage(2);
                        }),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: ContainerDecoration.roundedDecoration(),
                child: CarouselSlider(
                  carouselController: carouselController,
                  options: Carousel.carouselOptions(context: context),
                  items: [
                    Column(
                      children: [
                        Expanded(
                          child: EditTextArea(
                            keyBoardType: TextInputType.number,
                            inputFormat: MaskTextInputFormatter(
                                mask: '####/##/##',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy),
                            labelEditText: "Fecha de realización",
                            textController: textDateController,
                            numOfLines: 1,
                            selection: true,
                            withShowOption: true,
                            onSelected: () {
                              Operadores.selectOptionsActivity(
                                  context: context,
                                  options: Listas.listWithoutRepitedValues(
                                    Listas.listFromMapWithOneKey(
                                      values!,
                                      keySearched: 'Fecha_Registro',
                                    ),
                                  ),
                                  onClose: (value) {
                                    setState(() {
                                      textDateController.text = value;
                                      _runFilterSearch(value);
                                      Navigator.of(context).pop();
                                    });
                                  });
                            },
                            onChange: (value) {
                              setState(
                                () {
                                  _runFilterSearch(value);
                                },
                              );
                            },
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: FutureBuilder<List>(
                              initialData: values!,
                              future: Future.value(values!),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasError) print(snapshot.error);
                                return snapshot.hasData
                                    ? GridView.builder(
                                        padding: const EdgeInsets.all(8.0),
                                        gridDelegate:
                                            GridViewTools.gridDelegate(
                                                mainAxisExtent: 150),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data == null
                                            ? 0
                                            : snapshot.data.length,
                                        itemBuilder: (context, posicion) {
                                          return itemSelected(
                                              context: context,
                                              data: snapshot.data,
                                              index: posicion);
                                        })
                                    : Container();
                              }),
                        ),
                      ],
                    ),
                    operationScreen(),
                    // PhotoView(
                    //   imageProvider: MemoryImage(base64Decode(stringImage!)),
                    //   loadingBuilder: (context, progress) => Center(
                    //     child: SizedBox(
                    //       width: 20.0,
                    //       height: 20.0,
                    //       child: CircularProgressIndicator(
                    //         value: _progress == null
                    //             ? null
                    //             : _progress.cumulativeBytesLoaded /
                    //                 _progress.expectedTotalBytes,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// OPERACIONES DE LA INTERFAZ ****** ************ ************
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

  Future<void> toBaseImage() async {
    ByteData bytes = await rootBundle.load('assets/images/person.png');
    var buffer = bytes.buffer;

    setState(() {
      stringImage = base64.encode(Uint8List.view(buffer));
    });
  }

  Widget itemSelected(
      {required BuildContext context, required data, required int index}) {
    return GestureDetector(
      onTap: () {
        operationActivity = false;
        // ***************** ************* *****
        elementSelected = data[index];
        Pacientes.Auxiliar = data[index];
        carouselController.jumpToPage(1);
        // ***************** ************* *****
        updateElement(data[index]);
      },
      child: Container(
        decoration: ContainerDecoration.roundedDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                backgroundColor: Colors.black,
                child: Text(data[index]['ID_Laboratorio'].toString()),
              ),
            ),
            Expanded(
              // flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data[index]['Fecha_Registro'],
                    style: Styles.textSyleGrowth(fontSize: 14),
                  ),
                  Text(
                    data[index]['Tipo_Estudio'],
                    style: Styles.textSyleGrowth(fontSize: 12),
                  ),
                  Text(
                    "${data[index]['Estudio']} ${data[index]['Resultado']} ${data[index]['Unidad_Medida']}",
                    style: Styles.textSyleGrowth(fontSize: 10),
                  ),
                  CrossLine(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GrandIcon(
                          iconData: Icons.update,
                          labelButton: 'Actualizar',
                          onPress: () {
                            operationActivity = false;
                            elementSelected = data[index];
                            Pacientes.Paraclinicos = data[index];
                            carouselController.jumpToPage(1);

                            updateElement(data[index]);
                          }),
                      GrandIcon(
                          iconData: Icons.delete,
                          labelButton: 'Eliminar',
                          onPress: () {
                            deleteDialog(data[index]);
                          }),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  operationScreen() {
    if (isMobile(context) || isTablet(context)) {
      return SingleChildScrollView(
        controller: ScrollController(),
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
            Spinner(
                width: isTabletAndDesktop(context) ? 190 : 170, // 90
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
                    estudioValue = Auxiliares
                        .Laboratorios[Auxiliares.Categorias[index]][0];
                    unidadMedidaValue =
                        Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
                    // *************** *********** **************
                  });
                }),
            Spinner(
                width: isTabletAndDesktop(context) ? 120 : 170, // 90
                tittle: "Estudio",
                initialValue: estudioValue!,
                items: Auxiliares.Laboratorios[tipoEstudioValue],
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
                width: isTabletAndDesktop(context) ? 120 : 170, // 90
                tittle: "Unidad de Medida",
                initialValue: unidadMedidaValue!,
                items: Auxiliares.Medidas[tipoEstudioValue],
                onChangeValue: (String? newValue) {
                  setState(() {
                    unidadMedidaValue = newValue!;
                  });
                }),
            CrossLine(),
            Row(
              children: [
                Expanded(
                  child: GrandButton(
                      labelButton: operationActivity ? "Nuevo" : "Eliminar",
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
                                    title: const Text("Eliminados"),
                                    content: Text(listOfValues().toString()),
                                  );
                                });
                          }
                        }
                      }),
                ),
                operationActivity
                    ? Container()
                    : Expanded(
                        child: GrandButton(
                            labelButton: "Nuevo",
                            weigth: 50,
                            onPress: () {
                              initAllElement();
                            }),
                      ),
                Expanded(
                  child: GrandButton(
                      weigth: isTablet(context) ? 200 : 500,
                      labelButton: operationActivity ? "Agregar" : "Actualizar",
                      onPress: () {
                        operationMethod(
                            context: context,
                            operationActivity: operationActivity);
                      }),
                ),
              ],
            )
          ],
        ),
      );
    } else {
      return Column(
        children: [
          Expanded(child: TittlePanel(textPanel: tittle)),
          Expanded(
            flex: 4,
            child: GridView(
              gridDelegate: GridViewTools.gridDelegate(
                  crossAxisCount: 2, mainAxisExtent: 75),
              children: [
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
                Spinner(
                    width: isTabletAndDesktop(context) ? 190 : 170, // 90
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
                        estudioValue = Auxiliares
                            .Laboratorios[Auxiliares.Categorias[index]][0];
                        unidadMedidaValue =
                            Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
                        // *************** *********** **************
                      });
                    }),
                Spinner(
                    width: isTabletAndDesktop(context) ? 120 : 170, // 90
                    tittle: "Estudio",
                    initialValue: estudioValue!,
                    items: Auxiliares.Laboratorios[tipoEstudioValue],
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
              ],
            ),
          ),
          CrossLine(),
          Row(
            children: [
              Expanded(
                child: GrandButton(
                    labelButton: operationActivity ? "Nuevo" : "Eliminar",
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
                                  title: const Text("Eliminados"),
                                  content: Text(listOfValues().toString()),
                                );
                              });
                        }
                      }
                    }),
              ),
              operationActivity
                  ? Container()
                  : Expanded(
                      child: GrandButton(
                          labelButton: "Nuevo",
                          weigth: 50,
                          onPress: () {
                            initAllElement();
                          }),
                    ),
              Expanded(
                child: GrandButton(
                    weigth: isTablet(context) ? 200 : 500,
                    labelButton: operationActivity ? "Agregar" : "Actualizar",
                    onPress: () {
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
                                    title: const Text("Registrados"),
                                    content: Text(
                                        "Los registros \n${listOfValues().toString()} \n fueron actualizados"),
                                  );
                                })
                            .then((value) => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        VisualPacientes(actualPage: 5)))));
                      } else {
                        Actividades.actualizar(
                                Databases.siteground_database_reggabo,
                                Auxiliares.auxiliares['updateQuery'],
                                listOfValues(),
                                idOperacion!)
                            .then((value) => showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text("Actualizados"),
                                        content: Text(
                                            "Los registros \n${listOfValues().toString()} \n fueron actualizados"),
                                      );
                                    })
                                .then((value) => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            VisualPacientes(actualPage: 5)))));
                      }
                    }),
              ),
            ],
          )
        ],
      );
    }
  }

  Future<Null> _pullListRefresh() async {
    iniciar();
  }

  void _runFilterSearch(String enteredKeyword) {
    List? results = [];

    if (enteredKeyword.isEmpty) {
      _pullListRefresh();
    } else {
      results = Listas.listFromMap(
          lista: values!,
          keySearched: 'Fecha_Registro',
          elementSearched: enteredKeyword);

      setState(() {
        values = results;
      });
    }
  }

  // VARIABLES DE LA INTERFAZ ****** ************ ************
  String? stringImage = '';

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

  void operationMethod(
      {required BuildContext context, required bool operationActivity}) {
    if (operationActivity) {
      var aux = listOfValues();
      aux.removeLast();

      Actividades.registrar(
        Databases.siteground_database_reggabo,
        Auxiliares.auxiliares['registerQuery'],
        aux,
      ).then((value) {
        Operadores.alertActivity(
            context: context,
            tittle: "Registro de los Valores",
            message: 'Los registros fueron agregados');
        reiniciar().then((value) {
          setState(() {
            carouselController.jumpToPage(0);
          });
        });
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => VisualPacientes(actualPage: 5)));
      });
    } else {
      Actividades.actualizar(
              Databases.siteground_database_reggabo,
              Auxiliares.auxiliares['updateQuery'],
              listOfValues(),
              idOperacion!)
          .then((value) {
        Operadores.alertActivity(
            context: context,
            tittle: "Actualizacion de los Valores",
            message: 'Los registros fueron Actualizados');
        reiniciar().then((value) {
          setState(() {
            carouselController.jumpToPage(0);
          });
        });
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => VisualPacientes(actualPage: 5)));
      });
    }
  }
}
