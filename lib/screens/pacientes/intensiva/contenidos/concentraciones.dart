import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/ShowText.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/ValuePanel.dart';

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Concentraciones extends StatefulWidget {
  const Concentraciones({Key? key}) : super(key: key);

  @override
  State<Concentraciones> createState() => _ConcentracionesState();
}

class _ConcentracionesState extends State<Concentraciones> {
  double? concentracion = 100, dilucion = 100, velocidad = 10;
  double? pesoCorporalTotal = 0;
  double? mgMl = 0,
      mcgMl = 0,
      mgKg = 0,
      mcgKg = 0,
      mgHr = 0,
      mcgHr = 0,
      mcgKgHr = 0,
      mgKgHr = 0,
      mgKgMin = 0,
      mcgKgMin = 0;

  var concentracionTextController = TextEditingController();
  var dilucionTextController = TextEditingController();
  var velocidadTextController = TextEditingController();

  @override
  void initState() {
    setState(() {
      concentracionTextController.text = '100';
      dilucionTextController.text = '100';
      velocidadTextController.text = '10';
      //
      pesoCorporalTotal = Valores.pesoCorporalTotal;

      operation();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          TittlePanel(
            padding: 2.0,
            textPanel: 'Evaluación de Concentraciones',
          ),
          Expanded(
            child: isMobile(context)?
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: ContainerDecoration.roundedDecoration(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              controller: ScrollController(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  EditTextArea(
                                    keyBoardType: TextInputType.number,
                                    inputFormat: MaskTextInputFormatter(
                                        mask: '####',
                                        filter: {"#": RegExp(r'[0-9]')},
                                        type: MaskAutoCompletionType.lazy),
                                    labelEditText: 'Concentración del Fármaco (mg)',
                                    textController: concentracionTextController,
                                    numOfLines: 1,
                                    onChange: (value) {
                                      setState(() {
                                        concentracion = double.parse(value);
                                        operation();
                                      });
                                    },
                                  ),
                                  EditTextArea(
                                    keyBoardType: TextInputType.number,
                                    inputFormat: MaskTextInputFormatter(
                                        mask: '####',
                                        filter: {"#": RegExp(r'[0-9]')},
                                        type: MaskAutoCompletionType.lazy),
                                    labelEditText: 'Dilución del Fármaco (mL)',
                                    textController: dilucionTextController,
                                    numOfLines: 1,
                                    onChange: (value) {
                                      setState(() {
                                        dilucion = double.parse(value);
                                        operation();
                                      });
                                    },
                                  ),
                                  EditTextArea(
                                    keyBoardType: TextInputType.number,
                                    inputFormat: MaskTextInputFormatter(
                                        mask: '####',
                                        filter: {"#": RegExp(r'[0-9]')},
                                        type: MaskAutoCompletionType.lazy),
                                    labelEditText: 'Velocidad de Infusión (mL/Hr)',
                                    textController: velocidadTextController,
                                    numOfLines: 1,
                                    onChange: (value) {
                                      setState(() {
                                        velocidad = double.parse(value);
                                        operation();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ValuePanel(
                                  firstText: 'P.C.T.',
                                  secondText: pesoCorporalTotal!.toStringAsFixed(2),
                                  thirdText: 'Kg',
                                ),
                                GrandButton(
                                  weigth: 2000,
                                  labelButton: "Copiar en Portapapeles",
                                  onPress: () {
                                    Datos.portapapeles(
                                        context: context, text: Formatos.concentraciones);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration:
                      ContainerDecoration.roundedDecoration(),
                      child: GridView(
                        controller: ScrollController(),
                        gridDelegate: GridViewTools.gridDelegate(
                          crossAxisCount: 2,
                          mainAxisExtent: 55,
                        ),
                        children: [
                          ValuePanel(
                            firstText: '',
                            secondText: mgMl!.toStringAsFixed(2),
                            thirdText: 'mg/mL',
                          ),
                          ValuePanel(
                            firstText: '',
                            secondText: mcgMl!.toStringAsFixed(2),
                            thirdText: 'mcg/mL',
                          ),
                          ValuePanel(
                            firstText: '',
                            secondText: mgKg!.toStringAsFixed(2),
                            thirdText: 'mg/Kg',
                          ),
                          ValuePanel(
                            firstText: '',
                            secondText: mcgKg!.toStringAsFixed(2),
                            thirdText: 'mcg/Kg',
                          ),
                          ValuePanel(
                            firstText: '',
                            secondText: mgHr!.toStringAsFixed(2),
                            thirdText: 'mg/Hr',
                          ),
                          ValuePanel(
                            firstText: '',
                            secondText: mcgHr!.toStringAsFixed(2),
                            thirdText: 'mcg/Hr',
                          ),

                          ValuePanel(
                            firstText: '',
                            secondText: mgKgHr!.toStringAsFixed(2),
                            thirdText: 'mg/Kg/Hr',
                          ),
                          ValuePanel(
                            firstText: '',
                            secondText: mcgKgHr!.toStringAsFixed(2),
                            thirdText: 'mcg/Kg/Hr',
                          ),

                          ValuePanel(
                            firstText: '',
                            secondText: mgKgMin!.toStringAsFixed(2),
                            thirdText: 'mg/Kg/min',
                          ),
                          ValuePanel(
                            firstText: '',
                            secondText: mcgKgMin!.toStringAsFixed(2),
                            thirdText: 'mcg/Kg/min',
                          ),
                        ],
                      ),
                    ),
                  ),
                ])
            :Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: ContainerDecoration.roundedDecoration(),
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: Column(
                        children: [
                          EditTextArea(
                            keyBoardType: TextInputType.number,
                            inputFormat: MaskTextInputFormatter(
                                mask: '####',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy),
                            labelEditText: 'Concentración del Fármaco (mg)',
                            textController: concentracionTextController,
                            numOfLines: 1,
                            onChange: (value) {
                              setState(() {
                                concentracion = double.parse(value);
                                operation();
                              });
                            },
                          ),
                          EditTextArea(
                            keyBoardType: TextInputType.number,
                            inputFormat: MaskTextInputFormatter(
                                mask: '####',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy),
                            labelEditText: 'Dilución del Fármaco (mL)',
                            textController: dilucionTextController,
                            numOfLines: 1,
                            onChange: (value) {
                              setState(() {
                                dilucion = double.parse(value);
                                operation();
                              });
                            },
                          ),
                          EditTextArea(
                            keyBoardType: TextInputType.number,
                            inputFormat: MaskTextInputFormatter(
                                mask: '####',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy),
                            labelEditText: 'Velocidad de Infusión (mL/Hr)',
                            textController: velocidadTextController,
                            numOfLines: 1,
                            onChange: (value) {
                              setState(() {
                                velocidad = double.parse(value);
                                operation();
                              });
                            },
                          ),
                          CrossLine(),
                          Container(
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.all(10),
                              decoration:
                                  ContainerDecoration.roundedDecoration(),
                              child: ShowText(
                                title: 'P.C.T.',
                                data: pesoCorporalTotal,
                                medida: 'Kg',
                              )),
                          GrandButton(
                            weigth: 2000,
                            labelButton: "Copiar en Portapapeles",
                            onPress: () {
                              Datos.portapapeles(
                                  context: context, text: Formatos.concentraciones);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration:
                    ContainerDecoration.roundedDecoration(),
                    child: GridView(
                      controller: ScrollController(),
                      gridDelegate: GridViewTools.gridDelegate(
                        crossAxisCount: 4,
                        mainAxisExtent: 75,
                      ),
                      children: [
                        ValuePanel(
                          firstText: '',
                          secondText: mgMl!.toStringAsFixed(2),
                          thirdText: 'mg/mL',
                        ),
                        ValuePanel(
                          firstText: '',
                          secondText: mcgMl!.toStringAsFixed(2),
                          thirdText: 'mcg/mL',
                        ),
                        ValuePanel(
                          firstText: '',
                          secondText: mgKg!.toStringAsFixed(2),
                          thirdText: 'mg/Kg',
                        ),
                        ValuePanel(
                          firstText: '',
                          secondText: mcgKg!.toStringAsFixed(2),
                          thirdText: 'mcg/Kg',
                        ),
                        ValuePanel(
                          firstText: '',
                          secondText: mcgHr!.toStringAsFixed(2),
                          thirdText: 'mcg/Hr',
                        ),
                        CrossLine(),
                        CrossLine(),
                        ValuePanel(
                          firstText: '',
                          secondText: mgHr!.toStringAsFixed(2),
                          thirdText: 'mg/Hr',
                        ),

                        ValuePanel(
                          firstText: '',
                          secondText: mcgKgHr!.toStringAsFixed(2),
                          thirdText: 'mcg/Kg/Hr',
                        ),
                        CrossLine(),
                        CrossLine(),
                        ValuePanel(
                          firstText: '',
                          secondText: mgKgHr!.toStringAsFixed(2),
                          thirdText: 'mg/Kg/Hr',
                        ),

                        ValuePanel(
                          firstText: '',
                          secondText: mcgKgMin!.toStringAsFixed(2),
                          thirdText: 'mcg/Kg/min',
                        ),
                        CrossLine(),
                        CrossLine(),
                        ValuePanel(
                          firstText: '',
                          secondText: mgKgMin!.toStringAsFixed(2),
                          thirdText: 'mg/Kg/min',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void operation() {
    mgMl = concentracion! / dilucion!;
    mgHr = (concentracion!*velocidad!) / dilucion!;
    mgKg = (concentracion!) / pesoCorporalTotal!;

    mcgMl = (concentracion! * 1000) / dilucion!;
    mcgKg = (concentracion! * 1000) / pesoCorporalTotal!;
    mcgHr = (concentracion! * 1000) / velocidad!;
    mgKgHr = ((concentracion!) / pesoCorporalTotal!) / velocidad!;
    mcgKgHr = ((concentracion! * 1000) / pesoCorporalTotal!) / velocidad!;

    mgKgMin = ((concentracion! * 1000) / (pesoCorporalTotal! * 60) );
    mcgKgMin =
        ((concentracion! * 1000) / (pesoCorporalTotal! * 60) ) / 10;
  }
}
