import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/ShowText.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Cardiovasculares extends StatefulWidget {
  const Cardiovasculares({Key? key}) : super(key: key);

  @override
  State<Cardiovasculares> createState() => _CardiovascularesState();
}

class _CardiovascularesState extends State<Cardiovasculares> {
  var carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        TittlePanel(color: Colors.black, textPanel: 'Análisis Hemodinámico'),
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
                  labelButton: 'Hemodinamia',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(1);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.settings_backup_restore,
                  labelButton: 'Presiones',
                  onPress: () {
                    setState(() {
                      carouselController.jumpToPage(2);
                    });
                  },
                ),
                GrandIcon(
                  iconData: Icons.compress_outlined,
                  labelButton: 'Trabajo Cardiaco',
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
                          title: 'Frecuencia Cardiaca',
                          data: Valores.frecuenciaCardiaca!.toDouble(),
                          medida: 'L/min',
                        ),
                        ShowText(
                          title: 'Producto Frecuencia-Presión',
                          data: Valores.productoFrecuenciaPresion.toDouble(),
                          medida: 'mmHg',
                        ),
                        TittlePanel(
                            textPanel:
                                "T.A. ${Valores.tensionArterialSistemica} (${Valores.presionArterialMedia.toStringAsFixed(0)})"),
                        // const CrossLine(),
                        ShowText(
                          title: 'Hemoglobina',
                          data: Valores.hemoglobina,
                          medida: 'g/dL',
                        ),
                        ShowText(
                          title: 'SaO2',
                          data: Valores.soArteriales,
                          medida: '%',
                        ),
                        ShowText(
                          title: 'SvO2',
                          data: Valores.soVenosos,
                          medida: '%',
                        ),
                        ShowText(
                          title: 'PaO2',
                          data: Valores.poArteriales,
                          medida: 'mmHg',
                        ),
                        ShowText(
                          title: 'PvO2',
                          data: Valores.poVenosos,
                          medida: 'mmHg',
                        ),
                        const CrossLine(),
                        // TittlePanel(textPanel: "Fecha G. Venosa ${Valores.fechaGasometriaVenosa}"),
                        // TittlePanel(textPanel: "Fecha G. Arterial ${Valores.fechaGasometriaArterial}"),
                        // const CrossLine(),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        ShowText(
                          title: 'Resist. V. Sist.',
                          data: Valores.RVS,
                          medida: 'dinas/seg/cm2',
                        ),
                        ShowText(
                          title: 'I. Extracción Oxígeno',
                          data: Valores.IEO,
                          medida: '%',
                        ),
                        ShowText(
                          title: 'Disp. Oxígeno',
                          data: Valores.DO,
                          medida: 'mL/min/m2',
                        ),
                        ShowText(
                          title: 'Transporte Oxígeno',
                          data: Valores.TO,
                          medida: 'mL/O2/m2',
                        ),
                        ShowText(
                          title: 'Aa-O2',
                          data: Valores.GAA,
                          medida: 'mmHg',
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: [
                      ShowText(
                        title: 'P. Coloido-Osmótica',
                        data: Valores.presionColoidoOsmotica,
                        medida: 'mmHg',
                      ),
                    ]),
                  ),
                  SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(children: [
                      ShowText(
                        title: 'Trabajo Cardiaco Izquiedo',
                        data: Valores.TC,
                        medida: 'Kg*m',
                      ),
                      ShowText(
                        title: 'T. Látido Cardiaco Izquiedo',
                        data: Valores.TLVI,
                        medida: 'g*m',
                      ),
                      ShowText(
                        title: 'T. Látido Cardiaco Derecho',
                        data: Valores.TLVD,
                        medida: 'g*m',
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
