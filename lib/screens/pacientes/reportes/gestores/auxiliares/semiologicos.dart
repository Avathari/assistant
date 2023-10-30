import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/info/info.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CircleLabel.dart';
import 'package:assistant/widgets/CircleSwitched.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/CircleSwitched.dart';
import 'package:assistant/widgets/CircleSwitched.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/GrandLabel.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Semiologicos extends StatefulWidget {
  const Semiologicos({Key? key}) : super(key: key);

  @override
  State<Semiologicos> createState() => _SemiologicosState();
}

class _SemiologicosState extends State<Semiologicos> {
  int? numActivity = 0;

  @override
  void initState() {
    expoTextController.text = Exploracion.exploracionGeneral;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ContainerDecoration.roundedDecoration(colorBackground: Theming.cuaternaryColor),
      child: Row(
        children: [
          if (numActivity == 0)
            infoSemiologias.infograma(context, clusterInpeccion(context),
                tittle: "Inspección General")
          else
            Container(),
          if (numActivity == 0)
            Expanded(
                child: infoSemiologias.infograma(
                    context, clusterGlasgowEye(context),
                    tittle: "Apertura Ocular"))
          else
            Container(),
          if (numActivity == 0)
            Expanded(
                child: infoSemiologias.infograma(
                    context, clusterGlasgowVerbal(context),
                    tittle: "Respuesta Verbal"))
          else
            Container(),
          if (numActivity == 0)
            Expanded(
                child: infoSemiologias.infograma(
                    context, clusterGlasgowMotora(context),
                    tittle: "Respuesta Motora"))
          else
            Container(),
          // ****************************** **** *** **    *
          Expanded(
              flex: 8,
              child: Container(
                margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.all(5.0),
                decoration: ContainerDecoration.roundedDecoration(),
                child: Column(
                  children: [
                    TittlePanel(
                      textPanel: 'Exploración Física',
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GrandIcon(
                            labelButton: 'Hábito Externo',
                            iconData: Icons.brightness_1_outlined,
                            onPress: () {
                              setState(() {
                                numActivity = 0;
                              });
                            }, // carouselController.jumpToPage(0),
                          ),
                          GrandIcon(
                            labelButton: 'Cuello',
                            iconData: Icons.nest_cam_wired_stand,
                            onPress: () => carouselController.jumpToPage(1),
                          ),
                          GrandIcon(
                            labelButton: '',
                            iconData: Icons.brightness_1_outlined,
                            onPress: () => carouselController.jumpToPage(2),
                          )
                        ],
                      ),
                    )),
                    EditTextArea(
                        textController: expoTextController,
                        labelEditText: "Exploración física",
                        keyBoardType: TextInputType.multiline,
                        numOfLines: 7,
                        inputFormat: MaskTextInputFormatter()),
                    // ************************** **** *** **    *
                    Expanded(
                      flex: 10,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: ContainerDecoration.roundedDecoration(),
                        child: CarouselSlider(
                            carouselController: carouselController,
                            options: Carousel.carouselOptions(context: context),
                            items: [
                              Column(
                                children: [
                                  Expanded(
                                    child: infoSemiologias.infograma(
                                        context, clusterTegumentario(context),
                                        tittle: "Apariencia Tegumentaria",
                                        isVertical: false),
                                  ),
                                  Expanded(
                                    child: infoSemiologias.infograma(
                                        context, clusterTegumentario(context),
                                        tittle: "Apariencia Tegumentaria",
                                        isVertical: false),
                                  ),
                                  Expanded(
                                    child: infoSemiologias.infograma(
                                        context, clusterTegumentario(context),
                                        tittle: "Apariencia Tegumentaria",
                                        isVertical: false),
                                  ),
                                  Expanded(
                                    child: infoSemiologias.infograma(
                                        context, clusterTegumentario(context),
                                        tittle: "Apariencia Tegumentaria",
                                        isVertical: false),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TittlePanel(
                                            textPanel: 'Inspección General',
                                            fontSize: 11,
                                            padding: 5.0),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TittlePanel(
                                            textPanel: 'Apertura Ocular',
                                            fontSize: 11,
                                            padding: 5.0),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TittlePanel(
                                            textPanel: 'Respuesta Verbal',
                                            fontSize: 11,
                                            padding: 5.0),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TittlePanel(
                                            textPanel: 'Respuesta Motora',
                                            fontSize: 11,
                                            padding: 5.0),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TittlePanel(
                                            textPanel:
                                                'Apariencia Tegumentaria',
                                            fontSize: 11,
                                            padding: 5.0),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TittlePanel(
                                            textPanel: 'Apariencia Mucosas',
                                            fontSize: 11,
                                            padding: 5.0),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TittlePanel(
                                            textPanel: 'Cuello',
                                            fontSize: 11,
                                            padding: 5.0),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TittlePanel(
                                            textPanel: 'Tráquea',
                                            fontSize: 11,
                                            padding: 5.0),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TittlePanel(
                                            textPanel: 'Presencia de Bocio',
                                            fontSize: 11,
                                            padding: 5.0),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TittlePanel(
                                            textPanel: 'Adenopatías',
                                            fontSize: 11,
                                            padding: 5.0),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TittlePanel(
                                            textPanel: 'Adenomegalias',
                                            fontSize: 11,
                                            padding: 5.0),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TittlePanel(
                                            textPanel: 'Tórax',
                                            fontSize: 11,
                                            padding: 5.0),
                                        Expanded(
                                            child: CircleSwitched(
                                                tittle:
                                                    'Amplexión sin Restricciones',
                                                radios: 25,
                                                difRadios: 5,
                                                onChangeValue: () {
                                                  Exploracion.amplexionTorax =
                                                      'amplexión sin restricciones';
                                                  expoTextController.text =
                                                      Exploracion
                                                          .exploracionGeneral;
                                                })),
                                        Expanded(
                                            child: CircleSwitched(
                                                tittle:
                                                    'Amplexión con Restricción',
                                                radios: 25,
                                                difRadios: 5,
                                                onChangeValue: () {
                                                  Exploracion.amplexionTorax =
                                                      'amplexión con restricción';
                                                  expoTextController.text =
                                                      Exploracion
                                                          .exploracionGeneral;
                                                })),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        TittlePanel(
                                            textPanel:
                                                'Dificultad Respiratoria',
                                            fontSize: 11,
                                            padding: 5.0),
                                        Expanded(
                                            child: CircleSwitched(
                                                tittle:
                                                    'Sin Tiraje Intercostal',
                                                radios: 25,
                                                difRadios: 5,
                                                onChangeValue: () {
                                                  Exploracion.amplexacionTorax =
                                                      ', sin tiraje intercostal';
                                                  expoTextController.text =
                                                      Exploracion
                                                          .exploracionGeneral;
                                                })),
                                        Expanded(
                                            child: CircleSwitched(
                                                tittle: 'Tiraje Intercostal',
                                                radios: 25,
                                                difRadios: 5,
                                                onChangeValue: () {
                                                  Exploracion.amplexacionTorax =
                                                      ', tiraje intercostal';
                                                  expoTextController.text =
                                                      Exploracion
                                                          .exploracionGeneral;
                                                })),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Expanded(
                                child: infoSemiologias.infograma(
                                    context, clusterTegumentario(context),
                                    tittle: "Apariencia Tegumentaria",
                                    isVertical: false)),
                            Expanded(
                                child: infoSemiologias.infograma(
                                    context, clusterHidratacion(context),
                                    tittle: "Estado de Hidratación",
                                    isVertical: false)),
                          ],
                        )),
                  ],
                ),
              )),
          // ****************************** **** *** **    *
          if (numActivity == 0)
            Expanded(
                child:
                    infoSemiologias.infograma(context, clusterCuello(context)))
          else
            Container(),
          if (numActivity == 0)
            Expanded(
                child:
                    infoSemiologias.infograma(context, clusterTraquea(context)))
          else
            Container(),
          if (numActivity == 0)
            Expanded(
                child:
                    infoSemiologias.infograma(context, clusterBocio(context)))
          else
            Container(),
          if (numActivity == 0)
            Expanded(
                child:
                    infoSemiologias.infograma(context, clusterAdenos(context)))
          else
            Container(),
        ],
      ),
    );
  }

  // CLUSTERS ************************** **** *** **    *
  List<Widget> clusterInpeccion(
    BuildContext context,
  ) {
    return [
      CircleSwitched(
        tittle: "Alerta",
        radios: 25,
        difRadios: 5,
        onChangeValue: () {
          Exploracion.inspeccionGeneral = 'Alerta';
          expoTextController.text = Exploracion.exploracionGeneral;
          print(Exploracion.inspeccionGeneral);
        },
      ),
      CircleSwitched(
          tittle: 'Aturdido',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.inspeccionGeneral = 'Aturdido';
            expoTextController.text = Exploracion.exploracionGeneral;
            print(Exploracion.inspeccionGeneral);
          }),
      CircleSwitched(
          tittle: 'Desorientado',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.inspeccionGeneral = 'Desorientado';
            expoTextController.text = Exploracion.exploracionGeneral;
            print(Exploracion.inspeccionGeneral);
          }),
      CircleSwitched(
          tittle: 'Irritable',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.inspeccionGeneral = 'Irritable';
            expoTextController.text = Exploracion.exploracionGeneral;
            print(Exploracion.inspeccionGeneral);
          }),
      CircleSwitched(
          tittle: 'Obnubilado',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.inspeccionGeneral = 'Obnubilado';
            expoTextController.text = Exploracion.exploracionGeneral;
            print(Exploracion.inspeccionGeneral);
          }),
    ];
  }

  List<Widget> clusterGlasgowEye(BuildContext context) {
    return [
      CircleSwitched(
          tittle: 'Espontánea',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.aperturaOcular = '4';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
      CircleSwitched(
          tittle: 'Al Estimulo Verbal',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.aperturaOcular = '3';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
      CircleSwitched(
          tittle: 'Al Dolor',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.aperturaOcular = '2';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
      CircleSwitched(
          tittle: 'No Hay Respuesta Ocular',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.aperturaOcular = '1';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
    ];
  }

  List<Widget> clusterGlasgowVerbal(
    BuildContext context,
  ) {
    return [
      CircleSwitched(
          tittle: 'Orientada',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.respuestaVerbal = '5';
            expoTextController.text = Exploracion.exploracionGeneral;
            print(Exploracion.respuestaVerbal);
          }),
      CircleSwitched(
          tittle: 'Desorientada',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.respuestaVerbal = '4';
            expoTextController.text = Exploracion.exploracionGeneral;
            print(Exploracion.respuestaVerbal);
          }),
      CircleSwitched(
          tittle: 'Palabras Inapropiadas',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.respuestaVerbal = '3';
            expoTextController.text = Exploracion.exploracionGeneral;
            print(Exploracion.respuestaVerbal);
          }),
      CircleSwitched(
          tittle: 'Sonidos Incomprensibles',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.respuestaVerbal = '2';
            expoTextController.text = Exploracion.exploracionGeneral;
            print(Exploracion.respuestaVerbal);
          }),
      CircleSwitched(
          tittle: 'No hay Respuesta Verbal',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.respuestaVerbal = '1';
            expoTextController.text = Exploracion.exploracionGeneral;
            print(Exploracion.respuestaVerbal);
          }),
    ];
  }

  List<Widget> clusterGlasgowMotora(BuildContext context) {
    return [
      CircleSwitched(
          tittle: 'Obedece Ordenes',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.respuestaMotora = '6';
            expoTextController.text = Exploracion.exploracionGeneral;
            print(Exploracion.respuestaMotora);
          }),
      CircleSwitched(
          tittle: 'Localiza Dolor',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.respuestaMotora = '5';
            expoTextController.text = Exploracion.exploracionGeneral;
            print(Exploracion.respuestaMotora);
          }),
      CircleSwitched(
          tittle: 'Flexión Normal',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.respuestaMotora = '4';
            expoTextController.text = Exploracion.exploracionGeneral;
            print(Exploracion.respuestaMotora);
          }),
      CircleSwitched(
          tittle: 'Flexión Anormal',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.respuestaMotora = '3';
            expoTextController.text = Exploracion.exploracionGeneral;
            print(Exploracion.respuestaMotora);
          }),
      CircleSwitched(
          tittle: 'Extensión',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.respuestaMotora = '2';
            expoTextController.text = Exploracion.exploracionGeneral;
            print(Exploracion.respuestaMotora);
          }),
      CircleSwitched(
          tittle: 'No Hay Respuesta',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.respuestaMotora = '1';
            expoTextController.text = Exploracion.exploracionGeneral;
            print(Exploracion.respuestaMotora);
          }),
    ];
  }

  //************************** **** *** **    *
  List<Widget> clusterTegumentario(BuildContext context) {
    return [
      CircleSwitched(
          tittle: 'Sin Palidez Tegumentaria',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.coloracionTegumentaria = ', sin palidez tegumentaria';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
      CircleSwitched(
          tittle: 'Con Palidez Tegumentaria',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.coloracionTegumentaria = ', con palidez tegumentaria';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
    ];
  }

  List<Widget> clusterHidratacion(BuildContext context) {
    return [
      CircleSwitched(
          tittle: 'Sin Mucosas Deshidratación',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.coloracionMucosas = ', sin deshidratación en mucosas';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
      CircleSwitched(
          tittle: 'Con Mucosas Deshidratadas',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.coloracionMucosas = ', con deshidratación en mucosas';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
    ];
  }

  //************************** **** *** **    *
  List<Widget> clusterCuello(BuildContext context) {
    return [
      CircleSwitched(
          tittle: 'Sin Ingurgitación Yugular',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.ingurgitacionYugular = 'sin Ingurgitación Yugular';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
      CircleSwitched(
          tittle: 'Ingurgitación Yugular Grado I',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.ingurgitacionYugular =
                'con ingurgitación yugular grado I';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
      CircleSwitched(
          tittle: 'Ingurgitación Yugular Grado II',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.ingurgitacionYugular =
                'con ingurgitación yugular grado II';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
      CircleSwitched(
          tittle: 'Ingurgitación Yugular Grado III',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.ingurgitacionYugular =
                'con ingurgitación yugular grado III';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
      CrossLine(),
      CircleSwitched(
          tittle: 'Sin Presencia de Bocio',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.bocioCervical = ', sin presencia de bocio';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
      CircleSwitched(
          tittle: 'Con Presencia de Bocio',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.bocioCervical = ', con presencia de bocio';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
    ];
  }

  List<Widget> clusterTraquea(BuildContext context) {
    return [
      CircleSwitched(
          tittle: 'Sin Desviación Traqueal',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.desviacionTraqueal = ', tráquea central';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
      CircleSwitched(
          tittle: 'Tráquea desviada hacia la Izquierda',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.desviacionTraqueal =
                ', tráquea desviada hacia la izquierda';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
      CircleSwitched(
          tittle: 'Tráquea desviada hacia la Derecha',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.desviacionTraqueal =
                ', tráquea desviada hacia la derecha';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
      CrossLine(),
    ];
  }

  List<Widget> clusterAdenos(BuildContext context) {
    return [
      CircleSwitched(
          tittle: 'Sin Adenopatías',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.adenopatiaCervical = ', sin adenopatías';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
      CircleSwitched(
          tittle: 'Adenopatía en Región Lateral Izquierda',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.adenopatiaCervical =
                ', adenopatía en región lateral izquierda';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
      CircleSwitched(
          tittle: 'Adenopatía en Región Lateral Derecha',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.adenopatiaCervical =
                ', adenopatía en región lateral derecha';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
      CrossLine(),
      CircleSwitched(
          tittle: 'Sin Adenomegalias',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.adenomegaliasCervical = ', sin adenomegalias';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
      CircleSwitched(
          tittle: 'Adenopatía en Región Lateral Izquierda',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.adenomegaliasCervical =
                ', adenopatía en región lateral izquierda';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
      CircleSwitched(
          tittle: 'Adenopatía en Región Lateral Derecha',
          radios: 25,
          difRadios: 5,
          onChangeValue: () {
            Exploracion.adenomegaliasCervical =
                ', adenopatía en región lateral derecha';
            expoTextController.text = Exploracion.exploracionGeneral;
          }),
    ];
  }

  List<Widget> clusterBocio(BuildContext context) {
    return [];
  }

  //************************** **** *** **    *
  List<Widget> clusterRass(BuildContext context) {
    List<Widget> list = [];

    Escalas.RASS.forEach((element) {
      list.add(CircleLabel(
          tittle: element,
          radios: 25,
          ));
    });
    return list;
  }


  // VARIABLES ***********************************
  var expoTextController = TextEditingController();
  var carouselController = CarouselController();
}
