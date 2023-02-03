import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/GridLayout.dart';
import 'package:assistant/widgets/ShowText.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Gasometricos extends StatefulWidget {
  const Gasometricos({Key? key}) : super(key: key);

  @override
  State<Gasometricos> createState() => _GasometricosState();
}

class _GasometricosState extends State<Gasometricos> {
  var carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        TittlePanel(color:Colors.black, textPanel: 'Análisis Gasométrico'),
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
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        ShowText(
                          title: 'Peso Corporal Total',
                          data: Valores.pesoCorporalTotal,
                          medida: 'Kg',
                        ),
                        ShowText(
                          title: 'pH',
                          data: Valores.pHArteriales,
                          medida: '',
                        ),
                        ShowText(
                          title: 'PCO2',
                          data: Valores.pcoArteriales,
                          fractionDigits: 0,
                          medida: 'mmHg',
                        ),
                        ShowText(
                          title: 'PO2',
                          data: Valores.poArteriales,
                          fractionDigits: 0,
                          medida: 'mmHg',
                        ),
                        ShowText(
                          title: 'HCO3-',
                          data: Valores.bicarbonatoArteriales,
                          medida: 'mmol/L',
                          fractionDigits: 0,
                        ),
                        ShowText(
                          title: 'E.B.',
                          data: Valores.excesoBaseArteriales,
                          medida: 'mmol/L',
                        ),
                        ShowText(
                          title: 'SO2',
                          data: Valores.soArteriales,
                          medida: '%',
                        ),
                        ShowText(
                          title: 'FiO2',
                          data: Valores.fioArteriales,
                          medida: '%',
                        ),
                        const CrossLine(),
                        ShowText(
                          title: 'Temperatura Corporal',
                          data: Valores.temperaturCorporal,
                          medida: '°C',
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        TittlePanel(textPanel: "Trastorno Primario \n${Valores.trastornoPrimario} (pH ${Valores.pHArteriales})"),
                        TittlePanel(textPanel: "Trastorno Secundario \n${Valores.trastornoSecundario} (PCO2 ${Valores.pcoArteriales!.toStringAsFixed(0)})"),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: GridLayout(columnCount: isMobile(context) ? 1 : 2,
                        children: [
                      TittlePanel(textPanel: "Alteración del Oxígeno \n${Valores.trastornoTerciario} (pO2 ${Valores.poArteriales!.toStringAsFixed(0)})"),
                      TittlePanel(textPanel: "Alteración del CO2 \n${Valores.alteracionRespiratoria} (HCO3- ${Valores.pcoArteriales})"),
                      TittlePanel(textPanel: "Alteración por Bases \n${Valores.trastornoBases} (EB ${Valores.EB.toStringAsFixed(2)})"),
                      TittlePanel(textPanel: "Alteración del Anion Gap \n${Valores.trastornoGap} (GAP ${Valores.GAP.toStringAsFixed(0)})"),
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
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: [
                      ShowText(
                        title: 'Osmolaridad',
                        data: Valores.osmolaridadSerica,
                        medida: 'mOsm/L',
                      ),
                      ShowText(
                        title: 'GAP Osmolal',
                        data: Valores.GAPO,
                        medida: 'mOsm/L',
                      ),
                      ShowText(
                        title: 'Anion GAP',
                        data: Valores.GAP,
                        medida: '',
                      ),
                      ShowText(
                        title: 'Delta GAP',
                        data: Valores.d_GAP,
                        medida: '',
                      ),
                      ShowText(
                        title: 'Delta-Delta GAP',
                        data: Valores.D_d_GAP,
                        medida: '',
                      ),
                      ShowText(
                        title: 'Dif. Aniones Libres',
                        data: Valores.DIF,
                        medida: '',
                      ),
                      ShowText(
                        title: 'Efecto Búffer',
                        data: Valores.EBvGilFix,
                        medida: '',
                      ),
                      ShowText(
                        title: 'Diferencia Anionica',
                        data: Valores.DA,
                        medida: '',
                      ),
                      ShowText(
                        title: 'Verdadero Déficit de Base',
                        data: Valores.VDb,
                        medida: '',
                      ),
                      ShowText(
                        title: '[H+]',
                        data: Valores.H,
                        medida: '',
                      ),
                      ShowText(
                        title: 'pH[]',
                        data: Valores.PH,
                        medida: '',
                      ),
                    ]),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: [
                      ShowText(
                        title: 'Primera Regla del Bicarbonato',
                        data: Valores.HCOR_a,
                        medida: '',
                      ),
                      ShowText(
                        title: 'Segunda Regla del Bicarbonato',
                        data: Valores.HCOR_b,
                        medida: '',
                      ),
                      ShowText(
                        title: 'Tercera Regla del Bicarbonato',
                        data: Valores.HCOR_c,
                        medida: 'mEq/L',
                      ),
                      ShowText(
                        title: 'Déficit de Bicarbonato',
                        data: Valores.deficitBicarbonato,
                        medida: 'mEq/L',
                      ),
                      ShowText(
                        title: 'Déficit de Bicarbonato (Astrup)',
                        data: Valores.HCOAM,
                        medida: 'mEq/L',
                      ),
                      const CrossLine(),
                      ShowText(
                        title: 'Reposición de Bicarbonato',
                        data: Valores.VHCOAM,
                        medida: 'mEq/L',
                      ),
                      ShowText(
                        title: 'No Ampulas de Bicarbonato',
                        data: Valores.NOAMP,
                        medida: 'amp al 7.5%',
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
