import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/ventometr%C3%ADas.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/TittleContainer.dart';
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
    return TittleContainer(
      tittle: "Análisis Ventilatorio",
      color: Colors.black,
      centered: true,
      child: Column(
        children: [
          Expanded(
            flex: 8,
            child: Row(
              children: [
                Expanded(
                  flex: isMobile(context)? 3: 2,
                  child: TittleContainer(
                    color: Colors.black,
                    tittle: "Datos Generales",
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: Column(children: [
                            ValuePanel(
                              firstText: 'Vt',
                              secondText: Valores.volumenTidal!.toStringAsFixed(0),
                              thirdText: 'mL',
                            ),
                            ValuePanel(
                              firstText: 'Vt (6)',
                              secondText: Ventometrias.volumentTidal6.toStringAsFixed(0),
                              thirdText: 'mL',
                            ),
                            ValuePanel(
                              firstText: 'Vt (7)',
                              secondText: Ventometrias.volumentTidal7.toStringAsFixed(0),
                              thirdText: 'mL',
                            ),
                            ValuePanel(
                              firstText: 'Vt (8)',
                              secondText: Ventometrias.volumentTidal8.toStringAsFixed(0),
                              thirdText: 'mL',
                            ),
                            ValuePanel(
                              firstText: 'F. Vent',
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
                              firstText: 'Pmax',
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
                              firstText: 'PC / Psopp',
                              secondText: Valores.presionControl!.toStringAsFixed(0),
                              thirdText: 'cmH2O',
                            ),

                      ],),
                    ),
                  ),
                ),
                Flexible(
                  flex: isMobile(context)? 6: 5,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 7,
                        child: TittleContainer(
                          tittle: " ",
                          color: Colors.black,
                          centered: true,
                          child: Row(
                            children: [
                              Expanded(
                                child: Wrap(
                                    children: [
                                      ValuePanel(
                                        firstText: "VM",
                                        secondText: Ventometrias.volumenMinuto.toStringAsFixed(1),
                                        thirdText: "L/min",
                                      ),
                                      ValuePanel(
                                        firstText: "VMi",
                                        secondText:
                                        Ventometrias.volumenMinutoIdeal.toStringAsFixed(1),
                                        thirdText: "L/min",
                                      ),
                                      ValuePanel(
                                        firstText: "F",
                                        secondText: Ventometrias.flujoVentilatorioMedido
                                            .toStringAsFixed(2),
                                        thirdText: "L/min",
                                      ),
                                      CrossLine(),
                                      ValuePanel(
                                        firstText: "VTi (Cstat/Dp)",
                                        secondText: Ventometrias.volumenTidalIdeal
                                            .toStringAsFixed(0),
                                        thirdText: "L/cmH2O",
                                      ),
                                      ValuePanel(
                                        firstText: "Dp (Vt/Cstat)",
                                        secondText: (Ventometrias.drivingPressure * -1.0)
                                            .toStringAsFixed(2),
                                        thirdText: "L/cmH2O",
                                      ),
                                    ]),
                              ),
                              Expanded(
                                child: Wrap(
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
                                        firstText: "I. Vent.",
                                        secondText: Valores.IV.toStringAsFixed(1),
                                        thirdText: "",
                                      ),
                                      ValuePanel(
                                        firstText: "Ef. Vent",
                                        secondText: Valores.EV.toStringAsFixed(1),
                                        thirdText: "",
                                      ),
                                      ValuePanel(
                                        firstText: "FiO2 Vent",
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
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              child: ValuePanel(
                                firstText: "PmVa",
                                secondText:
                                Ventometrias.presionMediaViaAerea.toStringAsFixed(1),
                                thirdText: "cmH2O",
                              ),
                            ),
                            Expanded(
                              child: ValuePanel(
                                firstText: "W.O.B.",
                                secondText: Ventometrias.poderMecanico.toStringAsFixed(1),
                                thirdText: "cmH2O",
                              ),
                            ),
                            Expanded(
                              child: ValuePanel(
                                firstText: "Dyst",
                                secondText:
                                Ventometrias.distensibilidadPulmonar.toStringAsFixed(2),
                                thirdText: 'mL/cmH2O',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              child: ValuePanel(
                                firstText: "Dyst Est",
                                secondText: Ventometrias.distensibilidadPulmonarEstatica
                                    .toStringAsFixed(2),
                                thirdText: 'mL/cmH2O',
                              ),
                            ),
                            Expanded(
                              child: ValuePanel(
                                firstText: "Dyst Dyn",
                                secondText: Ventometrias.distensibilidadPulmonarDinamica
                                    .toStringAsFixed(2),
                                thirdText: 'mL/cmH2O',
                              ),
                            ),
                            Expanded(
                              child: ValuePanel(
                                firstText: "Ryst P.",
                                secondText:
                                Ventometrias.resistenciaPulmonar.toStringAsFixed(2),
                                thirdText: 'mL/cmH2O',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GrandButton(
              weigth: 2000,
              labelButton: "Copiar en Portapapeles",
              onPress: () {
                Datos.portapapeles(context: context, text: Ventometrias.ventilador);
              },
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
                    iconData: Icons.add_chart,
                    labelButton: 'Presiones y Resistencias',
                    onPress: () {
                      setState(() {
                        carouselController.jumpToPage(0);
                      });
                    },
                  ),
                  GrandIcon(
                    iconData: Icons.settings_backup_restore,
                    labelButton: 'Volumenes y Flujos',
                    onPress: () {
                      setState(() {
                        carouselController.jumpToPage(1);
                      });
                    },
                  ),
                  GrandIcon(
                    iconData: Icons.compress_outlined,
                    labelButton: 'Indices de Oxigenación',
                    onPress: () {
                      setState(() {
                        carouselController.jumpToPage(2);
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
