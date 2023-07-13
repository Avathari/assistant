import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
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
  var expoTextController = TextEditingController();
  var carouselController = CarouselController();

  @override
  void initState() {
    expoTextController.text = Exploracion.exploracionGeneral;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ContainerDecoration.roundedDecoration(),
      child: Column(
        children: [
          TittlePanel(
            textPanel: 'Exploración Física',
          ),
          EditTextArea(
              textController: expoTextController,
              labelEditText: "Exploración física",
              keyBoardType: TextInputType.multiline,
              numOfLines: 7,
              inputFormat: MaskTextInputFormatter()),
          Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                GrandIcon(
                  labelButton: 'Hábito Externo',
                  iconData: Icons.brightness_1_outlined,
                  onPress: () => carouselController.jumpToPage(0),
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
          Expanded(
            flex: 10,
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: ContainerDecoration.roundedDecoration(),
              child: CarouselSlider(
                  carouselController: carouselController,
                  options: Carousel.carouselOptions(context: context),
                  items: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              TittlePanel(textPanel: 'Inspección General'),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Alerta',
                                      onPress: () {
                                        Exploracion.inspeccionGeneral =
                                            'Alerta';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                        print(Exploracion.inspeccionGeneral);
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Aturdido',
                                      onPress: () {
                                        Exploracion.inspeccionGeneral =
                                            'Aturdido';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                        print(Exploracion.inspeccionGeneral);
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Desorientado',
                                      onPress: () {
                                        Exploracion.inspeccionGeneral =
                                            'Desorientado';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                        print(Exploracion.inspeccionGeneral);
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Irritable',
                                      onPress: () {
                                        Exploracion.inspeccionGeneral =
                                            'Irritable';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                        print(Exploracion.inspeccionGeneral);
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Obnubilado',
                                      onPress: () {
                                        Exploracion.inspeccionGeneral =
                                            'Obnubilado';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                        print(Exploracion.inspeccionGeneral);
                                      })),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              TittlePanel(textPanel: 'Apertura Ocular'),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Espontánea',
                                      onPress: () {
                                        Exploracion.aperturaOcular = '4';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Al Estimulo Verbal',
                                      onPress: () {
                                        Exploracion.aperturaOcular = '3';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Al Dolor',
                                      onPress: () {
                                        Exploracion.aperturaOcular = '2';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'No Hay Respuesta Ocular',
                                      onPress: () {
                                        Exploracion.aperturaOcular = '1';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              TittlePanel(textPanel: 'Respuesta Verbal'),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Orientada',
                                      onPress: () {
                                        Exploracion.respuestaVerbal = '5';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                        print(Exploracion.respuestaVerbal);
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Desorientada',
                                      onPress: () {
                                        Exploracion.respuestaVerbal = '4';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                        print(Exploracion.respuestaVerbal);
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Palabras Inapropiadas',
                                      onPress: () {
                                        Exploracion.respuestaVerbal = '3';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                        print(Exploracion.respuestaVerbal);
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Sonidos Incomprensibles',
                                      onPress: () {
                                        Exploracion.respuestaVerbal = '2';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                        print(Exploracion.respuestaVerbal);
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'No hay Respuesta Verbal',
                                      onPress: () {
                                        Exploracion.respuestaVerbal = '1';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                        print(Exploracion.respuestaVerbal);
                                      })),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              TittlePanel(textPanel: 'Respuesta Motora'),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Obedece Ordenes',
                                      onPress: () {
                                        Exploracion.respuestaMotora = '6';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                        print(Exploracion.respuestaMotora);
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Localiza Dolor',
                                      onPress: () {
                                        Exploracion.respuestaMotora = '5';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                        print(Exploracion.respuestaMotora);
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Flexión Normal',
                                      onPress: () {
                                        Exploracion.respuestaMotora = '4';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                        print(Exploracion.respuestaMotora);
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Flexión Anormal',
                                      onPress: () {
                                        Exploracion.respuestaMotora = '3';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                        print(Exploracion.respuestaMotora);
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Extensión',
                                      onPress: () {
                                        Exploracion.respuestaMotora = '2';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                        print(Exploracion.respuestaMotora);
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'No Hay Respuesta',
                                      onPress: () {
                                        Exploracion.respuestaMotora = '1';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                        print(Exploracion.respuestaMotora);
                                      })),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              TittlePanel(textPanel: 'Apariencia Tegumentaria'),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Sin Palidez Tegumentaria',
                                      onPress: () {
                                        Exploracion.coloracionTegumentaria = ', sin palidez tegumentaria';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Con Palidez Tegumentaria',
                                      onPress: () {
                                        Exploracion.coloracionTegumentaria = ', con palidez tegumentaria';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              TittlePanel(textPanel: 'Apariencia Mucosas'),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Sin Mucosas Deshidratación',
                                      onPress: () {
                                        Exploracion.coloracionMucosas = ', sin deshidratación en mucosas';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Con Mucosas Deshidratadas',
                                      onPress: () {
                                        Exploracion.coloracionMucosas = ', con deshidratación en mucosas';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
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
                              TittlePanel(textPanel: 'Cuello'),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Sin Ingurgitación Yugular',
                                      onPress: () {
                                        Exploracion.ingurgitacionYugular =
                                        'sin Ingurgitación Yugular';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Ingurgitación Yugular Grado I',
                                      onPress: () {
                                        Exploracion.ingurgitacionYugular =
                                        'con ingurgitación yugular grado I';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Ingurgitación Yugular Grado II',
                                      onPress: () {
                                        Exploracion.ingurgitacionYugular =
                                        'con ingurgitación yugular grado II';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Ingurgitación Yugular Grado III',
                                      onPress: () {
                                        Exploracion.ingurgitacionYugular =
                                        'con ingurgitación yugular grado III';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              TittlePanel(textPanel: 'Tráquea'),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Sin Desviación Traqueal',
                                      onPress: () {
                                        Exploracion.desviacionTraqueal =
                                        ', tráquea central';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Tráquea desviada hacia la Izquierda',
                                      onPress: () {
                                        Exploracion.desviacionTraqueal =
                                        ', tráquea desviada hacia la izquierda';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Tráquea desviada hacia la Derecha',
                                      onPress: () {
                                        Exploracion.desviacionTraqueal =
                                        ', tráquea desviada hacia la derecha';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              TittlePanel(textPanel: 'Presencia de Bocio'),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Sin Presencia de Bocio',
                                      onPress: () {
                                        Exploracion.bocioCervical =
                                        ', sin presencia de bocio';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Con Presencia de Bocio',
                                      onPress: () {
                                        Exploracion.bocioCervical =
                                        ', con presencia de bocio';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              TittlePanel(textPanel: 'Adenopatías'),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Sin Adenopatías',
                                      onPress: () {
                                        Exploracion.adenopatiaCervical =
                                        ', sin adenopatías';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Adenopatía en Región Lateral Izquierda',
                                      onPress: () {
                                        Exploracion.adenopatiaCervical =
                                        ', adenopatía en región lateral izquierda';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Adenopatía en Región Lateral Derecha',
                                      onPress: () {
                                        Exploracion.adenopatiaCervical =
                                        ', adenopatía en región lateral derecha';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              TittlePanel(textPanel: 'Adenomegalias'),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Sin Adenomegalias',
                                      onPress: () {
                                        Exploracion.adenomegaliasCervical =
                                        ', sin adenomegalias';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Adenopatía en Región Lateral Izquierda',
                                      onPress: () {
                                        Exploracion.adenomegaliasCervical =
                                        ', adenopatía en región lateral izquierda';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Adenopatía en Región Lateral Derecha',
                                      onPress: () {
                                        Exploracion.adenomegaliasCervical =
                                        ', adenopatía en región lateral derecha';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
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
                              TittlePanel(textPanel: 'Tórax'),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Amplexión sin Restricciones',
                                      onPress: () {
                                        Exploracion.amplexionTorax =
                                        'amplexión sin restricciones';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Amplexión con Restricción',
                                      onPress: () {
                                        Exploracion.amplexionTorax =
                                        'amplexión con restricción';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),

                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              TittlePanel(textPanel: 'Dificultad Respiratoria'),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Sin Tiraje Intercostal',
                                      onPress: () {
                                        Exploracion.amplexacionTorax =
                                        ', sin tiraje intercostal';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),
                              Expanded(
                                  child: GrandButton(
                                      labelButton: 'Tiraje Intercostal',
                                      onPress: () {
                                        Exploracion.amplexacionTorax =
                                        ', tiraje intercostal';
                                        expoTextController.text =
                                            Exploracion.exploracionGeneral;
                                      })),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
