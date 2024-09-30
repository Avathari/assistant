import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/operativity/pacientes/valores/semiologia/semiotica.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Prequirurgicos extends StatefulWidget {
  const Prequirurgicos({Key? key}) : super(key: key);

  @override
  State<Prequirurgicos> createState() => _PrequirurgicosState();
}

class _PrequirurgicosState extends State<Prequirurgicos> {
  var carouselController = CarouselSliderController();
  //
  var goldmanntextController = TextEditingController();
  var detskytextController = TextEditingController();
  var ariscatextController = TextEditingController();
  //

  @override
  void initState() {
    Valores.antecedenteInfarto = Dicotomicos.dicotomicos()[1];
    Valores.ritmoSinusal = Dicotomicos.dicotomicos()[0];
    Valores.extrasistolesVentriculares = Dicotomicos.dicotomicos()[1];
    Valores.ingurgitacionYugular = Dicotomicos.dicotomicos()[1];
    Valores.estenosisAortica = Dicotomicos.dicotomicos()[1];
    Valores.cirugiaUrgencia = Dicotomicos.dicotomicos()[1];
    Valores.cirugiaAbdomen = Dicotomicos.dicotomicos()[0];
    Valores.malEstadoOrganico = Dicotomicos.dicotomicos()[1];
    Valores.anginaEnMeses = Dicotomicos.dicotomicos()[1];
    Valores.edemaPulmonar = Dicotomicos.dicotomicos()[1];
    Valores.edemaPulmonarPasado = Dicotomicos.dicotomicos()[1];
    Valores.saturacionPerifericaOrigeno =
        Escalas.saturacionPerifericaOrigeno[0];
    Valores.infeccionRespiratoria = Dicotomicos.dicotomicos()[1];
    Valores.hemoglobinaInferior = Dicotomicos.dicotomicos()[1];
    Valores.incisionTipo = Escalas.incisionTipo[0];
    Valores.duracionCirugiaHoras = Escalas.duracionCirugiaHoras[0];
    //
    reInit();
    super.initState();
  }

