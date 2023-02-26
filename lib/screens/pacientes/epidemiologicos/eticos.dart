import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/Switched.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Eticos extends StatefulWidget {
  const Eticos({Key? key}) : super(key: key);

  @override
  State<Eticos> createState() => _EticosState();
}

class _EticosState extends State<Eticos> {

  // ********** ********* ********** ************
  var creenciasTextController = TextEditingController();
  var valoresTextController = TextEditingController();
  var costumbresTextController = TextEditingController();
  // ********** ********* ********** ************

  @override
  void initState() {
    setState(() {
      // // ********** ********* ********** ************
      // creenciasTextController.text = Valores.creenciasPaciente!;
      // valoresTextController.text = Valores.valoresPaciente!;
      // costumbresTextController.text = Valores.costumbresPaciente!;
      // // ********** ********* ********** ************
      // Valores.prejuiciosAtencion = false;
      // Valores.redesApoyo = false;
      // Valores.apoyoMadre = false;
      // Valores.apoyoPadre = false;
      // Valores.apoyoHermanos = false;
      // Valores.apoyoHijosMayores = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(textPanel: 'Ética y Moral'),
        CrossLine(),
        Switched(
          tittle: 'Refiere algun prejuicio con la Atención Médica',
          onChangeValue: (value) {
            setState(() {
              Valores.prejuiciosAtencion = value;
            });
          },
          isSwitched: Valores.prejuiciosAtencion,
        ),
        EditTextArea(
          keyBoardType: TextInputType.text,
          inputFormat: MaskTextInputFormatter(),
          labelEditText: 'Creencias',
          textController: creenciasTextController,
          numOfLines: 1,
          onChange: (value){
            Valores.creenciasPaciente = value;
          },
        ),
        EditTextArea(
          keyBoardType: TextInputType.text,
          inputFormat: MaskTextInputFormatter(),
          labelEditText: 'Valores',
          textController: valoresTextController,
          numOfLines: 1,
          onChange: (value){
            Valores.valoresPaciente = value;
          },
        ),
        EditTextArea(
          keyBoardType: TextInputType.text,
          inputFormat: MaskTextInputFormatter(),
          labelEditText: 'Costumbres',
          textController: costumbresTextController,
          numOfLines: 1,
          onChange: (value){
            Valores.costumbresPaciente = value;
          },
        ),
        CrossLine(),
        Switched(
          tittle: 'Redes de Apoyo durante la Atención Médica',
          onChangeValue: (value) {
            setState(
              () {
                Valores.redesApoyo = value;
              },
            );
          },
          isSwitched: Valores.redesApoyo,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Switched(
              tittle: 'Apoyo de Madre',
              onChangeValue: (value) {
                setState(
                  () {
                    Valores.apoyoMadre = value;
                  },
                );
              },
              isSwitched: Valores.apoyoMadre,
            ),
            Switched(
              tittle: 'Apoyo de Padre',
              onChangeValue: (value) {
                setState(
                  () {
                    Valores.apoyoPadre = value;
                  },
                );
              },
              isSwitched: Valores.apoyoPadre,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Switched(
              tittle: 'Apoyo de Hermanos',
              onChangeValue: (value) {
                setState(
                  () {
                    Valores.apoyoHermanos = value;
                  },
                );
              },
              isSwitched: Valores.apoyoHermanos,
            ),
            Switched(
              tittle: 'Apoyo de Hijos',
              onChangeValue: (value) {
                setState(
                  () {
                    Valores.apoyoHijosMayores = value;
                  },
                );
              },
              isSwitched: Valores.apoyoHijosMayores,
            ),
          ],
        ),
      ],
    );
  }
}
