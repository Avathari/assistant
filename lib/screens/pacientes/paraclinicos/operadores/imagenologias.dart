import 'dart:convert';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/cardiometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/cerebrovasculares.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/TittlePanel.dart';

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
  int index = 0;
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
  String tittle = "Imagenológicos";
  String idWidget = 'ID_Pace_GAB_RA';
  // TextController for search.
  var searchTextController = TextEditingController();
  // ############################ ####### ####### #############################
  // Variables de Valores de Interés
  // ############################ ####### ####### #############################
  int? idOperacion = 0;

  var textDateEstudyController = TextEditingController();
  String? tipoEstudioValue = Imagenologias.typesEstudios[0];
  // String? regionCorporalValue = Imagenologias.regiones[0];
  var regionCorporalTextController = TextEditingController();
  var hallazgosEstudioTextController = TextEditingController();
  var conclusionesTextController = TextEditingController();
  //
  String? stringImage = '';
  //
  String tipoEstudio = "Imagenologias";

  // ############################ ####### ####### #############################
  var fileAssocieted = Imagenologias.fileAssocieted;

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
      textDateEstudyController.text = Calendarios.today(format: 'yyyy/MM/dd');
      _reiniciar();
    });
    Terminal.printOther(message: " . . . Actividad Iniciada");

    super.initState();

    toBaseImage();
  }

  @override
  Widget build(BuildContext context) {
    var progress;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.grey),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => VisualPacientes(actualPage: 5))));
            },
          ),
          backgroundColor: Theming.primaryColor,
          title: AppBarText(tittle),
          actions: [
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
            const SizedBox(width: 25),
            // GrandIcon(
            //     iconData: Icons.photo_camera_back_outlined,
            //     labelButton: 'Imagen del Electrocardiograma',
            //     onPress: () {
            //       Directorios.choiseFromClipboard(context, "text");
            //     }),
            // if (!isMobile(context))GrandIcon(
            //     iconData: Icons.update,
            //     labelButton: 'Reiniciar . . . ',
            //     onPress: () {
            //       _reiniciar();
            //     }),
          ],
          // actions: isMobile(context) || isTablet(context)
          //     ? <Widget>[
          //         GrandIcon(
          //           iconData: Icons.replay_outlined,
          //           labelButton: Sentences.reload,
          //           onPress: () {
          //             reiniciar();
          //           },
          //         ),
          //         const SizedBox(width: 15),
          //         GrandIcon(
          //           iconData: Icons.dataset_linked_outlined,
          //           labelButton: "Registro de imagenológicos",
          //           onPress: () {
          //             carouselController.jumpToPage(0);
          //           },
          //         ),
          //         GrandIcon(
          //           iconData: Icons.browser_updated,
          //           labelButton: "Gestion del Registro",
          //           onPress: () {
          //             carouselController.jumpToPage(1);
          //           },
          //         ),
          //         GrandIcon(
          //           iconData: Icons.photo_camera_back_outlined,
          //           labelButton: 'Imagen del Electrocardiograma',
          //           onPress: () {
          //             Operadores.optionsActivity(
          //               context: context,
          //               tittle: 'Cargar imagen del Electrocardiograma',
          //               onClose: () {
          //                 Navigator.of(context).pop();
          //               },
          //               textOptionA: 'Cargar desde Dispositivo',
          //               optionA: () async {
          //                 var bytes = await Directorios.choiseFromDirectory();
          //                 setState(() {
          //                   stringImage = base64Encode(bytes);
          //                   Navigator.of(context).pop();
          //                 });
          //               },
          //               textOptionB: 'Cargar desde Cámara',
          //               optionB: () async {
          //                 var bytes = await Directorios.choiseFromCamara();
          //                 setState(() {
          //                   stringImage = base64Encode(bytes);
          //                   Navigator.of(context).pop();
          //                 });
          //               },
          //             );
          //           },
          //         ),
          //       ]
          //     : <Widget>[
          //         GrandIcon(
          //           iconData: Icons.replay_outlined,
          //           labelButton: Sentences.reload,
          //           onPress: () {
          //             reiniciar();
          //           },
          //         ),
          //         GrandIcon(
          //           iconData: Icons.photo_camera_back_outlined,
          //           labelButton: 'Imagen del Electrocardiograma',
          //           onPress: () {
          //             Operadores.optionsActivity(
          //               context: context,
          //               tittle: 'Cargar imagen del Electrocardiograma',
          //               onClose: () {
          //                 Navigator.of(context).pop();
          //               },
          //               textOptionA: 'Cargar desde Dispositivo',
          //               optionA: () async {
          //                 var bytes = await Directorios.choiseFromDirectory();
          //                 setState(() {
          //                   stringImage = base64Encode(bytes);
          //                   Navigator.of(context).pop();
          //                 });
          //               },
          //               textOptionB: 'Cargar desde Cámara',
          //               optionB: () async {
          //                 var bytes = await Directorios.choiseFromCamara();
          //                 setState(() {
          //                   stringImage = base64Encode(bytes);
          //                   Navigator.of(context).pop();
          //                 });
          //               },
          //             );
          //           },
          //         ),
          //       ],
        ),
        body: Container(
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(5),
          decoration: ContainerDecoration.roundedDecoration(),
          child: Column(
            children: [
              // Container(
              //   padding: const EdgeInsets.all(5),
              //   margin: const EdgeInsets.all(5),
              //   decoration: ContainerDecoration.roundedDecoration(),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Expanded(
              //         child: GrandButton(
              //             weigth: 100,
              //             labelButton: "Registro de imagenológicos",
              //             onPress: () {
              //               carouselController.jumpToPage(0);
              //             }),
              //       ),
              //       Expanded(
              //         child: GrandButton(
              //             weigth: 100,
              //             labelButton: "Gestion del Registro",
              //             onPress: () {
              //               carouselController.jumpToPage(1);
              //             }),
              //       ),
              //       Expanded(
              //         child: GrandButton(
              //             weigth: 100,
              //             labelButton: "Imagen del Registro",
              //             onPress: () {
              //               carouselController.jumpToPage(2);
              //             }),
              //       ),
              //     ],
              //   ),
              // ),
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
                              textController: searchTextController,
                              numOfLines: 1,
                              selection: true,
                              withShowOption: true,
                              onSelected: () {
                                Operadores.selectOptionsActivity(
                                    context: context,
                                    options: Listas.listWithoutRepitedValues(
                                      Listas.listFromMapWithOneKey(
                                        values!,
                                        keySearched: 'Pace_GAB_RA_Feca',
                                      ),
                                    ),
                                    onClose: (value) {
                                      setState(() {
                                        searchTextController.text = Valores.fechaElectrocardiograma = value;
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
                            child: RefreshIndicator(
                              color: Colors.white,
                              backgroundColor: Colors.black,
                              onRefresh: _reiniciar,
                              child: FutureBuilder<List>(
                                  initialData: values!,
                                  future: Future.value(values!),
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (snapshot.hasError)
                                      print(snapshot.error);
                                    return snapshot.hasData
                                        ? GridView.builder(
                                            padding: const EdgeInsets.all(8.0),
                                            gridDelegate:
                                                GridViewTools.gridDelegate(
                                              crossAxisCount:
                                                  isMobile(context) ? 1 : 3,
                                              mainAxisExtent:
                                                  isMobile(context) ? 150 : 170,
                                            ),
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
                          ),
                        ],
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
                      operationScreen(),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          height: 50,
          shape: CircularNotchedRectangle(), // notch redondeado
          notchMargin: 6.0, // margen entre el botón y el BottomAppBar
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(icon: Icon(Icons.domain), onPressed: () {carouselController.jumpToPage(0);}),
              IconButton(icon: Icon(Icons.app_registration), onPressed: () {carouselController.jumpToPage(2);}),
              SizedBox(width: 55), // espacio para el botón flotante
              IconButton(icon: Icon(Icons.image_aspect_ratio), onPressed: () {carouselController.jumpToPage(1);}),
              IconButton(icon: Icon(Icons.photo_camera_back_outlined), onPressed: () {Operadores.optionsActivity(
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
              );}),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: isMobile(context) || isTablet(context)
            ? CircleIcon(
                iconed: Icons.update,
                onChangeValue: () => _reiniciar(),
              )
            : null);
  }


  void deleteDialog(Map<String, dynamic> element) {
    Operadores.alertActivity(
        context: context,
        tittle: "Eliminación de Registros",
        message: "Registro eliminado",
        onAcept: () {
          Actividades.eliminar(Databases.siteground_database_reggabo,
                  Imagenologias.imagenologias['deleteQuery'], element[idWidget])
              .then((value) {
            Archivos.deleteFile(filePath: fileAssocieted).then((value) {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ImagenologiasGestion()));
            });
          }).onError((error, stackTrace) {
            Terminal.printAlert(message: "ERROR - Hubo un error : $error");
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
      regionCorporalTextController.text,
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
      // regionCorporalValue = Imagenologias.regiones[0];
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
      regionCorporalTextController.text = element['Pace_GAB_RA_reg'];
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

  Widget itemSelected(
      {required BuildContext context, required data, required int index}) {
    return GestureDetector(
      onTap: () {
        operationActivity = false;
        // ***************** ************* *****
        elementSelected = Pacientes.Imagenologias = data[index];
        carouselController.jumpToPage(1);
        // ***************** ************* *****
        updateElement(data[index]);
      },
      child: Container(
        decoration: ContainerDecoration.roundedDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.all(4.0),
                  decoration: ContainerDecoration.roundedDecoration(),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    child: Image.memory(
                      base64Decode(data[index]['Pace_GAB_RA_IMG']),
                      height: 150,
                      width: 100,
                    ),
                  ),
                )),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data[index]['Pace_GAB_RA_Feca'],
                    style: Styles.textSyleGrowth(fontSize: 14),
                  ),
                  Text(
                    data[index]['Pace_GAB_RA_typ'],
                    style: Styles.textSyleGrowth(fontSize: 12),
                  ),
                  Text(
                    data[index]['Pace_GAB_RA_reg'],
                    maxLines: 4,
                    style: Styles.textSyleGrowth(fontSize: 10),
                  ),
                  CrossLine(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: isMobile(context) ? 12 : 35),
                      GrandIcon(
                          iconData: Icons.update,
                          labelButton: 'Actualizar',
                          onPress: () {
                            operationActivity = false;
                            elementSelected = data[index];
                            Pacientes.Imagenologias = data[index];
                            carouselController.jumpToPage(1);

                            updateElement(data[index]);
                          }),
                      GrandIcon(
                          iconData: Icons.delete,
                          labelButton: 'Eliminar',
                          onPress: () {
                            deleteDialog(data[index]);
                          }),
                      const SizedBox(width: 5),
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
      return TittleContainer(
        centered: false,
        padding: 5.0,
        tittle: tittle,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              EditTextArea(
                keyBoardType: TextInputType.datetime,
                inputFormat: MaskTextInputFormatter(
                    mask: '####/##/## ##:##:##', // 'yyyy-MM-dd HH:mm:ss'
                    filter: {"#": RegExp(r'[0-9]')},
                    type: MaskAutoCompletionType.lazy),
                numOfLines: 1,
                labelEditText: "Fecha de realización",
                withShowOption: true,
                selection: true,
                onSelected: () {
                  textDateEstudyController.text =
                      Calendarios.today(format: "yyyy/MM/dd HH:mm:ss");
                }, textController: textDateEstudyController,
              ),
              Spinner(
                  width: isDesktop(context)
                      ? 400
                      : isTablet(context)
                          ? 200
                          : isMobile(context)
                              ? 230
                              : 300,
                  tittle: "Tipo de Estudios",
                  initialValue: tipoEstudioValue!,
                  items: Imagenologias.typesEstudios,
                  onChangeValue: (String? newValue) {
                    setState(() {
                      tipoEstudioValue = newValue!;

                      index = Imagenologias.typesEstudios.indexOf(newValue);
                    });
                  }),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: EditTextArea(
                      keyBoardType: TextInputType.text,
                      inputFormat: MaskTextInputFormatter(),
                      numOfLines: 3,
                      labelEditText: 'Región Estudiada',
                      textController: regionCorporalTextController,
                      selection: true,
                      withShowOption: true,
                      onSelected: () {
                        Operadores.selectOptionsActivity(
                            context: context,
                            options: Imagenologias.regiones[index].toList(),
                            onClose: (value) {
                              setState(() {
                                Navigator.pop(context);
                                regionCorporalTextController.text = value;
                              });
                            });
                      },
                    ),
                  ),
                  Expanded(
                    child: GrandIcon(
                      labelButton: "PIC/DVNO",
                      iconData: Icons.remove_red_eye_outlined,
                      onPress: () {
                        if (tipoEstudioValue == "Ultrasonidos") {
                          Operadores.editActivity(
                              context: context,
                              tittle: "Medición de PIC por DVNO",
                              message:
                                  "Medición de PIC por DVNO . . . Ingrese DVNO en mm",
                              onAcept: (value) {
                                setState(() {
                                  hallazgosEstudioTextController.text =
                                      "Se realiza ultrasonido ocular, "
                                      "con transductor lineal 3-15 mHz, obteniendo DVNO $value mm, "
                                      "concordante con PIC ~${Cerebrovasculares.picDVNO(double.parse(value)).toStringAsFixed(2)} mmHg. "
                                      "${Cardiometrias.presionArterialMedia != 0.0 ? "TAM ${Cardiometrias.presionArterialMedia} mmhG actual : " : ""}"
                                      "${Cardiometrias.presionArterialMedia != 0.0 ? "PPC inferida ${Cerebrovasculares.presionPrefusionCerebral(double.parse(value)).toStringAsFixed(2)} mmHg. " : ""}"
                                      "${Cardiometrias.presionArterialMedia != 0.0 ? "FSC aproximado ${Cerebrovasculares.flujoSanguineoCerebral(double.parse(value)).toStringAsFixed(2)} mL/100g/m2" : ""}";
                                  Navigator.of(context).pop();
                                });
                              });
                        }
                      },
                    ),
                  )
                ],
              ),
              // Spinner(
              //     width: isDesktop(context)
              //         ? 400
              //         : isTablet(context)
              //         ? 200
              //         : isMobile(context)
              //         ? 230
              //         : 300,
              //     tittle: "Región Corporal",
              //     initialValue: regionCorporalValue!,
              //     items: Imagenologias.regiones,
              //     onChangeValue: (String? newValue) {
              //       setState(() {
              //         regionCorporalValue = newValue!;
              //       });
              //     }),
              CrossLine(),
              EditTextArea(
                keyBoardType: TextInputType.multiline,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: "Hallazgos del Estudio",
                textController: hallazgosEstudioTextController,
                numOfLines: 7,
                onChange: (value) {
                  setState(() {});
                },
              ),
              EditTextArea(
                  keyBoardType: TextInputType.multiline,
                  inputFormat: MaskTextInputFormatter(),
                  numOfLines: 12,
                  labelEditText: "Conclusiones",
                  textController: conclusionesTextController,
                  prefixIcon: false),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GrandButton(
                        weigth: isMobile(context) ? 30 : 100,
                        labelButton: operationActivity ? "Nuevo" : "Eliminar",
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
                              weigth: isMobile(context) ? 20 : 100,
                              onPress: () {
                                initAllElement();
                              }),
                        ),
                  Expanded(
                    child: GrandButton(
                        weigth:
                            isMobile(context) || isTablet(context) ? 30 : 100,
                        labelButton:
                            operationActivity ? "Agregar" : "Actualizar",
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
        ),
      );
    } else {
      return Row(
        children: [
          Expanded(
            flex: 6,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              TittlePanel(color: Colores.backgroundWidget, textPanel: tittle),
              EditTextArea(
                keyBoardType: TextInputType.datetime,
                inputFormat: MaskTextInputFormatter(
                    mask: '####/##/##',
                    filter: {"#": RegExp(r'[0-9]')},
                    type: MaskAutoCompletionType.lazy),
                numOfLines: 1,
                labelEditText: "Fecha de realización",
                withShowOption: true,
                selection: true,
                textController: textDateEstudyController,
                onSelected: () {
                  textDateEstudyController.text =
                      Calendarios.today(format: 'yyyy/MM/dd');
                },
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

                      index = Imagenologias.typesEstudios.indexOf(newValue);
                    });
                  }),
              CrossLine(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: EditTextArea(
                      keyBoardType: TextInputType.text,
                      inputFormat: MaskTextInputFormatter(),
                      numOfLines: 3,
                      labelEditText: 'Región Estudiada',
                      textController: regionCorporalTextController,
                      selection: true,
                      withShowOption: true,
                      onSelected: () {
                        Operadores.selectOptionsActivity(
                            context: context,
                            options: Imagenologias.regiones[index].toList(),
                            onClose: (value) {
                              setState(() {
                                Navigator.pop(context);
                                regionCorporalTextController.text = value;
                              });
                            });
                      },
                    ),
                  ),
                  Expanded(
                    child: GrandIcon(
                      labelButton: "PIC/DVNO",
                      iconData: Icons.remove_red_eye_outlined,
                      onPress: () {
                        if (tipoEstudioValue == "Ultrasonidos") {
                          Operadores.editActivity(
                              context: context,
                              tittle: "Medición de PIC por DVNO",
                              message:
                                  "Medición de PIC por DVNO . . . Ingrese DVNO en mm",
                              onAcept: (value) {
                                setState(() {
                                  hallazgosEstudioTextController.text =
                                      "Se realiza ultrasonido ocular, "
                                      "con transductor lineal 3-15 mHz, obteniendo DVNO $value mm, "
                                      "concordante con PIC ~${Cerebrovasculares.picDVNO(double.parse(value)).toStringAsFixed(2)} mmHg. "
                                      "PPC inferida ${Cerebrovasculares.presionPrefusionCerebral(double.parse(value)).toStringAsFixed(2)} mmHg. "
                                      "FSC aproximado ${Cerebrovasculares.flujoSanguineoCerebral(double.parse(value)).toStringAsFixed(2)} mL/100g/m2";
                                  Navigator.of(context).pop();
                                });
                              });
                        }
                      },
                    ),
                  )
                ],
              ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GrandButton(
                        weigth: isMobile(context) ? 30 : 100,
                        labelButton: operationActivity ? "Nuevo" : "Eliminar",
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
                    operationActivity
                        ? Container()
                        : GrandButton(
                            labelButton: "Nuevo",
                            weigth: isMobile(context) ? 20 : 100,
                            onPress: () {
                              initAllElement();
                            }),
                    GrandButton(
                        weigth:
                            isMobile(context) || isTablet(context) ? 30 : 100,
                        labelButton:
                            operationActivity ? "Agregar" : "Actualizar",
                        onPress: () {
                          operationMethod(
                              context: context,
                              operationActivity: operationActivity);
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

  void operationMethod(
      {required BuildContext context, required bool operationActivity}) {
    if (operationActivity) {
      var aux = listOfValues();
      aux.removeAt(0);
      aux.removeLast();
      Terminal.printExpected(
          message:
              "operationActivity : :  $operationActivity : : method ${Imagenologias.imagenologias['registerQuery']}");
      Actividades.registrar(
        Databases.siteground_database_reggabo,
        Imagenologias.imagenologias['registerQuery'],
        aux,
      ).then((value) {
        Operadores.alertActivity(
            context: context,
            tittle: "Registro de los Valores",
            message: 'Los registros fueron agregados',
            onClose: () {
              Navigator.pop(context);
              _reiniciar().then((value) {
                setState(() {
                  carouselController.jumpToPage(0);
                });
              });
            },
            onAcept: () {
              Navigator.pop(context);
              _reiniciar().then((value) {
                setState(() {
                  carouselController.jumpToPage(0);
                });
              });
            });
      }).onError((error, stackTrace) {
        Terminal.printWarning(message: "ERROR - $error");
      });
    } else {
      Actividades.actualizar(
              Databases.siteground_database_reggabo,
              Imagenologias.imagenologias['updateQuery'],
              listOfValues(),
              idOperacion!)
          .then((value) {
        Operadores.alertActivity(
            context: context,
            tittle: "Actualizacion de los Valores",
            message: 'Los registros fueron Actualizados',
            onClose: () {
              Navigator.pop(context);
              _reiniciar().then((value) {
                setState(() {
                  carouselController.jumpToPage(0);
                });
              });
            },
            onAcept: () {
              Navigator.pop(context);
              _reiniciar().then((value) {
                setState(() {
                  carouselController.jumpToPage(0);
                });
              });
            });
        _reiniciar().then((value) {
          setState(() {
            carouselController.jumpToPage(0);
          });
        });
      }).onError((error, stackTrace) {
        Terminal.printWarning(message: "ERROR - $error");
      });
    }
  }

  //
  Future<void> _reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");
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
  }

  void _runFilterSearch(String enteredKeyword) {
    List? results = [];

    if (enteredKeyword.isEmpty) {
     _reiniciar();
    } else {
      results = Listas.listFromMap(
          lista: values!,
          keySearched: 'Pace_GAB_RA_Feca',
          elementSearched: enteredKeyword);

      setState(() {
        values = results;
      });
    }
  }

}
