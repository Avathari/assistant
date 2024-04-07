import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/metabolometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/renometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AuxiliaresExploracion extends StatefulWidget {
  bool? isPrequirurgico, isIngreso;

  AuxiliaresExploracion(
      {super.key, this.isPrequirurgico = false, this.isIngreso = false});

  @override
  State<AuxiliaresExploracion> createState() => _AuxiliaresExploracionState();
}

class _AuxiliaresExploracionState extends State<AuxiliaresExploracion> {
  var auxTextController = TextEditingController(),
      commenTextController = TextEditingController();
  var scrollAuxController = ScrollController(),
      scrollCommenController = ScrollController();
  late String? tipoEstudio;

  double mainAxisExtend = 50;

  @override
  void initState() {
    Auxiliares.registros();
    setState(() {
      if (widget.isPrequirurgico! == true) {
        Reportes.analisisComplementarios = Valorados.prequirurgicos;
      }
      //
      if (widget.isIngreso! == true) {
        Reportes.reportes['Analisis_Complementarios'] =
            Reportes.analisisComplementarios = Antropometrias.antropometricos();
        Reportes.reportes['Analisis_Complementarios'] =
            Reportes.analisisComplementarios + Metabolometrias.metabolometrias;
        Reportes.reportes['Analisis_Complementarios'] =
            Reportes.analisisComplementarios + Renometrias.renales();
        Reportes.reportes['Analisis_Complementarios'] =
            Reportes.analisisComplementarios + Renometrias.renales();
        //

        if (Reportes.auxiliaresDiagnosticos != "") {
          auxTextController.text =
              Reportes.reportes['Auxiliares_Diagnosticos'] =
                  Reportes.auxiliaresDiagnosticos;
        } else {
          Reportes.reportes['Auxiliares_Diagnosticos'] = Reportes
              .auxiliaresDiagnosticos = Auxiliares.historial(esAbreviado: true);
        }
      }
      // **************************************
      if (Reportes.reportes['Analisis_Complementarios'] != "" &&
          Reportes.reportes['Analisis_Complementarios'] != Null) {
        commenTextController.text = Reportes.analisisComplementarios =
            Reportes.reportes['Analisis_Complementarios'] ?? "";
      } else {
        commenTextController.text = Reportes.analisisComplementarios =
            Reportes.reportes['Analisis_Complementarios'] = "";
      }

      // ASIGNAR AUXILIARES GUARDADOS . . .
      if (Reportes.reportes['Auxiliares_Diagnosticos'] != "" &&
          Reportes.reportes['Auxiliares_Diagnosticos'] != Null) {
        auxTextController.text = Reportes.auxiliaresDiagnosticos =
            Reportes.reportes['Auxiliares_Diagnosticos'];
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: isDesktop(context) ? 5 : 3,
              child: EditTextArea(
                  textController: auxTextController,
                  labelEditText: "Auxiliares diagnósticos",
                  keyBoardType: TextInputType.multiline,
                  numOfLines: isTablet(context) ? 16 : 18,
                  onChange: ((value) {
                    setState(() {
                      Reportes.auxiliaresDiagnosticos =
                          Reportes.reportes['Auxiliares_Diagnosticos'] = value;
                    });
                  }),
                  inputFormat: MaskTextInputFormatter()),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: ContainerDecoration.roundedDecoration(),
                  child: isMobile(context) || isTablet(context)
                      ? Column(
                          children: [
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              alignment: WrapAlignment.center,
                              children: [
                                GrandIcon(
                                  iconData: Icons.attractions_outlined,
                                  labelButton: "Actualizados",
                                  onPress: () {
                                    Operadores.selectOptionsActivity(
                                      context: context,
                                      tittle:
                                          "Elija la fecha de los estudios . . . ",
                                      options: Listas.listWithoutRepitedValues(
                                        Listas.listFromMapWithOneKey(
                                          Pacientes.Paraclinicos!,
                                          keySearched: 'Fecha_Registro',
                                        ),
                                      ),
                                      onLongCloss: (value) {
                                        setState(() {
                                          auxTextController.text = Reportes
                                              .auxiliaresDiagnosticos = Reportes
                                                      .reportes[
                                                  'Auxiliares_Diagnosticos'] =
                                              value;
                                          Navigator.of(context).pop();
                                        });
                                      },
                                      onClose: (value) {
                                        setState(() {
                                          auxTextController.text = Reportes
                                              .auxiliaresDiagnosticos = Reportes
                                                      .reportes[
                                                  'Auxiliares_Diagnosticos'] =
                                              Auxiliares.porFecha(
                                                  fechaActual: value);
                                          //
                                          Navigator.of(context).pop();
                                        });
                                      },
                                    );
                                  },
                                ),
                                GrandIcon(
                                  iconData: Icons.clear_all,
                                  labelButton: "Historial",
                                  onPress: () {
                                    setState(() {
                                      auxTextController.text = Reportes
                                              .auxiliaresDiagnosticos =
                                          Reportes.reportes[
                                                  'Auxiliares_Diagnosticos'] =
                                              Auxiliares.historial();
                                    });
                                  },
                                  onLongPress: () {
                                    setState(() {
                                      auxTextController.text = Reportes
                                              .auxiliaresDiagnosticos =
                                          Reportes.reportes[
                                                  'Auxiliares_Diagnosticos'] =
                                              Auxiliares.historial(
                                                  esAbreviado: true);
                                    });
                                  },
                                ),
                                GrandIcon(
                                  iconData: Icons.clear_all,
                                  labelButton: "Ultimos Recabados . . . ",
                                  onPress: () {
                                    setState(() {
                                      auxTextController.text = Reportes
                                              .auxiliaresDiagnosticos =
                                          Reportes.reportes[
                                                  'Auxiliares_Diagnosticos'] =
                                              Auxiliares.getUltimo(
                                                  esAbreviado: true);
                                    });
                                  },
                                ),
                                CircleIcon(
                                    radios: 22,
                                    difRadios: 6,
                                    onChangeValue: () => auxTextController
                                        .text = Reportes
                                            .auxiliaresDiagnosticos =
                                        Reportes.reportes[
                                            'Auxiliares_Diagnosticos'] = ""),
                              ],
                            ),
                            CrossLine(
                              height: 7,
                            ),
                            Expanded(
                              flex: 5,
                              child: Wrap(
                                spacing: 5.0,
                                runSpacing: 5.0,
                                children: [
                                  GrandIcon(
                                    iconData: Icons.monitor_heart_outlined,
                                    labelButton: "Electrocardiograma",
                                    onPress: () {
                                      asignarParaclinico(indice: 20);
                                    },
                                  ),
                                  GrandIcon(
                                    iconData: Icons.bloodtype,
                                    labelButton: "Biometría hemática",
                                    onPress: () {
                                      int index = 0;
                                      Operadores.selectOptionsActivity(
                                        context: context,
                                        tittle:
                                            "Elija la fecha de la biometría hemática . . . ",
                                        options:
                                            Listas.listWithoutRepitedValues(
                                          Listas.listFromMapWithOneKey(
                                            Listas.listFromMap(
                                                lista: Pacientes.Paraclinicos!,
                                                keySearched: 'Tipo_Estudio',
                                                elementSearched: Auxiliares
                                                    .Categorias[index]),
                                          ),
                                        ),
                                        onClose: (value) {
                                          setState(() {
                                            asignarParaclinico(
                                                indice: index,
                                                fechaActual: value);
                                            Navigator.of(context).pop();
                                          });
                                        },
                                      );
                                    },
                                  ),
                                  GrandIcon(
                                    iconData: Icons.room_preferences_outlined,
                                    labelButton: "Química sanguínea",
                                    onPress: () {
                                      int index = 1;
                                      Operadores.selectOptionsActivity(
                                        context: context,
                                        tittle:
                                            "Elija la fecha de la química sanguínnea . . . ",
                                        options:
                                            Listas.listWithoutRepitedValues(
                                          Listas.listFromMapWithOneKey(
                                            Listas.listFromMap(
                                                lista: Pacientes.Paraclinicos!,
                                                keySearched: 'Tipo_Estudio',
                                                elementSearched: Auxiliares
                                                    .Categorias[index]),
                                          ),
                                        ),
                                        onClose: (value) {
                                          setState(() {
                                            asignarParaclinico(
                                                indice: index,
                                                fechaActual: value);
                                            Navigator.of(context).pop();
                                          });
                                        },
                                      );
                                    },
                                  ),
                                  GrandIcon(
                                    iconData: Icons.electric_bolt,
                                    labelButton: "Electrolitos séricos",
                                    onPress: () {
                                      int index = 2;
                                      Operadores.selectOptionsActivity(
                                        context: context,
                                        tittle:
                                            "Elija la fecha del estudio de electrolitos. . . ",
                                        options:
                                            Listas.listWithoutRepitedValues(
                                          Listas.listFromMapWithOneKey(
                                            Listas.listFromMap(
                                                lista: Pacientes.Paraclinicos!,
                                                keySearched: 'Tipo_Estudio',
                                                elementSearched: Auxiliares
                                                    .Categorias[index]),
                                          ),
                                        ),
                                        onClose: (value) {
                                          setState(() {
                                            asignarParaclinico(
                                                indice: index,
                                                fechaActual: value);
                                            Navigator.of(context).pop();
                                          });
                                        },
                                      );
                                    },
                                  ),
                                  GrandIcon(
                                    iconData: Icons.hdr_weak_sharp,
                                    labelButton: "Perfil hepático",
                                    onPress: () {
                                      int index = 3;
                                      Operadores.selectOptionsActivity(
                                        context: context,
                                        tittle:
                                            "Elija la fecha del perfil hepático . . . ",
                                        options:
                                            Listas.listWithoutRepitedValues(
                                          Listas.listFromMapWithOneKey(
                                            Listas.listFromMap(
                                                lista: Pacientes.Paraclinicos!,
                                                keySearched: 'Tipo_Estudio',
                                                elementSearched: Auxiliares
                                                    .Categorias[index]),
                                          ),
                                        ),
                                        onClose: (value) {
                                          setState(() {
                                            asignarParaclinico(
                                                indice: index,
                                                fechaActual: value);
                                            Navigator.of(context).pop();
                                          });
                                        },
                                      );
                                    },
                                  ),
                                  GrandIcon(
                                    iconData: Icons.wifi_tethering_error,
                                    labelButton: "Perfil lipídico",
                                    onPress: () {
                                      int index = 4;
                                      Operadores.selectOptionsActivity(
                                        context: context,
                                        tittle:
                                            "Elija la fecha del perfil lipíco . . . ",
                                        options:
                                            Listas.listWithoutRepitedValues(
                                          Listas.listFromMapWithOneKey(
                                            Listas.listFromMap(
                                                lista: Pacientes.Paraclinicos!,
                                                keySearched: 'Tipo_Estudio',
                                                elementSearched: Auxiliares
                                                    .Categorias[index]),
                                          ),
                                        ),
                                        onClose: (value) {
                                          setState(() {
                                            asignarParaclinico(
                                                indice: index,
                                                fechaActual: value);
                                            Navigator.of(context).pop();
                                          });
                                        },
                                      );
                                    },
                                  ),
                                  GrandIcon(
                                    iconData: Icons.nest_cam_wired_stand,
                                    labelButton: "Perfil tiroideo",
                                    onPress: () {
                                      int index = 5;
                                      Operadores.selectOptionsActivity(
                                        context: context,
                                        tittle:
                                            "Elija la fecha del perfil tiroideo . . . ",
                                        options:
                                            Listas.listWithoutRepitedValues(
                                          Listas.listFromMapWithOneKey(
                                            Listas.listFromMap(
                                                lista: Pacientes.Paraclinicos!,
                                                keySearched: 'Tipo_Estudio',
                                                elementSearched: Auxiliares
                                                    .Categorias[index]),
                                          ),
                                        ),
                                        onClose: (value) {
                                          setState(() {
                                            asignarParaclinico(
                                                indice: index,
                                                fechaActual: value);
                                            Navigator.of(context).pop();
                                          });
                                        },
                                      );
                                    },
                                  ),
                                  GrandIcon(
                                    iconData: Icons.title,
                                    labelButton: "Tiempos de coagulación",
                                    onPress: () {
                                      int index = 6;
                                      Operadores.selectOptionsActivity(
                                        context: context,
                                        tittle:
                                            "Elija la fecha del perfil de coagulación . . . ",
                                        options:
                                            Listas.listWithoutRepitedValues(
                                          Listas.listFromMapWithOneKey(
                                            Listas.listFromMap(
                                                lista: Pacientes.Paraclinicos!,
                                                keySearched: 'Tipo_Estudio',
                                                elementSearched: Auxiliares
                                                    .Categorias[index]),
                                          ),
                                        ),
                                        onClose: (value) {
                                          setState(() {
                                            asignarParaclinico(
                                                indice: index,
                                                fechaActual: value);
                                            Navigator.of(context).pop();
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : isDesktop(context) || isLargeDesktop(context)
                          ? Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: GrandIcon(
                                        iconData: Icons.attractions_outlined,
                                        labelButton: "Actualizados",
                                        onPress: () {
                                          Operadores.selectOptionsActivity(
                                            context: context,
                                            tittle:
                                                "Elija la fecha de los estudios . . . ",
                                            options:
                                                Listas.listWithoutRepitedValues(
                                              Listas.listFromMapWithOneKey(
                                                Pacientes.Paraclinicos!,
                                                keySearched: 'Fecha_Registro',
                                              ),
                                            ),
                                            onLongCloss: (value) {
                                              setState(() {
                                                auxTextController.text =
                                                    Auxiliares.porFecha(
                                                        fechaActual: value,
                                                        esAbreviado: true);
                                                Reportes.reportes[
                                                        'Auxiliares_Diagnosticos'] =
                                                    value;
                                                Navigator.of(context).pop();
                                              });
                                            },
                                            onClose: (value) {
                                              setState(() {
                                                auxTextController.text =
                                                    Auxiliares.porFecha(
                                                        fechaActual: value);
                                                Reportes.reportes[
                                                        'Auxiliares_Diagnosticos'] =
                                                    value;
                                                Navigator.of(context).pop();
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: GrandIcon(
                                        iconData: Icons.clear_all,
                                        labelButton: "Historial",
                                        onPress: () {
                                          setState(() {
                                            auxTextController.text = Reportes
                                                .auxiliaresDiagnosticos = Reportes
                                                        .reportes[
                                                    'Auxiliares_Diagnosticos'] =
                                                Auxiliares.historial();
                                          });
                                        },
                                        onLongPress: () {
                                          setState(() {
                                            auxTextController.text = Reportes
                                                .auxiliaresDiagnosticos = Reportes
                                                        .reportes[
                                                    'Auxiliares_Diagnosticos'] =
                                                Auxiliares.historial(
                                                    esAbreviado: true);
                                          });
                                        },
                                      ),
                                    ),
                                    CrossLine(
                                        isHorizontal: false,
                                        thickness: 4,
                                        color: Colors.grey),
                                    Expanded(
                                      flex: 3,
                                      child: GrandIcon(
                                        iconData: Icons.cleaning_services,
                                        labelButton: "Historial",
                                        onPress: () {
                                          setState(() {
                                            auxTextController.text = Reportes
                                                .auxiliaresDiagnosticos = Reportes
                                                    .reportes[
                                                'Auxiliares_Diagnosticos'] = "";
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                CrossLine(height: 7),
                                Expanded(
                                  flex: 5,
                                  child: GridView(
                                    controller: scrollAuxController,
                                    gridDelegate: GridViewTools.gridDelegate(
                                        mainAxisExtent: mainAxisExtend),
                                    children: [
                                      GrandIcon(
                                        iconData: Icons.monitor_heart_outlined,
                                        labelButton: "Electrocardiograma",
                                        onPress: () {
                                          asignarParaclinico(indice: 20);
                                        },
                                      ),
                                      GrandIcon(
                                        iconData: Icons.bloodtype,
                                        labelButton: "Biometría hemática",
                                        onPress: () {
                                          int index = 0;
                                          Operadores.selectOptionsActivity(
                                            context: context,
                                            tittle:
                                                "Elija la fecha de la biometría hemática . . . ",
                                            options:
                                                Listas.listWithoutRepitedValues(
                                              Listas.listFromMapWithOneKey(
                                                Listas.listFromMap(
                                                    lista:
                                                        Pacientes.Paraclinicos!,
                                                    keySearched: 'Tipo_Estudio',
                                                    elementSearched: Auxiliares
                                                        .Categorias[index]),
                                              ),
                                            ),
                                            onClose: (value) {
                                              setState(() {
                                                asignarParaclinico(
                                                    indice: index,
                                                    fechaActual: value);
                                                Navigator.of(context).pop();
                                              });
                                            },
                                          );
                                        },
                                      ),
                                      GrandIcon(
                                        iconData:
                                            Icons.room_preferences_outlined,
                                        labelButton: "Química sanguínea",
                                        onPress: () {
                                          int index = 1;
                                          Operadores.selectOptionsActivity(
                                            context: context,
                                            tittle:
                                                "Elija la fecha de la química sanguínnea . . . ",
                                            options:
                                                Listas.listWithoutRepitedValues(
                                              Listas.listFromMapWithOneKey(
                                                Listas.listFromMap(
                                                    lista:
                                                        Pacientes.Paraclinicos!,
                                                    keySearched: 'Tipo_Estudio',
                                                    elementSearched: Auxiliares
                                                        .Categorias[index]),
                                              ),
                                            ),
                                            onClose: (value) {
                                              setState(() {
                                                asignarParaclinico(
                                                    indice: index,
                                                    fechaActual: value);
                                                Navigator.of(context).pop();
                                              });
                                            },
                                          );
                                        },
                                      ),
                                      GrandIcon(
                                        iconData: Icons.electric_bolt,
                                        labelButton: "Electrolitos séricos",
                                        onPress: () {
                                          int index = 2;
                                          Operadores.selectOptionsActivity(
                                            context: context,
                                            tittle:
                                                "Elija la fecha del estudio de electrolitos. . . ",
                                            options:
                                                Listas.listWithoutRepitedValues(
                                              Listas.listFromMapWithOneKey(
                                                Listas.listFromMap(
                                                    lista:
                                                        Pacientes.Paraclinicos!,
                                                    keySearched: 'Tipo_Estudio',
                                                    elementSearched: Auxiliares
                                                        .Categorias[index]),
                                              ),
                                            ),
                                            onClose: (value) {
                                              setState(() {
                                                asignarParaclinico(
                                                    indice: index,
                                                    fechaActual: value);
                                                Navigator.of(context).pop();
                                              });
                                            },
                                          );
                                        },
                                      ),
                                      GrandIcon(
                                        iconData: Icons.hdr_weak_sharp,
                                        labelButton: "Perfil hepático",
                                        onPress: () {
                                          int index = 3;
                                          Operadores.selectOptionsActivity(
                                            context: context,
                                            tittle:
                                                "Elija la fecha del perfil hepático . . . ",
                                            options:
                                                Listas.listWithoutRepitedValues(
                                              Listas.listFromMapWithOneKey(
                                                Listas.listFromMap(
                                                    lista:
                                                        Pacientes.Paraclinicos!,
                                                    keySearched: 'Tipo_Estudio',
                                                    elementSearched: Auxiliares
                                                        .Categorias[index]),
                                              ),
                                            ),
                                            onClose: (value) {
                                              setState(() {
                                                asignarParaclinico(
                                                    indice: index,
                                                    fechaActual: value);
                                                Navigator.of(context).pop();
                                              });
                                            },
                                          );
                                        },
                                      ),
                                      GrandIcon(
                                        iconData: Icons.wifi_tethering_error,
                                        labelButton: "Perfil lipídico",
                                        onPress: () {
                                          int index = 4;
                                          Operadores.selectOptionsActivity(
                                            context: context,
                                            tittle:
                                                "Elija la fecha del perfil lipíco . . . ",
                                            options:
                                                Listas.listWithoutRepitedValues(
                                              Listas.listFromMapWithOneKey(
                                                Listas.listFromMap(
                                                    lista:
                                                        Pacientes.Paraclinicos!,
                                                    keySearched: 'Tipo_Estudio',
                                                    elementSearched: Auxiliares
                                                        .Categorias[index]),
                                              ),
                                            ),
                                            onClose: (value) {
                                              setState(() {
                                                asignarParaclinico(
                                                    indice: index,
                                                    fechaActual: value);
                                                Navigator.of(context).pop();
                                              });
                                            },
                                          );
                                        },
                                      ),
                                      GrandIcon(
                                        iconData: Icons.nest_cam_wired_stand,
                                        labelButton: "Perfil tiroideo",
                                        onPress: () {
                                          int index = 5;
                                          Operadores.selectOptionsActivity(
                                            context: context,
                                            tittle:
                                                "Elija la fecha del perfil tiroideo . . . ",
                                            options:
                                                Listas.listWithoutRepitedValues(
                                              Listas.listFromMapWithOneKey(
                                                Listas.listFromMap(
                                                    lista:
                                                        Pacientes.Paraclinicos!,
                                                    keySearched: 'Tipo_Estudio',
                                                    elementSearched: Auxiliares
                                                        .Categorias[index]),
                                              ),
                                            ),
                                            onClose: (value) {
                                              setState(() {
                                                asignarParaclinico(
                                                    indice: index,
                                                    fechaActual: value);
                                                Navigator.of(context).pop();
                                              });
                                            },
                                          );
                                        },
                                      ),
                                      GrandIcon(
                                        iconData: Icons.title,
                                        labelButton: "Tiempos de coagulación",
                                        onPress: () {
                                          int index = 6;
                                          Operadores.selectOptionsActivity(
                                            context: context,
                                            tittle:
                                                "Elija la fecha del perfil de coagulación . . . ",
                                            options:
                                                Listas.listWithoutRepitedValues(
                                              Listas.listFromMapWithOneKey(
                                                Listas.listFromMap(
                                                    lista:
                                                        Pacientes.Paraclinicos!,
                                                    keySearched: 'Tipo_Estudio',
                                                    elementSearched: Auxiliares
                                                        .Categorias[index]),
                                              ),
                                            ),
                                            onClose: (value) {
                                              setState(() {
                                                asignarParaclinico(
                                                    indice: index,
                                                    fechaActual: value);
                                                Navigator.of(context).pop();
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: GrandIcon(
                                        iconData: Icons.attractions_outlined,
                                        labelButton: "Actualizados",
                                        onPress: () {
                                          Operadores.selectOptionsActivity(
                                            context: context,
                                            tittle:
                                                "Elija la fecha de los estudios . . . ",
                                            options:
                                                Listas.listWithoutRepitedValues(
                                              Listas.listFromMapWithOneKey(
                                                Pacientes.Paraclinicos!,
                                                keySearched: 'Fecha_Registro',
                                              ),
                                            ),
                                            onClose: (value) {
                                              setState(() {
                                                auxTextController.text =
                                                    Auxiliares.porFecha(
                                                        fechaActual: value);
                                                Reportes.reportes[
                                                        'Auxiliares_Diagnosticos'] =
                                                    value;
                                                Navigator.of(context).pop();
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: GrandIcon(
                                        iconData: Icons.clear_all,
                                        labelButton: "Historial",
                                        onPress: () {
                                          setState(() {
                                            auxTextController.text =
                                                Auxiliares.historial();
                                            Reportes.reportes[
                                                    'Auxiliares_Diagnosticos'] =
                                                Auxiliares.historial();
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: GrandIcon(
                                        iconData: Icons.clear_all,
                                        labelButton: "Historial Abreviado",
                                        onPress: () {
                                          setState(() {
                                            auxTextController.text =
                                                Auxiliares.historial(
                                                    esAbreviado: true);
                                            Reportes.reportes[
                                                    'Auxiliares_Diagnosticos'] =
                                                Auxiliares.historial(
                                                    esAbreviado: true);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                CrossLine(),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration:
                                        ContainerDecoration.roundedDecoration(),
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
                                              int index = 0;
                                              Operadores.selectOptionsActivity(
                                                context: context,
                                                tittle:
                                                    "Elija la fecha de la biometría hemática . . . ",
                                                options: Listas
                                                    .listWithoutRepitedValues(
                                                  Listas.listFromMapWithOneKey(
                                                    Listas.listFromMap(
                                                        lista: Pacientes
                                                            .Paraclinicos!,
                                                        keySearched:
                                                            'Tipo_Estudio',
                                                        elementSearched:
                                                            Auxiliares
                                                                    .Categorias[
                                                                index]),
                                                  ),
                                                ),
                                                onClose: (value) {
                                                  setState(() {
                                                    asignarParaclinico(
                                                        indice: index,
                                                        fechaActual: value);
                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                              );
                                            },
                                          ),
                                          GrandButton(
                                            labelButton: "Química sanguínea",
                                            onPress: () {
                                              int index = 1;
                                              Operadores.selectOptionsActivity(
                                                context: context,
                                                tittle:
                                                    "Elija la fecha de la química sanguínnea . . . ",
                                                options: Listas
                                                    .listWithoutRepitedValues(
                                                  Listas.listFromMapWithOneKey(
                                                    Listas.listFromMap(
                                                        lista: Pacientes
                                                            .Paraclinicos!,
                                                        keySearched:
                                                            'Tipo_Estudio',
                                                        elementSearched:
                                                            Auxiliares
                                                                    .Categorias[
                                                                index]),
                                                  ),
                                                ),
                                                onClose: (value) {
                                                  setState(() {
                                                    asignarParaclinico(
                                                        indice: index,
                                                        fechaActual: value);
                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                              );
                                            },
                                          ),
                                          GrandButton(
                                            labelButton: "Electrolitos séricos",
                                            onPress: () {
                                              int index = 2;
                                              Operadores.selectOptionsActivity(
                                                context: context,
                                                tittle:
                                                    "Elija la fecha del estudio de electrolitos. . . ",
                                                options: Listas
                                                    .listWithoutRepitedValues(
                                                  Listas.listFromMapWithOneKey(
                                                    Listas.listFromMap(
                                                        lista: Pacientes
                                                            .Paraclinicos!,
                                                        keySearched:
                                                            'Tipo_Estudio',
                                                        elementSearched:
                                                            Auxiliares
                                                                    .Categorias[
                                                                index]),
                                                  ),
                                                ),
                                                onClose: (value) {
                                                  setState(() {
                                                    asignarParaclinico(
                                                        indice: index,
                                                        fechaActual: value);
                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                              );
                                            },
                                          ),
                                          GrandButton(
                                            labelButton: "Perfil hepático",
                                            onPress: () {
                                              int index = 3;
                                              Operadores.selectOptionsActivity(
                                                context: context,
                                                tittle:
                                                    "Elija la fecha del perfil hepático . . . ",
                                                options: Listas
                                                    .listWithoutRepitedValues(
                                                  Listas.listFromMapWithOneKey(
                                                    Listas.listFromMap(
                                                        lista: Pacientes
                                                            .Paraclinicos!,
                                                        keySearched:
                                                            'Tipo_Estudio',
                                                        elementSearched:
                                                            Auxiliares
                                                                    .Categorias[
                                                                index]),
                                                  ),
                                                ),
                                                onClose: (value) {
                                                  setState(() {
                                                    asignarParaclinico(
                                                        indice: index,
                                                        fechaActual: value);
                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                              );
                                            },
                                          ),
                                          GrandButton(
                                            labelButton: "Perfil lipídico",
                                            onPress: () {
                                              int index = 4;
                                              Operadores.selectOptionsActivity(
                                                context: context,
                                                tittle:
                                                    "Elija la fecha del perfil lipíco . . . ",
                                                options: Listas
                                                    .listWithoutRepitedValues(
                                                  Listas.listFromMapWithOneKey(
                                                    Listas.listFromMap(
                                                        lista: Pacientes
                                                            .Paraclinicos!,
                                                        keySearched:
                                                            'Tipo_Estudio',
                                                        elementSearched:
                                                            Auxiliares
                                                                    .Categorias[
                                                                index]),
                                                  ),
                                                ),
                                                onClose: (value) {
                                                  setState(() {
                                                    asignarParaclinico(
                                                        indice: index,
                                                        fechaActual: value);
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
                                                options: Listas
                                                    .listWithoutRepitedValues(
                                                  Listas.listFromMapWithOneKey(
                                                    Listas.listFromMap(
                                                        lista: Pacientes
                                                            .Paraclinicos!,
                                                        keySearched:
                                                            'Tipo_Estudio',
                                                        elementSearched:
                                                            Auxiliares
                                                                    .Categorias[
                                                                index]),
                                                  ),
                                                ),
                                                onClose: (value) {
                                                  setState(() {
                                                    asignarParaclinico(
                                                        indice: index,
                                                        fechaActual: value);
                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                              );
                                            },
                                          ),
                                          GrandButton(
                                            labelButton:
                                                "Tiempos de coagulación",
                                            onPress: () {
                                              int index = 6;
                                              Operadores.selectOptionsActivity(
                                                context: context,
                                                tittle:
                                                    "Elija la fecha del perfil de coagulación . . . ",
                                                options: Listas
                                                    .listWithoutRepitedValues(
                                                  Listas.listFromMapWithOneKey(
                                                    Listas.listFromMap(
                                                        lista: Pacientes
                                                            .Paraclinicos!,
                                                        keySearched:
                                                            'Tipo_Estudio',
                                                        elementSearched:
                                                            Auxiliares
                                                                    .Categorias[
                                                                index]),
                                                  ),
                                                ),
                                                onClose: (value) {
                                                  setState(() {
                                                    asignarParaclinico(
                                                        indice: index,
                                                        fechaActual: value);
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
                                ),
                              ],
                            )),
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
              flex: isDesktop(context) ? 5 : 3,
              child: EditTextArea(
                  textController: commenTextController,
                  labelEditText: "Análisis complementarios",
                  keyBoardType: TextInputType.multiline,
                  numOfLines: isTablet(context) ? 16 : 16,
                  onChange: ((value) {
                    setState(() {
                      Reportes.analisisComplementarios = Reportes
                          .reportes['Analisis_Complementarios'] = value ?? "";
                    });
                  }),
                  inputFormat: MaskTextInputFormatter()),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: ContainerDecoration.roundedDecoration(),
                child: Column(
                  children: [
                    Expanded(
                      flex:
                          isDesktop(context) || isLargeDesktop(context) ? 1 : 3,
                      child: GrandIcon(
                          iconData: Icons.cleaning_services,
                          labelButton: 'Limpiar . . . ',
                          onPress: () {
                            setState(() {
                              commenTextController.text = '';
                              Reportes.reportes['Analisis_Complementarios'] =
                                  "";
                            });
                          }),
                    ),
                    CrossLine(color: Colors.grey),
                    Expanded(
                        flex: 6,
                        child: isMobile(context)
                            ? Wrap(
                                children: [
                                  GrandIcon(
                                    iconData: Icons.horizontal_rule_sharp,
                                    labelButton: "Antropométricos",
                                    onPress: () {
                                      asignarAuxAnalisis(indice: 1);
                                    },
                                  ),
                                  GrandIcon(
                                    iconData: Icons.bubble_chart,
                                    labelButton: "Metabólicos",
                                    onPress: () {
                                      asignarAuxAnalisis(indice: 2);
                                    },
                                  ),
                                  GrandIcon(
                                    iconData: Icons.monitor_heart_outlined,
                                    labelButton: "Cardiovasculares",
                                    onPress: () {
                                      asignarAuxAnalisis(indice: 3);
                                    },
                                  ),
                                  GrandIcon(
                                    iconData: Icons.water_drop,
                                    labelButton: "Hídricos",
                                    onPress: () {
                                      asignarAuxAnalisis(indice: 4);
                                    },
                                  ),
                                  GrandIcon(
                                    iconData: Icons.living_sharp,
                                    labelButton: "Hepáticos",
                                    onPress: () {
                                      asignarAuxAnalisis(indice: 5);
                                    },
                                  ),
                                  GrandIcon(
                                    iconData: Icons.bloodtype,
                                    labelButton: "Hemáticos",
                                    onPress: () {
                                      asignarAuxAnalisis(indice: 6);
                                    },
                                  ),
                                  GrandIcon(
                                    iconData: Icons.water,
                                    labelButton: "Renales",
                                    onPress: () {
                                      asignarAuxAnalisis(indice: 7);
                                    },
                                  ),
                                ],
                              )
                            : isDesktop(context) || isLargeDesktop(context)
                                ? GridView(
                                    gridDelegate: GridViewTools.gridDelegate(
                                        mainAxisExtent: mainAxisExtend),
                                    children: [
                                      GrandIcon(
                                        iconData: Icons.horizontal_rule_sharp,
                                        labelButton: "Antropométricos",
                                        onPress: () {
                                          asignarAuxAnalisis(indice: 1);
                                        },
                                      ),
                                      GrandIcon(
                                        iconData: Icons.bubble_chart,
                                        labelButton: "Metabólicos",
                                        onPress: () {
                                          asignarAuxAnalisis(indice: 2);
                                        },
                                      ),
                                      GrandIcon(
                                        iconData: Icons.monitor_heart_outlined,
                                        labelButton: "Cardiovasculares",
                                        onPress: () {
                                          asignarAuxAnalisis(indice: 3);
                                        },
                                      ),
                                      GrandIcon(
                                        iconData: Icons.water_drop,
                                        labelButton: "Hídricos",
                                        onPress: () {
                                          asignarAuxAnalisis(indice: 4);
                                        },
                                      ),
                                      GrandIcon(
                                        iconData: Icons.living_sharp,
                                        labelButton: "Hepáticos",
                                        onPress: () {
                                          asignarAuxAnalisis(indice: 5);
                                        },
                                      ),
                                      GrandIcon(
                                        iconData: Icons.bloodtype,
                                        labelButton: "Hemáticos",
                                        onPress: () {
                                          asignarAuxAnalisis(indice: 6);
                                        },
                                      ),
                                      GrandIcon(
                                        iconData: Icons.water,
                                        labelButton: "Renales",
                                        onPress: () {
                                          asignarAuxAnalisis(indice: 7);
                                        },
                                      ),
                                    ],
                                  )
                                : SingleChildScrollView(
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
                                  )),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
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

// ***********************************************************************

// No suspender Metformina, sólo el día de la cirugía control con Insulina y durante el transquirurgico.
// Medidas universales de cuidados y prevención de paciente quirúrgico
// Monitoreo y control de cifras tensionales mantener TAM>65.
// Mantener cifras de glicemia entre 100 y 185, en caso de hiperglicemia infusión de insulina durante el tranquirúrgico.
// Evitar AINES
// No sobrecargar, se sugiere uso de soluciones cristaloides balanceadas sólo de ser necesario.
// Analgesia con opioides intermedios o fuertes.
// No ayuno mayor de 8hrs pre y postqx.
// Requiere envío a MI posteriormente para tratamiento de DM2.
// Se sugire inicio de Metformina 850 mg cada 12hrs. Y realizar labs de control.
