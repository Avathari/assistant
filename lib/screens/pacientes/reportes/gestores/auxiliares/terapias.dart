import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TerapiasItems extends StatefulWidget {
  bool? esCorto;

  TerapiasItems({Key? key, this.esCorto = true}) : super(key: key);

  @override
  State<TerapiasItems> createState() => _TerapiasItemsState();
}

class _TerapiasItemsState extends State<TerapiasItems> {
  var carouselController = CarouselController();
  //
  void reInit() {
    if (widget.esCorto!) {
      Reportes.exploracionFisica = Formatos.exploracionTerapiaCorta;
      Reportes.reportes['Exploracion_Fisica'] = Formatos.exploracionTerapiaCorta;
    } else {
      Reportes.exploracionFisica = Formatos.exploracionTerapia;
      Reportes.reportes['Exploracion_Fisica'] = Formatos.exploracionTerapia;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(
            color: Colors.black, textPanel: 'Valoración en Terapia Intensiva'),
        Expanded(
          flex: isDesktop(context) ? 2 : 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GrandIcon(
                  iconData: Icons.branding_watermark_outlined,
                  labelButton: 'Evaluación Neurológica y Muscular',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(0);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.bookmark_remove_outlined,
                  labelButton: 'Evaluación Ventilatoria',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(1);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.info_outline_rounded,
                  labelButton: 'Evaluación Hematoinfecciosa',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(2);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.event_available_sharp,
                  labelButton: 'Evaluación Complementaria',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(3);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 15,
          child: Padding(
            padding: EdgeInsets.all(isMobile(context) ? 5.0 : 12.0),
            child: CarouselSlider(
                items: [
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        TittlePanel(textPanel: "Evaluación Neurológica"),
                        Row(
                          children: [
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 200
                                    : isTablet(context)
                                        ? 100
                                        : isMobile(context)
                                    ? 65
                                            : 300,
                                tittle: 'R.A.S.S.',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.rass = value;
                                    reInit();
                                  });
                                },
                                items: Escalas.RASS,
                                initialValue: Exploracion.rass,
                              ),
                            ),
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 200
                                    : isTablet(context)
                                        ? 100
                                        : isMobile(context)
                                    ? 65
                                            : 300,
                                tittle: 'Ramsay',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.ramsay = value;
                                    reInit();
                                  });
                                },
                                items: Escalas.ramsay,
                                initialValue: Exploracion.ramsay,
                              ),
                            ),
                          ],
                        ),
                        Spinner(
                          width: isLargeDesktop(context) ?700
                              :  isDesktop(context)
                              ? 300
                              : isTablet(context)
                                  ? 250
                                  : isMobile(context)
                              ? 216
                                      : 300,
                          tittle: 'Sedo-analgesia',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.sedoanalgesia = value;
                              reInit();
                            });
                          },
                          items: Items.sedacion,
                          initialValue: Exploracion.sedoanalgesia,
                        ),
                        CrossLine(),
                        TittlePanel(textPanel: "Evaluación Neuromuscular"),
                        Row(
                          children: [
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 200
                                    : isTablet(context)
                                    ? 100
                                    : isMobile(context)
                                    ? 65
                                    : 300,
                                tittle: 'Asworth',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.ashworth = value;
                                    reInit();
                                  });
                                },
                                items: Escalas.ashworth,
                                initialValue: Exploracion.ashworth,
                              ),
                            ),
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 200
                                    : isTablet(context)
                                    ? 100
                                    : isMobile(context)
                                    ? 65
                                    : 300,
                                tittle: 'Daniels',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.daniels = value;
                                    reInit();
                                  });
                                },
                                items: Escalas.daniels,
                                initialValue: Exploracion.daniels,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 200
                                    : isTablet(context)
                                    ? 100
                                    : isMobile(context)
                                    ? 65
                                    : 300,
                                tittle: 'Siedel',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.siedel = value;
                                    reInit();
                                  });
                                },
                                items: Escalas.siedel,
                                initialValue: Exploracion.siedel,
                              ),
                            ),
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 200
                                    : isTablet(context)
                                    ? 100
                                    : isMobile(context)
                                    ? 65
                                    : 300,
                                tittle: 'M.R.C.',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.mrc = value;
                                    reInit();
                                  });
                                },
                                items: Escalas.MRC,
                                initialValue: Exploracion.mrc,
                              ),
                            ),
                          ],
                        ),
                         CrossLine(),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        TittlePanel(textPanel: "Evaluación Ventilatoria"),
                        Spinner(
                          width: isDesktop(context)
                              ? 200
                              : isTablet(context)
                              ? 200
                              : isMobile(context)
                              ? 216
                              : 300,
                          tittle: 'Fase ventilatoria',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.faseVentilatoria = value;
                              reInit();
                            });
                          },
                          items: Items.ventilatorio,
                          initialValue: Exploracion.faseVentilatoria,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 500
                              : isTablet(context)
                              ? 350
                              : isMobile(context)
                              ? 216
                              : 300,
                          tittle: 'Dispositivo empleado',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.dispositivoEmpleado = value;
                              reInit();
                            });
                          },
                          items: Items.dispositivosOxigeno,
                          initialValue: Exploracion.dispositivoEmpleado,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 200
                              : isTablet(context)
                              ? 200
                              : isMobile(context)
                              ? 216
                              : 300,
                          tittle: 'Tubo Endotraqueal',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.tuboEndotraqueal = value;
                              reInit();
                            });
                          },
                          items: Items.tuboendotraqueal,
                          initialValue: Exploracion.tuboEndotraqueal,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 200
                              : isTablet(context)
                              ? 200
                              : isMobile(context)
                              ? 216
                              : 300,
                          tittle: 'Distancia a arcada',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.haciaArcadaDentaria = value;
                              reInit();
                            });
                          },
                          items: Items.arcadaDentaria,
                          initialValue: Exploracion.haciaArcadaDentaria,
                        ),
                         CrossLine(),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        TittlePanel(textPanel: "Evaluación Hematoinfecciosa"),
                        Spinner(
                          width: isDesktop(context)
                              ? 200
                              : isTablet(context)
                              ? 200
                              : isMobile(context)
                              ? 216
                              : 300,
                          tittle: 'Riesgo por úlcera',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.evaluacionBraden = value;
                              reInit();
                            });
                          },
                          items: Escalas.braden,
                          initialValue: Exploracion.evaluacionBraden,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 200
                              : isTablet(context)
                              ? 200
                              : isMobile(context)
                              ? 216
                              : 300,
                          tittle: 'Riesgo por Inmovilidad',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.evaluacionNorton = value;
                              reInit();
                            });
                          },
                          items: Escalas.norton,
                          initialValue: Exploracion.evaluacionNorton,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 500
                              : isTablet(context)
                              ? 500
                              : isMobile(context)
                              ? 216
                              : 300,
                          tittle: 'Antibioticoterapia',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.antibioticoterapia = value;
                              reInit();
                            });
                          },
                          items: Items.antibioticoterapia,
                          initialValue: Exploracion.antibioticoterapia,
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        TittlePanel(textPanel: "Evaluación Complementaria"),
                        Spinner(
                          width: isDesktop(context)
                              ? 500
                              : isTablet(context)
                              ? 250
                              : isMobile(context)
                              ? 216
                              : 300,
                          tittle: 'Apoyo Aminérgico',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.apoyoAminergico = value;
                              reInit();
                            });
                          },
                          items: Items.aminergico,
                          initialValue: Exploracion.apoyoAminergico,
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(8.0),
                          decoration: ContainerDecoration.roundedDecoration(),
                          child: Row(children: [
                            Expanded(
                              child: ValuePanel(
                                heigth: 60,
                                firstText: 'Noradrenalina',

                              ),
                            ),
                            Expanded(
                              child: ValuePanel(
                                heigth: 60,
                                firstText: 'Midazolam',

                              ),
                            ),
                            Expanded(
                              child: ValuePanel(
                                heigth: 60,
                                firstText: 'Buprenorfina',

                              ),
                            ),
                          ],),
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 500
                              : isTablet(context)
                              ? 200
                              : isMobile(context)
                              ? 216
                              : 300,
                          tittle: 'Dieta Establecida',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.alimentacion = value;
                              reInit();
                            });
                          },
                          items: Items.dieta,
                          initialValue: Exploracion.alimentacion,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 170
                                    : isTablet(context)
                                    ? 200
                                    : isMobile(context)
                                    ? 216
                                    : 300,
                                tittle: 'Sonda Oro/Nasogástrica',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.tipoSondaAlimentacion = value;
                                    reInit();
                                  });
                                },
                                items: Items.orogastrico,
                                initialValue: Exploracion.tipoSondaAlimentacion,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 110
                                    : isTablet(context)
                                    ? 200
                                    : isMobile(context)
                                    ? 216
                                    : 300,
                                tittle: 'Sonda Foley',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.tipoSondaVesical = value;
                                    reInit();
                                  });
                                },
                                items: Items.foley,
                                initialValue: Exploracion.tipoSondaVesical,
                              ),
                            ),
                          ],
                        ),
                         CrossLine(),
                      ],
                    ),
                  ),
                ],
                carouselController: carouselController,
                options: Carousel.carouselOptions(context: context)),
          ),
        ),
      ],
    );
  }
}
