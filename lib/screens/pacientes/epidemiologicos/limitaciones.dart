import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/Switched.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Limitaciones extends StatefulWidget {
  const Limitaciones({super.key});

  @override
  State<Limitaciones> createState() => _LimitacionesState();
}

class _LimitacionesState extends State<Limitaciones> {
  // ************ *********** *********
  var usoLentesTextController = TextEditingController();
  var aparatoSorderaTextController = TextEditingController();
  var protesisDentariaTextController = TextEditingController();
  var marcapasosCardiacoTextController = TextEditingController();
  var ortesisDeambularTextController = TextEditingController();
  var limitacionesActividadCotidianaTextController = TextEditingController();
  // ************ *********** *********

  @override
  void initState() {
    setState(() {
      usoLentesTextController.text = Valores.usoLentesDescripcion!;
      aparatoSorderaTextController.text = Valores.aparatoSorderaDescripcion!;
      protesisDentariaTextController.text =
          Valores.protesisDentariaDescripcion!;
      marcapasosCardiacoTextController.text =
          Valores.marcapasosCardiacoDescripcion!;
      ortesisDeambularTextController.text =
          Valores.ortesisDeambularDescripcion!;
      limitacionesActividadCotidianaTextController.text =
          Valores.limitacionesActividadCotidianaDescripcion!;
      // ************ *********** *********
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(textPanel: 'Limitaciones Físicas'),
        CrossLine(),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Switched(
                tittle: 'Uso de Lentes',
                onChangeValue: (value) {
                  setState(() {
                    Valores.usoLentes = value;
                    if (value) {
                      usoLentesTextController.text = '';
                    } else {
                      usoLentesTextController.text =
                          'No usa lentes graduados ni otro en particular';
                      Valores.usoLentesDescripcion =
                          usoLentesTextController.text;
                    }
                  });
                },
                isSwitched: Valores.usoLentes,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Uso de Lentes',
                textController: usoLentesTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.usoLentesDescripcion = value;
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
                tittle: 'Uso de Aparatos de Sordera',
                onChangeValue: (value) {
                  setState(() {
                    Valores.aparatoSordera = value;
                    if (value) {
                      aparatoSorderaTextController.text = '';
                    } else {
                      aparatoSorderaTextController.text =
                          'No usa aparatos por hipoacusia';
                      Valores.aparatoSorderaDescripcion =
                          aparatoSorderaTextController.text;
                    }
                  });
                },
                isSwitched: Valores.aparatoSordera,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Uso de Aparatos de Sordera',
                textController: aparatoSorderaTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.aparatoSorderaDescripcion = value;
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
                tittle: 'Uso de Protesis Dentaria',
                onChangeValue: (value) {
                  setState(() {
                    Valores.protesisDentaria = value;
                    if (value) {
                      protesisDentariaTextController.text = '';
                    } else {
                      protesisDentariaTextController.text =
                          'No usa prótesis dentaria';
                      Valores.protesisDentariaDescripcion =
                          protesisDentariaTextController.text;
                    }
                  });
                },
                isSwitched: Valores.protesisDentaria,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Uso de Protesis Dentaria',
                textController: protesisDentariaTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.protesisDentariaDescripcion = value;
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
                tittle: 'Marcapasos Cardiaco',
                onChangeValue: (value) {
                  setState(() {
                    Valores.marcapasosCardiaco = value;
                    if (value) {
                      marcapasosCardiacoTextController.text = '';
                    } else {
                      marcapasosCardiacoTextController.text =
                          'No presenta uso de marcapasos cardiaco';
                      Valores.marcapasosCardiacoDescripcion =
                          marcapasosCardiacoTextController.text;
                    }
                  });
                },
                isSwitched: Valores.marcapasosCardiaco,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Uso de Marcapasos Cardiaco',
                textController: marcapasosCardiacoTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.marcapasosCardiacoDescripcion = value;
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
                tittle: 'Uso de Ortésis',
                onChangeValue: (value) {
                  setState(() {
                    Valores.ortesisDeambular = value;
                    if (value) {
                      ortesisDeambularTextController.text = '';
                    } else {
                      ortesisDeambularTextController.text =
                          'No usa ortésis al deambular';
                      Valores.ortesisDeambularDescripcion =
                          ortesisDeambularTextController.text;
                    }
                  });
                },
                isSwitched: Valores.ortesisDeambular,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Uso de Ortésis',
                textController: ortesisDeambularTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.ortesisDeambularDescripcion = value;
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
                tittle: 'Limitaciones Diarias',
                onChangeValue: (value) {
                  setState(() {
                    Valores.limitacionesActividadCotidiana = value;
                    if (value) {
                      limitacionesActividadCotidianaTextController.text = '';
                    } else {
                      limitacionesActividadCotidianaTextController.text =
                          'No presenta limitaciones en la actividad cotidiana';
                      Valores.limitacionesActividadCotidianaDescripcion =
                          limitacionesActividadCotidianaTextController.text;
                    }
                  });
                },
                isSwitched: Valores.limitacionesActividadCotidiana,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Limitaciones Diarias',
                textController: limitacionesActividadCotidianaTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.limitacionesActividadCotidianaDescripcion = value;
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
