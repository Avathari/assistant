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
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Hidricos extends StatefulWidget {
  bool? isLateral;

  Hidricos({super.key, this.isLateral = false});

  @override
  State<Hidricos> createState() => _HidricosState();
}

class _HidricosState extends State<Hidricos> {
  var carouselController = CarouselSliderController();

  var sodioInfundidoTextController = TextEditingController();

  @override
  void initState() {
    //
  //   Terminal.printAlert(message: "ERROR : : ${Pacientes.ID_Paciente}");
  //   //
  // Auxiliares.ultimoRegistro()
  //     .then((value) => Auxiliares.fromJson(value))
  //     .whenComplete(() => setState(() {}))
  //     .onError((error, stackTrace) =>
  //     Terminal.printAlert(message: "ERROR : : $error : $stackTrace"));

    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TittleContainer(
      centered: true,
      color: Colors.black,
      tittle: "Análisis Hídrico",
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 10.0, bottom: 8.0),
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
                    flex: widget.isLateral == true? 2: isTablet(context) || isMobile(context) ? 2 : 1,
                    child: valoresIniciales(context)),
                Expanded(
                  flex: widget.isLateral == true? 5: isTablet(context) ? 5 : 3,
                  child: CarouselSlider(
                      items: [
                        SingleChildScrollView(
                          controller: ScrollController(),
                          child: TittleContainer(
                            color: Colors.black,
                            padding: 4.0,
                            tittle: "Análisis Hídrico",
                            child: Column(
                              children: [
                                isMobile(context) || isTablet(context)
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ValuePanel(
                                            firstText: 'Req. Hídrico',
                                            secondText: Hidrometrias
                                                .requerimientoHidrico
                                                .toStringAsFixed(0),
                                            thirdText: 'mL',
                                          ),
                                          Slider(
                                            value: Hidrometrias
                                                .constanteRequerimientos,
                                            max: 65,
                                            divisions: 65,
                                            label: Hidrometrias
                                                .constanteRequerimientos
                                                .round()
                                                .toString(),
                                            onChanged: (double value) {
                                              setState(() {
                                                Hidrometrias
                                                        .constanteRequerimientos =
                                                    value;
                                              });
                                            },
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: ValuePanel(
                                              firstText: 'Req. H2O',
                                              secondText: Hidrometrias
                                                  .requerimientoHidrico
                                                  .toString(),
                                              thirdText: 'mL',
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Slider(
                                              value: Hidrometrias
                                                  .constanteRequerimientos,
                                              max: 65,
                                              divisions: 65,
                                              label: Hidrometrias
                                                  .constanteRequerimientos
                                                  .round()
                                                  .toString(),
                                              onChanged: (double value) {
                                                setState(() {
                                                  Hidrometrias
                                                          .constanteRequerimientos =
                                                      value;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                CrossLine(height: 10),
                                ValuePanel(
                                  firstText: 'ACT',
                                  secondText: Hidrometrias.aguaCorporalTotal
                                      .toStringAsFixed(2),
                                  thirdText: 'L',
                                ),
                                ValuePanel(
                                  firstText: 'Déf. H2O',
                                  secondText: Hidrometrias.deficitAguaCorporal
                                      .toStringAsFixed(2),
                                  thirdText: 'mL',
                                ),
                                ValuePanel(
                                  firstText: 'Exc. H2O L',
                                  secondText: Hidrometrias.excesoAguaLibre
                                      .toStringAsFixed(2),
                                  thirdText: 'mL',
                                ),
                                CrossLine(height: 10),
                                isMobile(context) || isTablet(context)
                                    ? Column(
                                        children: [
                                          ValuePanel(
                                            firstText: 'Osm. Sérica',
                                            secondText: Hidrometrias
                                                .osmolaridadSerica
                                                .toStringAsFixed(2),
                                            thirdText: 'Osm/mL',
                                          ),
                                          ValuePanel(
                                            firstText: 'BO',
                                            secondText: Hidrometrias
                                                .brechaOsmolar
                                                .toStringAsFixed(2),
                                            thirdText: 'Osm/mL',
                                          ),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          Expanded(
                                            child: ValuePanel(
                                              firstText: 'Osmolaridad Sérica',
                                              secondText: Hidrometrias
                                                  .osmolaridadSerica
                                                  .toStringAsFixed(2),
                                              thirdText: 'Osm/mL',
                                            ),
                                          ),
                                          Expanded(
                                            child: ValuePanel(
                                              firstText: 'Brecha Osmolar',
                                              secondText: Hidrometrias
                                                  .brechaOsmolar
                                                  .toStringAsFixed(2),
                                              thirdText: 'Osm/mL',
                                            ),
                                          ),
                                        ],
                                      ),
                                CrossLine(height: 10),
                                CircleIcon(
                                  radios: 30,
                                  tittle:
                                      'Copiar Análisis Hídrico en Portapapeles',
                                  iconed: Icons.copy_rounded,
                                  onChangeValue: () => Datos.portapapeles(
                                      context: context,
                                      text: Hidrometrias.hidricos),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          controller: ScrollController(),
                          child: TittleContainer(
                            color: Colors.black,
                            tittle: 'Análisis de Sodio',
                            child: Column(children: [
                              ValuePanel(
                                firstText: 'Sodio Corregido',
                                secondText: Hidrometrias.sodioCorregidoGlucosa
                                    .toStringAsFixed(2),
                                thirdText: 'mEq/L',
                              ),
                              CrossLine(),
                              ValuePanel(
                                firstText: 'Reposición de Sodio',
                                secondText: Hidrometrias.reposicionSodio
                                    .toStringAsFixed(2),
                                thirdText: 'mEq/L',
                              ),
                              ValuePanel(
                                firstText: 'Delta Sodio',
                                secondText: Hidrometrias.deficitSodio
                                    .toStringAsFixed(2),
                                thirdText: 'mEq/L',
                              ),
                              CrossLine(),
                              isMobile(context) || isTablet(context)
                                  ? Column(
                                      children: [
                                        EditTextArea(
                                          labelEditText: 'Sodio Infundido',
                                          numOfLines: 1,
                                          textController:
                                              sodioInfundidoTextController,
                                          keyBoardType: TextInputType.number,
                                          inputFormat: MaskTextInputFormatter(
                                            // mask: '####',
                                            // filter: {"#": RegExp(r'[0-9]')},
                                            // type: MaskAutoCompletionType.lazy,
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
                                        ValuePanel(
                                          firstText: 'Delta Sodio',
                                          secondText: Hidrometrias.deltaSodio
                                              .toStringAsFixed(2),
                                          thirdText: 'mEq/L INF',
                                        ),
                                        ValuePanel(
                                          firstText: 'Sodio Resultante',
                                          secondText: (Valores.sodio! + Hidrometrias.deltaSodio)
                                              .toStringAsFixed(2),
                                          thirdText: 'mmol/L',
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: EditTextArea(
                                            labelEditText: 'Sodio Infundido',
                                            numOfLines: 1,
                                            textController:
                                                sodioInfundidoTextController,
                                            keyBoardType: TextInputType.number,
                                            inputFormat: MaskTextInputFormatter(
                                              // mask: '####',
                                              // filter: {"#": RegExp(r'[0-9]')},
                                              // type: MaskAutoCompletionType.lazy,
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
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              ValuePanel(
                                                firstText: 'Delta Sodio',
                                                secondText: Hidrometrias.deltaSodio
                                                    .toStringAsFixed(2),
                                                thirdText: 'mEq/L INF',
                                              ),
                                              ValuePanel(
                                                firstText: 'Sodio Resultante',
                                                secondText: (Valores.sodio! + Hidrometrias.deltaSodio)
                                                    .toStringAsFixed(2),
                                                thirdText: 'mmol/L',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
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
                          child: TittleContainer(
                            tittle: 'Análisis de Potasio',
                            color: Colors.black,
                            child: Column(children: [
                              isMobile(context) || isTablet(context)
                                  ? Column(
                                      children: [
                                        ValuePanel(
                                          firstText: 'Req. Basal Potasio',
                                          secondText: Hidrometrias
                                              .requerimientoBasalPotasio
                                              .toStringAsFixed(2),
                                          thirdText: 'mEq/L',
                                        ),
                                        ValuePanel(
                                          firstText: 'Req. Potasio',
                                          secondText: Hidrometrias
                                              .requerimientoPotasio
                                              .toStringAsFixed(2),
                                          thirdText: 'mEq/L',
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                          child: ValuePanel(
                                            firstText: 'Req. Basal Potasio',
                                            secondText: Hidrometrias
                                                .requerimientoBasalPotasio
                                                .toStringAsFixed(2),
                                            thirdText: 'mEq/L',
                                          ),
                                        ),
                                        Expanded(
                                          child: ValuePanel(
                                            firstText: 'Req. Potasio',
                                            secondText: Hidrometrias
                                                .requerimientoPotasio
                                                .toStringAsFixed(2),
                                            thirdText: 'mEq/L',
                                          ),
                                        ),
                                      ],
                                    ),
                              CrossLine(),
                              ValuePanel(
                                firstText: 'Reposición Potasio',
                                secondText: Hidrometrias.reposicionPotasio
                                    .toStringAsFixed(2),
                                thirdText: 'mEq/L',
                              ),
                              isMobile(context) || isTablet(context)
                                  ? Column(
                                      children: [
                                        ValuePanel(
                                          firstText: 'Rep. K+ 1/3',
                                          secondText:
                                              ((Hidrometrias.reposicionPotasio /
                                                          3) *
                                                      1)
                                                  .toStringAsFixed(2),
                                          thirdText: 'mEq/L',
                                        ),
                                        ValuePanel(
                                          firstText: 'Rep. K+ 2/3',
                                          secondText:
                                              ((Hidrometrias.reposicionPotasio /
                                                          3) *
                                                      2)
                                                  .toStringAsFixed(2),
                                          thirdText: 'mEq/L',
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                          child: ValuePanel(
                                            firstText: 'Rep. K+ 1/3',
                                            secondText: ((Hidrometrias
                                                            .reposicionPotasio /
                                                        3) *
                                                    1)
                                                .toStringAsFixed(2),
                                            thirdText: 'mEq/L',
                                          ),
                                        ),
                                        Expanded(
                                          child: ValuePanel(
                                            firstText: 'Rep. K+ 2/3',
                                            secondText: ((Hidrometrias
                                                            .reposicionPotasio /
                                                        3) *
                                                    2)
                                                .toStringAsFixed(2),
                                            thirdText: 'mEq/L',
                                          ),
                                        ),
                                      ],
                                    ),
                              CrossLine(),
                              ValuePanel(
                                firstText: 'Repo. Periférica',
                                secondText: Hidrometrias.kalemiaPorPeriferico
                                    .toStringAsFixed(2),
                                thirdText: 'mEq/Hr',
                              ),
                              ValuePanel(
                                firstText: 'Repo. Central',
                                secondText: Hidrometrias.kalemiaPorCentral
                                    .toStringAsFixed(2),
                                thirdText: 'mEq/Hr',
                              ),
                              CrossLine(),
                              ValuePanel(
                                firstText: 'Delta Potasio',
                                secondText: Hidrometrias.deltaPotasio
                                    .toStringAsFixed(2),
                                thirdText: 'mEq/L',
                              ),
                              ValuePanel(
                                firstText: 'pH / Potasio',
                                secondText:
                                    Hidrometrias.pHKalemia.toStringAsFixed(2),
                                thirdText: 'mEq/L',
                              ),
                              CrossLine(),
                              TittlePanel(
                                  textPanel: Hidrometrias.kalemia,
                                  fontSize: 11),
                              CrossLine(height: 10),
                              CircleIcon(
                                radios: 30,
                                tittle:
                                    'Copiar Análisis Hídrico en Portapapeles',
                                iconed: Icons.copy_rounded,
                                onChangeValue: () => Datos.portapapeles(
                                    context: context,
                                    text: Hidrometrias.potasios),
                              ),
                            ]),
                          ),
                        ),
                        SingleChildScrollView(
                          controller: ScrollController(),
                          child: TittleContainer(
                            padding: 4,
                            tittle: 'Análisis de Calcio',
                            color: Colors.black,
                            child: Column(children: [
                              ValuePanel(
                                firstText: 'Calcio Corregido',
                                secondText: Hidrometrias.calcioCorregidoAlbumina
                                    .toStringAsFixed(2),
                                thirdText: 'mEql/L',
                              ),
                              CrossLine(),
                              Row(
                                children: [
                                  Expanded(
                                    child: ValuePanel(
                                      firstText: 'Alb-',
                                      secondText: Valores.albuminaSerica
                                          .toString(),
                                      thirdText: 'g/dL',
                                    ),

                                  ),
                                  Expanded(
                                    child: ValuePanel(
                                      firstText: 'Mg-',
                                      secondText: Valores.magnesio
                                          .toString(),
                                      thirdText: 'mg/dL',
                                    ),),
                                  Expanded(
                                    child: ValuePanel(
                                      firstText: 'PO3-',
                                      secondText: Valores.fosforo
                                          .toString(),
                                      thirdText: 'mg/dL',
                                    ),),
                                  Expanded(
                                    child: ValuePanel(
                                      firstText: 'Cr-',
                                      secondText: Valores.creatinina
                                          .toString(),
                                      thirdText: 'mg/dL',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [

                                  Expanded(
                                    child: ValuePanel(
                                      firstText: 'PTH',
                                      secondText: "0"
                                          .toString(),
                                      thirdText: 'mg/dL',
                                    ),
                                  ),
                                  Expanded(
                                    child: ValuePanel(
                                      firstText: '25(OH)D',
                                      secondText: "0"
                                          .toString(),
                                      thirdText: 'mg/dL',
                                    ),
                                  ),
                                  Expanded(
                                    child: ValuePanel(
                                      firstText: '1,25(OH)2D',
                                      secondText: "0"
                                          .toString(),
                                      thirdText: 'mg/dL',
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                        SingleChildScrollView(
                          controller: ScrollController(),
                          child: Column(children: [
                            ValuePanel(
                              firstText: 'Líquido Intracelular',
                              secondText: Hidrometrias.LI.toStringAsFixed(2),
                              thirdText: 'L',
                            ),
                            ValuePanel(
                              firstText: 'Líquido Extracelular',
                              secondText: Hidrometrias.LEC.toStringAsFixed(2),
                              thirdText: 'L',
                            ),
                            ValuePanel(
                              firstText: 'Líquido Intersticial',
                              secondText: Hidrometrias.LIC.toStringAsFixed(2),
                              thirdText: 'L',
                            ),
                            ValuePanel(
                              firstText: 'Líquido Intravascular',
                              secondText: Hidrometrias.LIV.toStringAsFixed(2),
                              thirdText: 'L',
                            ),
                            ValuePanel(
                              firstText: 'Volumen Plasmático',
                              secondText: Hidrometrias.volumenPlasmatico
                                  .toStringAsFixed(2),
                              thirdText: 'L',
                            ),
                            CrossLine(),
                            ValuePanel(
                              firstText: 'Volumen Sanguíneo',
                              secondText:
                                  Valores.volemiaAproximada.toStringAsFixed(2),
                              thirdText: 'L',
                            ),
                            ValuePanel(
                              firstText: 'Solutos Corporales',
                              secondText: Hidrometrias.SOL.toStringAsFixed(2),
                              thirdText: 'mOsm',
                            ),
                          ]),
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
      padding: 4.0,
      tittle: "",
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 5.0),
        controller: ScrollController(),
        child: Wrap(children: [
          ValuePanel(
            firstText: 'PCT',
            secondText: Valores.pesoCorporalTotal.toString(),
            thirdText: 'Kg',
          ),
          CrossLine(),
          ValuePanel(
            firstText: 'Na2+',
            secondText: Valores.sodio.toString(),
            thirdText: 'mEq/L',
          ),
          ValuePanel(
            firstText: 'K+',
            secondText: Valores.potasio.toString(),
            thirdText: 'mEq/L',
          ),
          ValuePanel(
            firstText: 'Cl-',
            secondText: Valores.cloro.toString(),
            thirdText: 'mg/dL',
          ),
          ValuePanel(
            firstText: 'PO3',
            secondText: Valores.fosforo.toString(),
            thirdText: 'mg/dL',
          ),
          ValuePanel(
            firstText: 'Mg',
            secondText: Valores.magnesio.toString(),
            thirdText: 'mg/dL',
          ),
          ValuePanel(
            firstText: 'Ca2+',
            secondText: Valores.calcio.toString(),
            thirdText: 'mg/dL',
          ),
          CrossLine(),
          ValuePanel(
            firstText: 'CHON-',
            secondText: Valores.glucosa.toString(),
            thirdText: 'mg/dL',
          ),
          ValuePanel(
            firstText: 'Urea',
            secondText: Valores.urea.toString(),
            thirdText: 'mg/dL',
          ),
        ]),
      ),
    );
  }
}
