import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/Switched.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Alcoholismo extends StatefulWidget {
  const Alcoholismo({Key? key}) : super(key: key);

  @override
  State<Alcoholismo> createState() => _AlcoholismoState();
}

class _AlcoholismoState extends State<Alcoholismo> {
  // ************ *********** *********
  var edadInicioTextController = TextEditingController();
  var duracionAnosTextController = TextEditingController();
  var periodicidadTextController = TextEditingController();
  var aosSuspensionTextController = TextEditingController();
  var tiposTextController = TextEditingController();
  // ************ *********** *********

  @override
  void initState() {
    setState(() {
      // // ************ *********** *********
      Valores.tiposAlcoholismo = Items.tiposAlcoholes[0];
      // // ************ *********** *********
      // tiposTextController.text = "";
      // // ************ *********** *********
      // edadInicioTextController.text = '';
      // // ************ *********** *********
      // edadInicioTextController.text =
      // Valores.edadInicioAlcoholismo!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(textPanel: 'Hábitos Alcoholismo'),
        const CrossLine(),
        Row(children: [
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Edad Inicio',
              textController: edadInicioTextController,
              numOfLines: 1,
              onChange: (value) {
                Valores.edadInicioAlcoholismo = value;
              },
            ),
          ),
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Duración en Años',
              textController: duracionAnosTextController,
              numOfLines: 1,
              onChange: (value) {
                Valores.duracionAnosAlcoholismo = value;
              },
            ),
          ),

        ],),
        Row(children: [
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Periodicidad',
              textController: periodicidadTextController,
              numOfLines: 1,
              onChange: (value) {
                Valores.periodicidadAlcoholismo = value;
              },
            ),
          ),
          Expanded(
            child: Spinner(
              tittle: 'Intervalo de Tiempo',
              width: SpinnersValues.minimunWidth(context: context),
              onChangeValue: (value) {
                setState(() {
                  Valores.intervaloAlcoholismo = value;
                });
              },
              items: Items.periodicidad,
              initialValue: Valores.intervaloAlcoholismo,
            ),
          ),
        ],),
        const CrossLine(),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Switched(
                tittle: 'Suspensión',
                onChangeValue: (value) {
                  setState(() {
                    Valores.suspensionAlcoholismo = value;
                    if (value) {
                      aosSuspensionTextController.text = '';
                    } else {
                      aosSuspensionTextController.text =
                      'Sin viajes nacionales o al extranjero en los últimoss 3 meses';
                      Valores.aosSuspensionAlcoholismo =
                          aosSuspensionTextController.text;
                    }
                  });
                },
                isSwitched: Valores.suspensionAlcoholismo,
              ),
            ),
            Expanded(
              flex: 2,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Años de Suspensión del Alcoholismo',
                textController: aosSuspensionTextController,
                numOfLines: 2,
                onChange: (value) {
                  Valores.aosSuspensionAlcoholismo = value;
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Spinner(
                tittle: 'Tipos de Alcohol',
                width: SpinnersValues.minimunWidth(context: context),
                onChangeValue: (value) {
                  setState(() {
                    if (tiposTextController.text == '') {
                      tiposTextController.text = "$value";
                    } else {
                      tiposTextController.text = "${tiposTextController.text}, $value";
                    }
                    // Asignación a la Variable Global.
                    Valores.tiposAlcoholismoDescripcion = tiposTextController.text;
                    //
                  });
                },
                initialValue: Valores.tiposAlcoholismo, items: Items.tiposAlcoholes,
              ),
            ),
            Expanded(
              flex: 2,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Descripción de los Tipos de Alcohol Consumido',
                textController: tiposTextController,
                numOfLines: 2,
                onChange: (value) {
                  Valores.tiposAlcoholismoDescripcion = value;
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