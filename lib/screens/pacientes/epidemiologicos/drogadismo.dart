import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/Switched.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Drogadismo extends StatefulWidget {
  const Drogadismo({Key? key}) : super(key: key);

  @override
  State<Drogadismo> createState() => _DrogadismoState();
}

class _DrogadismoState extends State<Drogadismo> {
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
      Valores.tiposDrogadismo = Items.tiposDrogas[0];
      // // ************ *********** *********
      // tiposTextController.text = "";
      // // ************ *********** *********
      // edadInicioTextController.text = '';
      // // ************ *********** *********
      // edadInicioTextController.text =
      // Valores.edadInicioDrogadismo!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(textPanel: 'Hábitos Drogadismo'),
        CrossLine(),
        Row(children: [
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Edad Inicio',
              textController: edadInicioTextController,
              numOfLines: 1,
              onChange: (value) {
                Valores.edadInicioDrogadismo = value;
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
                Valores.duracionAnosDrogadismo = value;
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
                Valores.periodicidadDrogadismo = value;
              },
            ),
          ),
          Expanded(
            child: Spinner(
              tittle: 'Intervalo de Tiempo',
              width: SpinnersValues.minimunWidth(context: context),
              onChangeValue: (value) {
                setState(() {
                  Valores.intervaloDrogadismo = value;
                });
              },
              items: Items.periodicidad,
              initialValue: Valores.intervaloDrogadismo,
            ),
          ),
        ],),
        CrossLine(),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Switched(
                tittle: 'Suspensión',
                onChangeValue: (value) {
                  setState(() {
                    Valores.suspensionDrogadismo = value;
                    if (value) {
                      aosSuspensionTextController.text = '';
                    } else {
                      aosSuspensionTextController.text =
                      'Sin viajes nacionales o al extranjero en los últimoss 3 meses';
                      Valores.aosSuspensionDrogadismo =
                          aosSuspensionTextController.text;
                    }
                  });
                },
                isSwitched: Valores.suspensionDrogadismo,
              ),
            ),
            Expanded(
              flex: 2,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Años de Suspensión del Drogadismo',
                textController: aosSuspensionTextController,
                numOfLines: 2,
                onChange: (value) {
                  Valores.aosSuspensionDrogadismo = value;
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
                    Valores.tiposDrogadismoDescripcion = tiposTextController.text;
                    //
                  });
                },
                initialValue: Valores.tiposDrogadismo, items: Items.tiposDrogas,
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
                  Valores.tiposDrogadismoDescripcion = value;
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
