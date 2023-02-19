import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TerapiasItems extends StatefulWidget {
  const TerapiasItems({Key? key}) : super(key: key);

  @override
  State<TerapiasItems> createState() => _TerapiasItemsState();
}

class _TerapiasItemsState extends State<TerapiasItems> {
  var carouselController = CarouselController();
  //
  void reInit() {
    Reportes.exploracionFisica = Formatos.exploracionTerapia;
    Reportes.reportes['Exploracion_Fisica'] = Formatos.exploracionTerapia;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(
            color: Colors.black, textPanel: 'Valoración en Terapia Intensiva'),
        Expanded(
          child: SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
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
            padding: const EdgeInsets.all(12.0),
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
                                    ? 400
                                    : isTablet(context)
                                        ? 100
                                        : isMobile(context)
                                            ? 100
                                            : 300,
                                tittle: 'R.A.S.S.',
                                onChangeValue: (value) {
                                  setState(() {
                                    Valores.rass = value;
                                    reInit();
                                  });
                                },
                                items: Escalas.RASS,
                                initialValue: Valores.rass,
                              ),
                            ),
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 400
                                    : isTablet(context)
                                        ? 100
                                        : isMobile(context)
                                            ? 100
                                            : 300,
                                tittle: 'Ramsay',
                                onChangeValue: (value) {
                                  setState(() {
                                    Valores.ramsay = value;
                                    reInit();
                                  });
                                },
                                items: Escalas.ramsay,
                                initialValue: Valores.ramsay,
                              ),
                            ),
                          ],
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                                  ? 250
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Sedo-analgesia',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.sedoanalgesia = value;
                              reInit();
                            });
                          },
                          items: Items.sedacion,
                          initialValue: Valores.sedoanalgesia,
                        ),
                        const CrossLine(),
                        TittlePanel(textPanel: "Evaluación Neuromuscular"),
                        Row(
                          children: [
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 400
                                    : isTablet(context)
                                    ? 100
                                    : isMobile(context)
                                    ? 100
                                    : 300,
                                tittle: 'Asworth',
                                onChangeValue: (value) {
                                  setState(() {
                                    Valores.ashworth = value;
                                    reInit();
                                  });
                                },
                                items: Escalas.ashworth,
                                initialValue: Valores.ashworth,
                              ),
                            ),
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 400
                                    : isTablet(context)
                                    ? 100
                                    : isMobile(context)
                                    ? 100
                                    : 300,
                                tittle: 'Daniels',
                                onChangeValue: (value) {
                                  setState(() {
                                    Valores.daniels = value;
                                    reInit();
                                  });
                                },
                                items: Escalas.daniels,
                                initialValue: Valores.daniels,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 400
                                    : isTablet(context)
                                    ? 100
                                    : isMobile(context)
                                    ? 100
                                    : 300,
                                tittle: 'Siedel',
                                onChangeValue: (value) {
                                  setState(() {
                                    Valores.siedel = value;
                                    reInit();
                                  });
                                },
                                items: Escalas.siedel,
                                initialValue: Valores.siedel,
                              ),
                            ),
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 400
                                    : isTablet(context)
                                    ? 100
                                    : isMobile(context)
                                    ? 100
                                    : 300,
                                tittle: 'M.R.C.',
                                onChangeValue: (value) {
                                  setState(() {
                                    Valores.mrc = value;
                                    reInit();
                                  });
                                },
                                items: Escalas.MRC,
                                initialValue: Valores.mrc,
                              ),
                            ),
                          ],
                        ),
                        const CrossLine(),
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
                              ? 400
                              : isTablet(context)
                              ? 200
                              : isMobile(context)
                              ? 100
                              : 300,
                          tittle: 'Fase ventilatoria',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.faseVentilatoria = value;
                              reInit();
                            });
                          },
                          items: Items.ventilatorio,
                          initialValue: Valores.faseVentilatoria,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                              ? 350
                              : isMobile(context)
                              ? 100
                              : 300,
                          tittle: 'Dispositivo empleado',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.dispositivoEmpleado = value;
                              reInit();
                            });
                          },
                          items: Items.dispositivosOxigeno,
                          initialValue: Valores.dispositivoEmpleado,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                              ? 200
                              : isMobile(context)
                              ? 100
                              : 300,
                          tittle: 'Tubo Endotraqueal',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.tuboEndotraqueal = value;
                              reInit();
                            });
                          },
                          items: Items.tuboendotraqueal,
                          initialValue: Valores.tuboEndotraqueal,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                              ? 200
                              : isMobile(context)
                              ? 100
                              : 300,
                          tittle: 'Distancia a arcada',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.haciaArcadaDentaria = value;
                              reInit();
                            });
                          },
                          items: Items.arcadaDentaria,
                          initialValue: Valores.haciaArcadaDentaria,
                        ),
                        const CrossLine(),
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
                              ? 400
                              : isTablet(context)
                              ? 200
                              : isMobile(context)
                              ? 100
                              : 300,
                          tittle: 'Riesgo por úlcera',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.evaluacionBraden = value;
                              reInit();
                            });
                          },
                          items: Escalas.braden,
                          initialValue: Valores.evaluacionBraden,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                              ? 200
                              : isMobile(context)
                              ? 100
                              : 300,
                          tittle: 'Riesgo por Inmovilidad',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.evaluacionNorton = value;
                              reInit();
                            });
                          },
                          items: Escalas.norton,
                          initialValue: Valores.evaluacionNorton,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 600
                              : isTablet(context)
                              ? 300
                              : isMobile(context)
                              ? 100
                              : 300,
                          tittle: 'Antibioticoterapia',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.antibioticoterapia = value;
                              reInit();
                            });
                          },
                          items: Items.antibioticoterapia,
                          initialValue: Valores.antibioticoterapia,
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
                              ? 400
                              : isTablet(context)
                              ? 250
                              : isMobile(context)
                              ? 100
                              : 300,
                          tittle: 'Apoyo Aminérgico',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.apoyoAminergico = value;
                              reInit();
                            });
                          },
                          items: Items.aminergico,
                          initialValue: Valores.apoyoAminergico,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                              ? 200
                              : isMobile(context)
                              ? 100
                              : 300,
                          tittle: 'Dieta Establecida',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.alimentacion = value;
                              reInit();
                            });
                          },
                          items: Items.dieta,
                          initialValue: Valores.alimentacion,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                              ? 200
                              : isMobile(context)
                              ? 100
                              : 300,
                          tittle: 'Sonda Oro/Nasogástrica',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.tipoSondaAlimentacion = value;
                              reInit();
                            });
                          },
                          items: Items.orogastrico,
                          initialValue: Valores.tipoSondaAlimentacion,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                              ? 200
                              : isMobile(context)
                              ? 100
                              : 300,
                          tittle: 'Sonda Foley',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.tipoSondaVesical = value;
                              reInit();
                            });
                          },
                          items: Items.foley,
                          initialValue: Valores.tipoSondaVesical,
                        ),
                        const CrossLine(),
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
