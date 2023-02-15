import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/Switched.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Tabaquismo extends StatefulWidget {
  const Tabaquismo({Key? key}) : super(key: key);

  @override
  State<Tabaquismo> createState() => _TabaquismoState();
}

class _TabaquismoState extends State<Tabaquismo> {
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
      Valores.tiposTabaquismo = Items.tiposTabacos[0];
      // // ************ *********** *********
      // tiposTextController.text = "";
      // // ************ *********** *********
      // edadInicioTextController.text = '';
      // // ************ *********** *********
      // edadInicioTextController.text =
      // Valores.edadInicioTabaquismo!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(textPanel: 'Hábitos Tabaquismo'),
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
                Valores.edadInicioTabaquismo = value;
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
                Valores.duracionAnosTabaquismo = value;
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
                Valores.periodicidadTabaquismo = value;
              },
            ),
          ),
          Expanded(
            child: Spinner(
              tittle: 'Intervalo de Tiempo',
              width: SpinnersValues.minimunWidth(context: context),
              onChangeValue: (value) {
                setState(() {
                  Valores.intervaloTabaquismo = value;
                });
              },
              items: Items.periodicidad,
              initialValue: Valores.intervaloTabaquismo,
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
                    Valores.suspensionTabaquismo = value;
                    if (value) {
                      aosSuspensionTextController.text = '';
                    } else {
                      aosSuspensionTextController.text =
                      'Sin viajes nacionales o al extranjero en los últimoss 3 meses';
                      Valores.aosSuspensionTabaquismo =
                          aosSuspensionTextController.text;
                    }
                  });
                },
                isSwitched: Valores.suspensionTabaquismo,
              ),
            ),
            Expanded(
              flex: 2,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Años de Suspensión del Tabaquismo',
                textController: aosSuspensionTextController,
                numOfLines: 2,
                onChange: (value) {
                  Valores.aosSuspensionTabaquismo = value;
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
                    Valores.tiposTabaquismoDescripcion = tiposTextController.text;
                    //
                  });
                },
                initialValue: Valores.tiposTabaquismo, items: Items.tiposTabacos,
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
                  Valores.tiposTabaquismoDescripcion = value;
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
