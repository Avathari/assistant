import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/hidrometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Hematinicos extends StatefulWidget {
  const Hematinicos({super.key});

  @override
  State<Hematinicos> createState() => _HematinicosState();
}

class _HematinicosState extends State<Hematinicos> {
  var carouselController = CarouselSliderController();

  var volumenSanguineoTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TittleContainer(
      centered: true,
      color: Colors.black,
      tittle: "Análisis Post-transfusional",
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 18.0,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GrandIcon(
                    iconData: Icons.fiber_manual_record_sharp,
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
            flex: 9,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: isTablet(context) || isMobile(context) ? 2 : 1,
                    child: valoresIniciales(context)),
                Expanded(
                  flex: isTablet(context) ? 5 : 3,
                  child: CarouselSlider(
                      items: [
                        SingleChildScrollView(
                          controller: ScrollController(),
                          child: TittleContainer(
                            color: Colors.black,
                            tittle: 'Análisis de Sodio',
                            child: Column(children: [
                              EditTextArea(
                                labelEditText: 'Vol. Sang.',
                                numOfLines: 1,
                                textController:
                                volumenSanguineoTextController,
                                keyBoardType: TextInputType.number,
                                inputFormat: MaskTextInputFormatter(
                                  mask: '####',
                                  filter: {"#": RegExp(r'[0-9]')},
                                  type: MaskAutoCompletionType.lazy,
                                ),
                                onChange: (String value) {
                                  setState(() {
                                    Hidrometrias.sodioInfundido =
                                        int.parse(value);
                                  });
                                },
                                selection: true,
                                withShowOption: true,
                                onSelected: () {},
                              ),
                              CrossLine(),
                              ValuePanel(
                                firstText: 'Volemia Expresada',
                                secondText: Valores.volemiaAproximada
                                    .toStringAsFixed(2),
                                thirdText: 'L',
                              ),
                              ValuePanel(
                                firstText: 'Delta Sodio',
                                secondText: Hidrometrias.deficitSodio
                                    .toStringAsFixed(2),
                                thirdText: 'mEq/L',
                              ),
                              CrossLine(),
                              CrossLine(),
                              CircleIcon(
                                radios: 30,
                                tittle:
                                    'Copiar Análisis Hídrico en Portapapeles',
                                iconed: Icons.copy_rounded,
                                onChangeValue: () => Datos.portapapeles(
                                    context: context,
                                    text: Hidrometrias.sodios),
                              ),
                            ]),
                          ),
                        ),
                        SingleChildScrollView(
                          controller: ScrollController(),
                          child: const Column(children: []),
                        ),
                        SingleChildScrollView(
                          controller: ScrollController(),
                          child: const Column(children: []),
                        ),
                        SingleChildScrollView(
                          controller: ScrollController(),
                          child: const Column(children: []),
                        ),
                        //
                        SingleChildScrollView(
                          controller: ScrollController(),
                          child: const Column(children: []),
                        ),
                      ],
                      carouselController: carouselController,
                      options: Carousel.carouselOptions(context: context)),
                ),
              ],
            ),
          ),
          Expanded(
            child: GrandButton(
              weigth: 2000,
              labelButton: "Copiar en Portapapeles",
              onPress: () {
                Datos.portapapeles(
                    context: context, text: Hidrometrias.hidricos);
              },
            ),
          ),
        ],
      ),
    );
  }

  TittleContainer valoresIniciales(BuildContext context) {
    return TittleContainer(
      color: Colors.black,
      tittle: "Valores Iniciales",
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Wrap(children: [
          ValuePanel(
            firstText: 'PCT',
            secondText: Valores.pesoCorporalTotal.toString(),
            thirdText: 'Kg',
          ),
          CrossLine(),
          ValuePanel(
            firstText: 'Hb',
            secondText: Valores.hemoglobina.toString(),
            thirdText: 'g/dL',
          ),
          ValuePanel(
            firstText: 'Hto',
            secondText: Valores.hematocrito.toString(),
            thirdText: '%',
          ),
          CrossLine(),

        ]),
      ),
    );
  }
}
