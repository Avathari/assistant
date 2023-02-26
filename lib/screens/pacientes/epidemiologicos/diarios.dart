import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/Switched.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Diarios extends StatefulWidget {
  const Diarios({Key? key}) : super(key: key);

  @override
  State<Diarios> createState() => _DiariosState();
}

class _DiariosState extends State<Diarios> {
  // ************ *********** *********
  var actividadesDiariasTextController = TextEditingController();
  var pasatiemposTextController = TextEditingController();
  var horasSuenoTextController = TextEditingController();
  var viajesRecientesTextController = TextEditingController();
  // ************ *********** *********

  @override
  void initState() {
    setState(() {
      // ************ *********** *********
      actividadesDiariasTextController.text = '';
      // ************ *********** *********
      actividadesDiariasTextController.text =
          Valores.actividadesDiariasDescripcion!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(textPanel: 'Hábitos Diarios'),
        CrossLine(),
        EditTextArea(
          keyBoardType: TextInputType.text,
          inputFormat: MaskTextInputFormatter(),
          labelEditText: 'Actividades Diarias',
          textController: actividadesDiariasTextController,
          numOfLines: 3,
          onChange: (value) {
            Valores.actividadesDiariasDescripcion = value;
          },
        ),
        EditTextArea(
          keyBoardType: TextInputType.text,
          inputFormat: MaskTextInputFormatter(),
          labelEditText: 'Pasatiempos',
          textController: pasatiemposTextController,
          numOfLines: 3,
          onChange: (value) {
            Valores.pasatiemposDescripcion = value;
          },
        ),
        Spinner(
          tittle: 'Horas de Sueño',
          width: SpinnersValues.mediumWidth(context: context),
          onChangeValue: (value) {
            setState(() {
              Valores.horasSuenoDescripcion = value;
            });
          },
          items: Items.horasSueno,
          initialValue: Items.horasSueno[2],
        ),
        CrossLine(),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Switched(
                tittle: 'Vacaciones o Viajes Recientes',
                onChangeValue: (value) {
                  setState(() {
                    Valores.viajesRecientes = value;
                    if (value) {
                      viajesRecientesTextController.text = '';
                    } else {
                      viajesRecientesTextController.text =
                          'Sin viajes nacionales o al extranjero en los últimoss 3 meses';
                      Valores.viajesRecientesDescripcion =
                          viajesRecientesTextController.text;
                    }
                  });
                },
                isSwitched: Valores.viajesRecientes,
              ),
            ),
            Expanded(
              flex: 2,
              child: EditTextArea(
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Viajes recientes',
                textController: viajesRecientesTextController,
                numOfLines: 2,
                onChange: (value) {
                  Valores.viajesRecientesDescripcion = value;
                },
              ),
            ),
          ],
        ),
        CrossLine(),
        Switched(
          tittle: 'Problemas Familiares',
          onChangeValue: (value) {
            setState(() {
              Valores.problemasFamiliares = value;
            });
          },
          isSwitched: Valores.problemasFamiliares,
        ),
        Row(
          children: [
            Expanded(
              child: Switched(
                tittle: 'Violencia Infantil',
                onChangeValue: (value) {
                  setState(() {
                    Valores.violenciaInfantil = value;
                  });
                },
                isSwitched: Valores.violenciaInfantil,
              ),
            ),
            Expanded(
              child: Switched(
                tittle: 'Abuso de Sustancias',
                onChangeValue: (value) {
                  setState(() {
                    Valores.abusoSustancias = value;
                  });
                },
                isSwitched: Valores.abusoSustancias,
              ),
            ),
          ],
        ),
        CrossLine(),
        Switched(
          tittle: 'Problemas Laborales',
          onChangeValue: (value) {
            setState(() {
              Valores.problemasLaborales = value;
            });
          },
          isSwitched: Valores.problemasLaborales,
        ),
        Row(
          children: [
            Expanded(
              child: Switched(
                tittle: 'Estrés Laboral',
                onChangeValue: (value) {
                  setState(() {
                    Valores.estresLaboral = value;
                  });
                },
                isSwitched: Valores.estresLaboral,
              ),
            ),
            Expanded(
              child: Switched(
                tittle: 'Hostilidad Laboral',
                onChangeValue: (value) {
                  setState(() {
                    Valores.hostilidadLaboral = value;
                  });
                },
                isSwitched: Valores.hostilidadLaboral,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Switched(
                tittle: 'Abuso Laboral',
                onChangeValue: (value) {
                  setState(() {
                    Valores.abusoLaboral = value;
                  });
                },
                isSwitched: Valores.abusoLaboral,
              ),
            ),
            Expanded(
              child: Switched(
                tittle: 'Acoso Laboral',
                onChangeValue: (value) {
                  setState(() {
                    Valores.acosoLaboral = value;
                  });
                },
                isSwitched: Valores.acosoLaboral,
              ),
            ),
          ],
        ),
        CrossLine(),
      ],
    );
  }
}
