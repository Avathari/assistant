import 'dart:convert';
import 'dart:math';
import 'package:image_picker/image_picker.dart';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/electrocardiogramas.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/ValuePanel.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:photo_view/photo_view.dart';

class ElectrocardiogramasGestion extends StatefulWidget {
  const ElectrocardiogramasGestion({super.key});

  @override
  State<ElectrocardiogramasGestion> createState() =>
      _ElectrocardiogramasGestionState();
}

class _ElectrocardiogramasGestionState
    extends State<ElectrocardiogramasGestion> {
  // ############################ ####### ####### #############################
  var fileAssocieted =
      '${Pacientes.localRepositoryPath}/electrocardiogramas.json';

  @override
  void initState() {
    Future.microtask(() async {
      Terminal.printWarning(
          message:
              " . . . Iniciando Actividad - Repositorio Electrocardiogramas del Pacientes");
      Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
        setState(() {
          Pacientes.Electros = value;
          //
          values = value;
          // Terminal.printData(message: values.toString());
          Terminal.printSuccess(
              message:
                  'Repositorio Electrocardiogramas del Pacientes Obtenido');
        });
      }).onError((error, stackTrace) {
        textDateEstudyController.text =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
        //
        _reiniciar();
        toBaseImage();
      });
      Terminal.printOther(message: " . . . Actividad Iniciada");
    });

    super.initState();
  }

  // ******************************************************
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => VisualPacientes(actualPage: 5))));
          },
        ),
        backgroundColor: Theming.primaryColor,
        title: AppBarText(tittle),
        actions: <Widget>[
          GrandIcon(
            iconData: Icons.replay_outlined,
            labelButton: Sentences.reload,
            onPress: () {
              _reiniciar();
            },
          ),
          CrossLine(isHorizontal: false, height: 10),
          // GrandIcon(
          //   iconData: Icons.dataset_linked_outlined,
          //   labelButton: "Registro de electrocardiogramas",
          //   onPress: () {
          //     carouselController.jumpToPage(0);
          //   },
          // ),
          // GrandIcon(
          //   iconData: Icons.browser_updated,
          //   labelButton: "Gestion del Registro",
          //   onPress: () {
          //     carouselController.jumpToPage(1);
          //   },
          // ),
          if (isMobile(context))
            GrandIcon(
              iconData: Icons.candlestick_chart,
              labelButton: 'Análisis de Parámetros',
              onPress: () {
                _key.currentState!.openEndDrawer();
                // Operadores.openDialog(
                //     context: context,
                //     chyldrim: AnalisisElectrocardiograma(
                //         operationActivity: operationActivity));
              },
            ),
          const SizedBox(width: 22),
          // GrandIcon(
          //   iconData: Icons.photo_camera_back_outlined,
          //   labelButton: 'Imagen del Electrocardiograma',
          //   onPress: () {
          //     Operadores.optionsActivity(
          //       context: context,
          //       tittle: 'Cargar imagen del Electrocardiograma',
          //       onClose: () {
          //         Navigator.of(context).pop();
          //       },
          //       textOptionA: 'Cargar desde Dispositivo',
          //       optionA: () async {
          //         var bytes = await Directorios.choiseFromDirectory();
          //         setState(() {
          //           stringImage = base64Encode(bytes);
          //           Navigator.of(context).pop();
          //         });
          //       },
          //       textOptionB: 'Cargar desde Cámara',
          //       optionB: () async {
          //         var bytes = await Directorios.choiseFromCamara();
          //         setState(() {
          //           stringImage = base64Encode(bytes);
          //           Navigator.of(context).pop();
          //         });
          //       },
          //     );
          //   },
          // ),
        ],
      ),
      endDrawer: drawerForm(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (!isMobile(context))
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(5),
                  decoration: ContainerDecoration.roundedDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: GrandButton(
                            weigth: 100,
                            labelButton: "Registro de electrocardiogramas",
                            onPress: () {
                              carouselController.jumpToPage(0);
                            }),
                      ),
                      Expanded(
                        child: GrandButton(
                            weigth: 100,
                            labelButton: "Gestion del Registro",
                            onPress: () {
                              carouselController.jumpToPage(2);
                            }),
                      ),
                      Expanded(
                        child: GrandButton(
                            weigth: 100,
                            labelButton: "Imagen del Registro",
                            onPress: () {
                              carouselController.jumpToPage(1);
                            }),
                      ),
                    ],
                  ),
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
                                mask: '####/##/## ##:##:##',
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
                          child: values == null
                              ? const Center(child: CircularProgressIndicator())
                              : RefreshIndicator(
                            color: Colors.white,
                            backgroundColor: Colors.black,
                            onRefresh: _reiniciar,
                            child: FutureBuilder<List>(
                              initialData: values,
                              future: Future.value(values),
                              builder: (context, AsyncSnapshot snapshot) {
                                print('Snapshot state: ${snapshot.connectionState}');
                                print('Has data: ${snapshot.hasData}');
                                print('Data: ${snapshot.data}');

                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  print('Error: ${snapshot.error}');
                                  return const Center(child: Text('Error al cargar.'));
                                } else if (!snapshot.hasData || snapshot.data == null) {
                                  return const Center(child: Text('Sin datos.'));
                                }

                                final List data = snapshot.data;

                                // ⛔ Aquí validamos si el único elemento es un mapa con error
                                if (data.length == 1 && data[0] is Map && data[0].containsKey('Error')) {
                                  return Center(child: Text(data[0]['Error']));
                                }

                                // ✅ Construir el GridView si todo está bien
                                return GridView.builder(
                                  padding: const EdgeInsets.all(8.0),
                                  gridDelegate: GridViewTools.gridDelegate(
                                    crossAxisCount: isMobile(context) ? 1 : 3,
                                    mainAxisExtent: isMobile(context) ? 150 : 170,
                                  ),
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  itemBuilder: (context, posicion) {
                                    return itemSelected(
                                      context: context,
                                      data: data,
                                      index: posicion,
                                    );
                                  },
                                );
                              },

                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PhotoView(
                              imageProvider:
                                  MemoryImage(base64Decode(stringImage!)),
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
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: GrandIcon(
                                  labelButton: "Foto desde Cámara . . . ",
                                  iconData: Icons.camera,
                                  onPress: () async {
                                    final x = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);

                                    stringImage = x != null
                                        ? base64Encode(await x
                                            .readAsBytes()
                                            .whenComplete(() {
                                            setState(() {});
                                          }))
                                        : base64Encode((await rootBundle.load(
                                                'assets/images/person.png'))
                                            .buffer
                                            .asUint8List());
                                  },
                                ),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: GrandButton(
                                    labelButton: "Foto desde Directorio . . . ",
                                    weigth: 2000,
                                    onPress: () async {
                                      final x = await ImagePicker().pickImage(
                                          source: ImageSource.gallery);

                                      stringImage = x != null
                                          ? base64Encode(await x
                                              .readAsBytes()
                                              .whenComplete(() {
                                              setState(() {});
                                            }))
                                          : base64Encode((await rootBundle.load(
                                                  'assets/images/person.png'))
                                              .buffer
                                              .asUint8List());
                                    },
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    operationScreen(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: isMobile(context)
          ? BottomAppBar(
              color: Colors.black,
              shape: const CircularNotchedRectangle(),
              notchMargin: 10,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GrandIcon(
                      iconData: operationActivity
                          ? Icons.move_up
                          : Icons.delete_sweep_rounded,
                      labelButton: operationActivity ? "Nuevo" : "Eliminar",
                      onPress: () {
                        if (operationActivity) {
                          initAllElement();
                          carouselController.jumpToPage(2);
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
                      : GrandIcon(
                          iconData: Icons.add,
                          labelButton: "Nuevo",
                          onPress: () {
                            initAllElement();
                            carouselController.jumpToPage(2);
                          }),
                  GrandIcon(
                      labelButton: operationActivity ? "Agregar" : "Actualizar",
                      iconData: operationActivity
                          ? Icons.add_circle_outline
                          : Icons.update,
                      onPress: () {
                        operationMethod(
                            context: context,
                            operationActivity: operationActivity);
                      }),
                  const SizedBox(width: 25),
                ],
              ),
            )
          : null,
      floatingActionButton: isMobile(context)
          ? FloatingActionButton(
              heroTag: UniqueKey(),
              backgroundColor: Colors.black,
              onPressed: () => Datos.portapapeles(
                  context: context, text: Electrocardiogramas.historial()),
              shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 4, color: Colors.grey),
                  borderRadius: BorderRadius.circular(100)),
              child: const Icon(
                Icons.monitor_heart_outlined,
                color: Colors.grey,
              ),
            )
          : FloatingActionButton(
              heroTag: UniqueKey(),
              backgroundColor: Colors.black,
              onPressed: () => Datos.portapapeles(
                  context: context, text: Electrocardiogramas.historial()),
              shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 4, color: Colors.grey),
                  borderRadius: BorderRadius.circular(100)),
              child: const Icon(
                Icons.featured_play_list_outlined,
                color: Colors.grey,
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Future<void> _reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");
    Actividades.consultarAllById(
            Databases.siteground_database_reggabo,
            Electrocardiogramas.electrocardiogramas['consultByIdPrimaryQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      setState(() {
        Pacientes.Electros = value;
        //
        Archivos.createJsonFromMap(value, filePath: fileAssocieted);
        values = value;
      });
    });
  }

  void deleteDialog(Map<String, dynamic> element) {
    Operadores.alertActivity(
        context: context,
        tittle: "Eliminación de Registros",
        message: "Registro eliminado",
        onAcept: () {
          Actividades.eliminar(
                  Databases.siteground_database_reggabo,
                  Electrocardiogramas.electrocardiogramas['deleteQuery'],
                  element[idWidget])
              .then((value) {
            Archivos.deleteFile(filePath: fileAssocieted).then((value) {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ElectrocardiogramasGestion()));
            });
          }).onError((error, stackTrace) {
            Terminal.printAlert(message: "ERROR - Hubo un error : $error");
          });
        });
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
      paceQrsTextController.text = "0.0";
      //
      segmentoSTValue = Electrocardiogramas.ast[1];
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

      toBaseImage();
    });
  }

  void updateElement(Map<String, dynamic> element) {
    setState(() {
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
      segmentoSTValue = element['Pace_EC_st'];
      stTextController.text = element['Pace_EC_ast_'].toString();
      //
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
      //
      stringImage = element['Pace_GAB_IMG'];
      conclusionTextController.text = element['Pace_EC_CON'];
    });
  }

  Widget itemSelected(
      {required BuildContext context, required data, required int index}) {
    return GestureDetector(
      onTap: () {
        operationActivity = false;
        // ***************** ************* *****
        elementSelected = Pacientes.Electrocardiogramas = data[index];
        //
        Electrocardiogramas.fromJson(elementSelected!);
        // ***************** ************* *****
        carouselController.jumpToPage(1);
        // ***************** ************* *****
        updateElement(data[index]);
      },
      onDoubleTap: () {
        Electrocardiogramas.fromJson(data[index]);
        //
        Datos.portapapeles(
            context: context, text: Auxiliares.electrocardiogramaAbreviado());
      },
      onLongPress: () {},
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
                      base64Decode(data[index]['Pace_GAB_IMG']),
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
                    data[index]['Pace_GAB_EC_Feca'],
                    style: Styles.textSyleGrowth(fontSize: 14),
                  ),
                  Text(
                    data[index]['Pace_EC_rit'],
                    style: Styles.textSyleGrowth(fontSize: 12),
                  ),
                  // Text(
                  //   data[index]['Pace_EC_CON'],
                  //   maxLines: 3,
                  //   overflow: TextOverflow.ellipsis,
                  //   style: Styles.textSyleGrowth(fontSize: 10),
                  // ),
                  CrossLine(
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GrandIcon(
                          iconData: Icons.update,
                          labelButton: 'Actualizar',
                          onPress: () {
                            operationActivity = false;
                            //
                            elementSelected =
                                Pacientes.Electrocardiogramas = data[index];
                            //
                            Electrocardiogramas.fromJson(
                                Pacientes.Electrocardiogramas);
                            //
                            updateElement(data[index]);
                            //
                            carouselController.jumpToPage(1);
                          }),
                      const SizedBox(width: 30),
                      GrandIcon(
                          iconData: Icons.delete,
                          labelButton: 'Eliminar',
                          onPress: () {
                            deleteDialog(data[index]);
                          }),
                      const SizedBox(width: 10),
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
          children: [
            EditTextArea(
              keyBoardType: TextInputType.datetime,
              inputFormat: MaskTextInputFormatter(
                  mask: '####/##/## ##:##:##',
                  filter: {"#": RegExp(r'[0-9]')},
                  type: MaskAutoCompletionType.lazy),
              numOfLines: 1,
              labelEditText: "Fecha de realización",
              textController: textDateEstudyController,
              withShowOption: true,
              selection: true,
              iconData: Icons.calendar_month,
              onSelected: () {
                textDateEstudyController.text =
                    Calendarios.today(format: 'yyyy/MM/dd HH:mm:ss');
              },
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Spinner(
                      width: isMobile(context) ? 150 : 150,
                      isRow: true,
                      tittle: "Ritmo cardiaco",
                      initialValue: ritmoCardiacoValue!,
                      items: Electrocardiogramas.ritmos,
                      onChangeValue: (String? newValue) {
                        setState(() {
                          ritmoCardiacoValue = newValue!;
                          Valores.ritmoCardiaco = newValue;
                        });
                      }),
                ),
                Expanded(
                  flex: 2,
                  child: Spinner(
                      width: isMobile(context) || isTablet(context) ? 170 : 110,
                      isRow: true,
                      tittle: "Segmento ST",
                      initialValue: segmentoSTValue!,
                      items: Electrocardiogramas.ast,
                      onChangeValue: (String? newValue) {
                        setState(() {
                          segmentoSTValue = newValue!;
                          Valores.segmentoST = newValue;
                        });
                      }),
                ),
              ],
            ),
            Spinner(
                width: 100,
                isRow: true,
                tittle: "Patrón QRS en DII",
                initialValue: patronQRSValue!,
                items: Electrocardiogramas.patronQRS,
                onChangeValue: (String? newValue) {
                  setState(() {
                    patronQRSValue = newValue!;
                  });
                }),
            CrossLine(),
            EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              numOfLines: 1,
              labelEditText: "Intervalo RR",
              textController: intervaloRRTextController,
              onChange: (value) {
                setState(() {
                  Valores.intervaloRR = int.parse(value);
                });
              },
            ),
            Row(
              children: [
                Expanded(
                  child: EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    numOfLines: 1,
                    labelEditText: "Duración de la Onda P",
                    textController: dopTextController,
                    onChange: (value) {
                      setState(() {
                        Valores.duracionOndaP = double.parse(value);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    numOfLines: 1,
                    labelEditText: "Altura de la Onda P",
                    textController: aopTextController,
                    onChange: (value) {
                      setState(() {
                        Valores.alturaOndaP = double.parse(value);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: "Duración del Intervalo PR",
                    textController: dprTextController,
                    numOfLines: 1,
                    onChange: (value) {
                      setState(() {
                        Valores.duracionPR = double.parse(value);
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    numOfLines: 1,
                    labelEditText: "Duración del QRS",
                    textController: dqrsTextController,
                    onChange: (value) {
                      setState(() {
                        Valores.duracionQRS = double.parse(value);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    numOfLines: 1,
                    labelEditText: "Altura del QRS",
                    textController: aqrsTextController,
                    onChange: (value) {
                      setState(() {
                        Valores.alturaQRS = double.parse(value);
                      });
                    },
                  ),
                ),
              ],
            ),
            CrossLine(),
            Row(
              children: [
                Expanded(
                  child: EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    numOfLines: 1,
                    labelEditText: "QRS en DI",
                    textController: qrsiTextController,
                    onChange: ((value) {
                      paceQrsTextController.text = tan(
                              int.parse(qrsaTextController.text) /
                                  int.parse(qrsiTextController.text))
                          .toStringAsFixed(1);
                      setState(() {
                        Valores.ejeCardiaco =
                            double.parse(paceQrsTextController.text);
                      });
                    }),
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    numOfLines: 1,
                    labelEditText: "QRS en aVF",
                    textController: qrsaTextController,
                    onChange: (value) {
                      paceQrsTextController.text = atan(
                              int.parse(qrsaTextController.text) /
                                  int.parse(qrsiTextController.text))
                          .toStringAsFixed(1);
                      setState(() {
                        Valores.ejeCardiaco =
                            double.parse(paceQrsTextController.text);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    numOfLines: 1,
                    prefixIcon: true,
                    labelEditText: "Eje Cardiaco",
                    textController: paceQrsTextController,
                  ),
                ),
              ],
            ),
            CrossLine(),
            EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: "Altura del ST",
              textController: stTextController,
              numOfLines: 1,
              onChange: (value) {
                setState(() {
                  Valores.alturaSegmentoST = double.parse(value);
                });
              },
            ),
            Row(
              children: [
                Expanded(
                  child: EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: "Duración de QT",
                    textController: dqtTextController,
                    numOfLines: 1,
                    onChange: (value) {
                      setState(() {
                        Valores.duracionQT = double.parse(value);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: "Duración Onda T",
                    textController: dotTextController,
                    numOfLines: 1,
                    onChange: (value) {
                      setState(() {
                        Valores.duracionOndaT = double.parse(value);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: "Altura Onda T",
                    textController: aotTextController,
                    numOfLines: 1,
                    onChange: (value) {
                      setState(() {
                        Valores.alturaOndaT = double.parse(value);
                      });
                    },
                  ),
                ),
              ],
            ),
            CrossLine(),
            //
            Row(
              children: [
                Expanded(
                  child: EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: "Onda R en V1",
                    textController: rv1TextController,
                    numOfLines: 1,
                    onChange: (value) {
                      setState(() {
                        Valores.rV1 = int.parse(value);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: "Onda S en V1",
                    textController: sv1TextController,
                    numOfLines: 1,
                    onChange: (value) {
                      setState(() {
                        Valores.sV1 = int.parse(value);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: "Onda R en V6",
                    textController: rv6TextController,
                    numOfLines: 1,
                    onChange: (value) {
                      setState(() {
                        Valores.rV6 = int.parse(value);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: "Onda S en V6",
                    textController: sv6TextController,
                    numOfLines: 1,
                    onChange: (value) {
                      setState(() {
                        Valores.sV6 = int.parse(value);
                      });
                    },
                  ),
                ),
              ],
            ),
            EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: "Onda R en aVL",
              textController: ravlTextController,
              numOfLines: 1,
              onChange: (value) {
                setState(() {
                  Valores.rAvL = int.parse(value);
                });
              },
            ),
            EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: "Onda S en V3",
              textController: sv3TextController,
              numOfLines: 1,
              onChange: (value) {
                setState(() {
                  Valores.sV3 = int.parse(value);
                });
              },
            ),
            //
            EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: "Deflexión Intrinsecoide",
              textController: deflexTextController,
              numOfLines: 1,
              onChange: (value) {
                setState(() {
                  Valores.deflexionIntrinsecoide = double.parse(value);
                });
              },
            ),
            //
            Row(
              children: [
                Expanded(
                  child: EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: "Onda R en DI",
                    textController: rdiTextController,
                    numOfLines: 1,
                    onChange: (value) {
                      setState(() {
                        Valores.rDI = double.parse(value);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: "Onda S en DI",
                    textController: sdiTextController,
                    numOfLines: 1,
                    onChange: (value) {
                      setState(() {
                        Valores.sDI = double.parse(value);
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: "Onda R en DIII",
                    textController: rdiiiTextController,
                    numOfLines: 1,
                    onChange: (value) {
                      setState(() {
                        Valores.rDIII = double.parse(value);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: "Onda S en DIII",
                    textController: sdiiiTextController,
                    numOfLines: 1,
                    onChange: (value) {
                      setState(() {
                        Valores.sDIII = double.parse(value);
                      });
                    },
                  ),
                ),
              ],
            ),
            CrossLine(),
            EditTextArea(
                keyBoardType: TextInputType.multiline,
                inputFormat: MaskTextInputFormatter(),
                numOfLines: 7,
                labelEditText: "Conclusiones",
                textController: conclusionTextController,
                prefixIcon: false),
            // Expanded(
            //   flex: 2,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Expanded(
            //         child: GrandButton(
            //             weigth: isMobile(context) ? 30 : 100,
            //             labelButton: operationActivity ? "Nuevo" : "Eliminar",
            //             onPress: () {
            //               if (operationActivity) {
            //                 initAllElement();
            //                 carouselController.jumpToPage(1);
            //               } else {
            //                 try {
            //                   deleteDialog(elementSelected!);
            //                 } finally {
            //                   carouselController.jumpToPage(0);
            //                   showDialog(
            //                       context: context,
            //                       builder: (context) {
            //                         return AlertDialog(
            //                           title: const Text("Eliminados"),
            //                           content: Text(listOfValues().toString()),
            //                         );
            //                       });
            //                 }
            //               }
            //             }),
            //       ),
            //       operationActivity
            //           ? Container()
            //           : Expanded(
            //               child: GrandButton(
            //                   labelButton: "Nuevo",
            //                   weigth: isMobile(context) ? 20 : 100,
            //                   onPress: () {
            //                     initAllElement();
            //                   }),
            //             ),
            //       Expanded(
            //         child: GrandButton(
            //             weigth: isMobile(context) || isTablet(context) ? 30 : 100,
            //             labelButton: operationActivity ? "Agregar" : "Actualizar",
            //             onPress: () {
            //               operationMethod(
            //                   context: context,
            //                   operationActivity: operationActivity);
            //             }),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      );
    } else {
      return Row(
        children: [
          Expanded(
            flex: 6,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                flex: 2,
                child: EditTextArea(
                  keyBoardType: TextInputType.datetime,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/## ##:##:##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  numOfLines: 1,
                  labelEditText: "Fecha de realización",
                  textController: textDateEstudyController,
                  withShowOption: true,
                  selection: true,
                  iconData: Icons.calendar_month,
                  onSelected: () {
                    textDateEstudyController.text =
                        Calendarios.today(format: 'yyyy/MM/dd HH:mm:ss');
                  },
                ),
              ),
              CrossLine(),
              Expanded(
                flex: 10,
                child: Container(
                  padding: const EdgeInsets.all(6.0),
                  margin: const EdgeInsets.only(top: 4.0, bottom: 5.0),
                  decoration: ContainerDecoration.roundedDecoration(),
                  child: GridView(
                    controller: ScrollController(),
                    gridDelegate: GridViewTools.gridDelegate(
                        crossAxisCount: 4,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                        mainAxisExtent: 55),
                    children: [
                      Spinner(
                          width: isMobile(context) ? 150 : 100,
                          isRow: false,
                          tittle: "Ritmo cardiaco",
                          initialValue: ritmoCardiacoValue!,
                          items: Electrocardiogramas.ritmos,
                          onChangeValue: (String? newValue) {
                            setState(() {
                              ritmoCardiacoValue = newValue!;
                              Valores.ritmoCardiaco = newValue;
                            });
                          }),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: "Intervalo RR",
                        textController: intervaloRRTextController,
                        numOfLines: 1,
                        onChange: (value) {
                          setState(() {
                            Valores.intervaloRR = int.parse(value);
                          });
                        },
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        numOfLines: 1,
                        labelEditText: "Duración de la Onda P",
                        textController: dopTextController,
                        onChange: (value) {
                          setState(() {
                            Valores.duracionOndaP = double.parse(value);
                          });
                        },
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        numOfLines: 1,
                        labelEditText: "Altura de la Onda P",
                        textController: aopTextController,
                        onChange: (value) {
                          setState(() {
                            Valores.alturaOndaP = double.parse(value);
                          });
                        },
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: "Duración del Intervalo PR",
                        textController: dprTextController,
                        numOfLines: 1,
                        onChange: (value) {
                          setState(() {
                            Valores.duracionPR = double.parse(value);
                          });
                        },
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: "Duración del QRS",
                        textController: dqrsTextController,
                        numOfLines: 1,
                        onChange: (value) {
                          setState(() {
                            Valores.duracionQRS = double.parse(value);
                          });
                        },
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: "Altura del QRS",
                        textController: aqrsTextController,
                        numOfLines: 1,
                        onChange: (value) {
                          setState(() {
                            Valores.alturaQRS = double.parse(value);
                          });
                        },
                      ),
                      CrossLine(),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        numOfLines: 1,
                        labelEditText: "QRS en DI",
                        textController: qrsiTextController,
                        prefixIcon: false,
                        onChange: ((value) {
                          paceQrsTextController.text = tan(
                                  int.parse(qrsaTextController.text) /
                                      int.parse(qrsiTextController.text))
                              .toStringAsFixed(1);
                          setState(() {
                            Valores.ejeCardiaco =
                                double.parse(paceQrsTextController.text);
                          });
                        }),
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        numOfLines: 1,
                        labelEditText: "QRS en aVF",
                        textController: qrsaTextController,
                        prefixIcon: false,
                        onChange: (value) {
                          paceQrsTextController.text = atan(
                                  int.parse(qrsaTextController.text) /
                                      int.parse(qrsiTextController.text))
                              .toStringAsFixed(1);
                          setState(() {
                            Valores.ejeCardiaco =
                                double.parse(paceQrsTextController.text);
                          });
                        },
                      ),
                      ValuePanel(
                        firstText: "Eje Cardiaco",
                        secondText: Valores.ejeCardiaco!.toStringAsFixed(2),
                      ),
                      CrossLine(),
                      //
                      Spinner(
                          width: isMobile(context) || isTablet(context)
                              ? 170
                              : 110,
                          isRow: false,
                          tittle: "Segmento ST",
                          initialValue: segmentoSTValue!,
                          items: Electrocardiogramas.ast,
                          onChangeValue: (String? newValue) {
                            setState(() {
                              segmentoSTValue = newValue!;
                              Valores.segmentoST = newValue;
                            });
                          }),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: "Altura del ST",
                        textController: stTextController,
                        numOfLines: 1,
                        onChange: (value) {
                          setState(() {
                            Valores.alturaSegmentoST = double.parse(value);
                          });
                        },
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: "Duración de QT",
                        textController: dqtTextController,
                        numOfLines: 1,
                        onChange: (value) {
                          setState(() {
                            Valores.duracionQT = double.parse(value);
                          });
                        },
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: "Duración Onda T",
                        textController: dotTextController,
                        numOfLines: 1,
                        onChange: (value) {
                          setState(() {
                            Valores.duracionOndaT = double.parse(value);
                          });
                        },
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: "Altura Onda T",
                        textController: aotTextController,
                        numOfLines: 1,
                        onChange: (value) {
                          setState(() {
                            Valores.alturaOndaT = double.parse(value);
                          });
                        },
                      ),
                      CrossLine(),
                      //
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: "Onda R en V1",
                        textController: rv1TextController,
                        numOfLines: 1,
                        onChange: (value) {
                          setState(() {
                            Valores.rV1 = int.parse(value);
                          });
                        },
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: "Onda S en V1",
                        textController: sv1TextController,
                        numOfLines: 1,
                        onChange: (value) {
                          setState(() {
                            Valores.sV1 = int.parse(value);
                          });
                        },
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: "Onda R en V6",
                        textController: rv6TextController,
                        numOfLines: 1,
                        onChange: (value) {
                          setState(() {
                            Valores.rV6 = int.parse(value);
                          });
                        },
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: "Onda S en V6",
                        textController: sv6TextController,
                        numOfLines: 1,
                        onChange: (value) {
                          setState(() {
                            Valores.sV6 = int.parse(value);
                          });
                        },
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: "Onda R en aVL",
                        textController: ravlTextController,
                        numOfLines: 1,
                        onChange: (value) {
                          setState(() {
                            Valores.rAvL = int.parse(value);
                          });
                        },
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: "Onda S en V3",
                        textController: sv3TextController,
                        numOfLines: 1,
                        onChange: (value) {
                          setState(() {
                            Valores.sV3 = int.parse(value);
                          });
                        },
                      ),
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
                        labelEditText: "Deflexión Intrinsecoide",
                        textController: deflexTextController,
                        numOfLines: 1,
                        onChange: (value) {
                          setState(() {
                            Valores.deflexionIntrinsecoide =
                                double.parse(value);
                          });
                        },
                      ),
                      //
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: "Onda R en DI",
                        textController: rdiTextController,
                        numOfLines: 1,
                        onChange: (value) {
                          setState(() {
                            Valores.rDI = double.parse(value);
                          });
                        },
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: "Onda S en DI",
                        textController: sdiTextController,
                        numOfLines: 1,
                        onChange: (value) {
                          setState(() {
                            Valores.sDI = double.parse(value);
                          });
                        },
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: "Onda R en DIII",
                        textController: rdiiiTextController,
                        numOfLines: 1,
                        onChange: (value) {
                          setState(() {
                            Valores.rDIII = double.parse(value);
                          });
                        },
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText: "Onda S en DIII",
                        textController: sdiiiTextController,
                        numOfLines: 1,
                        onChange: (value) {
                          setState(() {
                            Valores.sDIII = double.parse(value);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: EditTextArea(
                            keyBoardType: TextInputType.multiline,
                            inputFormat: MaskTextInputFormatter(),
                            numOfLines: 8,
                            labelEditText: "Conclusiones",
                            textController: conclusionTextController,
                            prefixIcon: false),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: GrandButton(
                                  weigth: isMobile(context) ? 30 : 100,
                                  labelButton:
                                      operationActivity ? "Nuevo" : "Eliminar",
                                  fontSize: 8,
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
                                                content: Text(
                                                    listOfValues().toString()),
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
                                        fontSize: 8,
                                        weigth: isMobile(context) ? 20 : 100,
                                        onPress: () {
                                          initAllElement();
                                        }),
                                  ),
                            Expanded(
                              child: GrandButton(
                                  weigth: isMobile(context) || isTablet(context)
                                      ? 30
                                      : 100,
                                  labelButton: operationActivity
                                      ? "Agregar"
                                      : "Actualizar",
                                  fontSize: 8,
                                  onPress: () {
                                    operationMethod(
                                        context: context,
                                        operationActivity: operationActivity);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 6,
                    child: AnalisisElectrocardiograma(
                      operationActivity: true,
                    )),
              ],
            ),
          )
        ],
      );
    }
  }

  // VARIABLES DE LA INTERFAZ ****** ************ ************
  String? stringImage = '';
  //
  late List? values = [];
  Map<String, dynamic>? elementSelected;
  //
  bool operationActivity = true; // Si true entonces REGISTER.register.
  String tittle = "Electrocardiogramas . . . ";
  String idWidget = 'ID_Pace_GAB_EC';

  // Variables de Ejecución // ############################ ####### ####### #############################
  var carouselController = CarouselSliderController();
  var textDateController =
      TextEditingController(); // TextController for search.
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
  //
  String? segmentoSTValue = Electrocardiogramas.ast[0];
  var stTextController = TextEditingController();
  //
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

  List<Widget> listOfComponents() {
    return [
      Spinner(
          width: isMobile(context) ? 150 : 100,
          isRow: false,
          tittle: "Ritmo cardiaco",
          initialValue: ritmoCardiacoValue!,
          items: Electrocardiogramas.ritmos,
          onChangeValue: (String? newValue) {
            setState(() {
              ritmoCardiacoValue = newValue!;
              Valores.ritmoCardiaco = newValue;
            });
          }),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Intervalo RR",
        textController: intervaloRRTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.intervaloRR = int.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Duración de la Onda P",
        textController: dopTextController,
        onChange: (value) {
          setState(() {
            Valores.duracionOndaP = double.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Altura de la Onda P",
        textController: aopTextController,
        onChange: (value) {
          setState(() {
            Valores.alturaOndaP = double.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Duración del Intervalo PR",
        textController: dprTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.duracionPR = double.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Duración del QRS",
        textController: dqrsTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.duracionQRS = double.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Altura del QRS",
        textController: aqrsTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.alturaQRS = double.parse(value);
          });
        },
      ),
      CrossLine(),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        numOfLines: 1,
        labelEditText: "QRS en DI",
        textController: qrsiTextController,
        prefixIcon: false,
        onChange: ((value) {
          paceQrsTextController.text = tan(int.parse(qrsaTextController.text) /
                  int.parse(qrsiTextController.text))
              .toStringAsFixed(1);
          setState(() {
            Valores.ejeCardiaco = double.parse(paceQrsTextController.text);
          });
        }),
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        numOfLines: 1,
        labelEditText: "QRS en aVF",
        textController: qrsaTextController,
        prefixIcon: false,
        onChange: (value) {
          paceQrsTextController.text = atan(int.parse(qrsaTextController.text) /
                  int.parse(qrsiTextController.text))
              .toStringAsFixed(1);
          setState(() {
            Valores.ejeCardiaco = double.parse(paceQrsTextController.text);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        numOfLines: 1,
        labelEditText: "Eje Cardiaco",
        textController: paceQrsTextController,
      ),
      CrossLine(),
      //
      Spinner(
          width: isMobile(context) || isTablet(context) ? 170 : 110,
          isRow: false,
          tittle: "Segmento ST",
          initialValue: segmentoSTValue!,
          items: Electrocardiogramas.ast,
          onChangeValue: (String? newValue) {
            setState(() {
              segmentoSTValue = newValue!;
              Valores.segmentoST = newValue;
            });
          }),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Altura del ST",
        textController: stTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.alturaSegmentoST = double.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Duración de QT",
        textController: dqtTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.duracionQT = double.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Duración Onda T",
        textController: dotTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.duracionOndaT = double.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Altura Onda T",
        textController: aotTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.alturaOndaT = double.parse(value);
          });
        },
      ),
      CrossLine(),
      //
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Onda R en V1",
        textController: rv1TextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.rV1 = int.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Onda S en V1",
        textController: sv1TextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.sV1 = int.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Onda R en V6",
        textController: rv6TextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.rV6 = int.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Onda S en V6",
        textController: sv6TextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.sV6 = int.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Onda R en aVL",
        textController: ravlTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.rAvL = int.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Onda S en V3",
        textController: sv3TextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.sV3 = int.parse(value);
          });
        },
      ),
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
        labelEditText: "Deflexión Intrinsecoide",
        textController: deflexTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.deflexionIntrinsecoide = double.parse(value);
          });
        },
      ),
      //
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Onda R en DI",
        textController: rdiTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.rDI = double.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Onda S en DI",
        textController: sdiTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.sDI = double.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Onda R en DIII",
        textController: rdiiiTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.rDIII = double.parse(value);
          });
        },
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Onda S en DIII",
        textController: sdiiiTextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.sDIII = double.parse(value);
          });
        },
      ),
    ];
  }

  List<String> listOfValues() {
    return [
      idOperacion!.toString(),
      Pacientes.ID_Paciente.toString(),
      textDateEstudyController.text,
      //
      ritmoCardiacoValue!,
      intervaloRRTextController.text,
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
      stTextController.text,
      segmentoSTValue!,
      //
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
      //
      conclusionTextController.text,
      stringImage!,
      tipoEstudio,
      //
      idOperacion!.toString(),
    ];
  }

  Future<void> toBaseImage() async {
    setState(() async => stringImage = base64Encode(
        (await rootBundle.load('assets/images/person.png'))
            .buffer
            .asUint8List()));
  }

  void operationMethod(
      {required BuildContext context, required bool operationActivity}) {
    if (operationActivity) {
      var aux = listOfValues();
      aux.removeAt(0);
      aux.removeLast();
      Terminal.printExpected(
          message: "operationActivity $operationActivity ${aux.length}");
      Actividades.registrar(
        Databases.siteground_database_reggabo,
        Electrocardiogramas.electrocardiogramas['registerQuery'],
        aux,
      ).then((value) {
        // Terminal.printExpected(message: "registerActivity $value");
        Operadores.alertActivity(
            context: context,
            tittle: "Registro de los Valores",
            message: 'Los registros fueron agregados',
            onAcept: () => Navigator.of(context).pop());
        _reiniciar().then((value) {
          setState(() {
            carouselController.jumpToPage(0);
          });
        });
      }).onError((error, stackTrace) {
        Terminal.printWarning(message: "ERROR - $error");
      });
    } else {
      Actividades.actualizar(
              Databases.siteground_database_reggabo,
              Electrocardiogramas.electrocardiogramas['updateQuery'],
              listOfValues(),
              idOperacion!)
          .then((value) {
        Operadores.alertActivity(
            context: context,
            tittle: "Actualizacion de los Valores",
            message: 'Los registros fueron Actualizados',
            onAcept: () => Navigator.of(context).pop());
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

  drawerForm(BuildContext context, {bool? analysis = false}) => Drawer(
        width: isMobile(context) ? 250 : 350,
        backgroundColor: Theming.cuaternaryColor,
        child: Container(
            decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(color: Colors.grey),
                  bottom: BorderSide(color: Colors.grey),
                  left: BorderSide(color: Colors.grey)),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  topLeft: Radius.circular(16)),
            ),
            child: AnalisisElectrocardiograma(
              operationActivity: operationActivity,
            )),
      );
}
