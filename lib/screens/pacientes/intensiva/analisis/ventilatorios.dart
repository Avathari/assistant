import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/ventometr%C3%ADas.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Ventilatorios extends StatefulWidget {

  Ventilatorios({super.key});

  @override
  State<Ventilatorios> createState() => _VentilatoriosState();
}

class _VentilatoriosState extends State<Ventilatorios> {
  var carouselController = CarouselController();

  var cEstTextController = TextEditingController();

  @override
  void initState() {

    setState(() {
      //
      Valores.distensibilidadEstaticaMedida = Ventometrias
          .distensibilidadPulmonarEstatica;
    });

    Terminal.printExpected(
        message: "Ventilatorios : : \n"
            "PEEP ${Valores.presionFinalEsiracion} cmH2O\n"
            "Pplat ${Valores.presionPlateau} cmH2O\n"
            "");
    super.initState();
  }

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: isMobile(context) ? 3 : 2,
                  child: TittleContainer(
                    color: Colors.black,
                    tittle: "Generales",
                    padding: 3.0,
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ValuePanel(
                            firstText: 'Vt',
                            secondText: Valores.volumenTidal!.toStringAsFixed(0),
                            thirdText: 'mL',
                          ),
                          CrossLine(),
                          ValuePanel(
                            firstText: 'F. Vent',
                            secondText: Valores.frecuenciaVentilatoria!
                                .toStringAsFixed(0),
                            thirdText: 'Vent/min',
                          ),
                          ValuePanel(
                            firstText: 'P.E.E.P.',
                            secondText: Valores.presionFinalEsiracion!
                                .toStringAsFixed(0),
                            thirdText: 'cmH2O',
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ValuePanel(
                                  firstText: 'FiO2',
                                  secondText: Valores
                                      .fraccionInspiratoriaVentilatoria!
                                      .toStringAsFixed(0),
                                  thirdText: '%',
                                ),
                              ),
                              Expanded(
                                child: ValuePanel(
                                  firstText: 'PaO2',
                                  secondText: Valores
                                      .poArteriales!
                                      .toStringAsFixed(0),
                                  thirdText: 'mmHg',
                                ),
                              ),
                            ],
                          ),
                          ValuePanel(
                            firstText: 'PC / Psopp',
                            secondText:
                                Valores.presionControl!.toStringAsFixed(0),
                            thirdText: 'cmH2O',
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ValuePanel(
                                  firstText: 'Pplat',
                                  secondText:
                                      Valores.presionPlateau!.toStringAsFixed(0),
                                  thirdText: 'cmH2O',
                                ),
                              ),
                              Expanded(
                                child: ValuePanel(
                                  firstText: 'Pmax',
                                  secondText:
                                      Valores.presionMaxima!.toStringAsFixed(0),
                                  thirdText: 'cmH2O',
                                ),
                              ),
                            ],
                          ),
                          CrossLine(),
                          ValuePanel(
                            firstText: "PmVa",
                            secondText: Ventometrias.presionMediaViaAerea
                                .toStringAsFixed(1),
                            thirdText: "cmH2O",
                          ),
                          ValuePanel(
                            firstText: "F",
                            secondText: Ventometrias
                                .flujoVentilatorioMedido
                                .toStringAsFixed(2),
                            thirdText: "L/min",
                          ), // Flujo
                          CrossLine(),
                          ValuePanel(
                            firstText: "VTi (Cstat/Dp)",
                            secondText: Ventometrias.volumenTidalIdeal
                                .toStringAsFixed(0),
                            thirdText: "L/cmH2O",
                          ),
                          CrossLine(),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            margin: const EdgeInsets.all(5.0),
                            decoration: ContainerDecoration.roundedDecoration(),
                            child: ValuePanel(
                              firstText: "Csr",
                              secondText:
                                  Valores.distensibilidadEstaticaMedida!
                                          .toStringAsFixed(2)
                                      ,
                              thirdText: "L/cmH2O",
                              onLongPress: () {
                                Operadores.editActivity(
                                    context: context,
                                    onAcept: (value) {
                                      setState(() {
                                        Valores.distensibilidadEstaticaMedida =
                                            double.parse(value.toString());
                                      });
                                      Navigator.pop(context);
                                    });
                              },
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: isMobile(context) ? 6 : 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(
                            child: ValuePanel(
                              thirdText: 'Sexo',
                              secondText: Valores.sexo!,
                              firstText: "",
                            ),
                          ),
                          Expanded(
                            child: ValuePanel(
                              firstText: 'PCT',
                              secondText:
                                  Valores.pesoCorporalTotal!.toStringAsFixed(1),
                              thirdText: 'kG',
                            ),
                          ),
                          Expanded(
                            child: ValuePanel(
                              firstText: 'Est',
                              secondText:
                                  Valores.alturaPaciente!.toStringAsFixed(2),
                              thirdText: 'mts',
                            ),
                          ),
                          Expanded(
                            child: ValuePanel(
                              firstText: 'PP',
                              secondText: Antropometrias.pesoCorporalPredicho
                                  .toStringAsFixed(1),
                              thirdText: 'kG',
                            ),
                          ),
                          Expanded(
                            child: ValuePanel(
                              firstText: 'SC',
                              secondText: Antropometrias.SC.toStringAsFixed(0),
                              thirdText: 'm2',
                            ),
                          ),
                        ],
                      )),
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(
                            child: ValuePanel(
                              firstText: 'Vt (6)',
                              secondText: Ventometrias.volumentTidal6
                                  .toStringAsFixed(0),
                              thirdText: 'mL',
                            ),
                          ),
                          Expanded(
                            child: ValuePanel(
                              firstText: 'Vt (7)',
                              secondText: Ventometrias.volumentTidal7
                                  .toStringAsFixed(0),
                              thirdText: 'mL',
                            ),
                          ),
                          Expanded(
                            child: ValuePanel(
                              firstText: 'Vt (8)',
                              secondText: Ventometrias.volumentTidal8
                                  .toStringAsFixed(0),
                              thirdText: 'mL',
                            ),
                          ),
                        ],
                      )),
                      Expanded(
                        flex: 8,
                        child: Column(
                          children: [
                            Expanded(
                              flex: 7,
                              child: TittleContainer(
                                tittle: " ",
                                padding: 8.0,
                                color: Colors.black,
                                centered: true,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        controller: ScrollController(),
                                        child: Column(
                                            children: [
                                              ValuePanel(
                                                firstText: "VM",
                                                secondText: Ventometrias
                                                    .volumenMinuto
                                                    .toStringAsFixed(1),
                                                thirdText: "L/min",
                                              ), // Volumen Minuto
                                              ValuePanel(
                                                firstText: "Pta",
                                                secondText: Ventometrias
                                                    .presionTranspulmonar
                                                    .toStringAsFixed(2),
                                                thirdText: "cmH2O",
                                              ), // Pta : Presión Transpulmonar
                                              CrossLine(),
                                              ValuePanel(
                                                firstText: "Dp (Vt/Cstat)",
                                                secondText:
                                                    (Ventometrias.drivingPressure)
                                                        .toStringAsFixed(0),
                                                thirdText: "L/cmH2O",
                                              ),
                                              ValuePanel(
                                                firstText: "Dpres",
                                                secondText: (Ventometrias
                                                        .presionDistencion)
                                                    .toStringAsFixed(0),
                                                thirdText: "L/cmH2O",
                                              ),
                                              CrossLine(),
                                              ValuePanel(
                                                firstText: "W.O.B.",
                                                secondText: Ventometrias
                                                    .poderMecanico
                                                    .toStringAsFixed(1),
                                                thirdText: "cmH2O",
                                              ),
                                              ValuePanel(
                                                firstText: "P.d.A.",
                                                secondText: Ventometrias
                                                    .poderDistencion
                                                    .toStringAsFixed(1),
                                                thirdText: "cmH2O",
                                              ),
                                            ]),
                                      ),
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        controller: ScrollController(),
                                        child: Column(children: [
                                          ValuePanel(
                                            firstText: "R.S.B.I",
                                            secondText: Valores.indiceTobinYang
                                                .toStringAsFixed(2),
                                            thirdText: "Resp/L.seg",
                                          ),
                                          ValuePanel(
                                            firstText: "I. Vent.",
                                            secondText:
                                                Valores.IV.toStringAsFixed(1),
                                            thirdText: "",
                                          ),
                                          ValuePanel(
                                            firstText: "Ef. Vent",
                                            secondText:
                                                Valores.EV.toStringAsFixed(1),
                                            thirdText: "",
                                          ),
                                          Row(children: [
                                            Expanded(
                                              child: ValuePanel(
                                                firstText: "iO2",
                                                secondText: Valores
                                                    .indiceOxigenacion
                                                    .toStringAsFixed(2),
                                                thirdText: "",
                                              ),
                                            ),
                                            Expanded(
                                              child: ValuePanel(
                                                firstText: "iO2a",
                                                secondText: Valores
                                                    .indiceOxigenacionAdaptado
                                                    .toStringAsFixed(2),
                                                thirdText: "",
                                              ),
                                            ),
                                          ],)
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                child: Row(
                              children: [
                                // PARÁMETROS IDEALES . . .
                                Expanded(
                                  child: ValuePanel(
                                    firstText: "VMi",
                                    secondText: Ventometrias.volumenMinutoIdeal
                                        .toStringAsFixed(1),
                                    thirdText: "L/min",
                                  ),
                                ),
                                Expanded(
                                  child: ValuePanel(
                                    firstText: "FiO2i",
                                    secondText: Valores.FIOI.toStringAsFixed(0),
                                    thirdText: "%",
                                  ),
                                ),
                                Expanded(
                                  child: ValuePanel(
                                    firstText: "VENTi",
                                    secondText: Valores.VENT.toStringAsFixed(0),
                                    thirdText: "Vent/min",
                                  ),
                                ),
                              ],
                            )),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ValuePanel(
                                      firstText: "Dyst",
                                      secondText: Ventometrias
                                          .distensibilidadPulmonar
                                          .toStringAsFixed(2),
                                      thirdText: 'mL/cmH2O',
                                      withEditMessage: true,
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
                                      secondText: Ventometrias
                                          .distensibilidadPulmonarEstatica
                                          .toStringAsFixed(2),
                                      thirdText: 'mL/cmH2O',
                                    ),
                                  ),
                                  Expanded(
                                    child: ValuePanel(
                                      firstText: "Dyst Dyn",
                                      secondText: Ventometrias
                                          .distensibilidadPulmonarDinamica
                                          .toStringAsFixed(2),
                                      thirdText: 'mL/cmH2O',
                                    ),
                                  ),
                                  Expanded(
                                    child: ValuePanel(
                                      firstText: "Ryst P.",
                                      secondText: Ventometrias
                                          .resistenciaPulmonar
                                          .toStringAsFixed(2),
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
              ],
            ),
          ),
          //
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      margin: const EdgeInsets.all(3.0),
                      decoration: ContainerDecoration.roundedDecoration(),
                      child: GrandButton(
                          labelButton: Ventometrias.modoVentilatorio,
                          onPress: () {}),
                    ),
                  ),
                  Expanded(
                    child: GrandIcon(
                      iconData: Icons.update,
                      labelButton: 'Reiniciar . . . ',
                      onPress: () {
                        setState(() {});
                      },
                    ),
                  ),
                  Expanded(
                    child: CircleIcon(
                      difRadios: 11,
                      tittle: "Copiar en Portapapeles",
                      iconed: Icons.copy_all,
                      onChangeValue: () {
                        Datos.portapapeles(
                            context: context, text: Ventometrias.ventilador);
                      },
                    ),
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
