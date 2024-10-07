import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/operativity/pacientes/valores/semiologia/semiotica.dart';
import 'package:assistant/screens/pacientes/auxiliares/revisiones/generales.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CircleSwitched.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/GrandLabel.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Semiologicos extends StatefulWidget {
  bool? esCorto, withoutAppBar;

  String? initialValue;

  Semiologicos({super.key, this.esCorto = true, this.withoutAppBar = false});

  @override
  State<Semiologicos> createState() => _SemiologicosState();
}

class _SemiologicosState extends State<Semiologicos>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    /// ENFORCE DEVICE ORIENTATION LANDSCAPE ONLY
    // if (isDesktop(context)) {
    //   SystemChrome.setPreferredOrientations([
    //     DeviceOrientation.landscapeLeft,
    //     DeviceOrientation.landscapeRight,
    //   ]);
    // } else {
    //   SystemChrome.setPreferredOrientations([
    //     DeviceOrientation.portraitUp,
    //     DeviceOrientation.portraitDown,
    //     DeviceOrientation.landscapeLeft,
    //     DeviceOrientation.landscapeRight,
    //   ]);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: [
                  ..._getComponents(entries: Exploracion.semiotica),
                  CrossLine(thickness: 3,),
                  ..._getComponents(entries: Exploracion.cervical),
                ],
              )),
        ),
        _centralPanel(context),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children:
                [
                  ..._getComponents(entries: Exploracion.torax),
                  CrossLine(thickness: 3,),
                  ..._getComponents(entries: Exploracion.abdomen),
                ]
              )),
        ),
        //
      ],
    );
  }

  @override
  void dispose() {
    /// ENFORCE DEVICE ORIENTATION TO PREDEFINE
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  List<Widget> _getComponents(
      {required Map<String, dynamic> entries}) {
    List<Widget> list = [];

    for (int index = 0; index < entries.length; index++) {
      widget.initialValue = entries.values.elementAt(index)[0];

      Terminal.printWarning(message: entries.keys.elementAt(index).toString());
      //
      list.add(
        Spinner(
          tittle: descompose(entries.keys.elementAt(index)),
          onChangeValue: (String value) {
            setState(() {
              widget.initialValue = value;
            });
            // Handle button press here
            Exploracion.toJson(
                entries.keys.elementAt(index),
              value
                );
            //  entries.values.elementAt(index)
            expoTextController.text = Exploracion.exploracionGeneral;
          },
          items: entries.values.elementAt(index),
          initialValue: widget.initialValue!,
        ),
      );

      //
      // list.add(Stack(
          //   children: [
          //     Container(
          //         width: double.infinity, // widget.width,
          //         height: entries.values.elementAt(index).length > 5 ? 110 : 75,
          //         margin: const EdgeInsets.all(12.0),
          //         padding:
          //             const EdgeInsets.only(left: 10, right: 8, top: 7, bottom: 5),
          //         decoration: BoxDecoration(
          //           border: Border.all(color: Colors.grey, width: 1),
          //           borderRadius: BorderRadius.circular(20),
          //           shape: BoxShape.rectangle,
          //         ),
          //         child: entries.values.elementAt(index).length > 4
          //             // ? isSpinner == false || entries.values.elementAt(index).length <= 10
          //             ? GridView(
          //                 shrinkWrap: true,
          //                 controller: ScrollController(),
          //                 gridDelegate: GridViewTools.gridDelegate(
          //                     crossAxisCount: isMobile(context) ? 3 : 5,
          //                     mainAxisExtent: isMobile(context) ||
          //                             isTablet(context) ||
          //                             isDesktop(context)
          //                         ? 45
          //                         : 45,
          //                     childAspectRatio: isMobile(context) ||
          //                             isTablet(context) ||
          //                             isDesktop(context)
          //                         ? 2.0
          //                         : 1.0,
          //                     crossAxisSpacing: 1.0,
          //                     mainAxisSpacing: 1.0),
          //                 children: entries.values
          //                     .elementAt(index)
          //                     .map<Widget>((title) => CircleLabel(
          //                           tittle: title,
          //                           onChangeValue: () {
          //                             // Handle button press here
          //                             Exploracion.toJson(
          //                                 entries.keys.elementAt(index), title);
          //                             //
          //                             expoTextController.text =
          //                                 Exploracion.exploracionGeneral;
          //                           },
          //                         ))
          //                     .toList())
          //             // : Spinner(
          //             //     initialValue: '${Exploracion.initialValue}',
          //             //     items: List<String>.from(entries.values.elementAt(index)),
          //             //     onChangeValue: (String value) {
          //             //       Exploracion.toJson(
          //             //           entries.keys.elementAt(index), value);
          //             //       //
          //             //       setState(() {
          //             //         Exploracion.initialValue = value;
          //             //       });
          //             //       //
          //             //       expoTextController.text =
          //             //           Exploracion.exploracionGeneral;
          //             //     },
          //             //   )
          //             : Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: entries.values
          //                     .elementAt(index)
          //                     .map<Widget>((title) => Expanded(
          //                           child: CircleLabel(
          //                             tittle: title,
          //                             onChangeValue: () {
          //                               // Handle button press here
          //                               Exploracion.toJson(
          //                                   entries.keys.elementAt(index), title);
          //                               //
          //                               expoTextController.text =
          //                                   Exploracion.exploracionGeneral;
          //                             },
          //                           ),
          //                         ))
          //                     .toList())),
          //     Positioned(
          //       left: 5,
          //       top: 0,
          //       child: Container(
          //         color: Theming.bdColor,
          //         margin: const EdgeInsets.only(left: 20, right: 10, top: 2),
          //         padding: const EdgeInsets.only(left: 20, right: 10, top: 0),
          //         child: Text(descompose(entries.keys.elementAt(index)),
          //             style: const TextStyle(color: Colors.white, fontSize: 10)),
          //       ),
          //     ),
          //   ],
          // ));
    }

    return list;
  }

  descompose(String value) {
    return value.contains(RegExp(r'[A-Z]'))
        ? Sentences.capitalize(value.replaceRange(
            value.indexOf(RegExp(r'[A-Z]')),
            value.indexOf(RegExp(r'[A-Z]')) + 1,
            " ${RegExp(r'[A-Z]').stringMatch(value).toString()}"))
        : value;
  }

  // VARIABLES
  var expoTextController = TextEditingController();
  var carouselController = CarouselSliderController();

  // COMPONENTES ****************************************************
  _drawerForm(BuildContext context) => Drawer(
        width: 100,
        backgroundColor: Theming.cuaternaryColor,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.grey),
                bottom: BorderSide(color: Colors.grey),
                right: BorderSide(color: Colors.grey)),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16), topLeft: Radius.circular(16)),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: DrawerHeader(
                    child: CircleIcon(
                  difRadios: 15,
                  iconed: Icons.line_weight_sharp,
                  onChangeValue: () {},
                )),
              ),
              Expanded(
                  flex: 10,
                  child: Column(
                    children: _sidePanel(context),
                  )),
              CrossLine(thickness: 3, height: 20, color: Colors.grey),
              Expanded(
                flex: 2,
                child: CircleIcon(
                  radios: 30,
                  difRadios: 5,
                  tittle: 'Copiar Esquema del Reporte',
                  iconed: Icons.copy_all_sharp,
                  onChangeValue: () {
                    // Datos.portapapeles(
                    //     context: context,
                    //     text: Reportes.copiarReporte(
                    //         tipoReporte: getTypeReport()));
                    _key.currentState!.closeEndDrawer();
                  },
                ),
              ),
            ],
          ),
        ),
      );

  _endDrawerForm(BuildContext context) => Drawer(
    width: 100,
    backgroundColor: Theming.cuaternaryColor,
    child: Container(
      decoration: const BoxDecoration(
        border: Border(
            top: BorderSide(color: Colors.grey),
            bottom: BorderSide(color: Colors.grey),
            left: BorderSide(color: Colors.grey)),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16), topLeft: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: DrawerHeader(
                child: CircleIcon(
                  difRadios: 15,
                  iconed: Icons.line_weight_sharp,
                  onChangeValue: () {},
                )),
          ),
          Expanded(
              flex: 10,
              child: Column(
                children: _sidePanel(context),
              )),
          CrossLine(thickness: 3, height: 20, color: Colors.grey),
          Expanded(
            flex: 2,
            child: CircleIcon(
              radios: 30,
              difRadios: 5,
              tittle: 'Copiar Esquema del Reporte',
              iconed: Icons.copy_all_sharp,
              onChangeValue: () {
                // Datos.portapapeles(
                //     context: context,
                //     text: Reportes.copiarReporte(
                //         tipoReporte: getTypeReport()));
                _key.currentState!.closeEndDrawer();
              },
            ),
          ),
        ],
      ),
    ),
  );

  _centralPanel(BuildContext context) {
    return Expanded(
        flex: 3,
        child: Container(
          margin: const EdgeInsets.all(5.0),
          padding: widget.withoutAppBar == true
              ? const EdgeInsets.only(top: 10.0, bottom: 10.0)
              : const EdgeInsets.only(top: 75.0, bottom: 10.0),
          decoration: ContainerDecoration.roundedDecoration(
              colorBackground: Theming.bdColor),
          child: Column(
            children: [
              // _Infusiones(context),
              // CrossLine(thickness: 1, color: Colors.grey),
              EditTextArea(
                  textController: expoTextController,
                  labelEditText: "Exploración física",
                  keyBoardType: TextInputType.multiline,
                  numOfLines: 5,
                  inputFormat: MaskTextInputFormatter()),
              // ************************** **** *** **    *
              CrossLine(thickness: 2, color: Colors.grey),
              Row(
                children: [
                  Expanded(
                    child: Spinner(
                      tittle: 'Coloración Tegumentaria',
                      onChangeValue: (String value) {
                        setState(() {
                          Exploracion.coloracionTegumentaria = value;
                        });
                        Exploracion.toJson("coloracionTegumentaria", value);
                        //
                        expoTextController.text =
                            Exploracion.exploracionGeneral;
                      },
                      initialValue: Exploracion.coloracionTegumentaria,
                      items: Items.coloracionTegumentaria,
                    ),
                  ),
                  Expanded(
                    child: Spinner(
                      tittle: 'Coloración Mucosas',
                      onChangeValue: (String value) {
                        setState(() {
                          Exploracion.coloracionMucosas = value;
                        });
                        Exploracion.toJson("coloracionMucosas", value);
                        //
                        expoTextController.text =
                            Exploracion.exploracionGeneral;
                      },
                      initialValue: Exploracion.coloracionMucosas,
                      items: Items.coloracionMucosas,
                    ),
                  ),
                ],
              ),
              Expanded(flex: 6, child: _Terapias(context)),
            ],
          ),
        ));
  }

  //
  _primerRevision(BuildContext context) {
    return Expanded(
        flex: 2,
        child: ListView(
          controller: ScrollController(),
          children: [
            // 0: CVP **************************************************************
            TittleContainer(
              tittle: "                                      CVP ",
              color: Theming.quincuaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleSwitched(
                        tittle: "¿Diagnóstico actual?",
                        radios: 30,
                        difRadios: 5,
                        onChangeValue: (bool value) {
                          Terminal.printExpected(
                              message:
                              "Value $value : not value : ${!value}");
                          setState(() {
                            isActualCVPValue =
                            Dicotomicos.fromBoolean(!value) as String;
                            if (isActualCVPValue == 'Si') {
                              fechaEventoCVPTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            } else {
                              fechaEventoCVPTextController.text = '';
                            }
                          });
                        },
                        isSwitched:
                        Dicotomicos.fromString(isActualCVPValue)),
                  ),
                  Expanded(
                    flex: 4,
                    child: EditTextArea(
                      iconData: Icons.line_style,
                      keyBoardType: TextInputType.datetime,
                      inputFormat: MaskTextInputFormatter(
                          mask: '####/##/##',
                          filter: {"#": RegExp(r'[0-9]')},
                          type: MaskAutoCompletionType.lazy),
                      labelEditText: 'Fecha del Evento',
                      textController: fechaEventoCVPTextController,
                      numOfLines: 1,
                      selection: true,
                      withShowOption: true,
                      optionEqui: 6,
                      onSelected: () {
                        fechaEventoCVPTextController.text =
                            Calendarios.today(format: 'yyyy/MM/dd');
                      },
                    ),
                  ),
                ],
              ),
            ),
            // 1: CVLP **************************************************************
            TittleContainer(
              tittle: "                                      CVLP ",
              color: Theming.quincuaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleSwitched(
                        tittle: "¿Diagnóstico actual?",
                        radios: 30,
                        difRadios: 5,
                        onChangeValue: (bool value) {
                          Terminal.printExpected(
                              message:
                              "Value $value : not value : ${!value}");
                          setState(() {
                            isActualCVLPValue =
                            Dicotomicos.fromBoolean(!value) as String;
                            if (isActualCVLPValue == 'Si') {
                              fechaEventoCVLPTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            } else {
                              fechaEventoCVLPTextController.text = '';
                            }
                          });
                        },
                        isSwitched:
                        Dicotomicos.fromString(isActualCVLPValue)),
                  ),
                  Expanded(
                    flex: 4,
                    child: EditTextArea(
                      iconData: Icons.line_style,
                      keyBoardType: TextInputType.datetime,
                      inputFormat: MaskTextInputFormatter(
                          mask: '####/##/##',
                          filter: {"#": RegExp(r'[0-9]')},
                          type: MaskAutoCompletionType.lazy),
                      labelEditText: 'Fecha del Evento',
                      textController: fechaEventoCVLPTextController,
                      numOfLines: 1,
                      selection: true,
                      withShowOption: true,
                      optionEqui: 6,
                      onSelected: () {
                        fechaEventoCVLPTextController.text =
                            Calendarios.today(format: 'yyyy/MM/dd');
                      },
                    ),
                  ),
                ],
              ),
            ),
            // 2: CVC **************************************************************
            TittleContainer(
              tittle: "                                      CVC ",
              color: Theming.quincuaryColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleSwitched(
                        tittle: "¿Diagnóstico actual?",
                        radios: 30,
                        difRadios: 5,
                        onChangeValue: (bool value) {
                          Terminal.printExpected(
                              message:
                              "Value $value : not value : ${!value}");
                          setState(() {
                            isActualCVCValue =
                            Dicotomicos.fromBoolean(!value) as String;
                            if (isActualCVCValue == 'Si') {
                              fechaEventoCVCTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            } else {
                              fechaEventoCVCTextController.text = '';
                            }
                          });
                        },
                        isSwitched:
                        Dicotomicos.fromString(isActualCVCValue)),
                  ),
                  Expanded(
                    flex: 4,
                    child: EditTextArea(
                      iconData: Icons.line_style,
                      keyBoardType: TextInputType.datetime,
                      inputFormat: MaskTextInputFormatter(
                          mask: '####/##/##',
                          filter: {"#": RegExp(r'[0-9]')},
                          type: MaskAutoCompletionType.lazy),
                      labelEditText: 'Fecha del Evento',
                      textController: fechaEventoCVCTextController,
                      numOfLines: 1,
                      selection: true,
                      withShowOption: true,
                      optionEqui: 6,
                      onSelected: () {
                        fechaEventoCVCTextController.text =
                            Calendarios.today(format: 'yyyy/MM/dd');
                      },
                    ),
                  ),
                ],
              ),
            ),
            // 3: MAHA **************************************************************
            TittleContainer(
              tittle: "                                      MAHA ",
              color: Theming.quincuaryColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleSwitched(
                        tittle: "¿Diagnóstico actual?",
                        radios: 30,
                        difRadios: 5,
                        onChangeValue: (bool value) {
                          Terminal.printExpected(
                              message:
                              "Value $value : not value : ${!value}");
                          setState(() {
                            isActualMAHAValue =
                            Dicotomicos.fromBoolean(!value) as String;
                            if (isActualMAHAValue == 'Si') {
                              fechaEventoMAHATextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            } else {
                              fechaEventoMAHATextController.text = '';
                            }
                          });
                        },
                        isSwitched:
                        Dicotomicos.fromString(isActualMAHAValue)),
                  ),
                  Expanded(
                    flex: 4,
                    child: EditTextArea(
                      iconData: Icons.line_style,
                      keyBoardType: TextInputType.datetime,
                      inputFormat: MaskTextInputFormatter(
                          mask: '####/##/##',
                          filter: {"#": RegExp(r'[0-9]')},
                          type: MaskAutoCompletionType.lazy),
                      labelEditText: 'Fecha del Evento',
                      textController: fechaEventoMAHATextController,
                      numOfLines: 1,
                      selection: true,
                      withShowOption: true,
                      optionEqui: 6,
                      onSelected: () {
                        fechaEventoMAHATextController.text =
                            Calendarios.today(format: 'yyyy/MM/dd');
                      },
                    ),
                  ),
                ],
              ),
            ),
            // 4: FOL **************************************************************
            TittleContainer(
              tittle: "                                      FOL ",
              color: Theming.quincuaryColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleSwitched(
                        tittle: "¿Diagnóstico actual?",
                        radios: 30,
                        difRadios: 5,
                        onChangeValue: (bool value) {
                          Terminal.printExpected(
                              message:
                              "Value $value : not value : ${!value}");
                          setState(() {
                            isActualFOLValue =
                            Dicotomicos.fromBoolean(!value) as String;
                            if (isActualFOLValue == 'Si') {
                              fechaEventoFOLTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            } else {
                              fechaEventoFOLTextController.text = '';
                            }
                          });
                        },
                        isSwitched:
                        Dicotomicos.fromString(isActualFOLValue)),
                  ),
                  Expanded(
                    flex: 4,
                    child: EditTextArea(
                      iconData: Icons.line_style,
                      keyBoardType: TextInputType.datetime,
                      inputFormat: MaskTextInputFormatter(
                          mask: '####/##/##',
                          filter: {"#": RegExp(r'[0-9]')},
                          type: MaskAutoCompletionType.lazy),
                      labelEditText: 'Fecha del Evento',
                      textController: fechaEventoFOLTextController,
                      numOfLines: 1,
                      selection: true,
                      withShowOption: true,
                      optionEqui: 6,
                      onSelected: () {
                        fechaEventoFOLTextController.text =
                            Calendarios.today(format: 'yyyy/MM/dd');
                      },
                    ),
                  ),
                ],
              ),
            ),
            // 5: SNG **************************************************************
            TittleContainer(
              tittle: "                                      SNG ",
              color: Theming.quincuaryColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleSwitched(
                        tittle: "¿Diagnóstico actual?",
                        radios: 30,
                        difRadios: 5,
                        onChangeValue: (bool value) {
                          Terminal.printExpected(
                              message:
                              "Value $value : not value : ${!value}");
                          setState(() {
                            isActualSNGValue =
                            Dicotomicos.fromBoolean(!value) as String;
                            if (isActualSNGValue == 'Si') {
                              fechaEventoSNGTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            } else {
                              fechaEventoSNGTextController.text = '';
                            }
                          });
                        },
                        isSwitched:
                        Dicotomicos.fromString(isActualSNGValue)),
                  ),
                  Expanded(
                    flex: 4,
                    child: EditTextArea(
                      iconData: Icons.line_style,
                      keyBoardType: TextInputType.datetime,
                      inputFormat: MaskTextInputFormatter(
                          mask: '####/##/##',
                          filter: {"#": RegExp(r'[0-9]')},
                          type: MaskAutoCompletionType.lazy),
                      labelEditText: 'Fecha del Evento',
                      textController: fechaEventoSNGTextController,
                      numOfLines: 1,
                      selection: true,
                      withShowOption: true,
                      optionEqui: 6,
                      onSelected: () {
                        fechaEventoSNGTextController.text =
                            Calendarios.today(format: 'yyyy/MM/dd');
                      },
                    ),
                  ),
                ],
              ),
            ),
            // : : ******************************
            CircleSwitched(
                tittle: "Agregar . . . ",
                radios: 30,
                difRadios: 5,
                onChangeValue: (bool value) =>_operationMethod(),
                isSwitched: true),
          ],
        ));
  }

  _segunndaRevision(BuildContext context) {
    return Expanded(
      flex: 2,
      child: ListView(
        // controller: _pageController,
        controller: ScrollController(),
        children: [
          // 6: SOG **************************************************************
          TittleContainer(
            tittle: "                                      SOG ",
            color: Theming.quincuaryColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: CircleSwitched(
                      radios: 30,
                      difRadios: 5,
                      tittle: "¿Diagnóstico actual?",
                      onChangeValue: (bool value) {
                        Terminal.printExpected(
                            message:
                            "Value $value : not value : ${!value}");
                        setState(() {
                          isActualSOGValue =
                          Dicotomicos.fromBoolean(!value) as String;
                          if (isActualSOGValue == 'Si') {
                            fechaEventoSOGTextController.text =
                                Calendarios.today(format: 'yyyy/MM/dd');
                          } else {
                            fechaEventoSOGTextController.text = '';
                          }
                        });
                      },
                      isSwitched:
                      Dicotomicos.fromString(isActualSOGValue)),
                ),
                Expanded(
                  flex: 4,
                  child: EditTextArea(
                    iconData: Icons.line_style,
                    keyBoardType: TextInputType.datetime,
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    labelEditText: 'Fecha del Evento',
                    textController: fechaEventoSOGTextController,
                    numOfLines: 1,
                    selection: true,
                    withShowOption: true,
                    optionEqui: 6,
                    onSelected: () {
                      fechaEventoSOGTextController.text =
                          Calendarios.today(format: 'yyyy/MM/dd');
                    },
                  ),
                ),
              ],
            ),
          ),
          // 7: PEN **************************************************************
          TittleContainer(
            tittle: "                                      PEN ",
            color: Theming.quincuaryColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: CircleSwitched(
                      radios: 30,
                      difRadios: 5,
                      tittle: "¿Diagnóstico actual?",
                      onChangeValue: (bool value) {
                        Terminal.printExpected(
                            message:
                            "Value $value : not value : ${!value}");
                        setState(() {
                          isActualPENValue =
                          Dicotomicos.fromBoolean(!value) as String;
                          if (isActualPENValue == 'Si') {
                            fechaEventoPENTextController.text =
                                Calendarios.today(format: 'yyyy/MM/dd');
                          } else {
                            fechaEventoPENTextController.text = '';
                          }
                        });
                      },
                      isSwitched:
                      Dicotomicos.fromString(isActualPENValue)),
                ),
                Expanded(
                  flex: 4,
                  child: EditTextArea(
                    iconData: Icons.line_style,
                    keyBoardType: TextInputType.datetime,
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    labelEditText: 'Fecha del Evento',
                    textController: fechaEventoPENTextController,
                    numOfLines: 1,
                    selection: true,
                    withShowOption: true,
                    optionEqui: 6,
                    onSelected: () {
                      fechaEventoPENTextController.text =
                          Calendarios.today(format: 'yyyy/MM/dd');
                    },
                  ),
                ),
              ],
            ),
          ),
          // 8 : COL **************************************************************
          TittleContainer(
            tittle: "                                      COL ",
            color: Theming.quincuaryColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: CircleSwitched(
                      radios: 30,
                      difRadios: 5,
                      tittle: "¿Diagnóstico actual?",
                      onChangeValue: (bool value) {
                        Terminal.printExpected(
                            message:
                            "Value $value : not value : ${!value}");
                        setState(() {
                          isActualCOLValue =
                          Dicotomicos.fromBoolean(!value) as String;
                          if (isActualCOLValue == 'Si') {
                            fechaEventoCOLTextController.text =
                                Calendarios.today(format: 'yyyy/MM/dd');
                          } else {
                            fechaEventoCOLTextController.text = '';
                          }
                        });
                      },
                      isSwitched:
                      Dicotomicos.fromString(isActualCOLValue)),
                ),
                Expanded(
                  flex: 4,
                  child: EditTextArea(
                    iconData: Icons.line_style,
                    keyBoardType: TextInputType.datetime,
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    labelEditText: 'Fecha del Evento',
                    textController: fechaEventoCOLTextController,
                    numOfLines: 1,
                    selection: true,
                    withShowOption: true,
                    optionEqui: 6,
                    onSelected: () {
                      fechaEventoCOLTextController.text =
                          Calendarios.today(format: 'yyyy/MM/dd');
                    },
                  ),
                ),
              ],
            ),
          ),
          // 9 : SEP ***************************************************************
          TittleContainer(
            tittle: "                                      SEP ",
            color: Theming.quincuaryColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: CircleSwitched(
                      radios: 30,
                      difRadios: 5,
                      tittle: "¿Diagnóstico actual?",
                      onChangeValue: (bool value) {
                        Terminal.printExpected(
                            message:
                            "Value $value : not value : ${!value}");
                        setState(() {
                          isActualSEPValue =
                          Dicotomicos.fromBoolean(!value) as String;
                          if (isActualSEPValue == 'Si') {
                            fechaEventoSEPTextController.text =
                                Calendarios.today(format: 'yyyy/MM/dd');
                          } else {
                            fechaEventoSEPTextController.text = '';
                          }
                        });
                      },
                      isSwitched:
                      Dicotomicos.fromString(isActualSEPValue)),
                ),
                Expanded(
                  flex: 4,
                  child: EditTextArea(
                    iconData: Icons.line_style,
                    keyBoardType: TextInputType.datetime,
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    labelEditText: 'Fecha del Evento',
                    textController: fechaEventoSEPTextController,
                    numOfLines: 1,
                    selection: true,
                    withShowOption: true,
                    optionEqui: 6,
                    onSelected: () {
                      fechaEventoSEPTextController.text =
                          Calendarios.today(format: 'yyyy/MM/dd');
                    },
                  ),
                ),
              ],
            ),
          ),
          // 10 : GAS **************************************************************
          TittleContainer(
            tittle: "                                      GAS ",
            color: Theming.quincuaryColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: CircleSwitched(
                      radios: 30,
                      difRadios: 5,
                      tittle: "¿Diagnóstico actual?",
                      onChangeValue: (bool value) {
                        Terminal.printExpected(
                            message:
                            "Value $value : not value : ${!value}");
                        setState(() {
                          isActualGASValue =
                          Dicotomicos.fromBoolean(!value) as String;
                          if (isActualGASValue == 'Si') {
                            fechaEventoGASTextController.text =
                                Calendarios.today(format: 'yyyy/MM/dd');
                          } else {
                            fechaEventoGASTextController.text = '';
                          }
                        });
                      },
                      isSwitched:
                      Dicotomicos.fromString(isActualGASValue)),
                ),
                Expanded(
                  flex: 4,
                  child: EditTextArea(
                    iconData: Icons.line_style,
                    keyBoardType: TextInputType.datetime,
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    labelEditText: 'Fecha del Evento',
                    textController: fechaEventoGASTextController,
                    numOfLines: 1,
                    selection: true,
                    withShowOption: true,
                    optionEqui: 6,
                    onSelected: () {
                      fechaEventoGASTextController.text =
                          Calendarios.today(format: 'yyyy/MM/dd');
                    },
                  ),
                ),
              ],
            ),
          ),
          // 11: TNK **************************************************************
          TittleContainer(
            tittle: "                                      TNK ",
            color: Theming.quincuaryColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: CircleSwitched(
                      radios: 30,
                      difRadios: 5,
                      tittle: "¿Diagnóstico actual?",
                      onChangeValue: (bool value) {
                        Terminal.printExpected(
                            message:
                            "Value $value : not value : ${!value}");
                        setState(() {
                          isActualTNKValue =
                          Dicotomicos.fromBoolean(!value) as String;
                          if (isActualTNKValue == 'Si') {
                            fechaEventoTNKTextController.text =
                                Calendarios.today(format: 'yyyy/MM/dd');
                          } else {
                            fechaEventoTNKTextController.text = '';
                          }
                        });
                      },
                      isSwitched:
                      Dicotomicos.fromString(isActualTNKValue)),
                ),
                Expanded(
                  flex: 4,
                  child: EditTextArea(
                    iconData: Icons.line_style,
                    keyBoardType: TextInputType.datetime,
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    labelEditText: 'Fecha del Evento',
                    textController: fechaEventoTNKTextController,
                    numOfLines: 1,
                    selection: true,
                    withShowOption: true,
                    optionEqui: 6,
                    onSelected: () {
                      fechaEventoTNKTextController.text =
                          Calendarios.today(format: 'yyyy/MM/dd');
                    },
                  ),
                ),
              ],
            ),
          ),
          // : : ******************************
          CircleSwitched(
              tittle: "Agregar . . . ",
              radios: 30,
              difRadios: 5,
              onChangeValue: (bool value) =>_operationMethod(),
              isSwitched: false),
        ],
      ),
    );
  }

  //
  _appBar(BuildContext context) => AppBar(
        foregroundColor: Colors.white,
        shape: CustomShapeBorder(),
        backgroundColor: Colors.black,
        centerTitle: true,
        // title: CircleIcon(
        //     iconed: Icons.drag_indicator_sharp,
        //     tittle: "Menu",
        //     onChangeValue: () {
        //       _key.currentState!.openEndDrawer();
        //       _key.currentState!.openDrawer();
        //     }),
        toolbarHeight: 80.0,
        elevation: 0,
        // title: CircleIcon(
        //     iconed: Icons.person,
        //     tittle: Sentences.app_bar_usuarios,
        //     onChangeValue: () {}),
        actions: [
          GrandIcon(
              iconData: Icons.receipt,
              labelButton: "Generales . . . ",
              onPress: () => Cambios.toNextActivity(context,
                  tittle: 'Generales diarios del Paciente . . . ',
                  chyld:  Generales())),
          CrossLine(height: 15, isHorizontal: false, thickness: 2),
          GrandIcon(
              iconData: Icons.drag_indicator_sharp,
              labelButton: "Menu",
              onPress: () {
                _key.currentState!.openEndDrawer();

              }),
          CrossLine(height: 15, isHorizontal: false, thickness: 0),
        ],
      );

  late AnimationController animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 250));
  final menuIsOpen = ValueNotifier(false);
  _floattingActionButton(BuildContext context) => Flow(
        delegate:
            FlowVerticalDelegate(animationController: animationController),
        children: [
          FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              backgroundColor: Colors.black,
              onPressed: () {
                toogleMenu();
              },
              child: const Icon(
                Icons.menu_rounded,
                color: Colors.white,
              )),
          FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              toogleMenu();
            },
            child: const Icon(
              Icons.ice_skating,
              color: Colors.white,
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () => showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: Theming.cuaternaryColor,
                      border: Border(
                          top: BorderSide(color: Colors.grey),
                          right: BorderSide(color: Colors.grey),
                          left: BorderSide(color: Colors.grey)),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16)),
                    ),
                    child: _downPanel(context),
                  );
                }),
            child: const Icon(
              Icons.ice_skating,
              color: Colors.white,
            ),
          )
        ],
      );

  _downPanel(BuildContext context) => Column(
        children: [
          Expanded(
            child: GrandLabel(
                labelButton: 'Copiar en Portapapeles . . . ',
                onPress: () => Datos.portapapeles(
                    context: context, text: Exploracion.exploracionGeneral)),
          ),
          Expanded(
            flex: 5,
            child: _Terapias(context),
          ),
        ],
      );

  _sidePanel(BuildContext context) => <Widget>[];

  /// Panel de Terapias . . .
  _Terapias(BuildContext context) => TittleContainer(
        centered: true,
        tittle: "Valoración en Terapia Intensiva",
        child: Padding(
          padding: EdgeInsets.all(isMobile(context) ? 5.0 : 5.0),
          child: CarouselSlider(
              items: [
                TittleContainer(
                  tittle: "Evaluación Neurológica",
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 200
                                    : isTablet(context)
                                        ? 100
                                        : isMobile(context)
                                            ? 65
                                            : 300,
                                tittle: 'R.A.S.S.',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.rass = value;
                                    reInit();
                                  });
                                },
                                items: Escalas.RASS,
                                initialValue: Exploracion.rass,
                              ),
                            ),
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 200
                                    : isTablet(context)
                                        ? 100
                                        : isMobile(context)
                                            ? 65
                                            : 300,
                                tittle: 'Ramsay',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.ramsay = value;
                                    reInit();
                                  });
                                },
                                items: Escalas.ramsay,
                                initialValue: Exploracion.ramsay,
                              ),
                            ),
                          ],
                        ),
                        Spinner(
                          width: isLargeDesktop(context)
                              ? 700
                              : isDesktop(context)
                                  ? 300
                                  : isTablet(context)
                                      ? 250
                                      : isMobile(context)
                                          ? 216
                                          : 300,
                          tittle: 'Sedo-analgesia',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.sedoanalgesia = value;
                              reInit();
                            });
                          },
                          items: Items.sedacion,
                          initialValue: Exploracion.sedoanalgesia,
                        ),
                        CrossLine(),
                      ],
                    ),
                  ),
                ),
                TittleContainer(
                  tittle: "Evaluación Neuromuscular",
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 200
                                    : isTablet(context)
                                        ? 100
                                        : isMobile(context)
                                            ? 65
                                            : 300,
                                tittle: 'Asworth',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.ashworth = value;
                                    reInit();
                                  });
                                },
                                items: Escalas.ashworth,
                                initialValue: Exploracion.ashworth,
                              ),
                            ),
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 200
                                    : isTablet(context)
                                        ? 100
                                        : isMobile(context)
                                            ? 65
                                            : 300,
                                tittle: 'Daniels',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.daniels = value;
                                    reInit();
                                  });
                                },
                                items: Escalas.daniels,
                                initialValue: Exploracion.daniels,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 200
                                    : isTablet(context)
                                        ? 100
                                        : isMobile(context)
                                            ? 65
                                            : 300,
                                tittle: 'Siedel',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.siedel = value;
                                    reInit();
                                  });
                                },
                                items: Escalas.siedel,
                                initialValue: Exploracion.siedel,
                              ),
                            ),
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 200
                                    : isTablet(context)
                                        ? 100
                                        : isMobile(context)
                                            ? 65
                                            : 300,
                                tittle: 'M.R.C.',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.mrc = value;
                                    reInit();
                                  });
                                },
                                items: Escalas.MRC,
                                initialValue: Exploracion.mrc,
                              ),
                            ),
                          ],
                        ),
                        CrossLine(),
                      ],
                    ),
                  ),
                ),
                TittleContainer(
                  tittle: "Evaluación Ventilatoria",
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 200
                                    : isTablet(context)
                                        ? 200
                                        : isMobile(context)
                                            ? 216
                                            : 300,
                                tittle: 'Fase ventilatoria',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.faseVentilatoria = value;
                                    reInit();
                                  });
                                },
                                items: Items.ventilatorio,
                                initialValue: Exploracion.faseVentilatoria,
                              ),
                            ),
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 500
                                    : isTablet(context)
                                        ? 350
                                        : isMobile(context)
                                            ? 216
                                            : 300,
                                tittle: 'Dispositivo empleado',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.dispositivoEmpleado = value;
                                    reInit();
                                  });
                                },
                                items: Items.dispositivosOxigeno,
                                initialValue: Exploracion.dispositivoEmpleado,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 200
                                    : isTablet(context)
                                        ? 200
                                        : isMobile(context)
                                            ? 216
                                            : 300,
                                tittle: 'Tubo Endotraqueal',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.tuboEndotraqueal = value;
                                    reInit();
                                  });
                                },
                                items: Items.tuboendotraqueal,
                                initialValue: Exploracion.tuboEndotraqueal,
                              ),
                            ),
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 200
                                    : isTablet(context)
                                        ? 200
                                        : isMobile(context)
                                            ? 216
                                            : 300,
                                tittle: 'Distancia a arcada',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.haciaArcadaDentaria = value;
                                    reInit();
                                  });
                                },
                                items: Items.arcadaDentaria,
                                initialValue: Exploracion.haciaArcadaDentaria,
                              ),
                            ),
                          ],
                        ),
                        CrossLine(),
                      ],
                    ),
                  ),
                ),
                TittleContainer(
                  tittle: "Evaluación Hematoinfecciosa",
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 200
                                    : isTablet(context)
                                        ? 200
                                        : isMobile(context)
                                            ? 216
                                            : 300,
                                tittle: 'Riesgo por úlcera',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.evaluacionBraden = value;
                                    reInit();
                                  });
                                },
                                items: Escalas.braden,
                                initialValue: Exploracion.evaluacionBraden,
                              ),
                            ),
                            Expanded(
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 200
                                    : isTablet(context)
                                        ? 200
                                        : isMobile(context)
                                            ? 216
                                            : 300,
                                tittle: 'Riesgo por Inmovilidad',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.evaluacionNorton = value;
                                    reInit();
                                  });
                                },
                                items: Escalas.norton,
                                initialValue: Exploracion.evaluacionNorton,
                              ),
                            ),
                          ],
                        ),
                        Spinner(
                          width: isDesktop(context)
                              ? 500
                              : isTablet(context)
                                  ? 500
                                  : isMobile(context)
                                      ? 216
                                      : 300,
                          tittle: 'Antibioticoterapia',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.antibioticoterapia = value;
                              reInit();
                            });
                          },
                          items: Items.antibioticoterapia,
                          initialValue: Exploracion.antibioticoterapia,
                        ),
                      ],
                    ),
                  ),
                ),
                TittleContainer(
                  tittle: "Evaluación Complementaria",
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        Spinner(
                          width: isDesktop(context)
                              ? 500
                              : isTablet(context)
                                  ? 250
                                  : isMobile(context)
                                      ? 216
                                      : 300,
                          tittle: 'Apoyo Aminérgico',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.apoyoAminergico = value;
                              reInit();
                            });
                          },
                          items: Items.aminergico,
                          initialValue: Exploracion.apoyoAminergico,
                        ),
                        // _Infusiones(context),
                        Spinner(
                          width: isDesktop(context)
                              ? 500
                              : isTablet(context)
                                  ? 200
                                  : isMobile(context)
                                      ? 216
                                      : 300,
                          tittle: 'Dieta Establecida',
                          onChangeValue: (value) {
                            setState(() {
                              Exploracion.alimentacion = value;
                              reInit();
                            });
                          },
                          items: Items.dieta,
                          initialValue: Exploracion.alimentacion,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 170
                                    : isTablet(context)
                                        ? 200
                                        : isMobile(context)
                                            ? 216
                                            : 300,
                                tittle: 'Sonda Oro/Nasogástrica',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.tipoSondaAlimentacion = value;
                                    reInit();
                                  });
                                },
                                items: Items.orogastrico,
                                initialValue: Exploracion.tipoSondaAlimentacion,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Spinner(
                                width: isDesktop(context)
                                    ? 110
                                    : isTablet(context)
                                        ? 200
                                        : isMobile(context)
                                            ? 216
                                            : 300,
                                tittle: 'Sonda Foley',
                                onChangeValue: (value) {
                                  setState(() {
                                    Exploracion.tipoSondaVesical = value;
                                    reInit();
                                  });
                                },
                                items: Items.foley,
                                initialValue: Exploracion.tipoSondaVesical,
                              ),
                            ),
                          ],
                        ),
                        CrossLine(),
                      ],
                    ),
                  ),
                ),
              ],
              carouselController: carouselController,
              options: Carousel.carouselOptions(context: context)),
        ),
      );

  _Infusiones(BuildContext context) => TittleContainer(
        tittle: 'Infusiones',
        child: Row(
          children: [
            Expanded(
              child: ValuePanel(
                  heigth: 60,
                  firstText: 'Noradrenalina',
                  secondText:
                      Vasoactivos.getNoradrenalina().toStringAsFixed(2) +
                          " mcg/Kg/min",
                  withEditMessage: true,
                  onEdit: (value) {
                    Operadores.editActivity(
                        context: context,
                        tittle: "Editar . . . ",
                        message: "¿Noradrenalina (mL/Hr)? . . . ",
                        onAcept: (value) {
                          // Terminal.printSuccess(
                          //     message:
                          //         "recieve $value");
                          setState(() {
                            Vasoactivos.noradrenalina = double.parse(value);
                            Navigator.of(context).pop();
                          });
                        });
                  }),
            ),
            Expanded(
              child: ValuePanel(
                heigth: 60,
                firstText: 'Midazolam',
              ),
            ),
            Expanded(
              child: ValuePanel(
                heigth: 60,
                firstText: 'Buprenorfina',
              ),
            ),
          ],
        ),
      );

  // FUNCIONES
  void reInit() {
    if (widget.esCorto!) {
      Reportes.exploracionFisica = Formatos.exploracionTerapiaCorta;
      Reportes.reportes['Exploracion_Fisica'] =
          Formatos.exploracionTerapiaCorta;
    } else {
      Reportes.exploracionFisica = Formatos.exploracionTerapia;
      Reportes.reportes['Exploracion_Fisica'] = Formatos.exploracionTerapia;
    }
  }

  toogleMenu() {
    print("menuIsOpen.value : ${menuIsOpen.value}");
    menuIsOpen.value
        ? animationController.reverse()
        : animationController.forward();
    menuIsOpen.value = !menuIsOpen.value;
  }


  // METHODS ***************************************
  List<List<dynamic>> listOfValues() {
    return [
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualCVPValue),
        tipoIncidenciaCVPTextController.text,
        eventualidadCVPTextController.text,
        fechaEventoCVPTextController.text,
        "",
        "",
      ], // 0 : CVP
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualCVLPValue),
        tipoIncidenciaCVLPTextController.text,
        eventualidadCVLPTextController.text,
        fechaEventoCVLPTextController.text,
        "",
        "",
      ], // 1 : CVLP
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualCVCValue),
        tipoIncidenciaCVCTextController.text,
        eventualidadCVCTextController.text,
        fechaEventoCVCTextController.text,
        "",
        "",
      ], // 2 : CVC
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualMAHAValue),
        tipoIncidenciaMAHATextController.text,
        eventualidadMAHATextController.text,
        fechaEventoMAHATextController.text,
        "",
        "",
      ], // 3 : MAHA
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualFOLValue),
        tipoIncidenciaFOLTextController.text,
        eventualidadFOLTextController.text,
        fechaEventoFOLTextController.text,
        "",
        "",
      ], // 4 : FOL
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualSNGValue),
        tipoIncidenciaSNGTextController.text,
        eventualidadSNGTextController.text,
        fechaEventoSNGTextController.text,
        "",
        "",
      ], // 5 : SNG
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualSOGValue),
        tipoIncidenciaSOGTextController.text,
        eventualidadSOGTextController.text,
        fechaEventoSOGTextController.text,
        "",
        "",
      ], // 6 : SOG
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualPENValue),
        tipoIncidenciaPENTextController.text,
        eventualidadPENTextController.text,
        fechaEventoPENTextController.text,
        "",
        "",
      ], // 7 : PEN
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualCOLValue),
        tipoIncidenciaCOLTextController.text,
        eventualidadCOLTextController.text,
        fechaEventoCOLTextController.text,
        "",
        "",
      ], // 8 : COL
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualSEPValue),
        tipoIncidenciaSEPTextController.text,
        eventualidadSEPTextController.text,
        fechaEventoSEPTextController.text,
        "",
        "",
      ], // 9 : SEP
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualGASValue),
        tipoIncidenciaGASTextController.text,
        eventualidadGASTextController.text,
        fechaEventoGASTextController.text,
        "",
        "",
      ], // 10 : GAS
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualTNKValue),
        tipoIncidenciaTNKTextController.text,
        eventualidadTNKTextController.text,
        fechaEventoTNKTextController.text,
        "",
        "",
      ], // 11 : TNK
    ];
  }

  // VARIABLES DE LA INTERFAZ ******** ******* * * *  *
  String appBarTitile = "Revisión General del Paciente . . . ";
  String? consultIdQuery = Situaciones.situacion['consultIdQuery'];
  String consultAllIdQuery = Situaciones.situacion['consultIdQuery'];
  String? registerQuery = Situaciones.situacion['registerQuery'];
  String? updateQuery = Situaciones.situacion['updateQuery'];
  // ****************************************************
  String databaseQuery = Databases.siteground_database_reghosp;
