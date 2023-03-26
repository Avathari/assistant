import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandButton.dart';
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
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: CarouselSlider(
                items: [
                  GridView(
                    padding: const EdgeInsets.all(5.0),
                    controller: ScrollController(),
                    gridDelegate: GridViewTools.gridDelegate(
                        crossAxisCount: isMobile(context) ? 3 : 4,
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
                        secondText: Valores.EB
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
                  GridView(
                      padding: const EdgeInsets.all(5.0),
                      controller: ScrollController(),
                      gridDelegate: GridViewTools.gridDelegate(
                          crossAxisCount: isMobile(context) ? 1 : 1,
                          mainAxisExtent: 75),
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
                  GridView(
                      padding: const EdgeInsets.all(5.0),
                      controller: ScrollController(),
                      gridDelegate: GridViewTools.gridDelegate(
                          crossAxisCount: isMobile(context) ? 3 : 4,
                          mainAxisExtent: 65),
                      children: [
                        ValuePanel(
                          firstText: "EB Esperado",
                          secondText: Valores.EBb.toStringAsFixed(2),
                          thirdText: "mmol/L",
                        ),
                        ValuePanel(
                          firstText: "PCO2 Esperado",
                          secondText: Valores.PCO2C.toStringAsFixed(2),
                          thirdText: "mmHg",
                        ),
                        ValuePanel(
                          firstText: "TCO2",
                          secondText: Valores.TCO.toStringAsFixed(2),
                          thirdText: "mmHg",
                        ),
                        ValuePanel(
                          firstText: "PCO2 Corregido",
                          secondText: Valores.PCO2C.toStringAsFixed(2),
                          thirdText: "mmHg",
                        ),
                        ValuePanel(
                          firstText: "EB Corregido",
                          secondText: Valores.EBecf.toStringAsFixed(2),
                          thirdText: "mmol/L",
                        ),
                        ValuePanel(
                          firstText: "EB Estándar",
                          secondText: Valores.EB.toStringAsFixed(2),
                          thirdText: 'mmol/L',
                        ),
                      ]),
                  GridView(
                      padding: const EdgeInsets.all(5.0),
                      controller: ScrollController(),
                      gridDelegate: GridViewTools.gridDelegate(
                          crossAxisCount: isMobile(context) ? 3 : 4,
                          mainAxisExtent: 65),
                      children: [
                        ValuePanel(
                          firstText: "Indice PAFI",
                          secondText: Valores.PAFI.toStringAsFixed(0),
                          thirdText: "",
                        ),
                        ValuePanel(
                          firstText: "Indice SAFI",
                          secondText: Valores.SAFI.toStringAsFixed(2),
                          thirdText: "",
                        ),
                        ValuePanel(
                          firstText: "PAO2",
                          secondText: Valores.PAO.toStringAsFixed(2),
                          thirdText: "mmHg",
                        ),
                        ValuePanel(
                          firstText: "Aa-O2",
                          secondText: Valores.GAA.toStringAsFixed(2),
                          thirdText: "mmHg",
                        ),
                        ValuePanel(
                          firstText: "Dif. Aa-O2",
                          secondText: Valores.DAA.toStringAsFixed(2),
                          thirdText: "mmHg",
                        ),
                        ValuePanel(
                          firstText: "Relación PaO2/PAO2",
                          secondText: Valores.PaO2PAO2.toStringAsFixed(2),
                          thirdText: "mmHg",
                        ),
                      ]),
                  GridView(
                    padding: const EdgeInsets.all(5.0),
                    controller: ScrollController(),
                    gridDelegate: GridViewTools.gridDelegate(
                        crossAxisCount: isMobile(context) ? 3 : 4,
                        mainAxisExtent: 65), //46
                    children: [
                      ValuePanel(
                        firstText: "Osm",
                        secondText:
                            Valores.osmolaridadSerica.toStringAsFixed(0),
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
                        crossAxisCount: isMobile(context) ? 3 : 3,
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
                        secondText:
                            Valores.deficitBicarbonato.toStringAsFixed(2),
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
                options: Carousel.carouselOptions(context: context)),
          ),
        ),
        Expanded(
          child: GrandButton(
            weigth: 2000,
            labelButton: "Copiar en Portapapeles",
            onPress: () {
              Datos.portapapeles(
                  context: context, text: 'Formatos.gasometrias()');
            },
          ),
        ),
      ],
    );
  }
}