  void reInit() {
    setState(() {
      goldmanntextController.text = Valores.valoracionGoldmann;
      detskytextController.text = Valores.valoracionDetsky;
      ariscatextController.text = Valores.valoracionAriscat;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TittleContainer(
      tittle: 'Valoración Prequirúrgica',
      centered: true,
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GrandIcon(
                    iconData: Icons.dataset,
                    labelButton: 'Datos Iniciales',
                    onPress: () {
                      setState(() {
                        carouselController.jumpToPage(0);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: GrandIcon(
                    iconData: Icons.add_chart,
                    labelButton: 'Escalas',
                    onPress: () {
                      setState(() {
                        carouselController.jumpToPage(1);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: CarouselSlider(
                  items: [
                    SingleChildScrollView(
                      controller: ScrollController(),
                      child: Column(
                        children: [
                          Spinner(
                            width: isDesktop(context)
                                ? 400
                                : isMobile(context)
                                    ? 216
                                    : 100,
                            tittle: 'Antecedente de Infarto',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.antecedenteInfarto = value;
                                reInit();
                              });
                            },
                            items: Dicotomicos.dicotomicos(),
                            initialValue: Valores.antecedenteInfarto,
                          ),
                          Spinner(
                            width: isDesktop(context)
                                ? 400
                                : isMobile(context)
                                    ? 216
                                    : 100,
                            tittle: 'Ritmo Sinusal',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.ritmoSinusal = value;
                                reInit();
                              });
                            },
                            items: Dicotomicos.dicotomicos(),
                            initialValue: Valores.ritmoSinusal,
                          ),
                          Spinner(
                            width: isDesktop(context)
                                ? 400
                                : isMobile(context)
                                    ? 216
                                    : 100,
                            tittle: 'Extrasistoles Ventriculares',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.extrasistolesVentriculares = value;
                                reInit();
                              });
                            },
                            items: Dicotomicos.dicotomicos(),
                            initialValue: Valores.extrasistolesVentriculares,
                          ),
                          Spinner(
                            width: isDesktop(context)
                                ? 400
                                : isMobile(context)
                                    ? 216
                                    : 100,
                            tittle: 'Ingurgitación Yugular',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.ingurgitacionYugular = value;
                                reInit();
                              });
                            },
                            items: Dicotomicos.dicotomicos(),
                            initialValue: Valores.ingurgitacionYugular,
                          ),
                          Spinner(
                            width: isDesktop(context)
                                ? 400
                                : isMobile(context)
                                    ? 216
                                    : 100,
                            tittle: 'Estenosis Aórticaa',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.estenosisAortica = value;
                                reInit();
                              });
                            },
                            items: Dicotomicos.dicotomicos(),
                            initialValue: Valores.estenosisAortica,
                          ),
                          Spinner(
                            width: isDesktop(context)
                                ? 400
                                : isMobile(context)
                                    ? 216
                                    : 100,
                            tittle: 'Cirugía de Urgencia',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.cirugiaUrgencia = value;
                                reInit();
                              });
                            },
                            items: Dicotomicos.dicotomicos(),
                            initialValue: Valores.cirugiaUrgencia,
                          ),
                          Spinner(
                            width: isDesktop(context)
                                ? 400
                                : isMobile(context)
                                    ? 216
                                    : 100,
                            tittle: 'Cirugía de Abdomen',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.cirugiaAbdomen = value;
                                reInit();
                              });
                            },
                            items: Dicotomicos.dicotomicos(),
                            initialValue: Valores.cirugiaAbdomen,
                          ),
                          Spinner(
                            width: isDesktop(context)
                                ? 400
                                : isMobile(context)
                                    ? 216
                                    : 100,
                            tittle: 'Mal Estado Orgánico',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.malEstadoOrganico = value;
                                reInit();
                              });
                            },
                            items: Dicotomicos.dicotomicos(),
                            initialValue: Valores.malEstadoOrganico,
                          ),
                          Spinner(
                            width: isDesktop(context)
                                ? 400
                                : isMobile(context)
                                    ? 216
                                    : 100,
                            tittle: 'Angina < 3 meses',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.anginaEnMeses = value;
                                reInit();
                              });
                            },
                            items: Dicotomicos.dicotomicos(),
                            initialValue: Valores.anginaEnMeses,
                          ),
                          Spinner(
                            width: isDesktop(context)
                                ? 400
                                : isMobile(context)
                                    ? 216
                                    : 100,
                            tittle: 'Edema Pulmonar < 1 mes',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.edemaPulmonar = value;
                                reInit();
                              });
                            },
                            items: Dicotomicos.dicotomicos(),
                            initialValue: Valores.edemaPulmonar,
                          ),
                          Spinner(
                            width: isDesktop(context)
                                ? 400
                                : isMobile(context)
                                    ? 216
                                    : 100,
                            tittle: 'Edema Pulmonar Pasado',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.edemaPulmonarPasado = value;
                                reInit();
                              });
                            },
                            items: Dicotomicos.dicotomicos(),
                            initialValue: Valores.edemaPulmonarPasado,
                          ),
                          Spinner(
                            width: isDesktop(context)
                                ? 400
                                : isMobile(context)
                                    ? 216
                                    : 100,
                            tittle: 'SpO2 (%) Previa',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.saturacionPerifericaOrigeno = value;
                                reInit();
                              });
                            },
                            items: Escalas.saturacionPerifericaOrigeno,
                            initialValue: Valores.saturacionPerifericaOrigeno,
                          ),
                          Spinner(
                            width: isDesktop(context)
                                ? 400
                                : isMobile(context)
                                    ? 216
                                    : 100,
                            tittle: 'Infección Respiratoria Previa',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.infeccionRespiratoria = value;
                                reInit();
                              });
                            },
                            items: Dicotomicos.dicotomicos(),
                            initialValue: Valores.infeccionRespiratoria,
                          ),
                          Spinner(
                            width: isDesktop(context)
                                ? 400
                                : isMobile(context)
                                    ? 216
                                    : 100,
                            tittle: 'Hemoglobina menor a 10 g/dL',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.hemoglobinaInferior = value;
                                reInit();
                              });
                            },
                            items: Dicotomicos.dicotomicos(),
                            initialValue: Valores.hemoglobinaInferior,
                          ),
                          Spinner(
                            width: isDesktop(context)
                                ? 400
                                : isMobile(context)
                                    ? 216
                                    : 100,
                            tittle: 'Tipo de Incisión',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.incisionTipo = value;
                                reInit();
                              });
                            },
                            items: Escalas.incisionTipo,
                            initialValue: Valores.incisionTipo,
                          ),
                          Spinner(
                            width: isDesktop(context)
                                ? 400
                                : isMobile(context)
                                    ? 216
                                    : 100,
                            tittle: 'Duración en Horas',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.duracionCirugiaHoras = value;
                                reInit();
                              });
                            },
                            items: Escalas.duracionCirugiaHoras,
                            initialValue: Valores.duracionCirugiaHoras,
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      controller: ScrollController(),
                      child: Column(
                        children: [
                          Spinner(
                            width: isDesktop(context) || isTablet(context)
                                ? 400
                                : 216,
                            tittle: 'Valoración A.S.A.',
                            onChangeValue: (value) {
                              setState(() {
                                Exploracion.valoracionAsa = value;
                              });
                            },
                            items: Escalas.asa,
                            initialValue: Exploracion.valoracionAsa,
                          ),
                          CrossLine(),
                          EditTextArea(
                            labelEditText: 'Riesgo Anestésicco (Goldmann)',
                            textController: goldmanntextController,
                            keyBoardType: TextInputType.number,
                            numOfLines: 1,
                            inputFormat: MaskTextInputFormatter(),
                            onChange: (value) {},
                          ),
                          EditTextArea(
                            labelEditText: 'Riesgo Cárdiaco (Detsky)',
                            textController: detskytextController,
                            keyBoardType: TextInputType.number,
                            numOfLines: 1,
                            inputFormat: MaskTextInputFormatter(),
                            onChange: (value) {},
                          ),
                          EditTextArea(
                            labelEditText: 'Riesgo Pulmonar (A.R.I.S.C.A.T)',
                            textController: ariscatextController,
                            keyBoardType: TextInputType.number,
                            numOfLines: 1,
                            inputFormat: MaskTextInputFormatter(),
                            onChange: (value) {},
                          ),
                          CrossLine(),
                          Spinner(
                            width: isDesktop(context) || isTablet(context)
                                ? 400
                                : 216,
                            tittle: 'Valoración Bromage',
                            onChangeValue: (value) {
                              setState(() {
                                Exploracion.valoracionBromage = value;
                              });
                            },
                            items: Escalas.bromage,
                            initialValue: Exploracion.valoracionBromage,
                          ),
                          Spinner(
                            width: isDesktop(context) || isTablet(context)
                                ? 400
                                : 216,
                            tittle: 'Valoración N.Y.H.A.',
                            onChangeValue: (value) {
                              setState(() {
                                Exploracion.valoracionNyha = value;
                              });
                            },
                            items: Escalas.nyha,
                            initialValue: Exploracion.valoracionNyha,
                          ),
                        ],
                      ),
                    ),
                  ],
                  carouselController: carouselController,
                  options: CarouselOptions(
                      height: isDesktop(context) ? 900 : 500,
                      enableInfiniteScroll: false,
                      viewportFraction: 1.0)),
            ),
          ),
        ],
      ),
    );
  }
}
