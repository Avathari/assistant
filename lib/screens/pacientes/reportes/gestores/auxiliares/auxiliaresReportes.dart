import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/analisis.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/DialogSelector.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AuxiliaresExploracion extends StatefulWidget {
  bool? isPrequirurgico;

  AuxiliaresExploracion({super.key, this.isPrequirurgico = false});

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
    setState(() {
      if (widget.isPrequirurgico! == true) {
        Reportes.analisisComplementarios = Valorados.prequirurgicos;
      }

      auxTextController.text = Reportes.auxiliaresDiagnosticos;
      commenTextController.text = Reportes.analisisComplementarios;
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: EditTextArea(
                      textController: auxTextController,
                      labelEditText: "Auxiliares diagn??sticos",
                      keyBoardType: TextInputType.multiline,
                      numOfLines: isTablet(context) ? 16: 8,
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
                          labelButton: "Biometr??a hem??tica",
                          onPress: () {
                            int index = 0;
                            Operadores.selectOptionsActivity(
                              context: context,
                              tittle:
                                  "Elija la fecha de la biometr??a hem??tica . . . ",
                              options: Listas.listWithoutRepitedValues(
                                Listas.listFromMapWithOneKey(
                                  Listas.listFromMap(
                                      lista: Pacientes.Paraclinicos!,
                                      keySearched: 'Tipo_Estudio',
                                      elementSearched:
                                          Auxiliares.Categorias[index]),
                                ),
                              ),
                              onClose: (value) {
                                setState(() {
                                  asignarParaclinico(
                                      indice: index, fechaActual: value);
                                  Navigator.of(context).pop();
                                });
                              },
                            );
                          },
                        ),
                        GrandButton(
                          labelButton: "Qu??mica sangu??nea",
                          onPress: () {
                            int index = 1;
                            Operadores.selectOptionsActivity(
                              context: context,
                              tittle:
                              "Elija la fecha de la qu??mica sangu??nnea . . . ",
                              options: Listas.listWithoutRepitedValues(
                                Listas.listFromMapWithOneKey(
                                  Listas.listFromMap(
                                      lista: Pacientes.Paraclinicos!,
                                      keySearched: 'Tipo_Estudio',
                                      elementSearched:
                                      Auxiliares.Categorias[index]),
                                ),
                              ),
                              onClose: (value) {
                                setState(() {
                                  asignarParaclinico(
                                      indice: index, fechaActual: value);
                                  Navigator.of(context).pop();
                                });
                              },
                            );
                          },
                        ),
                        GrandButton(
                          labelButton: "Electrolitos s??ricos",
                          onPress: () {
                            int index = 2;
                            Operadores.selectOptionsActivity(
                              context: context,
                              tittle:
                              "Elija la fecha del estudio de electrolitos. . . ",
                              options: Listas.listWithoutRepitedValues(
                                Listas.listFromMapWithOneKey(
                                  Listas.listFromMap(
                                      lista: Pacientes.Paraclinicos!,
                                      keySearched: 'Tipo_Estudio',
                                      elementSearched:
                                      Auxiliares.Categorias[index]),
                                ),
                              ),
                              onClose: (value) {
                                setState(() {
                                  asignarParaclinico(
                                      indice: index, fechaActual: value);
                                  Navigator.of(context).pop();
                                });
                              },
                            );
                          },
                        ),
                        GrandButton(
                          labelButton: "Perfil hep??tico",
                          onPress: () {
                              int index = 3;
                              Operadores.selectOptionsActivity(
                                context: context,
                                tittle:
                                "Elija la fecha del perfil hep??tico . . . ",
                                options: Listas.listWithoutRepitedValues(
                                  Listas.listFromMapWithOneKey(
                                    Listas.listFromMap(
                                        lista: Pacientes.Paraclinicos!,
                                        keySearched: 'Tipo_Estudio',
                                        elementSearched:
                                        Auxiliares.Categorias[index]),
                                  ),
                                ),
                                onClose: (value) {
                                  setState(() {
                                    asignarParaclinico(
                                        indice: index, fechaActual: value);
                                    Navigator.of(context).pop();
                                  });
                                },
                              );

                          },
                        ),
                        GrandButton(
                          labelButton: "Perfil lip??dico",
                          onPress: () {
                            int index = 4;
                            Operadores.selectOptionsActivity(
                              context: context,
                              tittle:
                              "Elija la fecha del perfil lip??co . . . ",
                              options: Listas.listWithoutRepitedValues(
                                Listas.listFromMapWithOneKey(
                                  Listas.listFromMap(
                                      lista: Pacientes.Paraclinicos!,
                                      keySearched: 'Tipo_Estudio',
                                      elementSearched:
                                      Auxiliares.Categorias[index]),
                                ),
                              ),
                              onClose: (value) {
                                setState(() {
                                  asignarParaclinico(
                                      indice: index, fechaActual: value);
                                  Navigator.of(context).pop();
                                });
                              },
                            );
                          },
                        ),
                        GrandButton(
                          labelButton: "Perfil tiroideo",
                          onPress: () {
                            int index = 5;
                            Operadores.selectOptionsActivity(
                              context: context,
                              tittle:
                              "Elija la fecha del perfil tiroideo . . . ",
                              options: Listas.listWithoutRepitedValues(
                                Listas.listFromMapWithOneKey(
                                  Listas.listFromMap(
                                      lista: Pacientes.Paraclinicos!,
                                      keySearched: 'Tipo_Estudio',
                                      elementSearched:
                                      Auxiliares.Categorias[index]),
                                ),
                              ),
                              onClose: (value) {
                                setState(() {
                                  asignarParaclinico(
                                      indice: index, fechaActual: value);
                                  Navigator.of(context).pop();
                                });
                              },
                            );

                          },
                        ),
                        GrandButton(
                          labelButton: "Tiempos de coagulaci??n",
                          onPress: () {
                            int index = 6;
                            Operadores.selectOptionsActivity(
                              context: context,
                              tittle:
                              "Elija la fecha del perfil de coagulaci??n . . . ",
                              options: Listas.listWithoutRepitedValues(
                                Listas.listFromMapWithOneKey(
                                  Listas.listFromMap(
                                      lista: Pacientes.Paraclinicos!,
                                      keySearched: 'Tipo_Estudio',
                                      elementSearched:
                                      Auxiliares.Categorias[index]),
                                ),
                              ),
                              onClose: (value) {
                                setState(() {
                                  asignarParaclinico(
                                      indice: index, fechaActual: value);
                                  Navigator.of(context).pop();
                                });
                              },
                            );

                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          CrossLine(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: EditTextArea(
                      textController: commenTextController,
                      labelEditText: "An??lisis complementarios",
                      keyBoardType: TextInputType.multiline,
                      numOfLines: isTablet(context) ? 16: 8,
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
                          labelButton: "Antropom??tricos",
                          onPress: () {
                            asignarAuxAnalisis(indice: 1);
                          },
                        ),
                        GrandButton(
                          labelButton: "Metab??licos",
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
                          labelButton: "H??dricos",
                          onPress: () {
                            asignarAuxAnalisis(indice: 4);
                          },
                        ),
                        GrandButton(
                          labelButton: "Hep??ticos",
                          onPress: () {
                            asignarAuxAnalisis(indice: 5);
                          },
                        ),
                        GrandButton(
                          labelButton: "Hem??ticos",
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

  void asignarParaclinico({required int indice, String fechaActual = ""}) {
    setState(() {

      if (auxTextController.text == "") {
        auxTextController.text = Pacientes.auxiliaresDiagnosticos(
            indice: indice, fechaActual: fechaActual);
      } else {
        auxTextController.text =
            "${auxTextController.text}\n${Pacientes.auxiliaresDiagnosticos(indice: indice, fechaActual: fechaActual)}";
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
  bool? isPrequirurgica;

  AnalisisMedico({super.key, this.isPrequirurgica = false});

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
    if (widget.isPrequirurgica!) {
      Reportes.tratamientoPropuesto = Formatos.indicacionesPreoperatorias;
      Reportes.reportes['Recomendaciones_Generales'] =
          Reportes.tratamientoPropuesto;

      eventualidadesTextController.text = "";
      terapiasTextController.text = "";
      analisisTextController.text = "";
      tratamientoTextController.text = Reportes.tratamientoPropuesto;
    } else {
      eventualidadesTextController.text = Reportes.eventualidadesOcurridas;
      terapiasTextController.text = Reportes.terapiasPrevias;
      analisisTextController.text = Reportes.analisisMedico;
      tratamientoTextController.text = Reportes.tratamientoPropuesto;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.isPrequirurgica == true
            ? Expanded(
                child: SingleChildScrollView(
                child: Column(children: [
                  EditTextArea(
                      textController: tratamientoTextController,
                      labelEditText: "Recomendaciones",
                      keyBoardType: TextInputType.multiline,
                      numOfLines: 20,
                      withShowOption: true,
                      onChange: ((value) {
                        Reportes.tratamientoPropuesto = "$value.";
                        Reportes.reportes['Analisis_Medico'] =
                            "${Reportes.eventualidadesOcurridas} ${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                        Reportes.reportes['Analisis_Terapia'] =
                            "${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                        Reportes.reportes['Recomendaciones_Generales'] =
                            Reportes.tratamientoPropuesto;
                      }),
                      inputFormat: MaskTextInputFormatter()),
                ]),
              ))
            : Expanded(
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
                        Reportes.reportes['Eventualidades'] = "$value.";
                        // ************ ******* *****************
                        Reportes.reportes['Analisis_Medico'] =
                            "${Reportes.eventualidadesOcurridas} ${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                        Reportes.reportes['Analisis_Terapia'] =
                            "${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
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
                        Reportes.reportes['Analisis_Terapia'] =
                            "${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                      }),
                      inputFormat: MaskTextInputFormatter()),
                  EditTextArea(
                      textController: analisisTextController,
                      labelEditText: "An??lisis m??dico",
                      keyBoardType: TextInputType.multiline,
                      numOfLines: 5,
                      withShowOption: true,
                      selection: true,
                      onSelected: () {
                        Operadores.openDialog(context: context, chyldrim: const Bibliografico(),
                        onAction: () {
                          setState(() {
                            analisisTextController.text = Reportes.analisisMedico;
                          });
                        });
                      },
                      onChange: ((value) {
                        Reportes.analisisMedico = "$value.";
                        Reportes.reportes['Analisis_Medico'] =
                            "${Reportes.eventualidadesOcurridas} ${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                        Reportes.reportes['Analisis_Terapia'] =
                            "${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                      }),
                      inputFormat: MaskTextInputFormatter()),
                  EditTextArea(
                      textController: tratamientoTextController,
                      labelEditText: "Terap??utica propuesta",
                      keyBoardType: TextInputType.multiline,
                      numOfLines: 5,
                      withShowOption: true,
                      onChange: ((value) {
                        Reportes.tratamientoPropuesto = "$value.";
                        Reportes.reportes['Analisis_Medico'] =
                            "${Reportes.eventualidadesOcurridas} ${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                        Reportes.reportes['Analisis_Terapia'] =
                            "${Reportes.terapiasPrevias} ${Reportes.analisisMedico} ${Reportes.tratamientoPropuesto}";
                      }),
                      inputFormat: MaskTextInputFormatter()),
                ]),
              ))
      ],
    );
  }
}

class DiagnosticosAndPronostico extends StatefulWidget {
  bool? isTerapia;

  DiagnosticosAndPronostico({this.isTerapia = false, super.key});

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
          widget.isTerapia == true
              ? Container()
              : Expanded(
                  child: EditTextArea(
                      textController: diagoTextController,
                      labelEditText: "Impresiones diagn??sticas",
                      keyBoardType: TextInputType.multiline,
                      numOfLines: 10,
                      onChange: ((value) {
                        Reportes.impresionesDiagnosticas = "$value.";
                        Reportes.reportes['Impresiones_Diagnosticas'] =
                            "$value.";
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
                        width: isMobile(context)
                            ? 60
                            : isTablet(context) || isTabletAndDesktop(context)
                                ? 140
                                : 200,
                        tittle: "Estado m??dico",
                        initialValue: estadoValue,
                        onChangeValue: (String? newValue) {
                          setState(() {
                            estadoValue = newValue!;
                          });
                        },
                        items: Pacientes.PronosticoEstado,
                      ),
                      Spinner(
                        width: isMobile(context)
                            ? 60
                            : isTablet(context) || isTabletAndDesktop(context)
                                ? 140
                                : 200,
                        tittle: "Para la funci??n",
                        initialValue: funcionValue,
                        onChangeValue: (String? newValue) {
                          setState(() {
                            funcionValue = newValue!;
                          });
                        },
                        items: Pacientes.PronosticoFuncion,
                      ),
                      Spinner(
                          width: isMobile(context)
                              ? 60
                              : isTablet(context) || isTabletAndDesktop(context)
                                  ? 150
                                  : 200,
                          tittle: "Para la vida",
                          initialValue: vidaValue,
                          onChangeValue: (String? newValue) {
                            setState(() {
                              vidaValue = newValue!;
                            });
                          },
                          items: Pacientes.PronosticoVida),
                      Spinner(
                        width: isMobile(context)
                            ? 60
                            : isTablet(context) || isTabletAndDesktop(context)
                                ? 150
                                : 200,
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
                          labelButton: "Aceptar pron??stico",
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
                            labelEditText: "Pron??stico m??dico",
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
                  labelEditText: "Licencias m??dicas",
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
                            tittle: 'Licencias M??dicas Otorgadas',
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
                            tittle: 'Pendientes en la Atenci??n',
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
                  labelEditText: "Citas m??dicas",
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
      decoration: ContainerDecoration.containerDecoration(),
      child: Column(
        children: [
          TittlePanel(
            color: Colores.backgroundPanel,
            textPanel: 'Indicaciones de la Hospitalizaci??n',
          ),
          const SizedBox(
            height: 10,
          ),
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
                    Operadores.openDialog(
                        context: context,
                        chyldrim: DialogSelector(
                          tittle: 'Medicamentos',
                          pathForFileSource: 'assets/diccionarios/Farmacos.txt',
                          typeOfDocument: 'txt',
                          onSelected: ((value) {
                            setState(() {
                              Reportes.medicamentosIndicados.add(value);
                              medicamentosTextController.text =
                                  "${medicamentosTextController.text}$value\n";
                            });
                          }),
                        ));
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
                  labelEditText: "Ox??genoterapia",
                  keyBoardType: TextInputType.multiline,
                  numOfLines: 5,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {},
                  onChange: ((value) {
                    Reportes.oxigenoterapia = traslate(value);
                    Reportes.reportes['Ox??genoterapia'] =
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
                            tittle: 'Pendientes en la Atenci??n',
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

// No suspender Metformina, s??lo el d??a de la cirug??a control con Insulina y durante el transquirurgico.
// Medidas universales de cuidados y prevenci??n de paciente quir??rgico
// Monitoreo y control de cifras tensionales mantener TAM>65.
// Mantener cifras de glicemia entre 100 y 185, en caso de hiperglicemia infusi??n de insulina durante el tranquir??rgico.
// Evitar AINES
// No sobrecargar, se sugiere uso de soluciones cristaloides balanceadas s??lo de ser necesario.
// Analgesia con opioides intermedios o fuertes.
// No ayuno mayor de 8hrs pre y postqx.
// Requiere env??o a MI posteriormente para tratamiento de DM2.
// Se sugire inicio de Metformina 850 mg cada 12hrs. Y realizar labs de control.
