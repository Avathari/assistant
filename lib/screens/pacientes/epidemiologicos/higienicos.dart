import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/Switched.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Higienicos extends StatefulWidget {
  const Higienicos({super.key});

  @override
  State<Higienicos> createState() => _HigienicosState();
}

class _HigienicosState extends State<Higienicos> {
  // ************ *********** *********
  var banoCorporalTextController = TextEditingController();
  var higieneManosTextController = TextEditingController();
  var cambiosRopaTextController = TextEditingController();
  var aseoDentalTextController = TextEditingController();
  // ************ *********** *********

  @override
  void initState() {
    setState(() {
      // ************ *********** *********
      banoCorporalTextController.text =
          Valores.banoCorporalDescripcion!;
      higieneManosTextController.text = Valores.higieneManosDescripcion!;
      cambiosRopaTextController.text = Valores.cambiosRopaDescripcion!;
      aseoDentalTextController .text= Valores.aseoDentalDescripcion!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(textPanel: 'Hábitos Higienicos'),
        CrossLine(),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Switched(
                tittle: 'Baño Corporal',
                onChangeValue: (value) {
                  setState(() {
                    Valores.banoCorporal = value;
                    if (value) {
                      banoCorporalTextController.text =
                      'Refiere realizar aseo corporal diario';
                    } else {
                      banoCorporalTextController.text =
                      'Refiere no realizar aseo corporal diario';
                    }
                    Valores.banoCorporalDescripcion =
                        banoCorporalTextController.text;
                  });
                },
                isSwitched: Valores.banoCorporal,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Baño Corporal',
                textController: banoCorporalTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.banoCorporalDescripcion = value;
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Switched(
                tittle: 'Higiene de Manos',
                onChangeValue: (value) {
                  setState(() {
                    Valores.higieneManos = value;
                    if (value) {
                      higieneManosTextController.text =
                      'Refiere realizar aseo de manos antes y después de comer e ir al baño';
                    } else {
                      higieneManosTextController.text =
                      'Refiere realizar un mal aseo de manos';
                    }
                    Valores.higieneManosDescripcion =
                        higieneManosTextController.text;
                  });
                },
                isSwitched: Valores.higieneManos,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Higiene de Manos',
                textController: higieneManosTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.higieneManosDescripcion = value;
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Switched(
                tittle: 'Cambios de Ropa',
                onChangeValue: (value) {
                  setState(() {
                    Valores.cambiosRopa = value;
                    if (value) {
                      cambiosRopaTextController.text =
                      'Refiere cambio diario de ropa';
                    } else {
                      cambiosRopaTextController.text =
                      'No tiene cambios de ropa diario';
                    }
                    Valores.cambiosRopaDescripcion =
                        cambiosRopaTextController.text;
                  });
                },
                isSwitched: Valores.cambiosRopa,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Cambios de Ropa',
                textController: cambiosRopaTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.cambiosRopaDescripcion = value;
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Switched(
                tittle: 'Aseo Dental',
                onChangeValue: (value) {
                  setState(() {
                    Valores.aseoDental = value;
                    if (value) {
                      aseoDentalTextController.text =
                      'Refiere aseo dental tres veces al dia, pero no usa hilo dental';
                    } else {
                      aseoDentalTextController.text =
                      'No tiene un adecuado aseo dental, ni usa hilo dental';
                    }
                    Valores.aseoDentalDescripcion =
                        aseoDentalTextController.text;
                  });
                },
                isSwitched: Valores.aseoDental,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Aseo Dental',
                textController: aseoDentalTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.aseoDentalDescripcion = value;
                },
              ),
            ),
          ],
        ),
        CrossLine(),
      ],
    );
  }
}
