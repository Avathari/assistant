import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/ShowText.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/ThreeLabelText.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Metabolicos extends StatefulWidget {
  const Metabolicos({Key? key}) : super(key: key);

  @override
  State<Metabolicos> createState() => _MetabolicosState();
}

class _MetabolicosState extends State<Metabolicos> {
  var carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        TittlePanel(textPanel: 'Análisis Metabólico'),
        Expanded(
          child: SingleChildScrollView(
            controller: ScrollController(),
            scrollDirection: Axis.horizontal,
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
                  labelButton: 'Análisis Energético',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(1);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.settings_backup_restore,
                  labelButton: 'Distribución de Macronutrientes',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(2);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.compress_outlined,
                  labelButton: 'Edad Metabólica',
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
          flex: 5,
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
                          fractionDigits: 0,
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
                        const CrossLine(),
                        ShowText(
                          title: 'Factor de Actividad',
                          data: Valores.factorActividad,
                          medida: '',
                        ),
                        ShowText(
                          title: 'Factor de Estrés',
                          data: Valores.factorEstres,
                          medida: '',
                        ),
                        const CrossLine(),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        ShowText(
                          title: 'Gasto Energético Basal',
                          data: Valores.gastoEnergeticoBasal,
                          medida: 'kCal/Día',
                        ),
                        ShowText(
                          title: 'Metabolismo Basal',
                          data: Valores.metabolismoBasal,
                          medida: 'kCal/Día',
                        ),
                        ShowText(
                          title: 'Efecto Térmico de los Alimentos',
                          data: Valores.efectoTermicoAlimentos,
                          medida: 'kCal/Día',
                        ),
                        ShowText(
                          title: 'Gasto Energético Total',
                          data: Valores.gastoEnergeticoTotal,
                          medida: 'kCal/Día',
                        ),
                        const CrossLine(),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: isMobile(context)? Row(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ShowText(
                            title: 'Glucosa',
                            data: Valores.glucosaPorcentaje,
                            medida: 'kCal/Día',
                          ),
                          ShowText(
                            title: '',
                            data: Valores.glucosaGramos,
                            medida: 'gr/Día',
                          ),
                          Spinner(
                            tittle: 'Constante',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.porcentajeCarbohidratos =
                                    int.parse(value);
                              });
                            },
                            items: List<String>.generate(
                                100, (i) => (i + 1).toString()),
                            initialValue:
                            Valores.porcentajeCarbohidratos.toString(),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ShowText(
                            title: 'Proteinas',
                            data: Valores.proteinasPorcentaje,
                            medida: 'kCal/Día',
                          ),
                          ShowText(
                            title: '',
                            data: Valores.proteinasGramos,
                            medida: 'gr/Día',
                          ),
                          Spinner(
                            tittle: 'Constante',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.porcentajeProteinas =
                                    int.parse(value);
                              });
                            },
                            items: List<String>.generate(
                                100, (i) => (i + 1).toString()),
                            initialValue:
                            Valores.porcentajeProteinas.toString(),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ShowText(
                            title: 'Lipidos',
                            data: Valores.lipidosPorcentaje,
                            medida: 'kCal/Día',
                          ),
                          ShowText(
                            title: '',
                            data: Valores.lipidosGramos,
                            medida: 'gr/Día',
                          ),
                          Spinner(
                            tittle: 'Constante',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.porcentajeLipidos =
                                    int.parse(value);
                              });
                            },
                            items: List<String>.generate(
                                100, (i) => (i + 1).toString()),
                            initialValue:
                            Valores.porcentajeLipidos.toString(),
                          ),
                        ],
                      ),
                      const CrossLine(),
                    ],) : Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ShowText(
                            title: 'Glucosa',
                            data: Valores.glucosaPorcentaje,
                            medida: 'kCal/Día',
                          ),
                          ShowText(
                            title: '',
                            data: Valores.glucosaGramos,
                            medida: 'gr/Día',
                          ),
                          Spinner(
                            tittle: 'Constante',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.porcentajeCarbohidratos =
                                    int.parse(value);
                              });
                            },
                            items: List<String>.generate(
                                100, (i) => (i + 1).toString()),
                            initialValue:
                            Valores.porcentajeCarbohidratos.toString(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ShowText(
                            title: 'Proteinas',
                            data: Valores.proteinasPorcentaje,
                            medida: 'kCal/Día',
                          ),
                          ShowText(
                            title: '',
                            data: Valores.proteinasGramos,
                            medida: 'gr/Día',
                          ),
                          Spinner(
                            tittle: 'Constante',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.porcentajeProteinas =
                                    int.parse(value);
                              });
                            },
                            items: List<String>.generate(
                                100, (i) => (i + 1).toString()),
                            initialValue:
                            Valores.porcentajeProteinas.toString(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ShowText(
                            title: 'Lipidos',
                            data: Valores.lipidosPorcentaje,
                            medida: 'kCal/Día',
                          ),
                          ShowText(
                            title: '',
                            data: Valores.lipidosGramos,
                            medida: 'gr/Día',
                          ),
                          Spinner(
                            tittle: 'Constante',
                            onChangeValue: (value) {
                              setState(() {
                                Valores.porcentajeLipidos =
                                    int.parse(value);
                              });
                            },
                            items: List<String>.generate(
                                100, (i) => (i + 1).toString()),
                            initialValue:
                            Valores.porcentajeLipidos.toString(),
                          ),
                        ],
                      ),
                      const CrossLine(),
                      ShowText(
                        title: '% Porcentual',
                        data: double.parse(Valores.sumaPorcentualMetabolicos.toString()),
                        medida: '%',
                      ),
                    ]),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: [
                      ShowText(
                        title: 'Edad Metabólica',
                        data: Valores.edadMetabolica,
                        medida: 'Años',
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
      ],
    ));
  }
}
