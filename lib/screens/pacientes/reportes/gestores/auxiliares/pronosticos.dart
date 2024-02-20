import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/analisis.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/DialogSelector.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DiagnosticosAndPronostico extends StatefulWidget {
  bool? isTerapia;

  DiagnosticosAndPronostico({this.isTerapia = false, super.key});

  @override
  State<DiagnosticosAndPronostico> createState() =>
      _DiagnosticosAndPronosticoState();
}

class _DiagnosticosAndPronosticoState extends State<DiagnosticosAndPronostico> {

  @override
  void initState() {
    setState(() {
      //
      diagoTextController.text = Reportes.impresionesDiagnosticas.isNotEmpty
          ? Reportes.impresionesDiagnosticas
          : Pacientes.diagnosticos();

      // if (Reportes.reportes['Impresiones_Diagnosticas'] != "") diagoTextController.text = Reportes.reportes['Impresiones_Diagnosticas']; else diagoTextController.text = Pacientes.diagnosticos();

      if (Reportes.reportes['Pronostico_Medico'] != "")
        pronosTextController.text = Reportes.reportes['Pronostico_Medico'];
      else
        pronosTextController.text = Pacientes.pronosticoMedico();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: Column(
        children: [
          widget.isTerapia == true
              ? Container()
              : Expanded(
                  child: EditTextArea(
                      textController: diagoTextController,
                      labelEditText: "Impresiones diagnósticas",
                      keyBoardType: TextInputType.multiline,
                      numOfLines: 15,
                      onChange: ((value) {
                        Reportes.impresionesDiagnosticas = "$value.";
                        Reportes.reportes['Impresiones_Diagnosticas'] =
                            "$value.";
                      }),
                      inputFormat: MaskTextInputFormatter()),
                ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(children: [
                    Expanded(
                      child: Spinner(
                        width: isMobile(context)
                            ? 60
                            : isTablet(context) || isTabletAndDesktop(context)
                                ? 140
                                : 180,
                        tittle: "Estado médico",
                        initialValue: estadoValue,
                        onChangeValue: (String? newValue) {
                          setState(() {
                            estadoValue = newValue!;
                          });
                        },
                        items: Pacientes.PronosticoEstado,
                      ),
                    ),
                    Expanded(
                      child: Spinner(
                        width: isMobile(context)
                            ? 60
                            : isTablet(context) || isTabletAndDesktop(context)
                                ? 140
                                : 180,
                        tittle: "Para la función",
                        initialValue: funcionValue,
                        onChangeValue: (String? newValue) {
                          setState(() {
                            funcionValue = newValue!;
                          });
                        },
                        items: Pacientes.PronosticoFuncion,
                      ),
                    ),
                    Expanded(
                      child: Spinner(
                          width: isMobile(context)
                              ? 60
                              : isTablet(context) || isTabletAndDesktop(context)
                                  ? 150
                                  : 180,
                          tittle: "Para la vida",
                          initialValue: vidaValue,
                          onChangeValue: (String? newValue) {
                            setState(() {
                              vidaValue = newValue!;
                            });
                          },
                          items: Pacientes.PronosticoVida),
                    ),
                    Expanded(
                      child: Spinner(
                        width: isMobile(context)
                            ? 60
                            : isTablet(context) || isTabletAndDesktop(context)
                                ? 150
                                : 180,
                        tittle: "Para el tiempo",
                        initialValue: tiempoValue,
                        onChangeValue: (String? newValue) {
                          setState(() {
                            tiempoValue = newValue!;
                          });
                        },
                        items: Pacientes.PronosticoTiempo,
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GrandButton(
                          labelButton: "Aceptar pronóstico",
                          onPress: () {
                            setState(() {
                              aceptar();
                              pronosTextController.text =
                                  Pacientes.pronosticoMedico();
                            });
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: EditTextArea(
                                  textController: pronosTextController,
                                  labelEditText: "Pronóstico médico",
                                  keyBoardType: TextInputType.multiline,
                                  numOfLines: 10,
                                  limitOfChars: 2000,
                                  onChange: ((value) {
                                    Reportes.pronosticoMedico = "$value.";
                                    Reportes.reportes['Pronostico_Medico'] =
                                        "$value.";
                                  }),
                                  inputFormat: MaskTextInputFormatter()),
                            ),
                            Expanded(
                              child: CircleIcon(
                                  iconed: Icons.add,
                                  tittle: "Comentarios Previos . . . ",
                                  onChangeValue: () {
                                    Operadores.selectOptionsActivity(context: context,
                                        options: Items.bibliografiasContempladas.map((e) =>
                                        e['Diagnostico']).toList(),
                                        onClose: (valar) {
                                          Terminal.printWarning(message: "$valar");

                                          Items.bibliografiasContempladas.forEach((e) {
                                            //
                                            if (e['Diagnostico'] == valar) {
                                              pronosTextController.text = "${pronosTextController.text}${e['Bibliografia']!}";
                                            }
                                          });
                                          Navigator.of(context).pop();
                                        });
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ))
    ]);
  }

  void aceptar() {
    Pacientes.pronosticoFuncion = funcionValue;
    Pacientes.pronosticoVida = vidaValue;
    Pacientes.pronosticoTiempo = tiempoValue;
    Pacientes.pronosticoEstado = estadoValue;
  }

  // INICIO DE LAS OPERACIONES STATE() Y BUILD(). **********************
  var scrollController = ScrollController();
  //
  var diagoTextController = TextEditingController();
  var pronosTextController = TextEditingController();
  // ######################### ### # ### ############################
  String? funcionValue = Pacientes.PronosticoFuncion[0];
  String? vidaValue = Pacientes.PronosticoVida[0];
  String? tiempoValue = Pacientes.PronosticoTiempo[0];
  String? estadoValue = Pacientes.PronosticoEstado[0];
// ######################### ### # ### ############################
// INICIO DE LAS OPERACIONES STATE() Y BUILD().
// ######################### ### # ### ############################

}
