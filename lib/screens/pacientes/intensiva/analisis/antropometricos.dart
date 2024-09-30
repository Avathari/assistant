import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/ShowText.dart';
import 'package:assistant/widgets/ThreeLabelText.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/ValuePanel.dart';
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
  var carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return TittleContainer(
      tittle: 'Análisis Antropométrico',
      color:Colors.black,
      centered: true,
      child: Column(
        children: [
          Expanded(
            flex: 8,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        ValuePanel(
                          firstText: "Sexo",
                          secondText: (Valores.sexo ?? ''),
                          padding: 1,
                        ),
                        ValuePanel(
                          firstText: 'Edad',
                          secondText: Valores.edad!.toDouble().toStringAsFixed(2),
                          thirdText: 'Años',
                        ),
                        ValuePanel(
                          firstText: 'PCT',
                          secondText: Valores.pesoCorporalTotal!.toStringAsFixed(1),
                          thirdText: 'Kg',
                        ),
                        ValuePanel(
                          firstText: 'Estatura',
                          secondText: Valores.alturaPaciente!.toStringAsFixed(2),
                          thirdText: 'mts',
                        ),
                        CrossLine(),
                        ValuePanel(
                          firstText: 'C. Cervical',
                          secondText: Valores.circunferenciaCuello!.toStringAsFixed(2),
                          thirdText: 'mm',
                        ),
                        ValuePanel(
                          firstText: 'C. Cintura',
                          secondText: Valores.circunferenciaCintura!.toStringAsFixed(2),
                          thirdText: 'mm',
                        ),
                        ValuePanel(
                          firstText: 'C. Cadera',
                          secondText: Valores.circunferenciaCadera!.toStringAsFixed(2),
                          thirdText: 'mm',
                        ),
                        CrossLine(),
                        ValuePanel(
                          firstText: 'P. M. Mesobraquial',
                          secondText: Antropometrias.perimetroMesobraquial.toStringAsFixed(1),
                          thirdText: 'cm',
                        ),
                        ValuePanel(
                          firstText: 'A. M.Mesobraquial',
                          secondText: Antropometrias.areaMesobraquial.toStringAsFixed(1),
                          thirdText: 'cm2',
                        ),
                        ValuePanel(
                          firstText: 'A. Adip. Mesobraquial',
                          secondText: Antropometrias.areaAdiposaMesobraquial.toStringAsFixed(1),
                          thirdText: 'cm2',
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 7,
                        child: TittleContainer(
                          tittle: "",
                          centered: true,
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CarouselSlider(
                                items: [
                                  SingleChildScrollView(
                                    controller: ScrollController(),
                                    child: Column(
                                      children: [
                                        ValuePanel(
                                          firstText: 'I.M.C.',
                                          secondText: Antropometrias.imc.toStringAsFixed(2),
                                          thirdText: 'Kg/m2',
                                        ),
                                        TittlePanel(
                                            textPanel: "Clase I.M.C. ${(Antropometrias.claseIMC)}"),
                                        CrossLine(),
                                        ValuePanel(
                                          firstText: 'Peso Predicho',
                                          secondText: Antropometrias.pesoCorporalPredicho.toStringAsFixed(2),
                                          thirdText: 'Kg',
                                        ),
                                        ValuePanel(
                                          firstText: 'P.C.I. (Máximo)',
                                          secondText: Antropometrias.PCIM.toStringAsFixed(2),
                                          thirdText: 'Kg',
                                        ),
                                        ValuePanel(
                                          firstText: 'P.C.I. (Broca)',
                                          secondText: Antropometrias.PCIB.toStringAsFixed(2),
                                          thirdText: 'Kg',
                                        ),
                                        ValuePanel(
                                          firstText: 'P.C.I. (Lorentz)',
                                          secondText: Antropometrias.PCIL.toStringAsFixed(2),
                                          thirdText: 'Kg',
                                        ),
                                        ValuePanel(
                                          firstText: 'P.C.I. (West)',
                                          secondText: Antropometrias.PCIW.toStringAsFixed(2),
                                          thirdText: 'Kg',
                                        ),
                                        CrossLine(),
                                        ValuePanel(
                                          firstText: 'Indice Cintura - Cadera',
                                          secondText: Antropometrias.indiceCinturaCadera.toStringAsFixed(2),
                                          thirdText: '',
                                        ),
                                      ],
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    controller: ScrollController(),
                                    child: Column(children: [
                                      ValuePanel(
                                        firstText: 'Sup. Corporal',
                                        secondText: Antropometrias.SC.toStringAsFixed(2),
                                        thirdText: 'm2',
                                      ),
                                      ValuePanel(
                                        firstText: 'Sup. Corporal Simp.',
                                        secondText: Antropometrias.SCS.toStringAsFixed(2),
                                        thirdText: 'm2',
                                      ),
                                      ValuePanel(
                                        firstText: 'SCT / Edad',
                                        secondText: Antropometrias.SCE.toStringAsFixed(2),
                                        thirdText: 'm2',
                                      ),
                                      ValuePanel(
                                        firstText: 'SCT (Haycock)',
                                        secondText: Antropometrias.SCH.toStringAsFixed(2),
                                        thirdText: 'm2',
                                      ),
                                    ]),
                                  ),
                                  SingleChildScrollView(
                                    controller: ScrollController(),
                                    child: Column(children: [
                                      ValuePanel(
                                        firstText: 'Exceso Peso Corporal',
                                        secondText: Antropometrias.excesoPesoCorporal.toStringAsFixed(2),
                                        thirdText: 'Kg',
                                      ),
                                      ValuePanel(
                                        firstText: 'PCT Ajustado',
                                        secondText: Antropometrias.pesoCorporalAjustado.toStringAsFixed(2),
                                        thirdText: 'Kg',
                                      ),
                                      ValuePanel(
                                        firstText: 'P.C.A. (IMC 25)',
                                        secondText: Antropometrias.PCB_25.toStringAsFixed(2),
                                        thirdText: 'Kg',
                                      ),
                                      ValuePanel(
                                        firstText: 'P.C.A. (IMC 30)',
                                        secondText: Antropometrias.PCB_30.toStringAsFixed(2),
                                        thirdText: 'Kg',
                                      ),
                                    ]),
                                  ),
                                  SingleChildScrollView(
                                    controller: ScrollController(),
                                    child: Row(children: [
                                      Expanded(child: Column(children: [
                                        ValuePanel(
                                          firstText: "p. C. bicipital",
                                          secondText: Valores.pliegueCutaneoBicipital!.toStringAsFixed(2),
                                          thirdText: 'mm',
                                        ),
                                        ValuePanel(
                                          firstText: "p. C.tricipital",
                                          secondText: Valores.pliegueCutaneoTricipital!.toStringAsFixed(2),
                                          thirdText: 'mm',
                                        ),
                                        ValuePanel(
                                          firstText: "p. C.escapular",
                                          secondText: Valores.pliegueCutaneoEscapular!.toStringAsFixed(2),
                                          thirdText: 'mm',
                                        ),
                                        ValuePanel(
                                          firstText: "p. C.ilíaco",
                                          secondText: Valores.pliegueCutaneoIliaco!.toStringAsFixed(2),
                                          thirdText: 'mm',
                                        ),
                                        ValuePanel(
                                          firstText: "p. C.pectoral",
                                          secondText: Valores.pliegueCutaneoPectoral!.toStringAsFixed(2),
                                          thirdText: 'mm',
                                        ),

                                      ],)),

                                      Expanded(
                                        child: Column(
                                          children: [
                                            ValuePanel(
                                              firstText: '% Grasa',
                                              secondText: Antropometrias.porcentajeGrasaCorporal.toStringAsFixed(2),
                                              thirdText: '%',
                                            ),
                                            CrossLine(),
                                            Container(
                                              decoration: ContainerDecoration.roundedDecoration(),
                                              child: ValuePanel(
                                                firstText: "Densidad Corporal",
                                                secondText: Antropometrias.densidadCorporal.toStringAsFixed(2),
                                                thirdText: '',
                                              ),
                                            ),
                                            CrossLine(),
                                            ValuePanel(
                                              firstText: 'Grasa Corporal',
                                              secondText: Antropometrias.grasaCorporalEsencial.toStringAsFixed(2),
                                              thirdText: '%',
                                            ),
                                            ValuePanel(
                                              firstText: 'GC. Esencial',
                                              secondText: Antropometrias.grasaCorporalEsencial.toStringAsFixed(2),
                                              thirdText: '%',
                                            ),
                                            ValuePanel(
                                              firstText: 'Peso Magro',
                                              secondText: Antropometrias.pesoCorporalMagro.toStringAsFixed(2),
                                              thirdText: 'Kg',
                                            ),
                                          ],
                                        ),
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
                      ),
                      Expanded(
                        child: GrandButton(
                          weigth: 2000,
                          labelButton: "Copiar en Portapapeles",
                          onPress: () {
                            Datos.portapapeles(
                                context: context, text: Antropometrias.antropometricos(isAbreviado: false));
                          },
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),

          //
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
        ],
      ),
    );
  }
}
