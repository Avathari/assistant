import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/ShowText.dart';
import 'package:assistant/widgets/TittlePanel.dart';

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
  double? mgMl = 0, mcgMl = 0, mgKg = 0, mcgKg = 0, mgHr = 0,
      mcgHr = 0, mcgKgHr = 0, mgKgHr = 0, mgKgMin = 0,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
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
                         const CrossLine(),
                        ShowText(title: 'Peso Corporal Total', data: pesoCorporalTotal, medida: 'Kg',),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Column(
                      children: [
                        ShowText(title: '', data: mgMl, medida: 'mg/mL',),
                        ShowText(title: '', data: mcgMl, medida: 'mcg/mL',),
                        ShowText(title: '', data: mgKg, medida: 'mg/Kg', fractionDigits: 4,),
                        ShowText(title: '', data: mcgKg, medida: 'mcg/Kg',),
                        ShowText(title: '', data: mgHr, medida: 'mg/Hr',),
                        ShowText(title: '', data: mcgHr, medida: 'mcg/Hr',),
                        ShowText(title: '', data: mcgKgHr, medida: 'mcg/Kg/Hr',),
                        ShowText(title: '', data: mgKgHr, medida: 'mg/Kg/Hr',),
                        ShowText(title: '', data: mgKgMin, medida: 'mg/Kg/min',),
                        ShowText(title: '', data: mcgKgMin, medida: 'mcg/Kg/min',),
                        const CrossLine(),
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

  void operation(){
    mgMl = concentracion! / dilucion!;
    mcgMl = (concentracion! * 1000) / dilucion!;
    mgKg = (concentracion!) / pesoCorporalTotal!;
    mcgKg = (concentracion! * 1000) / pesoCorporalTotal!;
    mgHr = (concentracion!) / velocidad!;
    mcgHr = (concentracion! * 1000) / velocidad!;
    mgKgHr = ((concentracion!) / pesoCorporalTotal!) / velocidad!;
    mcgKgHr = ((concentracion! * 1000) / pesoCorporalTotal!) / velocidad!;
    mgKgMin = ((concentracion!) / pesoCorporalTotal!) / (velocidad! / 60);
    mcgKgMin = ((concentracion! * 1000) / pesoCorporalTotal!) / (velocidad! / 60);
  }
}
