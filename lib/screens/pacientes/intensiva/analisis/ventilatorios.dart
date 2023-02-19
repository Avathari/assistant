import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/ShowText.dart';
import 'package:assistant/widgets/TittlePanel.dart';
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
    TittlePanel(color:Colors.black, textPanel: 'Análisis Ventilatorio'),
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
                      title: 'Volumen tidal',
                      data: Valores.volumenTidal,
                      fractionDigits: 0,
                      medida: 'mL',
                    ),
                    ShowText(
                      title: 'Volumen tidal (6)',
                      data: Valores.volumentTidal6,
                      medida: 'mL',
                    ),
                    ShowText(
                      title: 'Volumen tidal (7)',
                      data: Valores.volumentTidal7,
                      medida: 'mL',
                    ),
                    ShowText(
                      title: 'Volumen tidal (8)',
                      data: Valores.volumentTidal8,
                      medida: 'mL',
                    ),
                    ShowText(
                      title: 'Frecuencia Ventilatoria',
                      data: Valores.frecuenciaVentilatoria!.toDouble(),
                      fractionDigits: 0,
                      medida: 'Vent/min',
                    ),
                    ShowText(
                      title: 'P.E.E.P.',
                      data: Valores.presionFinalEsiracion!.toDouble(),
                      fractionDigits: 0,
                      medida: 'cmH2O',
                    ),
                    ShowText(
                      title: 'Presión máxima',
                      data: Valores.presionMaxima!.toDouble(),
                      medida: 'cmH2O',
                    ),
                    ShowText(
                      title: 'FiO2',
                      data: Valores.fraccionInspiratoriaVentilatoria!.toDouble(),
                      fractionDigits: 0,
                      medida: '%',
                    ),
                    ShowText(
                      title: 'P. Control / P. Soporte',
                      data: Valores.presionControl!.toDouble(),
                      fractionDigits: 0,
                      medida: 'cmH2O',
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: [
                    isMobile(context) || isTablet(context)?
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShowText(
                          title: 'PmVa',
                          data: Valores.presionMediaViaAerea,
                          medida: 'cmH2O',
                        ),
                        ShowText(
                          title: 'W.O.B.',
                          data: Valores.poderMecanico,
                          medida: 'cmH2O',
                        ),
                      ],
                    ) :
                    ShowText(
                      title: 'Distensibilidad Pulmonar',
                      data: Valores.distensibilidadPulmonar,
                      medida: 'mL/cmH2O',
                    ),
                    ShowText(
                      title: 'Distensibilidad Pulmonar Estática',
                      data: Valores.distensibilidadPulmonarEstatica,
                      medida: 'mL/cmH2O',
                    ),
                    ShowText(
                      title: 'Distensibilidad Pulmonar Dinámica',
                      data: Valores.distensibilidadPulmonarDinamica,
                      medida: 'mL/cmH2O',
                    ),
                    ShowText(
                      title: 'Resistencia Pulmonar',
                      data: Valores.resistenciaPulmonar,
                      medida: 'mL/cmH2O',
                    ),
                    ShowText(
                      title: 'Pd',
                      data: Valores.dummy,
                      medida: 'cmH2O/mL',
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                controller: ScrollController(),
                child: Column(children: [
                  ShowText(
                    title: 'Volumen Minuto',
                    data: Valores.volumenMinuto,
                    medida: 'L/min',
                  ),
                  ShowText(
                    title: 'Volumen Minuto Ideal',
                    data: Valores.volumenMinutoIdeal,
                    medida: 'L/min',
                  ),
                  ShowText(
                    title: 'Flujo Ventilatorio',
                    data: Valores.flujoVentilatorioMedido,
                    medida: 'L/min',
                  ),
                ]),
              ),
              SingleChildScrollView(
                controller: ScrollController(),
                child: Column(children: [
                  ShowText(
                    title: 'R.S.B.I.',
                    data: Valores.indiceTobinYang,
                    medida: 'Resp/L.seg',
                  ),
                  ShowText(
                    title: 'iO2',
                    data: Valores.indiceOxigenacion,
                    medida: '',
                  ),
                  ShowText(
                    title: 'Indice Ventilatorio',
                    data: Valores.IV,
                    medida: '',
                  ),
                  ShowText(
                    title: 'Eficiencia Ventilatoria',
                    data: Valores.EV,
                    medida: '',
                  ),
                  ShowText(
                    title: 'FiO2 por Ventilación',
                    data: Valores.VENT,
                    medida: '%',
                  ),
                  ShowText(
                    title: 'FiO2 Ideal',
                    data: Valores.FIOI,
                    medida: '%',
                  ),
                  ShowText(
                    title: 'Frecuencia Ventilatoria Ideal',
                    data: Valores.FIOV,
                    medida: 'Vent/min',
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
    );
  }
}