// ****************************************************
  int idOperation = 0;

  // Variables de Operación *********************************

  // 0: CVP **************************************************************
  var isActualCVPValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaCVPTextController = TextEditingController(),
      eventualidadCVPTextController = TextEditingController(),
      fechaEventoCVPTextController = TextEditingController();
  // var observacionesEventoCVPTextController = TextEditingController(),
  //     otrosEventoCVPTextController = TextEditingController();
  // 1: CVLP **************************************************************
  var isActualCVLPValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaCVLPTextController = TextEditingController(),
      eventualidadCVLPTextController = TextEditingController(),
      fechaEventoCVLPTextController = TextEditingController();
  // var observacionesEventoCVLPTextController = TextEditingController(),
  //     otrosEventoCVLPTextController = TextEditingController();
  // 2: CVC **************************************************************
  var isActualCVCValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaCVCTextController = TextEditingController(),
      eventualidadCVCTextController = TextEditingController(),
      fechaEventoCVCTextController = TextEditingController();
  // var observacionesEventoCVCTextController = TextEditingController(),
  //     otrosEventoCVCTextController = TextEditingController();
  // 3: MAHA **************************************************************
  var isActualMAHAValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaMAHATextController = TextEditingController(),
      eventualidadMAHATextController = TextEditingController(),
      fechaEventoMAHATextController = TextEditingController();
  // var observacionesEventoMAHATextController = TextEditingController(),
  //     otrosEventoMAHATextController = TextEditingController();
  // 4: FOL **************************************************************
  var isActualFOLValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaFOLTextController = TextEditingController(),
      eventualidadFOLTextController = TextEditingController(),
      fechaEventoFOLTextController = TextEditingController();
  // var observacionesEventoFOLTextController = TextEditingController(),
  //     otrosEventoFOLTextController = TextEditingController();
  // 5: SNG **************************************************************
  var isActualSNGValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaSNGTextController = TextEditingController(),
      eventualidadSNGTextController = TextEditingController(),
      fechaEventoSNGTextController = TextEditingController();
  // var observacionesEventoSNGTextController = TextEditingController(),
  //     otrosEventoSNGTextController = TextEditingController();
  // 6: SOG **************************************************************
  var isActualSOGValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaSOGTextController = TextEditingController(),
      eventualidadSOGTextController = TextEditingController(),
      fechaEventoSOGTextController = TextEditingController();
  // var observacionesEventoSOGTextController = TextEditingController(),
  //     otrosEventoSOGTextController = TextEditingController();
  // 7: PEN **************************************************************
  var isActualPENValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaPENTextController = TextEditingController(),
      eventualidadPENTextController = TextEditingController(),
      fechaEventoPENTextController = TextEditingController();
  // var observacionesEventoPENTextController = TextEditingController(),
  //     otrosEventoPENTextController = TextEditingController();
  // 8 : COL **************************************************************
  var isActualCOLValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaCOLTextController = TextEditingController(),
      eventualidadCOLTextController = TextEditingController(),
      fechaEventoCOLTextController = TextEditingController();
  // var observacionesEventoCOLTextController = TextEditingController(),
  //     otrosEventoCOLTextController = TextEditingController();
  // 9 : SEP ***************************************************************
  var isActualSEPValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaSEPTextController = TextEditingController(),
      eventualidadSEPTextController = TextEditingController(),
      fechaEventoSEPTextController = TextEditingController();
  // var observacionesEventoSEPTextController = TextEditingController(),
  //     otrosEventoSEPTextController = TextEditingController();
  // 10 : GAS **************************************************************
  var isActualGASValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaGASTextController = TextEditingController(),
      eventualidadGASTextController = TextEditingController(),
      fechaEventoGASTextController = TextEditingController();
  // var observacionesEventoGASTextController = TextEditingController(),
  //     otrosEventoGASTextController = TextEditingController();
  // 11: TNK **************************************************************
  var isActualTNKValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaTNKTextController = TextEditingController(),
      eventualidadTNKTextController = TextEditingController(),
      fechaEventoTNKTextController = TextEditingController();
  // var observacionesEventoTNKTextController = TextEditingController(),
  //     otrosEventoTNKTextController = TextEditingController();

  // Auxiliares *******************************************
  int index = 0;
  String? tipoEstudioValue;

  // OPERACIONES DE LA INTERFAZ ****************** ********
  _operationMethod() async {
    Operadores.loadingActivity(
        context: context,
        tittle: "Registrando información . . .",
        message: "Información registrada",
        onCloss: () {
          // Navigator.of(context).pop();
          // cerrar();
        });
    //
    Future.forEach(listOfValues(), (element) async {
      var aux = element as List<dynamic>;

      if (aux.isNotEmpty) {
        if (aux[2] == true) {
          await Actividades.registrar(
            Databases.siteground_database_reghosp,
            Situaciones.situacion['registerQuery'],
            element,
          );
        }
      }
    }).whenComplete(() {
      Situaciones.consultarRegistro();
      //
      Navigator.of(context).pop(); // Cierre del LoadActivity
      Operadores.alertActivity(
          context: context,
          tittle: "Registrando información . . .",
          message: "Información registrada",
          onAcept: () {
            // Se emplean 3 Navigator.of(context).pop(); para cerrar cada una de
            //    las ventanas emergentes y la interfaz inicial.
            //
            Navigator.of(context).pop(); // Cierre del AlertActivity
          });

    }).onError((error, stackTrace) {
      Pacientes.getParaclinicosHistorial(reload: true).whenComplete(() {
        Terminal.printAlert(message: "ERROR - $error : : : $stackTrace");
        Operadores.alertActivity(
          context: context,
          tittle: "$error . . .",
          message: "$stackTrace",
        );
      });
      //
    });
  }


}


