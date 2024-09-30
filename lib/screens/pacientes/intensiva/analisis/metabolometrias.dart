import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/metabolometrias.dart';
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
  var carouselController = CarouselSliderController();

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
                            firstText: 'PCT',
                            secondText: Valores.pesoCorporalTotal!.toStringAsFixed(1),
                            thirdText: 'Kg',
                          ),
                        ),
                        Expanded(
                          child: ValuePanel(
                            firstText: 'Est',
                            secondText: Valores.alturaPaciente!.toStringAsFixed(2),
                            thirdText: 'mts',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    CrossLine(),
                    Row(
                      children: [
                        Expanded(
                          child: ValuePanel(
                            firstText: 'Factor de Actividad',
                            secondText: Valores.factorActividad!.toStringAsFixed(2),
                            thirdText: '',
                          ),
                        ),
                        Expanded(
                          child: ValuePanel(
                            firstText: 'Factor de Estrés',
                            secondText: Valores.factorEstres!.toStringAsFixed(2),
                            thirdText: '',
                          ),
                        ),
                      ],
                    ),
                    CrossLine(),
                    ValuePanel(
                      firstText: '% Grasa',
                      secondText: Antropometrias.porcentajeGrasaCorporal.toStringAsFixed(2),
                      thirdText: '%',
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ValuePanel(
                            firstText: 'P. Magro',
                            secondText: Antropometrias.pesoCorporalMagro.toStringAsFixed(2),
                            thirdText: 'kG',
                          ),
                        ),
                        Expanded(
                          child: ValuePanel(
                            firstText: 'P. Graso',
                            secondText: Antropometrias.pesoCorporalGraso.toStringAsFixed(2),
                            thirdText: 'kG',
                          ),
                        ),

                      ],
                    ),
                    ValuePanel(
                      firstText: 'PCTe',
                      secondText: (Antropometrias.pesoCorporalMagro + Antropometrias.pesoCorporalGraso).toStringAsFixed(2),
                      thirdText: 'Kg',
                    ),
                    CrossLine(),
                    Row(
                      children: [
                        Expanded(
                          child: ValuePanel(
                            firstText: 'Grasa Esencial',
                            secondText: Antropometrias.grasaCorporalEsencial.toStringAsFixed(2),
                            thirdText: 'kg',
                          ),
                        ),
                        Expanded(
                          child: ValuePanel(
                            firstText: 'Peso Calórico',
                            secondText: (Antropometrias.pesoCorporalGraso * 9).toStringAsFixed(2),
                            thirdText: 'kCal/PCG',
                          ),
                        ),
                      ],
                    ),


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
                            secondText: Metabolometrias.gastoEnergeticoBasal.toStringAsFixed(2),
                            thirdText: 'kCal/Día',
                          ),
                          ValuePanel(
                            firstText: 'Metabolismo Basal',
                            secondText: Metabolometrias.metabolismoBasal.toStringAsFixed(2),
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
                            firstText: 'E.T.A.',
                            secondText: Metabolometrias.efectoTermicoAlimentos.toStringAsFixed(2),
                            thirdText: 'kCal/Día',
                          ),
                          ValuePanel(
                            firstText: 'Gasto Energético Total',
                            secondText: Metabolometrias.gastoEnergeticoTotal.toStringAsFixed(2),
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
                        data: Metabolometrias.glucosaPorcentaje,
                        medida: 'kCal/Día',
                      ),
                      ShowText(
                        title: '',
                        data: Metabolometrias.glucosaGramos,
                        medida: 'gr/Día',
                      ),
                      Slider(
                        value: Metabolometrias
                            .porcentajeCarbohidratos.toDouble(),
                        max: 100,
                        divisions: 100,
                        label: Metabolometrias
                            .porcentajeCarbohidratos.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            Metabolometrias
                                .porcentajeCarbohidratos = value.toInt();
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ShowText(
                        title: 'Proteinas',
                        data: Metabolometrias.proteinasPorcentaje,
                        medida: 'kCal/Día',
                      ),
                      ShowText(
                        title: '',
                        data: Metabolometrias.proteinasGramos,
                        medida: 'gr/Día',
                      ),
                      Slider(
                        value: Metabolometrias
                            .porcentajeProteinas.toDouble(),
                        max: 100,
                        divisions: 100,
                        label: Metabolometrias
                            .porcentajeProteinas.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            Metabolometrias
                                .porcentajeProteinas = value.toInt();
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ShowText(
                        title: 'Lipidos',
                        data: Metabolometrias.lipidosPorcentaje,
                        medida: 'kCal/Día',
                      ),
                      ShowText(
                        title: '',
                        data: Metabolometrias.lipidosGramos,
                        medida: 'gr/Día',
                      ),
                      Slider(
                        value: Metabolometrias
                            .porcentajeLipidos.toDouble(),
                        max: 100,
                        divisions: 100,
                        label: Metabolometrias
                            .porcentajeLipidos.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            Metabolometrias
                                .porcentajeLipidos = value.toInt();
                          });
                        },
                      ),
                    ],
                  ),
                  CrossLine(),
                  ShowText(
                    title: '% Porcentual',
                    data: double.parse(Metabolometrias.sumaPorcentualMetabolicos.toString()),
                    medida: '%',
                  ),
                ],) : Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ShowText(
                        title: 'Glucosa',
                        data: Metabolometrias.glucosaPorcentaje,
                        medida: ' kCal/Día',
                      ),
                      ShowText(
                        title: '',
                        data: Metabolometrias.glucosaGramos,
                        medida: ' gr/Día',
                      ),
                      Expanded(
                        child: Slider(
                          value: Metabolometrias
                              .porcentajeCarbohidratos.toDouble(),
                          max: 100,
                          divisions: 100,
                          label: Metabolometrias
                              .porcentajeCarbohidratos.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              Metabolometrias
                                  .porcentajeCarbohidratos = value.toInt();
                            });
                          },
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ShowText(
                        title: 'Proteinas',
                        data: Metabolometrias.proteinasPorcentaje,
                        medida: ' kCal/Día',
                      ),
                      ShowText(
                        title: '',
                        data: Metabolometrias.proteinasGramos,
                        medida: ' gr/Día',
                      ),
                      Expanded(
                        child: Slider(
                          value: Metabolometrias
                              .porcentajeProteinas.toDouble(),
                          max: 100,
                          divisions: 100,
                          label: Metabolometrias
                              .porcentajeProteinas.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              Metabolometrias
                                  .porcentajeProteinas = value.toInt();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ShowText(
                        title: 'Lipidos',
                        data: Metabolometrias.lipidosPorcentaje,
                        medida: ' kCal/Día',
                      ),
                      ShowText(
                        title: '',
                        data: Metabolometrias.lipidosGramos,
                        medida: ' gr/Día',
                      ),
                      Expanded(
                        child: Slider(
                          value: Metabolometrias
                              .porcentajeLipidos.toDouble(),
                          max: 100,
                          divisions: 100,
                          label: Metabolometrias
                              .porcentajeLipidos.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              Metabolometrias
                                  .porcentajeLipidos = value.toInt();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  CrossLine(),
                  ShowText(
                    title: '% Porcentual',
                    data: double.parse(Metabolometrias.sumaPorcentualMetabolicos.toString()),
                    medida: '%',
                  ),
                ]),
              ),
              SingleChildScrollView(
                controller: ScrollController(),
                child: Column(children: [
                  ShowText(
                    title: 'Edad Metabólica',
                    data: Metabolometrias.edadMetabolica,
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
                  context: context, text: Metabolometrias.metabolometrias);
            },
          ),
        ),
      ],
    );
  }
}
