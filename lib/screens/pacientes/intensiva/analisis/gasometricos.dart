import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/GridLayout.dart';
import 'package:assistant/widgets/ShowText.dart';
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
    return Column(
      children: [
        TittlePanel(color: Colors.black, textPanel: 'Análisis Gasométrico'),
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
                  labelButton: 'Análisis Gasométrico',
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
                  iconData: Icons.compress_outlined,
                  labelButton: 'Compensación',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(3);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.change_circle_outlined,
                  labelButton: 'Oxigenación',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(4);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.water_drop_outlined,
                  labelButton: 'Perfil Metabólico',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(5);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.change_circle_outlined,
                  labelButton: 'Reglas del Bicarbonato',
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
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CarouselSlider(
                items: [
                  GridView(
                    padding: const EdgeInsets.all(5.0),
                    controller: ScrollController(),
                    gridDelegate: GridViewTools.gridDelegate(
                        crossAxisCount: isMobile(context) ? 3 : 5,
                        mainAxisExtent: 65), //46
                    children: [
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
                        secondText: Valores.EB.toStringAsFixed(2), // excesoBaseArteriales
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
                      ValuePanel(
                        firstText: "SaO2",
                        secondText: Valores.soArteriales.toString(),
                        thirdText: "%",
                      ),
                      CrossLine(),
                      ValuePanel(
                        firstText: "Temp. C.",
                        secondText: Valores.temperaturCorporal.toString(),
                        thirdText: "°C",
                      ),
                      CrossLine(),
                      CrossLine(),
                      ValuePanel(
                        firstText: "Fecha",
                        secondText: Valores.fechaGasometriaArterial.toString(),
                        thirdText: "",
                      ),
                      CrossLine(),
                    ],
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        TittlePanel(
                            textPanel:
                                "Trastorno Primario \n${Valores.trastornoPrimario} (pH ${Valores.pHArteriales})"),
                        TittlePanel(
                            textPanel:
                                "Trastorno Secundario \n${Valores.trastornoSecundario} (PCO2 ${Valores.pcoArteriales!.toStringAsFixed(0)})"),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: GridLayout(
                        columnCount: isMobile(context) ? 1 : 2,
                        children: [
                          TittlePanel(
                              textPanel:
                                  "Alteración del Oxígeno \n${Valores.trastornoTerciario} (pO2 ${Valores.poArteriales!.toStringAsFixed(0)})"),
                          TittlePanel(
                              textPanel:
                                  "Alteración del CO2 \n${Valores.alteracionRespiratoria} (HCO3- ${Valores.pcoArteriales})"),
                          TittlePanel(
                              textPanel:
                                  "Alteración por Bases \n${Valores.trastornoBases} (EB ${Valores.EB.toStringAsFixed(2)})"),
                          TittlePanel(
                              textPanel:
                                  "Alteración del Anion Gap \n${Valores.trastornoGap} (GAP ${Valores.GAP.toStringAsFixed(0)})"),
                        ]),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: [
                      ShowText(
                        title: 'EB Esperado',
                        data: Valores.EBb,
                        medida: 'mmol/L',
                      ),
                      ShowText(
                        title: 'PCO2 Esperado',
                        data: Valores.PCO2C,
                        medida: 'mmHg',
                      ),
                      ShowText(
                        title: 'TCO2',
                        data: Valores.TCO,
                        medida: 'mmHg',
                      ),
                      ShowText(
                        title: 'PCO2 Corregido',
                        data: Valores.PCO2C,
                        medida: 'mmHg',
                      ),
                      ShowText(
                        title: 'EB Corregido',
                        data: Valores.EBecf,
                        medida: 'mmol/L',
                      ),
                      ShowText(
                        title: 'EB Estándar',
                        data: Valores.EB,
                        medida: 'mmol/L',
                      ),
                    ]),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: [
                      ShowText(
                        title: 'Indice PAFI',
                        data: Valores.PAFI,
                        medida: '',
                      ),
                      ShowText(
                        title: 'Indice SAFI',
                        data: Valores.SAFI,
                        medida: '',
                      ),
                      ShowText(
                        title: 'PAO2',
                        data: Valores.PAO,
                        medida: 'mmHg',
                      ),
                      ShowText(
                        title: 'Aa-O2',
                        data: Valores.GAA,
                        medida: 'mmHg',
                      ),
                      ShowText(
                        title: 'Dif. Aa-O2',
                        data: Valores.DAA,
                        medida: 'mmHg',
                      ),
                      ShowText(
                        title: 'Relación PaO2/PAO2',
                        data: Valores.PaO2PAO2,
                        medida: 'mmHg',
                      ),
                    ]),
                  ),
                  GridView(
                    padding: const EdgeInsets.all(5.0),
                    controller: ScrollController(),
                    gridDelegate: GridViewTools.gridDelegate(
                        crossAxisCount: isMobile(context) ? 3 : 5,
                        mainAxisExtent: 65), //46
                    children: [
                      ValuePanel(
                        firstText: "Osm",
                        secondText: Valores.osmolaridadSerica.toStringAsFixed(0),
                        thirdText: "mOsm//L",
                      ),
                      ValuePanel(
                        firstText: "Osm Gap",
                        secondText: Valores.GAPO.toStringAsFixed(0),
                        thirdText: "mOsm/L",
                      ),
                      ValuePanel(
                        firstText: "a-GAP",
                        secondText: Valores.GAP.toStringAsFixed(0),
                        thirdText: "",
                      ),
                      ValuePanel(
                        firstText: "Delta GAP",
                        secondText: Valores.d_GAP.toStringAsFixed(2),
                        thirdText: "",
                      ),
                      CrossLine(),
                      ValuePanel(
                        firstText: "Delta-Delta GAP",
                        secondText: Valores.D_d_GAP.toStringAsFixed(2),
                        thirdText: "",
                      ),
                      ValuePanel(
                        firstText: "Dif. Aniones Libres",
                        secondText: Valores.DIF.toStringAsFixed(2),
                        thirdText: "",
                      ),
                      CrossLine(),
                      ValuePanel(
                        firstText: "Efecto Buffer",
                        secondText: Valores.EBvGilFix.toStringAsFixed(2),
                        thirdText: "",
                      ),
                      ValuePanel(
                        firstText: "Dif. Anionica",
                        secondText: Valores.DA.toStringAsFixed(2),
                        thirdText: "",
                      ),
                      ValuePanel(
                        firstText: "Verdaero Déf Base",
                        secondText: Valores.VDb.toStringAsFixed(2),
                        thirdText: "",
                      ),
                      ValuePanel(
                        firstText: "[H+]",
                        secondText: Valores.H.toStringAsFixed(2),
                        thirdText: "",
                      ),
                      CrossLine(),
                      ValuePanel(
                        firstText: "pH[]",
                        secondText: Valores.PH.toStringAsFixed(2),
                        thirdText: "",
                      ),
                      CrossLine(),
                    ],
                  ),
                  GridView(
                    padding: const EdgeInsets.all(5.0),
                    controller: ScrollController(),
                    gridDelegate: GridViewTools.gridDelegate(
                        crossAxisCount: isMobile(context) ? 3 : 5,
                        mainAxisExtent: 65), //46
                    children: [
                      ValuePanel(
                        firstText: "1ra HCO3-",
                        secondText: Valores.HCOR_a.toString(),
                        thirdText: "",
                      ),
                      ValuePanel(
                        firstText: "2da HCO3-",
                        secondText: Valores.HCOR_b.toStringAsFixed(2),
                        thirdText: "",
                      ),
                      ValuePanel(
                        firstText: "3ra HCO3-",
                        secondText: Valores.HCOR_c.toStringAsFixed(2),
                        thirdText: "mEq/L",
                      ),
                      CrossLine(),
                      CrossLine(),
                      CrossLine(),
                      ValuePanel(
                        firstText: "Def. HCO3-",
                        secondText: Valores.deficitBicarbonato.toStringAsFixed(2),
                        thirdText: "mEq/L",
                      ),
                      CrossLine(),
                      ValuePanel(
                        firstText: "Def. HCO3- (Astrup)",
                        secondText: Valores.HCOAM.toStringAsFixed(2),
                        thirdText: "mEq/L",
                      ),

                      ValuePanel(
                        firstText: "Rep. HCO3-",
                        secondText: Valores.VHCOAM.toStringAsFixed(2),
                        thirdText: "mEq/L",
                      ),
                      CrossLine(),
                      ValuePanel(
                        firstText: "No. Amp. HCO3-",
                        secondText: Valores.NOAMP.toStringAsFixed(0),
                        thirdText: "amp al 7.5%",
                      ),
                    ],
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
    );
  }
}
