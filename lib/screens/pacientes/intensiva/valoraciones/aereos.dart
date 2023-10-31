import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Aereas extends StatefulWidget {
  const Aereas({Key? key}) : super(key: key);

  @override
  State<Aereas> createState() => _AereasState();
}

class _AereasState extends State<Aereas> {
  var carouselController = CarouselController();
  //

  void reInit() {}

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        TittlePanel(
            color: Colors.black, textPanel: 'Valoración de la Vía Aérea'),
        Expanded(
          child: SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GrandIcon(
                  iconData: Icons.dataset,
                  labelButton: 'Parámetros Iniciales',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(0);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 5,
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
                              : isTablet(context)
                                  ? 400
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Movilidad Cervical',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.movilidadCervical = value;
                              reInit();
                            });
                          },
                          items: Escalas.movilidadCervical,
                          initialValue: Exploracion.movilidadCervical,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                              ? 400
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Distancia Tiromentoniana',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.distanciaTiromentoniana = value;
                              reInit();
                            });
                          },
                          items: Escalas.distanciaTiromentoniana,
                          initialValue: Exploracion.distanciaTiromentoniana,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                              ? 400
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Distancia Esternomentoniana',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.distanciaEsternomentoniana = value;
                              reInit();
                            });
                          },
                          items: Escalas.distanciaEsternomentoniana,
                          initialValue: Exploracion.distanciaEsternomentoniana,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                              ? 400
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Apertura Mandibular',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.aperturaMandibular = value;
                              reInit();
                            });
                          },
                          items: Escalas.aperturaMandibular,
                          initialValue: Exploracion.aperturaMandibular,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                              ? 400
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Protusión Mandibular',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.movilidadTemporoMandibular = value;
                              reInit();
                            });
                          },
                          items: Escalas.movilidadTemporoMandibular,
                          initialValue: Exploracion.movilidadTemporoMandibular,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                              ? 400
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Valoración por Mallampati',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.escalaMallampati = value;
                              reInit();
                            });
                          },
                          items: Escalas.escalaMallampati,
                          initialValue: Exploracion.escalaMallampati,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                              ? 400
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Cormack-Lahane',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.escalaCormackLahane = value;
                              reInit();
                            });
                          },
                          items: Escalas.escalaCormackLahane,
                          initialValue: Exploracion.escalaCormackLahane,
                        ),
                      ],
                    ),
                  ),
                ],
                carouselController: carouselController,
                options: CarouselOptions(
                    height: isDesktop(context) ? 1000 : 500,
                    enableInfiniteScroll: false,
                    viewportFraction: 1.0)),
          ),
        ),
      ],
    ));
  }
}
