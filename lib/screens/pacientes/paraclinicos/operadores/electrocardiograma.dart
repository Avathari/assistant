import 'dart:convert';
import 'dart:math';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/screens/pacientes/paraclinicos/paraclinicos.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/GridLayout.dart';
import 'package:assistant/widgets/ScrollableWidget.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/ThreeLabelText.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/WidgetsModels.dart';

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
    Terminal.printWarning(
        message:
            " . . . Iniciando Actividad - Repositorio Electrocardiogramas del Pacientes");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        values = value;
        // Terminal.printData(message: values.toString());
        Terminal.printSuccess(
            message: 'Repositorio Electrocardiogramas del Pacientes Obtenido');
      });
    }).onError((error, stackTrace) {
      final f = DateFormat('yyyy-MM-dd');
      textDateEstudyController.text = f.format(DateTime.now());

      reiniciar();
      toBaseImage();
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) => VisualPacientes(actualPage: 5))));
          },
        ),
        backgroundColor: Theming.primaryColor,
        title: Text(
          tittle,
          style: Styles.textSyleGrowth(fontSize: 14),
        ),
        actions: <Widget>[
          GrandIcon(
            iconData: Icons.replay_outlined,
            labelButton: Sentences.reload,
            onPress: () {
              reiniciar();
            },
          ),
          GrandIcon(
            iconData: Icons.dataset_linked_outlined,
            labelButton: "Registro de electrocardiogramas",
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
            iconData: Icons.candlestick_chart,
            labelButton: 'Análisis de Parámetros',
            onPress: () {
              Operadores.openDialog(
                  context: context,
                  chyldrim: AnalisisElectrocardiograma(
                      operationActivity: operationActivity));
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
                          flex: isMobile(context) ? 2 : 1,
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
                                            GridViewTools.gridDelegate(
                                                  crossAxisCount: isMobile(context) ? 1 : 2,
                                                  mainAxisExtent: isMobile(context) ? 170 : 150,
                                                  crossAxisSpacing: 4.0,
                                                  mainAxisSpacing: 4.0,
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

  Future<void> reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");
    Actividades.consultarAllById(
            Databases.siteground_database_reggabo,
            Electrocardiogramas.electrocardiogramas['consultByIdPrimaryQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      setState(() {
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
                      builder: (context) => const ElectrocardiogramasGestion()));
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
        Pacientes.Electrocardiogramas = data[index];
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
                  Text(
                    data[index]['Pace_EC_CON'],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.textSyleGrowth(fontSize: 10),
                  ),
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
                            elementSelected = data[index];
                            Pacientes.Electrocardiogramas = data[index];
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
      return Column(
        children: [
          // isMobile(context)
          //     ? Expanded(
          //   flex: isMobile(context) ? 2 : 1,
          //         child: TittlePanel(
          //             padding: isMobile(context) ? 0 : 4,
          //             color: Colores.backgroundWidget,
          //             textPanel: tittle))
          //     : Container(),
          Expanded(
            flex: 2,
            child: EditTextArea(
              keyBoardType: TextInputType.datetime,
              inputFormat: MaskTextInputFormatter(
                  mask: '####/##/##',
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
                    Calendarios.today(format: 'yyyy/MM/dd');
              },
            ),
          ),
          Expanded(
            flex: 10,
            child: GridView(
              controller: ScrollController(),
              gridDelegate: GridViewTools.gridDelegate(
                  crossAxisCount: isMobile(context) ? 1: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  mainAxisExtent: isMobile(context)? 75 : 75),
              children: [
                Spinner(
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
                EditTextArea(
                  keyBoardType: TextInputType.number,
                  inputFormat: MaskTextInputFormatter(),
                  labelEditText: "Eje Cardiaco",
                  textController: paceQrsTextController,
                ),
                CrossLine(),
                //
                Spinner(
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
                    isRow: true,
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
              ],
            ),
          ),
          Expanded(child: CrossLine()),
          Expanded(
            flex: isMobile(context) ? 4 : 2,
            child: EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                numOfLines: 5,
                labelEditText: "Conclusiones",
                textController: conclusionTextController,
                prefixIcon: false),
          ),
          Expanded(
            flex: 2,
            child: Row(
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
                      weigth: isMobile(context) || isTablet(context) ? 30 : 100,
                      labelButton: operationActivity ? "Agregar" : "Actualizar",
                      onPress: () {
                        operationMethod(
                            context: context,
                            operationActivity: operationActivity);
                      }),
                ),
              ],
            ),
          )
        ],
      );

    } if (isMobile(context)) {

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
                      mask: '####/##/##',
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
                        Calendarios.today(format: 'yyyy/MM/dd');
                  },
                ),
              ),
              Expanded(
                flex: 10,
                child: GridView(
                  controller: ScrollController(),
                  gridDelegate: GridViewTools.gridDelegate(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                      mainAxisExtent: 75),
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
                    EditTextArea(
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: "Eje Cardiaco",
                      textController: paceQrsTextController,
                    ),
                    CrossLine(),
                    //
                    Spinner(
                        width:
                            isMobile(context) || isTablet(context) ? 170 : 110,
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
                  ],
                ),
              ),
            ]),
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: EditTextArea(
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      numOfLines: 5,
                      labelEditText: "Conclusiones",
                      textController: conclusionTextController,
                      prefixIcon: false),
                ),
                Expanded(
                  child: Row(
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
                                        content:
                                            Text(listOfValues().toString()),
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
            message: 'Los registros fueron agregados');
        reiniciar().then((value) {
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
            message: 'Los registros fueron Actualizados');
        reiniciar().then((value) {
          setState(() {
            carouselController.jumpToPage(0);
          });
        });
      }).onError((error, stackTrace) {
        Terminal.printWarning(message: "ERROR - $error");
      });
    }
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
            padding: isMobile(context)
                ? const EdgeInsets.all(4.0)
                : const EdgeInsets.all(12.0),
            controller: ScrollController(),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              TittlePanel(
                color: const Color.fromARGB(255, 58, 55, 55),
                textPanel: 'Analisis de Electrocardiograma',
              ),
              Column(
                children: [
                  ThreeLabelTextAline(
                    firstText: "Fecha de realización",
                    secondText: (Valores.fechaElectrocardiograma ?? ''),
                    padding: 1,
                  ),
                  ThreeLabelTextAline(
                    firstText: "Ritmo Cardiaco",
                    secondText: (Valores.ritmoCardiaco ?? ''),
                    padding: 1,
                  ),
                  ThreeLabelTextAline(
                    firstText: "Segmento ST",
                    secondText: (Valores.segmentoST ?? ''),
                    padding: 1,
                  ),
                ],
              ),
              GridLayout(
                  childAspectRatio: 5.0,
                  columnCount: isMobile(context) ? 1 : 2,
                  children: [
                    ThreeLabelTextAline(
                      padding: 1,
                      firstText: "Frecuencia Cardica",
                      secondText:
                          (1500 / Valores.intervaloRR!).toStringAsFixed(0),
                      thirdText: "L/min",
                    ),
                    ThreeLabelTextAline(
                      padding: 1,
                      firstText: "Eje Cardiaco",
                      secondText: (Valores.ejeCardiaco!).toStringAsFixed(2),
                      thirdText: "°",
                    ),
                    ThreeLabelTextAline(
                      padding: 1,
                      firstText: "Indice Sokolow-Lyon",
                      secondText: Valores.indiceSokolowLyon.toStringAsFixed(2),
                      thirdText: "mV",
                    ),
                    ThreeLabelTextAline(
                      padding: 1,
                      firstText: "Indice de Gubner", //-Underleider",
                      secondText:
                          Valores.indiceGubnerUnderleiger.toStringAsFixed(2),
                      thirdText: "mV",
                    ),
                    ThreeLabelTextAline(
                      padding: 1,
                      firstText: "Indice de Lewis",
                      secondText: Valores.indiceLewis.toStringAsFixed(2),
                      thirdText: "mV",
                    ),
                    ThreeLabelTextAline(
                      padding: 1,
                      firstText: "Voltaje de Cornell",
                      secondText: Valores.voltajeCornell.toStringAsFixed(2),
                      thirdText: "mV",
                    ),
                    ThreeLabelTextAline(
                      padding: 1,
                      firstText: "Indice Enrique Cabrera",
                      secondText:
                          Valores.indiceEnriqueCabrera.toStringAsFixed(2),
                      thirdText: "mV",
                    ),
                  ]),
            ]),
          )),
    );
  }
}
