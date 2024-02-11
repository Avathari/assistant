import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/hidrometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/gasometricos.dart' as Gas;
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
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
          Expanded(
            flex: 7,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Wrap(children: [
                      ValuePanel(
                        firstText: "P.C.T.",
                        secondText: Valores.pesoCorporalTotal.toString(),
                        thirdText: "Kg",
                      ),
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
                        firstText: "Temp. C.",
                        secondText: Valores.temperaturCorporal.toString(),
                        thirdText: "°C",
                      ),
                      ValuePanel(
                        firstText: "Fecha",
                        secondText: Valores.fechaGasometriaArterial.toString(),
                        thirdText: "",
                      ),
                      CrossLine(),
                ],)),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: ContainerDecoration.roundedDecoration(),
                    margin: const EdgeInsets.all(12.0),
                    padding: const EdgeInsets.all(12.0),
                    child: CarouselSlider(
                        items: [
                          SingleChildScrollView(
                            controller: ScrollController(),
                            child: Column(
                              children: [
                                TittlePanel(
                                    textPanel:
                                        "Trastorno Primario \n${Gas.Gasometricos.trastornoPrimario} (pH ${Valores.pHArteriales})"),
                                TittlePanel(
                                    textPanel:
                                        "Trastorno Secundario \n${Gas.Gasometricos.trastornoSecundario} (PCO2 ${Valores.pcoArteriales!.toStringAsFixed(0)})"),
                                CrossLine(thickness: 4,),
                                TittlePanel(
                                    textPanel:
                                    "Alteración del Oxígeno \n${Gas.Gasometricos.trastornoTerciario} (pO2 ${Valores.poArteriales!.toStringAsFixed(0)})"),
                                TittlePanel(
                                    textPanel:
                                    "Alteración del CO2 \n${Gas.Gasometricos.alteracionRespiratoria} (HCO3- ${Valores.pcoArteriales})"),
                                TittlePanel(
                                    textPanel:
                                    "Alteración por Bases \n${Gas.Gasometricos.trastornoBases} (EB ${Gas.Gasometricos.EB.toStringAsFixed(2)})"),
                                TittlePanel(
                                    textPanel:
                                    "Alteración del Anion Gap \n${Gas.Gasometricos.trastornoGap} (GAP ${Gas.Gasometricos.GAP.toStringAsFixed(0)})"),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            controller: ScrollController(),
                            child: Column(
                                children: [
                                  ValuePanel(
                                    firstText: "PAFI",
                                    secondText: Gas.Gasometricos.PAFI.toStringAsFixed(0),
                                    thirdText: "",
                                  ),
                                  ValuePanel(
                                    firstText: "SAFI",
                                    secondText: Gas.Gasometricos.SAFI.toStringAsFixed(2),
                                    thirdText: "",
                                  ),
                                  ValuePanel(
                                    firstText: "PAO2",
                                    secondText: Gas.Gasometricos.PAO.toStringAsFixed(2),
                                    thirdText: "mmHg",
                                  ),
                                  ValuePanel(
                                    firstText: "Aa-O2",
                                    secondText: Gas.Gasometricos.GAA.toStringAsFixed(2),
                                    thirdText: "mmHg",
                                  ),
                                  ValuePanel(
                                    firstText: "DAa-O2",
                                    secondText: Gas.Gasometricos.DAA.toStringAsFixed(2),
                                    thirdText: "mmHg",
                                  ),
                                  ValuePanel(
                                    firstText: "PaO2/PAO2",
                                    secondText: Gas.Gasometricos.PaO2PAO2.toStringAsFixed(2),
                                    thirdText: "mmHg",
                                  ),
                                ]),
                          ),
                          SingleChildScrollView(
                            controller: ScrollController(),
                            child: Column(
                              children: [
                                ValuePanel(
                                  firstText: "Osm",
                                  secondText:
                                      Hidrometrias.osmolaridadSerica.toStringAsFixed(0),
                                  thirdText: "mOsm//L",
                                ),
                                ValuePanel(
                                  firstText: "Osm Gap",
                                  secondText: Gas.Gasometricos.GAPO.toStringAsFixed(0),
                                  thirdText: "mOsm/L",
                                ),
                                ValuePanel(
                                  firstText: "a-GAP",
                                  secondText: Gas.Gasometricos.GAP.toStringAsFixed(0),
                                  thirdText: "",
                                ),
                                ValuePanel(
                                  firstText: "Delta GAP",
                                  secondText: Gas.Gasometricos.d_GAP.toStringAsFixed(2),
                                  thirdText: "",
                                ),
                                CrossLine(),
                                ValuePanel(
                                  firstText: "Delta-Delta GAP",
                                  secondText: Gas.Gasometricos.D_d_GAP.toStringAsFixed(2),
                                  thirdText: "",
                                ),
                                ValuePanel(
                                  firstText: "Dif. Aniones Libres",
                                  secondText: Gas.Gasometricos.DIF.toStringAsFixed(2),
                                  thirdText: "",
                                ),
                                CrossLine(),
                                ValuePanel(
                                  firstText: "Efecto Buffer",
                                  secondText: Gas.Gasometricos.EBvGilFix.toStringAsFixed(2),
                                  thirdText: "",
                                ),
                                ValuePanel(
                                  firstText: "Dif. Anionica",
                                  secondText: Gas.Gasometricos.DA.toStringAsFixed(2),
                                  thirdText: "",
                                ),
                                ValuePanel(
                                  firstText: "Verdaero Déf Base",
                                  secondText: Gas.Gasometricos.VDb.toStringAsFixed(2),
                                  thirdText: "",
                                ),
                                ValuePanel(
                                  firstText: "[H+]",
                                  secondText: Gas.Gasometricos.H.toStringAsFixed(2),
                                  thirdText: "",
                                ),
                                CrossLine(),
                                ValuePanel(
                                  firstText: "pH[]",
                                  secondText: Gas.Gasometricos.PH.toStringAsFixed(2),
                                  thirdText: "",
                                ),
                                CrossLine(),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            controller: ScrollController(),
                            child: Column(
                              children: [
                                ValuePanel(
                                  firstText: "1ra HCO3-",
                                  secondText: Gas.Gasometricos.HCOR_a.toString(),
                                  thirdText: "",
                                ),
                                ValuePanel(
                                  firstText: "2da HCO3-",
                                  secondText: Gas.Gasometricos.HCOR_b.toStringAsFixed(2),
                                  thirdText: "",
                                ),
                                ValuePanel(
                                  firstText: "3ra HCO3-",
                                  secondText: Gas.Gasometricos.HCOR_c.toStringAsFixed(2),
                                  thirdText: "mEq/L",
                                ),
                                CrossLine(),
                                ValuePanel(
                                  firstText: "Def. HCO3-",
                                  secondText:
                                  Gas.Gasometricos.deficitBicarbonato.toStringAsFixed(2),
                                  thirdText: "mEq/L",
                                ),
                                CrossLine(),
                                ValuePanel(
                                  firstText: "Def. HCO3- (Astrup)",
                                  secondText: Gas.Gasometricos.HCOAM.toStringAsFixed(2),
                                  thirdText: "mEq/L",
                                ),
                                ValuePanel(
                                  firstText: "Rep. HCO3-",
                                  secondText: Gas.Gasometricos.VHCOAM.toStringAsFixed(2),
                                  thirdText: "mEq/L",
                                ),
                                CrossLine(),
                                ValuePanel(
                                  firstText: "No. Amp. HCO3-",
                                  secondText: Gas.Gasometricos.NOAMP.toStringAsFixed(0),
                                  thirdText: "amp al 7.5%",
                                ),
                              ],
                            ),
                          ),
                        ],
                        carouselController: carouselController,
                        options: Carousel.carouselOptions(context: context)),
                  ),
                ),
                Expanded(child: Wrap(
                    children: [
                      ValuePanel(
                        firstText: "EB Esperado",
                        secondText: Gas.Gasometricos.EBb.toStringAsFixed(2),
                        thirdText: "mmol/L",
                      ),
                      ValuePanel(
                        firstText: "PCO2 Esperado",
                        secondText: Gas.Gasometricos.PCO2C.toStringAsFixed(2),
                        thirdText: "mmHg",
                      ),
                      ValuePanel(
                        firstText: "TCO2",
                        secondText: Gas.Gasometricos.TCO.toStringAsFixed(2),
                        thirdText: "mmHg",
                      ),
                      ValuePanel(
                        firstText: "PCO2 Corregido",
                        secondText: Gas.Gasometricos.PCO2C.toStringAsFixed(2),
                        thirdText: "mmHg",
                      ),
                      ValuePanel(
                        firstText: "EB Corregido",
                        secondText: Gas.Gasometricos.EBecf.toStringAsFixed(2),
                        thirdText: "mmol/L",
                      ),
                      ValuePanel(
                        firstText: "EB Estándar",
                        secondText: Gas.Gasometricos.EB.toStringAsFixed(2),
                        thirdText: 'mmol/L',
                      ),
                    ]
                ))
              ],
            ),
          ),
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
          Expanded(child: Wrap(
            spacing: 20,
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
            ],
          ),), 
          // Expanded(
          //   child: GrandButton(
          //     weigth: 2000,
          //     labelButton: "Copiar en Portapapeles",
          //     onPress: () {
          //       Datos.portapapeles(
          //           context: context, text: Gas.Gasometricos.gasometricos);
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
