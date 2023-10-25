import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/ShowText.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/ValuePanel.dart';
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
    return Column(
      children: [
    TittlePanel(color:Colors.black, textPanel: 'Análisis Metabólico'),
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
      flex: 7,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: CarouselSlider(
            items: [
              SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: [
                    ValuePanel(
                      firstText: "Sexo",
                      secondText: (Valores.sexo ?? ''),
                      thirdText: "",
                    ),
                    const SizedBox(height: 8,),
                    Row(
                      children: [
                        Expanded(
                          child: ValuePanel(
                            firstText: 'Edad',
                            secondText: Valores.edad!.toStringAsFixed(0),
                            thirdText: 'Años',
                          ),
                        ),
                        Expanded(
                          child: ValuePanel(
                            firstText: 'Peso Corporal Total',
                            secondText: Valores.pesoCorporalTotal!.toStringAsFixed(1),
                            thirdText: 'Kg',
                          ),
                        ),
                        Expanded(
                          child: ValuePanel(
                            firstText: 'Estatura',
                            secondText: Valores.alturaPaciente!.toStringAsFixed(2),
                            thirdText: 'mts',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    CrossLine(),
                    ValuePanel(
                      firstText: 'Factor de Actividad',
                      secondText: Valores.factorActividad!.toStringAsFixed(2),
                      thirdText: '',
                    ),
                    const SizedBox(height: 8,),
                    ValuePanel(
                      firstText: 'Factor de Estrés',
                      secondText: Valores.factorEstres!.toStringAsFixed(2),
                      thirdText: '',
                    ),
                    CrossLine(),
                  ],
                ),
              ),
              SingleChildScrollView(
                controller: ScrollController(),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ValuePanel(
                            firstText: 'Gasto Energético Basal',
                            secondText: Valores.gastoEnergeticoBasal.toStringAsFixed(2),
                            thirdText: 'kCal/Día',
                          ),
                          ValuePanel(
                            firstText: 'Metabolismo Basal',
                            secondText: Valores.metabolismoBasal.toStringAsFixed(2),
                            thirdText: 'kCal/Día',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ValuePanel(
                            firstText: 'Efecto Térmico de los Alimentos',
                            secondText: Valores.efectoTermicoAlimentos.toStringAsFixed(2),
                            thirdText: 'kCal/Día',
                          ),
                          ValuePanel(
                            firstText: 'Gasto Energético Total',
                            secondText: Valores.gastoEnergeticoTotal.toStringAsFixed(2),
                            thirdText: 'kCal/Día',
                          ),
                          // CrossLine(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                controller: ScrollController(),
                child: isMobile(context) || isTablet(context) ? Column(children: [
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
                  CrossLine(),
                  ShowText(
                    title: '% Porcentual',
                    data: double.parse(Valores.sumaPorcentualMetabolicos.toString()),
                    medida: '%',
                  ),
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
                        width: 60,
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
                        width: 60,
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
                        width: 60,
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
                  CrossLine(),
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
            options: Carousel.carouselOptions(context: context)),
      ),
    ),
        Expanded(
          child: GrandButton(
            weigth: 2000,
            labelButton: "Copiar en Portapapeles",
            onPress: () {
              Datos.portapapeles(
                  context: context, text: Valorados.metabolometrias);
            },
          ),
        ),
      ],
    );
  }
}
