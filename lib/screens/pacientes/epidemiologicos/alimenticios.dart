import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/Switched.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Alimenticios extends StatefulWidget {
  const Alimenticios({Key? key}) : super(key: key);

  @override
  State<Alimenticios> createState() => _AlimenticiosState();
}

class _AlimenticiosState extends State<Alimenticios> {

  // ************ *********** *********
  var alimentacionDiariaTextController = TextEditingController();
  var dietaAsignadaTextController = TextEditingController();
  var variacionAlimentacionTextController = TextEditingController();
  var problemasMasticacionTextController = TextEditingController();
  var intoleranciaAlimentariaTextController = TextEditingController();
  var alteracionesPesoTextController = TextEditingController();
  // ************ *********** *********

  @override
  void initState() {
    setState(() {
      Valores.alimentacionDiariaDescripcion = '';
      // ************ *********** *********
      alimentacionDiariaTextController.text =
          Valores.alimentacionDiariaDescripcion!;
      // ************ *********** *********
      Valores.alimentacionDiaria = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(textPanel: 'Hábitos Alimenticios'),
        const CrossLine(),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Switched(
                tittle: 'Alimentación Diaria',
                onChangeValue: (value) {
                  setState(() {
                    Valores.alimentacionDiaria = value;
                    if (value) {
                      alimentacionDiariaTextController.text = '';
                    } else {
                      alimentacionDiariaTextController.text =
                          'No tiene dieta diaria estable';
                      Valores.alimentacionDiariaDescripcion =
                          alimentacionDiariaTextController.text;
                    }
                  });
                },
                isSwitched: Valores.alimentacionDiaria,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Alimentación Diaria',
                textController: alimentacionDiariaTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.alimentacionDiariaDescripcion = value;
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
                tittle: 'Dieta Asignada',
                onChangeValue: (value) {
                  setState(() {
                    Valores.dietaAsignada = value;
                    if (value) {
                      dietaAsignadaTextController.text = '';
                    } else {
                      dietaAsignadaTextController.text =
                          'Sin dieta asignada por nutriologo';
                      Valores.dietaAsignadaDescripcion =
                          dietaAsignadaTextController.text;
                    }
                  });
                },
                isSwitched: Valores.dietaAsignada,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Dieta Asignada',
                textController: dietaAsignadaTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.dietaAsignadaDescripcion = value;
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
                tittle: 'Variación de la Alimentación',
                onChangeValue: (value) {
                  setState(() {
                    Valores.variacionAlimentacion = value;
                    if (value) {
                      variacionAlimentacionTextController.text = '';
                    } else {
                      variacionAlimentacionTextController.text =
                          'Sin variaciones en la alimentación';
                      Valores.variacionAlimentacionDescripcion =
                          variacionAlimentacionTextController.text;
                    }
                  });
                },
                isSwitched: Valores.variacionAlimentacion,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Variación de la Alimentación',
                textController: variacionAlimentacionTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.variacionAlimentacionDescripcion = value;
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
                tittle: 'Dificultad en la Masticación',
                onChangeValue: (value) {
                  setState(() {
                    Valores.problemasMasticacion = value;
                    if (value) {
                      problemasMasticacionTextController.text = '';
                    } else {
                      problemasMasticacionTextController.text =
                          'No refiere problemas en la masticación';
                      Valores.problemasMasticacionDescripcion =
                          problemasMasticacionTextController.text;
                    }
                  });
                },
                isSwitched: Valores.problemasMasticacion,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Problemas en la Masticación',
                textController: problemasMasticacionTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.problemasMasticacionDescripcion = value;
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
                tittle: 'Intolerancia Alimentaria',
                onChangeValue: (value) {
                  setState(() {
                    Valores.intoleranciaAlimentaria = value;
                    if (value) {
                      intoleranciaAlimentariaTextController.text = '';
                    } else {
                      intoleranciaAlimentariaTextController.text =
                          'No refiere alergia o intolerancia alimentaria de ningún tipo';
                      Valores.intoleranciaAlimentariaDescripcion =
                          intoleranciaAlimentariaTextController.text;
                    }
                  });
                },
                isSwitched: Valores.intoleranciaAlimentaria,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Intolerancia Alimentaria',
                textController: intoleranciaAlimentariaTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.intoleranciaAlimentariaDescripcion = value;
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
                tittle: 'Variación del Peso Corporal',
                onChangeValue: (value) {
                  setState(() {
                    Valores.alteracionesPeso = value;
                    if (value) {
                      alteracionesPesoTextController.text = '';
                    } else {
                      alteracionesPesoTextController.text =
                          'No refiere variaciones significativas del peso en los últimos dos meses';
                      Valores.alteracionesPesoDescripcion =
                          alteracionesPesoTextController.text;
                    }
                  });
                },
                isSwitched: Valores.alteracionesPeso,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Alteraciones del Peso Corporal',
                textController: alteracionesPesoTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.alteracionesPesoDescripcion = value;
                },
              ),
            ),
          ],
        ),
        const CrossLine(),
      ],
    );
  }
}
