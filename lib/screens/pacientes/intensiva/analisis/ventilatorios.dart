import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Ventilatorios extends StatefulWidget {
  const Ventilatorios({Key? key}) : super(key: key);

  @override
  State<Ventilatorios> createState() => _VentilatoriosState();
}

class _VentilatoriosState extends State<Ventilatorios> {
  var carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(color: Colors.black, textPanel: 'Análisis Ventilatorio'),
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
                  labelButton: 'Presiones y Resistencias',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(1);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.settings_backup_restore,
                  labelButton: 'Volumenes y Flujos',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(2);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.compress_outlined,
                  labelButton: 'Indices de Oxigenación',
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
                  GridView(
                    padding: const EdgeInsets.all(5.0),
                    controller: ScrollController(),
                    gridDelegate: GridViewTools.gridDelegate(
                        crossAxisCount: isMobile(context) ? 3 : 3,
                        mainAxisExtent: 65),
                    children: [
                      ValuePanel(
                        firstText: 'Volumen tidal',
                        secondText: Valores.volumenTidal!.toStringAsFixed(0),
                        thirdText: 'mL',
                      ),
                      ValuePanel(
                        firstText: 'Volumen tidal (6)',
                        secondText: Valores.volumentTidal6!.toStringAsFixed(0),
                        thirdText: 'mL',
                      ),
                      ValuePanel(
                        firstText: 'Volumen tidal (7)',
                        secondText: Valores.volumentTidal7!.toStringAsFixed(0),
                        thirdText: 'mL',
                      ),
                      ValuePanel(
                        firstText: 'Volumen tidal (8)',
                        secondText: Valores.volumentTidal8!.toStringAsFixed(0),
                        thirdText: 'mL',
                      ),
                      ValuePanel(
                        firstText: 'Frecuencia Ventilatoria',
                        secondText:
                            Valores.frecuenciaVentilatoria!.toStringAsFixed(0),
                        thirdText: 'Vent/min',
                      ),
                      ValuePanel(
                        firstText: 'P.E.E.P.',
                        secondText:
                            Valores.presionFinalEsiracion!.toStringAsFixed(0),
                        thirdText: 'cmH2O',
                      ),
                      ValuePanel(
                        firstText: 'Presión máxima',
                        secondText: Valores.presionMaxima!.toStringAsFixed(0),
                        thirdText: 'cmH2O',
                      ),
                      ValuePanel(
                        firstText: 'FiO2',
                        secondText: Valores.fraccionInspiratoriaVentilatoria!
                            .toStringAsFixed(0),
                        thirdText: '%',
                      ),
                      ValuePanel(
                        firstText: 'P. Control / P. Soporte',
                        secondText: Valores.presionControl!.toStringAsFixed(0),
                        thirdText: 'cmH2O',
                      ),
                    ],
                  ),
                  GridView(
                    padding: const EdgeInsets.all(5.0),
                    controller: ScrollController(),
                    gridDelegate: GridViewTools.gridDelegate(
                        crossAxisCount: isMobile(context) ? 3 : 3,
                        mainAxisExtent: 65),
                    children: [
                      ValuePanel(
                        firstText: "PmVa",
                        secondText:
                            Valores.presionMediaViaAerea.toStringAsFixed(1),
                        thirdText: "cmH2O",
                      ),
                      ValuePanel(
                        firstText: "W.O.B.",
                        secondText: Valores.poderMecanico.toStringAsFixed(1),
                        thirdText: "cmH2O",
                      ),
                      ValuePanel(
                        firstText: "Dyst Pulmonar",
                        secondText:
                            Valores.distensibilidadPulmonar.toStringAsFixed(2),
                        thirdText: 'mL/cmH2O',
                      ),
                      ValuePanel(
                        firstText: "Dyst Est",
                        secondText: Valores.distensibilidadPulmonarEstatica
                            .toStringAsFixed(2),
                        thirdText: 'mL/cmH2O',
                      ),
                      ValuePanel(
                        firstText: "Dyst Dyn",
                        secondText: Valores.distensibilidadPulmonarDinamica
                            .toStringAsFixed(2),
                        thirdText: 'mL/cmH2O',
                      ),
                      ValuePanel(
                        firstText: "Rest. Pulmonar",
                        secondText:
                            Valores.resistenciaPulmonar.toStringAsFixed(2),
                        thirdText: 'mL/cmH2O',
                      ),
                    ],
                  ),
                  GridView(
                      padding: const EdgeInsets.all(5.0),
                      controller: ScrollController(),
                      gridDelegate: GridViewTools.gridDelegate(
                          crossAxisCount: isMobile(context) ? 3 : 3,
                          mainAxisExtent: 65),
                      children: [
                        ValuePanel(
                          firstText: "Volumen Minuto",
                          secondText: Valores.volumenMinuto.toStringAsFixed(1),
                          thirdText: "L/min",
                        ),
                        ValuePanel(
                          firstText: "Volumen Minuto Ideal",
                          secondText:
                              Valores.volumenMinutoIdeal.toStringAsFixed(1),
                          thirdText: "L/min",
                        ),
                        ValuePanel(
                          firstText: "Flujo Ventilatorio",
                          secondText: Valores.flujoVentilatorioMedido
                              .toStringAsFixed(2),
                          thirdText: "L/min",
                        ),
                      ]),
                  GridView(
                      padding: const EdgeInsets.all(5.0),
                      controller: ScrollController(),
                      gridDelegate: GridViewTools.gridDelegate(
                          crossAxisCount: isMobile(context) ? 3 : 3,
                          mainAxisExtent: 65),
                      children: [
                        ValuePanel(
                          firstText: "R.S.B.I",
                          secondText:
                              Valores.indiceTobinYang.toStringAsFixed(2),
                          thirdText: "Resp/L.seg",
                        ),
                        ValuePanel(
                          firstText: "iO2",
                          secondText:
                              Valores.indiceOxigenacion.toStringAsFixed(2),
                          thirdText: "",
                        ),
                        ValuePanel(
                          firstText: "Indice Ventilatorio",
                          secondText: Valores.IV.toStringAsFixed(1),
                          thirdText: "",
                        ),
                        ValuePanel(
                          firstText: "Ef. Vent",
                          secondText: Valores.EV.toStringAsFixed(1),
                          thirdText: "",
                        ),
                        ValuePanel(
                          firstText: "FiO2 por Ventilación",
                          secondText: Valores.VENT.toStringAsFixed(0),
                          thirdText: "%",
                        ),
                        ValuePanel(
                          firstText: "FiO2 Ideal",
                          secondText: Valores.FIOI.toStringAsFixed(0),
                          thirdText: "%",
                        ),
                        ValuePanel(
                          firstText: "Vent. Ideal",
                          secondText: Valores.FIOV.toStringAsFixed(0),
                          thirdText: "Vent/min",
                        ),
                      ]),
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
              Datos.portapapeles(context: context, text: Formatos.ventilador);
            },
          ),
        ),
      ],
    );
  }
}
