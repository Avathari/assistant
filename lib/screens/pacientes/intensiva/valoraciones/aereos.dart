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
                                  ? 200
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Movilidad Cervical',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.movilidadCervical = value;
                              reInit();
                            });
                          },
                          items: Escalas.movilidadCervical,
                          initialValue: Valores.movilidadCervical,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                                  ? 200
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Distancia Tiromentoniana',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.distanciaTiromentoniana = value;
                              reInit();
                            });
                          },
                          items: Escalas.distanciaTiromentoniana,
                          initialValue: Valores.distanciaTiromentoniana,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                                  ? 200
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Distancia Esternomentoniana',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.distanciaEsternomentoniana = value;
                              reInit();
                            });
                          },
                          items: Escalas.distanciaEsternomentoniana,
                          initialValue: Valores.distanciaEsternomentoniana,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                                  ? 200
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Apertura Mandibular',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.aperturaMandibular = value;
                              reInit();
                            });
                          },
                          items: Escalas.aperturaMandibular,
                          initialValue: Valores.aperturaMandibular,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                                  ? 200
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Protusión Mandibular',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.movilidadTemporoMandibular = value;
                              reInit();
                            });
                          },
                          items: Escalas.movilidadTemporoMandibular,
                          initialValue: Valores.movilidadTemporoMandibular,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                                  ? 200
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Valoración por Mallampati',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.escalaMallampati = value;
                              reInit();
                            });
                          },
                          items: Escalas.escalaMallampati,
                          initialValue: Valores.escalaMallampati,
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 400
                              : isTablet(context)
                                  ? 200
                                  : isMobile(context)
                                      ? 100
                                      : 300,
                          tittle: 'Valoración por Cormack-Lahane',
                          onChangeValue: (value) {
                            setState(() {
                              Valores.escalaCormackLahane = value;
                              reInit();
                            });
                          },
                          items: Escalas.escalaCormackLahane,
                          initialValue: Valores.escalaCormackLahane,
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
