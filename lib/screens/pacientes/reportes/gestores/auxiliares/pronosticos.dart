import 'package:assistant/widgets/CrossLine.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';

import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/values/SizingInfo.dart';

class DiagnosticosAndPronostico extends StatefulWidget {
  final bool? isTerapia;

  DiagnosticosAndPronostico({this.isTerapia = false, super.key});

  @override
  State<DiagnosticosAndPronostico> createState() => _DiagnosticosAndPronosticoState();
}

class _DiagnosticosAndPronosticoState extends State<DiagnosticosAndPronostico> {
  final diagoTextController = TextEditingController();
  final pronosTextController = TextEditingController();
  final scrollController = ScrollController();

  String? funcionValue = Pacientes.PronosticoFuncion[0];
  String? vidaValue = Pacientes.PronosticoVida[0];
  String? tiempoValue = Pacientes.PronosticoTiempo[0];
  String? estadoValue = Pacientes.PronosticoEstado[0];

  @override
  void initState() {
    super.initState();

    if (!(widget.isTerapia ?? false)) {
      diagoTextController.text =
      Reportes.reportes['Impresiones_Diagnosticas']?.isNotEmpty == true
          ? Reportes.reportes['Impresiones_Diagnosticas']!
          : Reportes.reportes['Diagnosticos_Hospital']?.isNotEmpty == true
          ? Reportes.reportes['Diagnosticos_Hospital']!
          : Reportes.impresionesDiagnosticas.isNotEmpty
          ? Reportes.impresionesDiagnosticas
          : Pacientes.diagnosticos();
    }

    pronosTextController.text =
    Reportes.reportes['Pronostico_Medico']?.isNotEmpty == true
        ? Reportes.reportes['Pronostico_Medico']!
        : Pacientes.pronosticoMedico();
  }

  void aceptar() {
    Pacientes.pronosticoFuncion = funcionValue;
    Pacientes.pronosticoVida = vidaValue;
    Pacientes.pronosticoTiempo = tiempoValue;
    Pacientes.pronosticoEstado = estadoValue;

    // Sincroniza texto actual con las variables antes de guardar
    Reportes.impresionesDiagnosticas = diagoTextController.text;
    Reportes.reportes['Impresiones_Diagnosticas'] = diagoTextController.text;
    Reportes.reportes['Diagnosticos_Hospital'] = diagoTextController.text;

    Reportes.pronosticoMedico = pronosTextController.text;
    Reportes.reportes['Pronostico_Medico'] = pronosTextController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Column(
          children: [
            if (!(widget.isTerapia ?? false))
              Expanded(
                child: EditTextArea(
                  textController: diagoTextController,
                  labelEditText: "Impresiones diagnósticas",
                  keyBoardType: TextInputType.multiline,
                  numOfLines: 22,
                  limitOfChars: 700,
                  onChange: (value) {
                    Reportes.impresionesDiagnosticas = value;
                    Reportes.reportes['Impresiones_Diagnosticas'] = value;
                    Reportes.reportes['Diagnosticos_Hospital'] = value;
                    //
                    Reportes.impresionesDiagnosticas = diagoTextController.text;
                    Reportes.reportes['Impresiones_Diagnosticas'] = diagoTextController.text;
                    Reportes.reportes['Diagnosticos_Hospital'] = diagoTextController.text;
                  },
                  inputFormat: MaskTextInputFormatter(),
                ),
              ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  pronosticosSpinners(context),
                  Expanded(
                    flex: 5,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          GrandButton(
                            weigth: 1200,
                            height: 25,
                            labelButton: "Aceptar pronóstico",
                            onPress: () {
                              setState(() {
                                aceptar();
                                pronosTextController.text =
                                    Pacientes.pronosticoMedico();
                              });
                            },
                          ),
                          CrossLine(thickness: 3, height: 10),
                          pronosticoEditor(context),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Widget pronosticosSpinners(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(children: [
        spinner("Estado médico", estadoValue, Pacientes.PronosticoEstado, (val) {
          estadoValue = val;
        }),
        spinner("Para la función", funcionValue, Pacientes.PronosticoFuncion, (val) {
          funcionValue = val;
        }),
        spinner("Para la vida", vidaValue, Pacientes.PronosticoVida, (val) {
          vidaValue = val;
        }),
        spinner("Para el tiempo", tiempoValue, Pacientes.PronosticoTiempo, (val) {
          tiempoValue = val;
        }),
      ]),
    );
  }

  Widget spinner(String title, String? value, List<String> items, Function(String) onChanged) {
    return Expanded(
      child: Spinner(
        fontSize: 6.0,
        width: isMobile(context)
            ? 60
            : isTablet(context) || isTabletAndDesktop(context)
            ? 140
            : 180,
        tittle: title,
        initialValue: value,
        onChangeValue: (newValue) => setState(() => onChanged(newValue!)),
        items: items,
      ),
    );
  }

  Widget pronosticoEditor(BuildContext context) {
    final isMobileDevice = isMobile(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 5,
              child: EditTextArea(
                textController: pronosTextController,
                labelEditText: "Pronóstico médico",
                keyBoardType: TextInputType.multiline,
                numOfLines: isTablet(context) ? 15 : isMobileDevice ? 18 : 10,
                limitOfChars: 2000,
                onChange: (value) {
                  Reportes.pronosticoMedico = value;
                  Reportes.reportes['Pronostico_Medico'] = value;
                },
                inputFormat: MaskTextInputFormatter(),
              ),
            ),
            if (!isMobileDevice)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: sideIcons(),
                ),
              ),
          ],
        ),
        if (isMobileDevice)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: sideIcons().map((e) => Expanded(child: e)).toList(),
          ),
      ],
    );
  }

  List<Widget> sideIcons() {
    return [
      CircleIcon(
        iconed: Icons.add,
        tittle: "Comentarios Previos . . . ",
        onChangeValue: () {
          Operadores.selectOptionsActivity(
            context: context,
            options: Items.bibliografiasContempladas.map((e) => e['Diagnostico']).toList(),
            onClose: (valar) {
              final selected = Items.bibliografiasContempladas.firstWhere(
                    (e) => e['Diagnostico'] == valar,
                orElse: () => {},
              );
              if (selected['Bibliografia'] != null) {
                pronosTextController.text += selected['Bibliografia']!;
              }
              Navigator.of(context).pop();
            },
          );
        },
      ),
      const SizedBox(height: 15),
      CircleIcon(
        iconed: Icons.hourglass_bottom,
        radios: 25,
        difRadios: 7,
        tittle: "Cultivos Recabados . . . ",
        onChangeValue: () {
          final cultivos = Auxiliares.getCultivos();
          pronosTextController.text += " $cultivos";
          Reportes.reportes['Pronostico_Medico'] = pronosTextController.text;
        },
      ),
      const SizedBox(height: 15),
      GrandButton(onPress: () {}),
    ];
  }
}
