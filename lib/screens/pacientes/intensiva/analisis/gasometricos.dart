import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/hidrometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/gasometricos.dart' as Gas;
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/antropometricos.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/info/auxiliarGasometricos.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Gasometricos extends StatefulWidget {
  const Gasometricos({Key? key}) : super(key: key);

  @override
  State<Gasometricos> createState() => _GasometricosState();
}

class _GasometricosState extends State<Gasometricos> {
  var carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return TittleContainer(
      tittle: 'Análisis Gasométrico',
      centered: true,
      color: Colors.black,
      child: Column(
        children: [
          Expanded(child: ValuePanel(
            firstText: "",
            secondText: Valores.fechaGasometriaArterial.toString(),
            thirdText: "",
          ),),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ValuePanel(
                    firstText: "P.C.T.",
                    secondText: Valores.pesoCorporalTotal.toString(),
                    thirdText: "Kg",
                  ),
                ),
                Expanded(
                  child: ValuePanel(
                    firstText: "Est",
                    secondText: Valores.alturaPaciente.toString(),
                    thirdText: "mts",
                  ),
                ),
                Expanded(
                  child: ValuePanel(
                    firstText: "S.C.",
                    secondText: Antropometrias.SC.toStringAsFixed(2),
                    thirdText: "m2",
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Row
            (children: [
            Expanded(
              child: ValuePanel(
                firstText: "Na2+",
                secondText: Valores.sodio.toString(),
                thirdText: "mEq/L",
              ),
            ),
            Expanded(
              child: ValuePanel(
                firstText: "K+",
                secondText: Valores.potasio.toString(),
                thirdText: "mEq/L",
              ),
            ),
            Expanded(
              child: ValuePanel(
                firstText: "Cl-",
                secondText: Valores.cloro.toString(),
                thirdText: "mEq/L",
              ),
            ),
          ],),),
          Expanded(
            flex: 9,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(children: [
                    CrossLine(),
                        ValuePanel(
                          firstText: "pH",
                          secondText: Valores.pHArteriales.toString(),
                          thirdText: "",
                        ),
                        ValuePanel(
                          firstText: "PaCO2",
                          secondText: Valores.pcoArteriales.toString(),
                          thirdText: "mmHg",
                        ),
                        ValuePanel(
                          firstText: "PaO2",
                          secondText: Valores.poArteriales.toString(),
                          thirdText: "mmHg",
                        ),
                        ValuePanel(
                          firstText: "HCO3-",
                          secondText: Valores.bicarbonatoArteriales.toString(),
                          thirdText: "mmol/L",
                        ),
                        ValuePanel(
                          firstText: "EB",
                          secondText: Gas.Gasometricos.EB
                              .toStringAsFixed(2), // excesoBaseArteriales
                          thirdText: "mmol/L",
                        ),
                        ValuePanel(
                          firstText: "SaO2",
                          secondText: Valores.soArteriales.toString(),
                          thirdText: "%",
                        ),
                        ValuePanel(
                          firstText: "FiO2",
                          secondText: Valores.fioArteriales.toString(),
                          thirdText: "%",
                        ),
                        CrossLine(),
                    ValuePanel(
                      firstText: "Lactato",
                      secondText: Valores.lactatoArterial.toString(),
                      thirdText: "mmol/L",
                    ),
                    CrossLine(),
                        ValuePanel(
                          firstText: "Temp. C.",
                          secondText: Valores.temperaturCorporal.toString(),
                          thirdText: "°C",
                        ),
                        ValuePanel(
                          firstText: "Fecha",
                          secondText: Valores.fechaGasometriaArterial.toString(),
                          thirdText: "",
                        ),
                    ValuePanel(
                      firstText: "Proteinas",
                      secondText: Valores.proteinasTotales.toString(),
                      thirdText: "g/dL",
                    ),
                        CrossLine(),
                  ],),
                )),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: ContainerDecoration.roundedDecoration(),
                    margin: const EdgeInsets.all(12.0),
                    padding: const EdgeInsets.all(12.0),
                    child: CarouselSlider(
                        items: [
                          AuxiliarGasometricos.conclusionesGasometricos(),
                          AuxiliarGasometricos.analisisOxigenacion(),
                          AuxiliarGasometricos.analisisAcidoBase(),
                          AuxiliarGasometricos.analisisBicarbonato(),
                        ],
                        carouselController: carouselController,
                        options: Carousel.carouselOptions(context: context)),
                  ),
                ),
                Expanded(child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                      children: [
                        CrossLine(),
                        ValuePanel(
                          firstText: "EBesp",
                          secondText: Gas.Gasometricos.excesoBaseEsperado.toStringAsFixed(2),
                          thirdText: "mmol/L",
                        ),
                        ValuePanel(
                          firstText: "PCO2e",
                          secondText: Gas.Gasometricos.PCO2C.toStringAsFixed(2),
                          thirdText: "mmHg",
                        ),
                        CrossLine(),
                        ValuePanel(
                          firstText: "ΔCO2",
                          secondText: Gas.Gasometricos.DeltaCOS.toStringAsFixed(2),
                          thirdText: "mmHg",
                        ),
                        CrossLine(),
                        ValuePanel(
                          firstText: "TCO2",
                          secondText: Gas.Gasometricos.TCO.toStringAsFixed(2),
                          thirdText: "mmHg",
                        ),
                        ValuePanel(
                          firstText: "cPCO2",
                          secondText: Gas.Gasometricos.PCO2C.toStringAsFixed(2),
                          thirdText: "mmHg",
                        ),
                        ValuePanel(
                          firstText: "cEB",
                          secondText: Gas.Gasometricos.EBecf.toStringAsFixed(2),
                          thirdText: "mmol/L",
                        ),
                        ValuePanel(
                          firstText: "EBstd",
                          secondText: Gas.Gasometricos.EB.toStringAsFixed(2),
                          thirdText: 'mmol/L',
                        ),
                      ]
                  ),
                ))
              ],
            ),
          ),
          CrossLine(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GrandIcon(
                    iconData: Icons.add_chart,
                    labelButton: 'Análisis Gasométrico',
                    onPress: () {
                      setState(() {
                        carouselController.jumpToPage(0);
                      });
                    },
                  ),
                  GrandIcon(
                    iconData: Icons.change_circle_outlined,
                    labelButton: 'Oxigenación',
                    onPress: () {
                      setState(() {
                        carouselController.jumpToPage(1);
                      });
                    },
                  ),
                  GrandIcon(
                    iconData: Icons.settings_backup_restore,
                    labelButton: 'Complementarios',
                    onPress: () {
                      setState(() {
                        carouselController.jumpToPage(2);
                      });
                    },
                  ),
                  GrandIcon(
                    iconData: Icons.change_circle_outlined,
                    labelButton: 'Reglas del Bicarbonato',
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
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GrandIcon(
                  iconData: Icons.g_mobiledata,
                  labelButton: "Gasometricos",
                  onPress: () => Datos.portapapeles(
                      context: context, text: Gas.Gasometricos.gasometricos)),
              GrandIcon(
                  iconData: Icons.gesture,
                  labelButton: "Gasometricos Completo",
                  onPress: () => Datos.portapapeles(
                      context: context,
                      text: Gas.Gasometricos.gasometricosCompleto)),
              GrandIcon(
                  iconData: Icons.grain_sharp,
                  labelButton: "Gasometricos Medial",
                  onPress: () => Datos.portapapeles(
                      context: context,
                      text: Gas.Gasometricos.gasometricosMedial)),
              GrandIcon(
                  iconData: Icons.blinds_closed,
                  labelButton: "Reposición de Bicarbonato",
                  onPress: () => Datos.portapapeles(
                      context: context,
                      text: Gas.Gasometricos.gasometricosBicarbonato)),
              GrandIcon(
                  iconData: Icons.nest_cam_wired_stand_outlined,
                  labelButton: "Gasometricos Nombrado",
                  onPress: () => Datos.portapapeles(
                      context: context,
                      text: Gas.Gasometricos.gasometricosNombrado)),
              //
              GrandIcon(
                  iconData: Icons.grain_sharp,
                  labelButton: "Gasometrico Avanzado",
                  onPress: () => Datos.portapapeles(
                      context: context, text: Gas.Gasometricos.gasometricosAvanzado)),
            ],
          ),),
        ],
      ),
    );
  }
}
