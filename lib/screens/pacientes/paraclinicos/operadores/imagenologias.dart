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
import 'package:assistant/widgets/GridLayout.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/WidgetsModels.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:photo_view/photo_view.dart';

class ImagenologiasGestion extends StatefulWidget {
  const ImagenologiasGestion({super.key});

  @override
  State<ImagenologiasGestion> createState() => _ImagenologiasGestionState();
}

class _ImagenologiasGestionState extends State<ImagenologiasGestion> {
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
  String? regionCorporalValue = Imagenologias.regiones[0];
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
    Terminal.printWarning(
        message:
            " . . . Iniciando Actividad - Repositorio Paraclinicos del Pacientes");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        values = value;
        Terminal.printData(message: values.toString());
        Terminal.printSuccess(
            message: 'Repositorio Paraclinicos del Pacientes Obtenido');
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
                  builder: ((context) =>  Paraclinicos())));
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => VisualPacientes(actualPage: 5))));
            }
          },
        ),
        backgroundColor: Theming.primaryColor,
        title: Text(tittle, style: Styles.textSyleGrowth(fontSize: 14),),
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
                            onChange: (value) {
                              setState(
                                () {
                                  Valores.fechaElectrocardiograma = value;
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
                                            GridViewTools.gridDelegate(mainAxisExtent: 150),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data == null
                                            ? 0
                                            : snapshot.data.length,
                                        itemBuilder: (context, posicion) {
                                          return itemSelected(context:context, data: snapshot.data, index: posicion);
                                        })
                                    : Container();
                              }),
                        ),
                      ],
                    ),
                    operationScreen(),
                    PhotoView(
                      imageProvider: MemoryImage(base64Decode(stringImage!)),
                      loadingBuilder: (context, progress) => Center(
                        child: SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: CircularProgressIndicator(
                            value: _progress == null
                                ? null
                                : _progress.cumulativeBytesLoaded /
                                    _progress.expectedTotalBytes,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                                const ImagenologiasGestion()))));
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

  void initAllElement() {
    setState(() {
      operationActivity = true;

      idOperacion = 0;
      final f = DateFormat('yyyy-MM-dd');
      textDateEstudyController.text = f.format(DateTime.now());
      //
      tipoEstudioValue = Imagenologias.typesEstudios[0];
      regionCorporalValue = Imagenologias.regiones[0];
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

  Future<void> toBaseImage() async {
    ByteData bytes = await rootBundle.load('assets/images/person.png');
    var buffer = bytes.buffer;

    setState(() {
      stringImage = base64.encode(Uint8List.view(buffer));
    });
  }

  Widget itemSelected({required BuildContext context, required data, required int index}) {
    return GestureDetector(
      onTap: () {
        operationActivity = false;
        // ***************** ************* *****
        elementSelected =
        data[index];
        Pacientes.Imagenologias =
        data[index];
        carouselController.jumpToPage(1);
        // ***************** ************* *****
        updateElement(
            data[index]);
      },
      child: Container(
        decoration: ContainerDecoration
            .roundedDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  margin:
                  const EdgeInsets.all(4.0),
                  padding:
                  const EdgeInsets.all(4.0),
                  decoration:
                  ContainerDecoration
                      .roundedDecoration(),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    child: Image.memory(
                      base64Decode(data[
                      index][
                      'Pace_GAB_RA_IMG']),
                      height: 150,
                      width: 100,),
                  ),
                )),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data[index][
                    'Pace_GAB_RA_Feca'],
                    style: Styles
                        .textSyleGrowth(fontSize: 14),
                  ),
                  Text(
                    data[index]
                    ['Pace_GAB_RA_typ'],
                    style: Styles
                        .textSyleGrowth(fontSize: 12),
                  ),
                  Text(
                    data[index]
                    ['Pace_GAB_RA_reg'],
                    style: Styles
                        .textSyleGrowth(fontSize: 10),
                  ),
                  CrossLine(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GrandIcon(
                          iconData: Icons.update,
                          labelButton:
                          'Actualizar',
                          onPress: () {
                            operationActivity =
                            false;
                            elementSelected =
                            data[
                            index];
                            Pacientes
                                .Imagenologias =
                            data[
                            index];
                            carouselController
                                .jumpToPage(1);

                            updateElement(
                                data[
                                index]);
                          }),
                      GrandIcon(
                          iconData: Icons.delete,
                          labelButton:
                          'Eliminar',
                          onPress: () {
                            deleteDialog(
                                data[
                                index]);
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
                items: Imagenologias.regiones,
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
            EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                numOfLines: 15,
                labelEditText: "Conclusiones",
                textController: conclusionesTextController,
                prefixIcon: false),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: GrandButton(
                      weigth: isMobile(context) ? 30 : 100,
                      labelButton: operationActivity
                          ? "Nuevo"
                          : "Eliminar",
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
                ),
                operationActivity
                    ? Container()
                    : Expanded(
                      child: GrandButton(
                      labelButton: "Nuevo",
                      weigth:
                      isMobile(context) ? 20 : 100,
                      onPress: () {
                        initAllElement();
                      }),
                    ),
                Expanded(
                  child: GrandButton(
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
                            Imagenologias.imagenologias[
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
                              }).then((value) => Navigator.of(
                              context)
                              .push(MaterialPageRoute(
                              builder: (context) =>
                              const ImagenologiasGestion()))));
                        } else {
                          Actividades.actualizar(
                              Databases
                                  .siteground_database_reggabo,
                              Imagenologias.imagenologias[
                              'updateQuery'],
                              listOfValues(),
                              idOperacion!)
                              .then((value) => showDialog(
                              context: context,
                              builder: (context) {
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
                              builder: (context) =>
                              const ImagenologiasGestion()))));
                        }
                      }),
                ),
              ],
            )
          ],
        ),
      );
    }
    else {
      return Row(
        children: [
          Expanded(
            flex: 6,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                      items: Imagenologias.regiones,
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
                ]),
          ),
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    numOfLines: 15,
                    labelEditText: "Conclusiones",
                    textController: conclusionesTextController,
                    prefixIcon: false),
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  children: [
                    GrandButton(
                        weigth: isMobile(context) ? 30 : 100,
                        labelButton: operationActivity
                            ? "Nuevo"
                            : "Eliminar",
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
                        weigth:
                        isMobile(context) ? 20 : 100,
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
                              Imagenologias.imagenologias[
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
                                }).then((value) => Navigator.of(
                                context)
                                .push(MaterialPageRoute(
                                builder: (context) =>
                                const ImagenologiasGestion()))));
                          } else {
                            Actividades.actualizar(
                                Databases
                                    .siteground_database_reggabo,
                                Imagenologias.imagenologias[
                                'updateQuery'],
                                listOfValues(),
                                idOperacion!)
                                .then((value) => showDialog(
                                context: context,
                                builder: (context) {
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
                                builder: (context) =>
                                const ImagenologiasGestion()))));
                          }
                        }),
                  ],
                )
              ],
            ),
          )
        ],
      );
    }
  }

}
