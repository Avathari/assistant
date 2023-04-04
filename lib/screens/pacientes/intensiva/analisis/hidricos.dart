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
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Hidricos extends StatefulWidget {
  const Hidricos({Key? key}) : super(key: key);

  @override
  State<Hidricos> createState() => _HidricosState();
}

class _HidricosState extends State<Hidricos> {
  var carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(color: Colors.black, textPanel: 'Análisis Hídrico'),
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
                  labelButton: 'Análisis Hídrico',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(1);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.settings_backup_restore,
                  labelButton: 'Correciones',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(2);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.compress_outlined,
                  labelButton: 'Osmolaridad',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(3);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.change_circle_outlined,
                  labelButton: 'Reposiciones',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(4);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.water_drop_outlined,
                  labelButton: 'Líquidos Corporales',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(5);
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
                        ShowText(
                          title: 'Peso Corporal Total',
                          data: Valores.pesoCorporalTotal,
                          medida: 'Kg',
                        ),
                        ShowText(
                          title: 'Sodio',
                          data: Valores.sodio,
                          medida: 'mEq/L',
                        ),
                        ShowText(
                          title: 'Potasio',
                          data: Valores.potasio,
                          medida: 'mEq/L',
                        ),
                        ShowText(
                          title: 'Cloro',
                          data: Valores.cloro,
                          medida: 'mg/dL',
                        ),
                        ShowText(
                          title: 'Fósforo',
                          data: Valores.fosforo,
                          medida: 'mg/dL',
                        ),
                        ShowText(
                          title: 'Magnesio',
                          data: Valores.magnesio,
                          medida: 'mg/dL',
                        ),
                        ShowText(
                          title: 'Calcio',
                          data: Valores.calcio,
                          medida: 'mg/dL',
                        ),
                        CrossLine(),
                        ShowText(
                          title: 'Glucosa',
                          data: Valores.glucosa,
                          medida: 'mg/dL',
                        ),
                        ShowText(
                          title: 'Urea',
                          data: Valores.urea,
                          medida: 'mg/dL',
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        isMobile(context) || isTablet(context)
                            ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ShowText(
                                    title: 'Requerimiento Hídrico',
                                    data: Valores.requerimientoHidrico,
                                    medida: 'mL',
                                  ),
                                  Spinner(
                                    tittle: 'Constante',
                                    onChangeValue: (value) {
                                      setState(() {
                                        Valores.constanteRequerimientos =
                                            int.parse(value);
                                      });
                                    },
                                    items: List<String>.generate(
                                        65, (i) => (i + 1).toString()),
                                    initialValue: Valores
                                        .constanteRequerimientos
                                        .toString(),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ShowText(
                                    title: 'Requerimiento Hídrico',
                                    data: Valores.requerimientoHidrico,
                                    medida: 'mL',
                                  ),
                                  Spinner(
                                    tittle: 'Constante',
                                    onChangeValue: (value) {
                                      setState(() {
                                        Valores.constanteRequerimientos =
                                            int.parse(value);
                                      });
                                    },
                                    items: List<String>.generate(
                                        65, (i) => (i + 1).toString()),
                                    initialValue: Valores
                                        .constanteRequerimientos
                                        .toString(),
                                  ),
                                ],
                              ),
                        ShowText(
                          title: 'Agua Corporal Total',
                          data: Valores.aguaCorporalTotal,
                          medida: 'L',
                        ),
                        ShowText(
                          title: 'Déficit de Agua Corporal',
                          data: Valores.deficitAguaCorporal,
                          medida: 'mL',
                        ),
                        ShowText(
                          title: 'Exceso de Agua Libre',
                          data: Valores.excesoAguaLibre,
                          medida: 'mL',
                        ),
                        ShowText(
                          title: 'Delta Sodio',
                          data: Valores.deficitSodio,
                          medida: 'mEq/L',
                        ),
                        ShowText(
                          title: 'Sodio Corregido',
                          data: Valores.sodioCorregidoGlucosa,
                          medida: 'mEq/L',
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: [
                      ShowText(
                        title: 'Sodio Corregido',
                        data: Valores.sodioCorregidoGlucosa,
                        medida: 'mEq/L',
                      ),
                      ShowText(
                        title: 'Calcio Corregido',
                        data: Valores.calcioCorregidoAlbumina,
                        medida: 'mEql/L',
                      ),
                      ShowText(
                        title: 'Volumen Plasmático',
                        data: Valores.volumenPlasmatico,
                        medida: 'L',
                      ),
                      ShowText(
                        title: 'Volumen Sanguíneo',
                        data: Valores.volemiaAproximada,
                        medida: 'L',
                      ),
                      ShowText(
                        title: 'Solutos Corporales',
                        data: Valores.SOL,
                        medida: 'mOsm',
                      ),
                    ]),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: [
                      ShowText(
                        title: 'Osmolaridad Sérica',
                        data: Valores.osmolaridadSerica,
                        medida: 'Osm/mL',
                      ),
                      ShowText(
                        title: 'Brecha Osmolar',
                        data: Valores.brechaOsmolar,
                        medida: 'Osm/mL',
                      ),
                    ]),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: [
                      ShowText(
                        title: 'Déficit de Sodio',
                        data: Valores.deficitSodio,
                        medida: 'mEq/L',
                      ),
                      ShowText(
                        title: 'Reposición de Sodio',
                        data: Valores.reposicionSodio,
                        medida: 'mEq/L',
                      ),
                      ShowText(
                        title: 'Requerimiento Basal Potasio',
                        data: Valores.requerimientoBasalPotasio,
                        medida: 'mEq/L',
                      ),
                      ShowText(
                        title: 'Requerimiento Potasio',
                        data: Valores.requerimientoPotasio,
                        medida: 'mEq/L',
                      ),
                      ShowText(
                        title: 'Reposición Potasio',
                        data: Valores.reposicionPotasio,
                        medida: 'mEq/L',
                      ),
                      ShowText(
                        title: 'Delta Potasio',
                        data: Valores.deltaPotasio,
                        medida: 'mEq/L',
                      ),
                      ShowText(
                        title: 'pH / Potasio',
                        data: Valores.pHKalemia,
                        medida: 'mEq/L',
                      ),
                      TittlePanel(textPanel: Valores.kalemia),
                    ]),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: [
                      ShowText(
                        title: 'Líquido Intracelular',
                        data: Valores.LI,
                        medida: 'L',
                      ),
                      ShowText(
                        title: 'Líquido Extracelular',
                        data: Valores.LEC,
                        medida: 'L',
                      ),
                      ShowText(
                        title: 'Líquido Intersticial',
                        data: Valores.LIC,
                        medida: 'L',
                      ),
                      ShowText(
                        title: 'Líquido Intravascular',
                        data: Valores.LIV,
                        medida: 'L',
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
                  context: context, text: Valorados.hidricos);
            },
          ),
        ),
      ],
    );
  }
}
