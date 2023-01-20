import 'package:assistant/conexiones/usuarios/Pacientes.dart';
import 'package:assistant/widgets/DialogSelector.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ExploracionFisica extends StatefulWidget {
  const ExploracionFisica({super.key});

  @override
  State<ExploracionFisica> createState() => _ExploracionFisicaState();
}

class _ExploracionFisicaState extends State<ExploracionFisica> {
  var expoTextController = TextEditingController();
  var vitalTextController = TextEditingController();

  var scrollSignoController = ScrollController();
  var scrollExpoController = ScrollController();

  // ######################### ### # ### ############################
  // INICIO DE LAS OPERACIONES STATE() Y BUILD().
  // ######################### ### # ### ############################

  @override
  void initState() {
    setState(() {
      expoTextController.text = Reportes.exploracionFisica;
      vitalTextController.text = Reportes.signosVitales;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: EditTextArea(
                      textController: vitalTextController,
                      labelEditText: "Signos Vitales",
                      keyBoardType: TextInputType.multiline,
                      numOfLines: 6,
                      onChange: ((value) => setState(() {
                            Reportes.signosVitales = value;
                            Reportes.reportes['Signos_Vitales'] = value;
                          })),
                      inputFormat: MaskTextInputFormatter()),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    controller: scrollSignoController,
                    child: Column(
                      children: [
                        GrandButton(
                          labelButton: "Bioconstantes",
                          onPress: () {
                            asignarVitales(indice: 1);
                          },
                        ),
                        GrandButton(
                          labelButton: "Signos vitales",
                          onPress: () {
                            asignarVitales(indice: 2);
                          },
                        ),
                        GrandButton(
                          labelButton: "Medidas antropométricas",
                          onPress: () {
                            asignarVitales(indice: 3);
                          },
                        ),
                        GrandButton(
                          labelButton: "Asociado a Riesgo",
                          onPress: () {
                            asignarVitales(indice: 4);
                          },
                        ),
                        GrandButton(
                          labelButton: "Antropometría infantil",
                          onPress: () {
                            asignarVitales(indice: 5);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: EditTextArea(
                      textController: expoTextController,
                      labelEditText: "Exploración física",
                      keyBoardType: TextInputType.multiline,
                      numOfLines: 13,
                      onChange: ((value) => setState(() {
                            Reportes.exploracionFisica = value;
                            Reportes.reportes['Exploracion_Fisica'] = value;
                          })),
                      inputFormat: MaskTextInputFormatter()),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    controller: scrollExpoController,
                    child: Column(
                      children: [
                        GrandButton(
                          labelButton: "Exploración física",
                          onPress: () {
                            asignarExploracion(indice: 1);
                          },
                        ),
                        GrandButton(
                          labelButton: "Exploración física extensa",
                          onPress: () {
                            asignarExploracion(indice: 2);
                          },
                        ),
                        GrandButton(
                          labelButton: "Analisis de terapia intensiva",
                          onPress: () {
                            asignarExploracion(indice: 3);
                          },
                        ),
                        GrandButton(
                          labelButton: "Sin hallazgos relevantes",
                          onPress: () {
                            asignarExploracion(indice: 0);
                          },
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

  void asignarVitales({required int indice}) {
    setState(() {
      vitalTextController.text = Pacientes.signosVitales(indice: indice);
      Reportes.reportes['Signos_Vitales'] = "${vitalTextController.text}.";
      Reportes.signosVitales = vitalTextController.text;
    });
  }

  void asignarExploracion({required int indice}) {
    setState(() {
      expoTextController.text = Pacientes.exploracionFisica(indice: indice);
      Reportes.reportes['Exploracion_Fisica'] = "${expoTextController.text}.";
      Reportes.exploracionFisica = expoTextController.text;
    });
  }
}

class AuxiliaresExploracion extends StatefulWidget {
  const AuxiliaresExploracion({super.key});

  @override
  State<AuxiliaresExploracion> createState() => _AuxiliaresExploracionState();
}

class _AuxiliaresExploracionState extends State<AuxiliaresExploracion> {
  var auxTextController = TextEditingController();
  var commenTextController = TextEditingController();

  var scrollAuxController = ScrollController();
  var scrollCommenController = ScrollController();

  late String? tipoEstudio;

  @override
  void initState() {
    Auxiliares.registros();
    auxTextController.text = Reportes.auxiliaresDiagnosticos;
    commenTextController.text = Reportes.analisisComplementarios;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: EditTextArea(
                      textController: auxTextController,
                      labelEditText: "Auxiliares diagnósticos",
                      keyBoardType: TextInputType.multiline,
                      numOfLines: 8,
                      withShowOption: true,
                      onChange: ((value) {
                        Reportes.auxiliaresDiagnosticos = value;
                        Reportes.reportes['Auxiliares_Diagnosticos'] = value;
                      }),
                      inputFormat: MaskTextInputFormatter()),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    controller: scrollAuxController,
                    child: Column(
                      children: [
                        GrandButton(
                          labelButton: "Electrocardiograma",
                          onPress: () {
                            asignarParaclinico(indice: 20);
                          },
                        ),
                        GrandButton(
                          labelButton: "Biometría hemática",
                          onPress: () {
                            setState(() {
                              asignarParaclinico(indice: 0);
                            });
                          },
                        ),
                        GrandButton(
                          labelButton: "Química sanguínea",
                          onPress: () {
                            setState(() {
                              asignarParaclinico(indice: 1);
                            });
                          },
                        ),
                        GrandButton(
                          labelButton: "Electrolitos séricos",
                          onPress: () {
                            setState(() {
                              asignarParaclinico(indice: 2);
                            });
                          },
                        ),
                        GrandButton(
                          labelButton: "Perfil hepático",
                          onPress: () {
                            setState(() {
                              asignarParaclinico(indice: 3);
                            });
                          },
                        ),
                        GrandButton(
                          labelButton: "Perfil lipídico",
                          onPress: () {
                            setState(() {
                              asignarParaclinico(indice: 4);
                            });
                          },
                        ),
                        GrandButton(
                          labelButton: "Perfil tiroideo",
                          onPress: () {
                            setState(() {
                              asignarParaclinico(indice: 5);
                            });
                          },
                        ),
                        GrandButton(
                          labelButton: "Tiempos de coagulación",
                          onPress: () {
                            setState(() {
                              asignarParaclinico(indice: 6);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: EditTextArea(
                      textController: commenTextController,
                      labelEditText: "Análisis complementarios",
                      keyBoardType: TextInputType.multiline,
                      numOfLines: 8,
                      onChange: ((value) {
                        Reportes.analisisComplementarios = value;
                        Reportes.reportes['Analisis_Complementarios'] = value;
                      }),
                      inputFormat: MaskTextInputFormatter()),
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    controller: scrollCommenController,
                    child: Column(
                      children: [
                        GrandButton(
                          labelButton: "Antropométricos",
                          onPress: () {
                            asignarAuxAnalisis(indice: 1);
                          },
                        ),
                        GrandButton(
                          labelButton: "Metabólicos",
                          onPress: () {
                            asignarAuxAnalisis(indice: 2);
                          },
                        ),
                        GrandButton(
                          labelButton: "Cardiovasculares",
                          onPress: () {
                            asignarAuxAnalisis(indice: 3);
                          },
                        ),
                        GrandButton(
                          labelButton: "Hídricos",
                          onPress: () {
                            asignarAuxAnalisis(indice: 4);
                          },
                        ),
                        GrandButton(
                          labelButton: "Hepáticos",
                          onPress: () {
                            asignarAuxAnalisis(indice: 5);
                          },
                        ),
                        GrandButton(
                          labelButton: "Hemáticos",
                          onPress: () {
                            asignarAuxAnalisis(indice: 6);
                          },
                        ),
                        GrandButton(
                          labelButton: "Renales",
                          onPress: () {
                            asignarAuxAnalisis(indice: 7);
                          },
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

  void asignarParaclinico({required int indice}) {
    setState(() {
      if (auxTextController.text == "") {
        auxTextController.text =
            Pacientes.auxiliaresDiagnosticos(indice: indice);
      } else {
        auxTextController.text =
            "${auxTextController.text}\n${Pacientes.auxiliaresDiagnosticos(indice: indice)}";
      }
      Reportes.reportes['Auxiliares_Diagnosticos'] = auxTextController.text;
      Reportes.auxiliaresDiagnosticos = auxTextController.text;
    });
  }

  void asignarAuxAnalisis({required int indice}) {
    setState(() {
      if (commenTextController.text == "") {
        commenTextController.text =
            Pacientes.analisisComplementarios(indice: indice);
      } else {
        commenTextController.text =
            "${commenTextController.text}\n${Pacientes.analisisComplementarios(indice: indice)}";
      }
      Reportes.reportes['Analisis_Complementarios'] = commenTextController.text;
      Reportes.analisisComplementarios = commenTextController.text;
    });
  }
}

class AnalisisMedico extends StatefulWidget {
  const AnalisisMedico({super.key});

  @override
  State<AnalisisMedico> createState() => _AnalisisMedicoState();
}

class _AnalisisMedicoState extends State<AnalisisMedico> {
  var eventualidadesTextController = TextEditingController();
  var terapiasTextController = TextEditingController();
  var analisisTextController = TextEditingController();
  var tratamientoTextController = TextEditingController();

  @override
  void initState() {
    eventualidadesTextController.text = Reportes.eventualidadesOcurridas;
    terapiasTextController.text = Reportes.terapiasPrevias;
    analisisTextController.text = Reportes.analisisMedico;
    tratamientoTextController.text = Reportes.tratamientoPropuesto;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          child: Column(children: [
            EditTextArea(
                textController: eventualidadesTextController,
                labelEditText: "Eventualidades sucitadas",
                keyBoardType: TextInputType.multiline,
                numOfLines: 5,
                withShowOption: true,
                onChange: ((value) {
                  Reportes.eventualidadesOcurridas = "$value.";
                  Reportes.reportes['Analisis_Medico'] =
                      "${Reportes.eventualidadesOcurridas} ${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                }),
                inputFormat: MaskTextInputFormatter()),
            EditTextArea(
                textController: terapiasTextController,
                labelEditText: "Terapias previas",
                keyBoardType: TextInputType.multiline,
                numOfLines: 5,
                withShowOption: true,
                onChange: ((value) {
                  Reportes.terapiasPrevias = "$value.";
                  Reportes.reportes['Analisis_Medico'] =
                      "${Reportes.eventualidadesOcurridas} ${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                }),
                inputFormat: MaskTextInputFormatter()),
            EditTextArea(
                textController: analisisTextController,
                labelEditText: "Análisis médico",
                keyBoardType: TextInputType.multiline,
                numOfLines: 5,
                withShowOption: true,
                onChange: ((value) {
                  Reportes.analisisMedico = "$value.";
                  Reportes.reportes['Analisis_Medico'] =
                      "${Reportes.eventualidadesOcurridas} ${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                }),
                inputFormat: MaskTextInputFormatter()),
            EditTextArea(
                textController: tratamientoTextController,
                labelEditText: "Terapéutica propuesta",
                keyBoardType: TextInputType.multiline,
                numOfLines: 5,
                withShowOption: true,
                onChange: ((value) {
                  Reportes.tratamientoPropuesto = "$value.";
                  Reportes.reportes['Analisis_Medico'] =
                      "${Reportes.eventualidadesOcurridas} ${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                }),
                inputFormat: MaskTextInputFormatter()),
          ]),
        ))
      ],
    );
  }
}

class DiagnosticosAndPronostico extends StatefulWidget {
  const DiagnosticosAndPronostico({super.key});

  @override
  State<DiagnosticosAndPronostico> createState() =>
      _DiagnosticosAndPronosticoState();
}

class _DiagnosticosAndPronosticoState extends State<DiagnosticosAndPronostico> {
  // ######################### ### # ### ############################
  // INICIO DE LAS OPERACIONES STATE() Y BUILD().
  // ######################### ### # ### ############################
  var scrollController = ScrollController();
  // #######################+## ### # ### ############################
  // INICIO DE LAS OPERACIONES STATE() Y BUILD().
  // ######################### ### # ### ############################
  var diagoTextController = TextEditingController();
  var pronosTextController = TextEditingController();
  // ######################### ### # ### ############################
  // INICIO DE LAS OPERACIONES STATE() Y BUILD().
  // ######################### ### # ### ############################
  String? funcionValue = Pacientes.PronosticoFuncion[0];
  String? vidaValue = Pacientes.PronosticoVida[0];
  String? tiempoValue = Pacientes.PronosticoTiempo[0];
  String? estadoValue = Pacientes.PronosticoEstado[0];
  // ######################### ### # ### ############################
  // INICIO DE LAS OPERACIONES STATE() Y BUILD().
  // ######################### ### # ### ############################

  @override
  void initState() {
    setState(() {
      // funcionValue = Pacientes.pronosticoFuncion;
      // vidaValue = Pacientes.pronosticoVida;
      // tiempoValue = Pacientes.pronosticoTiempo;
      // estadoValue = Pacientes.pronosticoEstado;
      diagoTextController.text = "";
      pronosTextController.text = "";
      //
      diagoTextController.text = Pacientes.diagnosticos();
      pronosTextController.text = Pacientes.pronosticoMedico();
      //
      Reportes.reportes['Impresiones_Diagnosticas'] = Pacientes.diagnosticos();
      Reportes.reportes['Pronostico_Medico'] = Pacientes.pronosticoMedico();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: Column(
        children: [
          Expanded(
            child: EditTextArea(
                textController: diagoTextController,
                labelEditText: "Impresiones diagnósticas",
                keyBoardType: TextInputType.multiline,
                numOfLines: 5,
                onChange: ((value) {
                  Reportes.impresionesDiagnosticas = "$value.";
                  Reportes.reportes['Impresiones_Diagnosticas'] = "$value.";
                }),
                inputFormat: MaskTextInputFormatter()),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(children: [
                      Spinner(
                        tittle: "Estado médico",
                        initialValue: estadoValue,
                        onChangeValue: (String? newValue) {
                          setState(() {
                            estadoValue = newValue!;
                          });
                        },
                        items: Pacientes.PronosticoEstado,
                      ),
                      Spinner(
                        tittle: "Para la función",
                        initialValue: funcionValue,
                        onChangeValue: (String? newValue) {
                          setState(() {
                            funcionValue = newValue!;
                          });
                        },
                        items: Pacientes.PronosticoFuncion,
                      ),
                      Spinner(
                          tittle: "Para la vida",
                          initialValue: vidaValue,
                          onChangeValue: (String? newValue) {
                            setState(() {
                              vidaValue = newValue!;
                            });
                          },
                          items: Pacientes.PronosticoVida),
                      Spinner(
                        tittle: "Para el tiempo",
                        initialValue: tiempoValue,
                        onChangeValue: (String? newValue) {
                          setState(() {
                            tiempoValue = newValue!;
                          });
                        },
                        items: Pacientes.PronosticoTiempo,
                      ),
                    ]),
                  ),
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
                        EditTextArea(
                            textController: pronosTextController,
                            labelEditText: "Pronóstico médico",
                            keyBoardType: TextInputType.multiline,
                            numOfLines: 10,
                            onChange: ((value) {
                              Reportes.pronosticoMedico = "$value.";
                              Reportes.reportes['Pronostico_Medico'] =
                                  "$value.";
                            }),
                            inputFormat: MaskTextInputFormatter()),
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
}

class IndicacionesConsulta extends StatefulWidget {
  const IndicacionesConsulta({super.key});

  @override
  State<IndicacionesConsulta> createState() => _IndicacionesConsultaState();
}

class _IndicacionesConsultaState extends State<IndicacionesConsulta> {
  var medicamentosTextController = TextEditingController();
  var licenciasTextController = TextEditingController();
  var pendientesTextController = TextEditingController();
  var citasTextController = TextEditingController();
  var recomendacionesTextController = TextEditingController();

  @override
  void initState() {
    medicamentosTextController.text = traduce(Reportes.medicamentosIndicados);
    licenciasTextController.text = traduce(Reportes.licenciasMedicas);
    pendientesTextController.text = traduce(Reportes.pendientes);
    citasTextController.text = traduce(Reportes.citasMedicas);
    recomendacionesTextController.text =
        traduce(Reportes.recomendacionesGenerales);
    // tratamientoTextController.text = Reportes.tratamientoPropuesto;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.black,
      child: Column(
        children: [
          TittlePanel(textPanel: 'Indicaciones'),
          Expanded(
              child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(children: [
              EditTextArea(
                  textController: medicamentosTextController,
                  labelEditText: "Medicamentos",
                  keyBoardType: TextInputType.multiline,
                  numOfLines: 5,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    showDialog(
                        useSafeArea: true,
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: DialogSelector(
                            tittle: 'Medicamentos',
                            pathForFileSource:
                                'assets/diccionarios/Farmacos.txt',
                            typeOfDocument: 'txt',
                            onSelected: ((value) {
                              setState(() {
                                Reportes.medicamentosIndicados.add(value);
                                medicamentosTextController.text =
                                    "${medicamentosTextController.text}$value\n";
                              });
                            }),
                          ));
                        });
                  },
                  onChange: ((value) {
                    Reportes.medicamentosIndicados = traslate(value);
                    Reportes.reportes['Medicamentos'] =
                        Reportes.medicamentosIndicados;
                  }),
                  inputFormat: MaskTextInputFormatter()),
              EditTextArea(
                  textController: licenciasTextController,
                  labelEditText: "Licencias médicas",
                  keyBoardType: TextInputType.multiline,
                  numOfLines: 5,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    showDialog(
                        useSafeArea: true,
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: DialogSelector(
                            tittle: 'Licencias Médicas Otorgadas',
                            pathForFileSource:
                                'assets/diccionarios/Farmacos.txt',
                            typeOfDocument: 'txt',
                            onSelected: ((value) {
                              setState(() {
                                Reportes.licenciasMedicas.add(value);
                                licenciasTextController.text =
                                    "${licenciasTextController.text}$value\n";
                              });
                            }),
                          ));
                        });
                  },
                  onChange: ((value) {
                    Reportes.licenciasMedicas = traslate(value);
                    Reportes.reportes['Licencia_Medica'] =
                        Reportes.licenciasMedicas;
                  }),
                  inputFormat: MaskTextInputFormatter()),
              EditTextArea(
                  textController: pendientesTextController,
                  labelEditText: "Pendientes",
                  keyBoardType: TextInputType.multiline,
                  numOfLines: 5,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    showDialog(
                        useSafeArea: true,
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: DialogSelector(
                            tittle: 'Pendientes en la Atención',
                            pathForFileSource:
                                'assets/diccionarios/Pendientes.txt',
                            typeOfDocument: 'txt',
                            onSelected: ((value) {
                              setState(() {
                                Reportes.pendientes.add(value);
                                pendientesTextController.text =
                                    "${pendientesTextController.text}$value\n";
                              });
                            }),
                          ));
                        });
                  },
                  onChange: ((value) {
                    Reportes.pendientes = traslate(value);
                    Reportes.reportes['Pendientes'] = Reportes.pendientes;
                  }),
                  inputFormat: MaskTextInputFormatter()),
              EditTextArea(
                  textController: citasTextController,
                  labelEditText: "Citas médicas",
                  keyBoardType: TextInputType.multiline,
                  numOfLines: 5,
                  withShowOption: true,
                  onChange: ((value) {
                    Reportes.citasMedicas = traslate(value);
                    Reportes.reportes['Citas'] = Reportes.citasMedicas;
                  }),
                  inputFormat: MaskTextInputFormatter()),
              EditTextArea(
                  textController: recomendacionesTextController,
                  labelEditText: "Recomendaciones generales",
                  keyBoardType: TextInputType.multiline,
                  numOfLines: 5,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    showDialog(
                        useSafeArea: true,
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: DialogSelector(
                            tittle: 'Recomendaciones Generales',
                            pathForFileSource:
                                'assets/diccionarios/Recomendaciones.txt',
                            typeOfDocument: 'txt',
                            onSelected: ((value) {
                              setState(() {
                                Reportes.recomendacionesGenerales.add(value);
                                recomendacionesTextController.text =
                                    "${recomendacionesTextController.text}$value\n";
                              });
                            }),
                          ));
                        });
                  },
                  onChange: ((value) {
                    Reportes.recomendacionesGenerales = traslate(value);
                    Reportes.reportes['Recomendaciones'] =
                        Reportes.recomendacionesGenerales;
                  }),
                  inputFormat: MaskTextInputFormatter()),
            ]),
          ))
        ],
      ),
    );
  }
}

String traduce(List<String> collection) {
  String string = "";
  for (var element in collection) {
    // print('element $element');
    if (string == "") {
      string = "$element\n";
    } else {
      string = "$string$element\n";
    }
  }
  return string;
}

List<String> traslate(String value) {
  return value.split('\n');
}

class IndicacionesHospital extends StatefulWidget {
  const IndicacionesHospital({super.key});

  @override
  State<IndicacionesHospital> createState() => _IndicacionesHospitalState();
}

class _IndicacionesHospitalState extends State<IndicacionesHospital> {
  var liquidosTextController = TextEditingController();
  var medicamentosTextController = TextEditingController();
  var medidasTextController = TextEditingController();
  var insulinoterapiaTextController = TextEditingController();
  var oxigenoterapiaTextController = TextEditingController();
  var hemoterapiaTextController = TextEditingController();
  var pendientesTextController = TextEditingController();

  @override
  void initState() {
    liquidosTextController.text = traduce(Reportes.hidroterapia);
    medicamentosTextController.text = traduce(Reportes.medicamentosIndicados);
    medidasTextController.text = traduce(Reportes.medidasGenerales);
    insulinoterapiaTextController.text = traduce(Reportes.insulinoterapia);
    oxigenoterapiaTextController.text = traduce(Reportes.oxigenoterapia);
    hemoterapiaTextController.text = traduce(Reportes.hemoterapia);
    pendientesTextController.text = traduce(Reportes.pendientes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.black,
      child: Column(
        children: [
          TittlePanel(textPanel: 'Indicaciones'),
          Expanded(
              child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(children: [
              EditTextArea(
                  textController: liquidosTextController,
                  labelEditText: "Hidroterapia",
                  keyBoardType: TextInputType.multiline,
                  numOfLines: 5,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    showDialog(
                        useSafeArea: true,
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: DialogSelector(
                            tittle: 'Hidroterapia',
                            pathForFileSource:
                                'assets/diccionarios/Farmacos.txt',
                            typeOfDocument: 'txt',
                            onSelected: ((value) {
                              setState(() {
                                Reportes.medicamentosIndicados.add(value);
                                medicamentosTextController.text =
                                    "${medicamentosTextController.text}$value\n";
                              });
                            }),
                          ));
                        });
                  },
                  onChange: ((value) {
                    Reportes.hidroterapia = traslate(value);
                    Reportes.reportes['Hidroterapia'] = Reportes.hidroterapia;
                  }),
                  inputFormat: MaskTextInputFormatter()),
              EditTextArea(
                  textController: medicamentosTextController,
                  labelEditText: "Medicamentos",
                  keyBoardType: TextInputType.multiline,
                  numOfLines: 5,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    showDialog(
                        useSafeArea: true,
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: DialogSelector(
                            tittle: 'Medicamentos',
                            pathForFileSource:
                                'assets/diccionarios/Farmacos.txt',
                            typeOfDocument: 'txt',
                            onSelected: ((value) {
                              setState(() {
                                Reportes.medicamentosIndicados.add(value);
                                medicamentosTextController.text =
                                    "${medicamentosTextController.text}$value\n";
                              });
                            }),
                          ));
                        });
                  },
                  onChange: ((value) {
                    Reportes.medicamentosIndicados = traslate(value);
                    Reportes.reportes['Medicamentos'] =
                        Reportes.medicamentosIndicados;
                  }),
                  inputFormat: MaskTextInputFormatter()),
              EditTextArea(
                  textController: medidasTextController,
                  labelEditText: "Medidas Generales",
                  keyBoardType: TextInputType.multiline,
                  numOfLines: 5,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    showDialog(
                        useSafeArea: true,
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: DialogSelector(
                            tittle: 'Medidas Generales',
                            pathForFileSource:
                                'assets/diccionarios/Medidas.txt',
                            typeOfDocument: 'txt',
                            onSelected: ((value) {
                              setState(() {
                                Reportes.medidasGenerales.add(value);
                                medidasTextController.text =
                                    "${medidasTextController.text}$value\n";
                              });
                            }),
                          ));
                        });
                  },
                  onChange: ((value) {
                    Reportes.medidasGenerales = traslate(value);
                    Reportes.reportes['Medidas_Generales'] =
                        Reportes.medidasGenerales;
                  }),
                  inputFormat: MaskTextInputFormatter()),
              EditTextArea(
                  textController: oxigenoterapiaTextController,
                  labelEditText: "Oxígenoterapia",
                  keyBoardType: TextInputType.multiline,
                  numOfLines: 5,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {},
                  onChange: ((value) {
                    Reportes.oxigenoterapia = traslate(value);
                    Reportes.reportes['Oxígenoterapia'] =
                        Reportes.oxigenoterapia;
                  }),
                  inputFormat: MaskTextInputFormatter()),
              //
              EditTextArea(
                  textController: insulinoterapiaTextController,
                  labelEditText: "Insulinoterapia",
                  keyBoardType: TextInputType.multiline,
                  numOfLines: 5,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {},
                  onChange: ((value) {
                    Reportes.insulinoterapia = traslate(value);
                    Reportes.reportes['Insulinoterapia'] =
                        Reportes.insulinoterapia;
                  }),
                  inputFormat: MaskTextInputFormatter()),
              EditTextArea(
                  textController: hemoterapiaTextController,
                  labelEditText: "Hemoterapia",
                  keyBoardType: TextInputType.multiline,
                  numOfLines: 5,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {},
                  onChange: ((value) {
                    Reportes.hemoterapia = traslate(value);
                    Reportes.reportes['Hemoterapia'] = Reportes.hemoterapia;
                  }),
                  inputFormat: MaskTextInputFormatter()),
              //
              EditTextArea(
                  textController: pendientesTextController,
                  labelEditText: "Pendientes",
                  keyBoardType: TextInputType.multiline,
                  numOfLines: 5,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    showDialog(
                        useSafeArea: true,
                        context: context,
                        builder: (context) {
                          return Dialog(
                              child: DialogSelector(
                            tittle: 'Pendientes en la Atención',
                            pathForFileSource:
                                'assets/diccionarios/Pendientes.txt',
                            typeOfDocument: 'txt',
                            onSelected: ((value) {
                              setState(() {
                                Reportes.pendientes.add(value);
                                pendientesTextController.text =
                                    "${pendientesTextController.text}$value\n";
                              });
                            }),
                          ));
                        });
                  },
                  onChange: ((value) {
                    Reportes.pendientes = traslate(value);
                    Reportes.reportes['Pendientes'] = Reportes.pendientes;
                  }),
                  inputFormat: MaskTextInputFormatter()),
            ]),
          ))
        ],
      ),
    );
  }
}
