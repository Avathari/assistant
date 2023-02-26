import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/Switched.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Exposiciones extends StatefulWidget {
  const Exposiciones({Key? key}) : super(key: key);

  @override
  State<Exposiciones> createState() => _ExposicionesState();
}

class _ExposicionesState extends State<Exposiciones> {

  // ************ *********** *********
  var exposicionBiomasaTextController = TextEditingController();
  var exposicionHumosQuimicosTextController = TextEditingController();
  var exposicionPesticidasTextController = TextEditingController();
  var exposicionMetalesPesadosTextController = TextEditingController();
  var exposicionPsicotropicosTextController = TextEditingController();
  // ************ *********** *********

  @override
  void initState() {
    setState(() {
      // ************ *********** *********
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(textPanel: 'Exposiciones a Sustancias Nocivas'),
        CrossLine(),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Switched(
                tittle: 'Biomasa',
                onChangeValue: (value) {
                  setState(() {
                    Valores.exposicionBiomasa = value;
                    if (value) {
                      exposicionBiomasaTextController.text = '';
                    } else {
                      exposicionBiomasaTextController.text =
                      'No refiere uso o exposición a humo de biomasa';
                      Valores.exposicionBiomasaDescripcion =
                          exposicionBiomasaTextController.text;
                    }
                  });
                },
                isSwitched: Valores.exposicionBiomasa,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Biomasa',
                textController: exposicionBiomasaTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.exposicionBiomasaDescripcion = value;
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
                tittle: 'Humos Químicos',
                onChangeValue: (value) {
                  setState(() {
                    Valores.exposicionHumosQuimicos = value;
                    if (value) {
                      exposicionHumosQuimicosTextController.text = '';
                    } else {
                      exposicionHumosQuimicosTextController.text =
                      'No refiere uso o exposición a humos químicos';
                      Valores.exposicionHumosQuimicosDescripcion =
                          exposicionHumosQuimicosTextController.text;
                    }
                  });
                },
                isSwitched: Valores.exposicionHumosQuimicos,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Humos Químicos',
                textController: exposicionHumosQuimicosTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.exposicionHumosQuimicosDescripcion = value;
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
                tittle: 'Pesticidas',
                onChangeValue: (value) {
                  setState(() {
                    Valores.exposicionPesticidas = value;
                    if (value) {
                      exposicionPesticidasTextController.text = '';
                    } else {
                      exposicionPesticidasTextController.text =
                      'No refiere uso o exposición a pesticidas';
                      Valores.exposicionPesticidasDescripcion =
                          exposicionPesticidasTextController.text;
                    }
                  });
                },
                isSwitched: Valores.exposicionPesticidas,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Pesticidas',
                textController: exposicionPesticidasTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.exposicionPesticidasDescripcion = value;
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
                tittle: 'Metales Pesados',
                onChangeValue: (value) {
                  setState(() {
                    Valores.exposicionMetalesPesados = value;
                    if (value) {
                      exposicionMetalesPesadosTextController.text = '';
                    } else {
                      exposicionMetalesPesadosTextController.text =
                      'No refiere uso o exposición a metales pesados';
                      Valores.exposicionMetalesPesadosDescripcion =
                          exposicionMetalesPesadosTextController.text;
                    }
                  });
                },
                isSwitched: Valores.exposicionMetalesPesados,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Uso de Metales Pesados',
                textController: exposicionMetalesPesadosTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.exposicionMetalesPesadosDescripcion = value;
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
                tittle: 'Psicotrópicos',
                onChangeValue: (value) {
                  setState(() {
                    Valores.exposicionPsicotropicos = value;
                    if (value) {
                      exposicionPsicotropicosTextController.text = '';
                    } else {
                      exposicionPsicotropicosTextController.text =
                      'Sin referencia de uso de psicotrópicos';
                      Valores.exposicionPsicotropicosDescripcion =
                          exposicionPsicotropicosTextController.text;
                    }
                  });
                },
                isSwitched: Valores.exposicionPsicotropicos,
              ),
            ),
            Expanded(
              flex: 3,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Psicotrópicos',
                textController: exposicionPsicotropicosTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.exposicionPsicotropicosDescripcion = value;
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
