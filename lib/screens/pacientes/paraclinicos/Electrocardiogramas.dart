import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/intensiva/herramientas.dart';
import 'package:assistant/screens/pacientes/pacientes.dart';
import 'package:assistant/screens/pacientes/paraclinicos/AuxiliaresDiagnosticos.dart';
import 'package:assistant/values/SizingInfo.dart';
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

class ElectrocardiogramasGestion extends StatefulWidget {
  const ElectrocardiogramasGestion({super.key});

  @override
  State<ElectrocardiogramasGestion> createState() =>
      _ElectrocardiogramasGestionState();
}

class _ElectrocardiogramasGestionState
    extends State<ElectrocardiogramasGestion> {
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

    toBaseImage();
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
          width: isMobile(context) ? 150 :100,
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
            Valores.intervaloRR = double.parse(value);
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
      const CrossLine(),
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
      const CrossLine(),
      //
      Spinner(
          width: isMobile(context) || isTablet(context) ? 170: 110,
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
      const CrossLine(),
      //
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: "Onda R en V1",
        textController: rv1TextController,
        numOfLines: 1,
        onChange: (value) {
          setState(() {
            Valores.rV1 = double.parse(value);
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
            Valores.sV1 = double.parse(value);
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
            Valores.rV6 = double.parse(value);
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
            Valores.sV6 = double.parse(value);
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
            Valores.rAvL = double.parse(value);
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
            Valores.sV3 = double.parse(value);
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
        actions: isMobile(context) || isTablet(context)
            ? <Widget>[
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
                    openActivity(AnalisisElectrocardiograma(
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
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GrandButton(
                          weigth: 100,
                          labelButton: "Registro de electrocardiogramas",
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
                            ? 700
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TittlePanel(
                                        color: Colores.backgroundWidget,
                                        textPanel: tittle),
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
                                    GridLayout(
                                        childAspectRatio: isTablet(context)
                                            ? 5.0
                                            : isTablet(context)
                                                ? 5.0
                                                : isDesktop(context)
                                                    ? 5.0
                                                    : isMobile(context)
                                                        ? 3.8
                                                        : 5.0,
                                        columnCount: isMobile(context) ? 1 : 2,
                                        children: listOfComponents()),
                                    Column(
                                      children: [
                                        EditTextArea(
                                            keyBoardType: TextInputType.number,
                                            inputFormat:
                                                MaskTextInputFormatter(),
                                            numOfLines: 5,
                                            labelEditText: "Conclusiones",
                                            textController:
                                                conclusionTextController,
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
                                                weigth: isMobile(context) || isTablet(context)
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
                                                      Electrocardiogramas
                                                              .electrocardiogramas[
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
                                                                context:
                                                                    context,
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
                          isTablet(context)
                              ? Container()
                              : isDesktop(context)
                                  ? Expanded(
                                      flex: 2,
                                      child: AnalisisElectrocardiograma(
                                          operationActivity: operationActivity),
                                    )
                                  : isMobile(context)
                                      ? Container()
                                      : Expanded(
                                          flex: 2,
                                          child: AnalisisElectrocardiograma(
                                              operationActivity:
                                                  operationActivity),
                                        ),
                        ],
                      ),
                      SingleChildScrollView(
                        padding: const EdgeInsets.all(12.0),
                        controller: ScrollController(),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: stringImage != "" && stringImage != null
                                  ? Expanded(
                                      child: Image.memory(
                                        base64Decode(stringImage!),
                                        scale: 1.0,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          ClipOval(
                                            child: Icon(
                                              Icons.file_present,
                                              size: 200,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      )
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
    listOfCells.add(dataCell(element['ID_Pace_GAB_EC'].toString(), onTapped: () {
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
    },));
    listOfCells.add(dataCell(element['Pace_GAB_EC_Feca'].toString(), onTapped: () {
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
    },));
    listOfCells.add(dataCell(element['Pace_EC_rit'].toString(), onTapped: () {
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
    },));
    listOfCells.add(dataCell(element['Pace_EC_rr'].toString(), onTapped: () {
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
    },));
    listOfCells
        .add(dataCell((1500 / element['Pace_EC_rr']).toStringAsFixed(0), onTapped: () {
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
    },));
    listOfCells.add(dataCell(element['Pace_EC_CON'].toString(), onTapped: () {
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
    },));
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

  void openActivity(chyldrim) {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          return Dialog(
              backgroundColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: chyldrim),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: Colors.grey,
                          )),
                      child: GrandButton(
                        labelButton: 'Cerrar',
                        onPress: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  Future<void> toBaseImage() async {
    ByteData bytes = await rootBundle.load('assets/images/person.png');
    var buffer = bytes.buffer;

    setState(() {
      stringImage = base64.encode(Uint8List.view(buffer));
    });
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
