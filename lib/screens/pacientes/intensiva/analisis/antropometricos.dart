import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/ShowText.dart';
import 'package:assistant/widgets/ThreeLabelText.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Antropometricos extends StatefulWidget {
  const Antropometricos({Key? key}) : super(key: key);

  @override
  State<Antropometricos> createState() => _AntropometricosState();
}

class _AntropometricosState extends State<Antropometricos> {
  var carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(color: Colors.black, textPanel: 'Análisis Antropométrico'),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GrandIcon(
                  iconData: Icons.dataset,
                  labelButton: 'Datos Iniciales',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(0);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.add_chart,
                  labelButton: 'Indice de Masa Muscular',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(1);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.monitor_weight_outlined,
                  labelButton: 'Peso Corporal Ideal',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(2);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.compress_outlined,
                  labelButton: 'Superficie Corporal',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(3);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.line_weight_sharp,
                  labelButton: 'Peso Corporal Ajustado',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(4);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.water_drop_outlined,
                  labelButton: 'Grasa Corporal',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(5);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.area_chart_sharp,
                  labelButton: 'Areas Musculares y Adiposas',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(6);
                    });
                  },
                ),
              ],
            ),
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
                        ThreeLabelTextAline(
                          firstText: "Sexo",
                          secondText: (Valores.sexo ?? ''),
                          padding: 1,
                        ),
                        ShowText(
                          title: 'Edad',
                          data: Valores.edad!.toDouble(),
                          medida: 'Años',
                        ),
                        ShowText(
                          title: 'Peso Corporal Total',
                          data: Valores.pesoCorporalTotal,
                          medida: 'Kg',
                        ),
                        ShowText(
                          title: 'Estatura',
                          data: Valores.alturaPaciente,
                          medida: 'mts',
                        ),
                        CrossLine(),
                        ShowText(
                          title: 'C. Cervical',
                          data: Valores.circunferenciaCuello!.toDouble(),
                          medida: 'mm',
                        ),
                        ShowText(
                          title: 'C. Cintura',
                          data: Valores.circunferenciaCintura!.toDouble(),
                          medida: 'mm',
                        ),
                        ShowText(
                          title: 'C. Cadera',
                          data: Valores.circunferenciaCadera!.toDouble(),
                          medida: 'mm',
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        ShowText(
                          title: 'I.M.C.',
                          data: Valores.imc,
                          medida: 'Kg/m2',
                        ),
                        TittlePanel(
                            textPanel: "Clase I.M.C. ${(Valores.claseIMC)}"),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: [
                      ShowText(
                        title: 'Peso Predicho',
                        data: Valores.pesoCorporalPredicho,
                        medida: 'Kg',
                      ),
                      ShowText(
                        title: 'P.C.I. (Máximo)',
                        data: Valores.PCIM,
                        medida: 'Kg',
                      ),
                      ShowText(
                        title: 'P.C.I. (Broca)',
                        data: Valores.PCIB,
                        medida: 'Kg',
                      ),
                      ShowText(
                        title: 'P.C.I. (Lorentz)',
                        data: Valores.PCIL,
                        medida: 'Kg',
                      ),
                      ShowText(
                        title: 'P.C.I. (West)',
                        data: Valores.PCIW,
                        medida: 'Kg',
                      ),
                    ]),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: [
                      ShowText(
                        title: 'Sup. Corporal',
                        data: Valores.SC,
                        medida: 'm2',
                      ),
                      ShowText(
                        title: 'Sup. Corporal Simp.',
                        data: Valores.SCS,
                        medida: 'm2',
                      ),
                      ShowText(
                        title: 'Sup. Corporal para Edad',
                        data: Valores.SCE,
                        medida: 'm2',
                      ),
                      ShowText(
                        title: 'Sup. Corporal (Haycock)',
                        data: Valores.SCH,
                        medida: 'm2',
                      ),
                    ]),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: [
                      ShowText(
                        title: 'Exceso Peso Corporal',
                        data: Valores.excesoPesoCorporal,
                        medida: 'Kg',
                      ),
                      ShowText(
                        title: 'Peso Corporal Ajustado',
                        data: Valores.pesoCorporalAjustado,
                        medida: 'Kg',
                      ),
                      ShowText(
                        title: 'P.C.A. (IMC 25)',
                        data: Valores.PCB_25,
                        medida: 'Kg',
                      ),
                      ShowText(
                        title: 'P.C.A. (IMC 30)',
                        data: Valores.PCB_30,
                        medida: 'Kg',
                      ),
                    ]),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: [
                      ShowText(
                        title: 'Grasa Corporal',
                        data: Valores.grasaCorporalEsencial,
                        medida: '%',
                      ),
                      ShowText(
                        title: 'Grasa Corporal Esencial',
                        data: Valores.grasaCorporalEsencial,
                        medida: '%',
                      ),
                      ShowText(
                        title: 'Peso Magro',
                        data: Valores.masaMuscularMagra,
                        medida: 'Kg',
                      ),
                      ShowText(
                        title: 'Indice Cintura - Cadera',
                        data: Valores.indiceCinturaCadera,
                        medida: '',
                      ),
                    ]),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: [
                      ShowText(
                        title: 'P. Muscular Mesobraquial',
                        data: Valores.perimetroMesobraquial,
                        medida: 'cm',
                      ),
                      ShowText(
                        title: 'A. Muscular Mesobraquial',
                        data: Valores.areaMesobraquial,
                        medida: 'cm2',
                      ),
                      ShowText(
                        title: 'A. Adiposa Mesobraquial',
                        data: Valores.areaAdiposaMesobraquial,
                        medida: 'cm2',
                      ),
                    ]),
                  ),
                ],
                carouselController: carouselController,
                options: CarouselOptions(
                    height: 500,
                    enableInfiniteScroll: false,
                    viewportFraction: 1.0)),
          ),
        ),
        Expanded(
          child: GrandButton(
            weigth: 2000,
            labelButton: "Copiar en Portapapeles",
            onPress: () {
              Datos.portapapeles(
                  context: context, text: Valorados.antropometricos(isAbreviado: false));
            },
          ),
        ),
      ],
    );
  }
}
