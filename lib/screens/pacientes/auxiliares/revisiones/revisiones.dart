import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/hepatometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/hospitalarios/globulares.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/antropometricos.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/balancesHidrico.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/cardiovasculares.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/gasometricos.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/hidricos.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/metabolometrias.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/ventilatorios.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/RoundedPanel.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';

class Revisiones extends StatefulWidget {
  var actualView = 0;

  bool? withTitle;

  Revisiones({Key? key, this.withTitle = true}) : super(key: key);

  @override
  State<Revisiones> createState() => _RevisionesState();
}

class _RevisionesState extends State<Revisiones> {
  String fileAssocieted = Pacientes.localPath;

  @override
  void initState() {
    Terminal.printWarning(
        message:
            " . . . Iniciando Actividad - Repositorio Paraclinicos del Pacientes");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        Valores.fromJson(value[0]);
        Terminal.printSuccess(
            message: 'Repositorio de Valores obtenido . . . '); // ${value[0]}
      });
    }).onError((error, stackTrace) {
      Terminal.printAlert(
          message: " . . . Actividad no iniciada : $error \n: : $stackTrace");
    }).whenComplete(() {
      setState(() {
        Auxiliares.registros();
        Terminal.printOther(message: " . . . Actividad Iniciada");
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isMobile(context) ? mobileView() : tabletView();
  }

  mobileView() {
    return RoundedPanel(
      child: TittleContainer(
        centered: true,
        tittle: 'Revisión General',
        child: Column(
          children: [
            Expanded(
              flex: 22,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GridView(
                      padding: const EdgeInsets.all(5.0),
                      controller: ScrollController(),
                      gridDelegate: GridViewTools.gridDelegate(
                          crossAxisCount: 1,
                          mainAxisSpacing: 2.0,
                          crossAxisSpacing: 2.0,
                          mainAxisExtent: 60), //46
                      children: [
                        ValuePanel(
                          firstText: "T. Sys",
                          secondText:
                              Valores.tensionArterialSystolica.toString(),
                          thirdText: "mmHg",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Tensión sistólica? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    Valores.tensionArterialSystolica =
                                        int.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        ValuePanel(
                          firstText: "T. Dyas",
                          secondText:
                              Valores.tensionArterialDyastolica.toString(),
                          thirdText: "mmHg",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Tensión diastólica? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    Valores.tensionArterialDyastolica =
                                        int.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        ValuePanel(
                          firstText: "F. Card.",
                          secondText: Valores.frecuenciaCardiaca.toString(),
                          thirdText: "Lat/min",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Frecuencia cardiaca? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    Valores.frecuenciaCardiaca =
                                        int.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        ValuePanel(
                          firstText: "F. Resp.",
                          secondText: Valores.frecuenciaRespiratoria.toString(),
                          thirdText: "Resp/min",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Frecuencia respiratoria? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    Valores.frecuenciaRespiratoria =
                                        int.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        ValuePanel(
                          firstText: "T. C.",
                          secondText: Valores.temperaturCorporal.toString(),
                          thirdText: "°C",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Temperatura corporal? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    Valores.temperaturCorporal =
                                        double.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        ValuePanel(
                          firstText: "SpO2",
                          secondText:
                              Valores.saturacionPerifericaOxigeno.toString(),
                          thirdText: "Resp/min",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message:
                                    "¿Saturación periférica de oxígeno? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    Valores.saturacionPerifericaOxigeno =
                                        int.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        ValuePanel(
                          firstText: "P. Corporal",
                          secondText: Valores.pesoCorporalTotal.toString(),
                          thirdText: "Kg",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Peso corporal total? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    Valores.pesoCorporalTotal =
                                        double.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        ValuePanel(
                          firstText: "Estatura",
                          secondText: Valores.alturaPaciente.toString(),
                          thirdText: "mts",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Altura del paciente? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    Valores.alturaPaciente =
                                        double.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        ValuePanel(
                          firstText: "G. Cap.",
                          secondText: Valores.glucemiaCapilar.toString(),
                          thirdText: "mg/dL",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Glucemia capilar? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    Valores.glucemiaCapilar = int.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        CrossLine(),
                        CrossLine(),
                        ValuePanel(
                          firstText: "Horas ayuno",
                          secondText: Valores.horasAyuno.toString(),
                          thirdText: "Horas",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Horas de ayuno? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    Valores.horasAyuno = int.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 8,
                            child: Container(
                              margin: const EdgeInsets.only(
                                  bottom: 12.0, top: 12.0),
                              decoration:
                                  ContainerDecoration.roundedDecoration(),
                              child: widget.actualView == 0
                                  ? Container()
                                  : widget.actualView == 1
                                      ? biometrias()
                                      : widget.actualView == 2
                                          ? quimicas()
                                          : widget.actualView == 3
                                              ? electrolitos()
                                              : widget.actualView == 4
                                                  ? arteriales()
                                                  : widget.actualView == 5
                                                      ? venosos()
                                                      : widget.actualView == 6
                                                          ? hepaticos()
                                                          : widget.actualView ==
                                                                  7
                                                              ? electrolitos()
                                                              : widget.actualView ==
                                                                      8
                                                                  ? electrolitos()
                                                                  : widget.actualView ==
                                                                          9
                                                                      ? balances()
                                                                      : widget.actualView ==
                                                                              10
                                                                          ? ventilaciones()
                                                                          : widget.actualView == 11
                                                                              ? const Hidricos()
                                                                              : widget.actualView == 12
                                                                                  ? const Metabolicos()
                                                                                  : widget.actualView == 13
                                                                                      ? const Antropometricos()
                                                                                      : widget.actualView == 14
                                                                                          ? const Cardiovasculares()
                                                                                          : widget.actualView == 15
                                                                                              ? const Ventilatorios()
                                                                                              : widget.actualView == 16
                                                                                                  ? const Gasometricos()
                                                                                                  : widget.actualView == 17
                                                                                                      ? const Hidricos()
                                                                                                      : widget.actualView == 18
                                                                                                          ? const Hidricos()
                                                                                                          : widget.actualView == 19
                                                                                                              ? const Hidricos()
                                                                                                              : widget.actualView == 20
                                                                                                                  ? const Hidricos()
                                                                                                                  : widget.actualView == 21
                                                                                                                      ? const Hemoderivados()
                                                                                                                      : Container(),
                            )),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 1.0, left: 3.0, right: 3.0, bottom: 1.0),
                            padding: const EdgeInsets.all(2.0),
                            decoration: ContainerDecoration.roundedDecoration(),
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(5.0),
                              controller: ScrollController(),
                              child: Column(
                                children: [
                                  GrandButton(
                                    fontSize: 8,
                                    weigth: 2000,
                                    labelButton: 'Biometría Hemática',
                                    onPress: () {
                                      setState(() {
                                        widget.actualView = 1;
                                      });
                                    },
                                  ),
                                  GrandButton(
                                    fontSize: 8,
                                    weigth: 2000,
                                    labelButton: 'Química Sanguínea',
                                    onPress: () {
                                      setState(() {
                                        widget.actualView = 2;
                                      });
                                    },
                                  ),
                                  GrandButton(
                                    fontSize: 8,
                                    weigth: 2000,
                                    labelButton: 'Electrolitos Séricos',
                                    onPress: () {
                                      setState(() {
                                        widget.actualView = 3;
                                      });
                                    },
                                  ),
                                  GrandButton(
                                    fontSize: 8,
                                    weigth: 2000,
                                    labelButton: 'Gasometría Arterial',
                                    onPress: () {
                                      setState(() {
                                        widget.actualView = 4;
                                      });
                                    },
                                  ),
                                  GrandButton(
                                    fontSize: 8,
                                    weigth: 2000,
                                    labelButton: 'Gasometría Venosa',
                                    onPress: () {
                                      setState(() {
                                        widget.actualView = 5;
                                      });
                                    },
                                  ),
                                  GrandButton(
                                    fontSize: 8,
                                    weigth: 2000,
                                    labelButton: 'Hepáticos',
                                    onPress: () {
                                      setState(() {
                                        widget.actualView = 6;
                                      });
                                    },
                                  ),
                                  GrandButton(
                                    fontSize: 8,
                                    weigth: 2000,
                                    labelButton: 'Balances Hídricos',
                                    onPress: () {
                                      setState(() {
                                        widget.actualView = 9;
                                      });
                                    },
                                  ),
                                  GrandButton(
                                    fontSize: 8,
                                    weigth: 2000,
                                    labelButton: 'Ventilaciones',
                                    onPress: () {
                                      setState(() {
                                        widget.actualView = 10;
                                      });
                                    },
                                  ),
                                  GrandButton(
                                    fontSize: 8,
                                    weigth: 2000,
                                    labelButton: 'Transfusiones',
                                    onPress: () {
                                      setState(() {
                                        widget.actualView = 21;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: CrossLine(thickness: 3)),
            // Expanded(
            //     flex: 2,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         GrandIcon(
            //           iconData: Icons.update,
            //           labelButton: "Actualizar",
            //           onPress: () {
            //             setState(() {});
            //           },
            //         ),
            //         GrandIcon(
            //           iconData: Icons.checklist_rtl,
            //           labelButton: "Laboratorios",
            //           onPress: () {
            //             Operadores.selectOptionsActivity(
            //               context: context,
            //               tittle: "Elija la fecha de los estudios . . . ",
            //               options: Listas.listWithoutRepitedValues(
            //                 Listas.listFromMapWithOneKey(
            //                   Pacientes.Paraclinicos!,
            //                   keySearched: 'Fecha_Registro',
            //                 ),
            //               ),
            //               onClose: (value) {
            //                 setState(() {
            //                   Datos.portapapeles(
            //                       context: context,
            //                       text:
            //                           Auxiliares.porFecha(fechaActual: value));
            //                   Navigator.of(context).pop();
            //                 });
            //               },
            //             );
            //           },
            //         ),
            //         GrandIcon(
            //           iconData: Icons.checklist_sharp,
            //           labelButton: "Laboratorios",
            //           onPress: () {
            //             Datos.portapapeles(
            //                 context: context, text: Auxiliares.historial());
            //           },
            //           onLongPress: () {
            //             Datos.portapapeles(
            //                 context: context,
            //                 text: Auxiliares.historial(esAbreviado: true));
            //           },
            //         ),
            //         GrandIcon(
            //           iconData: Icons.checklist_sharp,
            //           labelButton: "Laboratorios",
            //           onPress: () {
            //             Datos.portapapeles(
            //                 context: context, text: Auxiliares.getUltimo());
            //           },
            //           onLongPress: () {
            //             Datos.portapapeles(
            //                 context: context,
            //                 text: Auxiliares.getUltimo(esAbreviado: true));
            //           },
            //         ),
            //       ],
            //     )),
            // Expanded(
            //   flex: 3,
            //   child: Wrap(
            //     spacing: 8,
            //     runSpacing: 2,
            //     runAlignment: WrapAlignment.spaceBetween,
            //     alignment: WrapAlignment.spaceBetween,
            //     children: [
            //       GrandIcon(
            //         iconData: Icons.water_drop,
            //         labelButton: 'Análisis Hidrico',
            //         onPress: () {
            //           Operadores.openDialog(
            //               context: context, chyldrim: const Hidricos());
            //         },
            //       ),
            //       GrandIcon(
            //         iconData: Icons.bubble_chart,
            //         labelButton: 'Análisis Metabólico',
            //         onPress: () {
            //           Operadores.openDialog(
            //               context: context, chyldrim: const Metabolicos());
            //         },
            //       ),
            //       GrandIcon(
            //         iconData: Icons.horizontal_rule_sharp,
            //         labelButton: 'Análisis Antropométrico',
            //         onPress: () {
            //           Operadores.openDialog(
            //               context: context, chyldrim: const Antropometricos());
            //         },
            //       ),
            //       GrandIcon(
            //         iconData: Icons.monitor_heart_outlined,
            //         labelButton: 'Análisis Cardiovascular',
            //         onPress: () {
            //           Operadores.openDialog(
            //               context: context, chyldrim: const Cardiovasculares());
            //         },
            //       ),
            //       GrandIcon(
            //         iconData: Icons.all_inclusive_rounded,
            //         labelButton: 'Análisis Ventilatorio',
            //         onPress: () {
            //           Operadores.openDialog(
            //               context: context, chyldrim: const Ventilatorios());
            //         },
            //       ),
            //       GrandIcon(
            //         iconData: Icons.g_mobiledata,
            //         labelButton: 'Análisis Gasométrico',
            //         onPress: () {
            //           Operadores.openDialog(
            //               context: context, chyldrim: const Gasometricos());
            //         },
            //       ),
            //       GrandIcon(
            //         labelButton: 'Análisis Cerebrovascular',
            //         onPress: () {
            //           Operadores.alertActivity(
            //               context: context,
            //               tittle: "¡Disculpas!",
            //               message: "Actividad en construcción");
            //           // Operadores.openDialog(
            //           //     context: context, chyldrim: const Hidricos());
            //         },
            //       ),
            //       GrandIcon(
            //         labelButton: 'Análisis Renal',
            //         onPress: () {
            //           Operadores.alertActivity(
            //               context: context,
            //               tittle: "¡Disculpas!",
            //               message: "Actividad en construcción");
            //           // Operadores.openDialog(
            //           //     context: context, chyldrim: const Hidricos());
            //         },
            //       ),
            //       GrandIcon(
            //         labelButton: 'Análisis Sanguíneo Circulante',
            //         onPress: () {
            //           Operadores.alertActivity(
            //               context: context,
            //               tittle: "¡Disculpas!",
            //               message: "Actividad en construcción");
            //           // Operadores.openDialog(
            //           //     context: context, chyldrim: const Hidricos());
            //         },
            //       ),
            //       GrandIcon(
            //         labelButton: 'Análisis Pulmonar',
            //         onPress: () {
            //           Operadores.alertActivity(
            //               context: context,
            //               tittle: "¡Disculpas!",
            //               message: "Actividad en construcción");
            //           // Operadores.openDialog(
            //           //     context: context, chyldrim: const Hidricos());
            //         },
            //       ),
            //       GrandIcon(
            //         labelButton: 'Edad Corregida',
            //         onPress: () {
            //           Operadores.alertActivity(
            //               context: context,
            //               tittle: "¡Disculpas!",
            //               message: "Actividad en construcción");
            //           // Operadores.openDialog(
            //           //     context: context, chyldrim: const Hidricos());
            //         },
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  tabletView() {
    return RoundedPanel(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(5),
              decoration: ContainerDecoration.roundedDecoration(),
              child: Column(
                children: [
                  Expanded(
                    child: ValuePanel(
                      firstText: "",
                      secondText: Valores.fechaVitales.toString(),
                      thirdText: "",
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: GridView(
                      padding: const EdgeInsets.all(5.0),
                      controller: ScrollController(),
                      gridDelegate: GridViewTools.gridDelegate(
                          crossAxisCount: isMobile(context) ? 4 : 2,
                          mainAxisExtent: 66), //46
                      children: [
                        ValuePanel(
                          firstText: "T. Sys",
                          secondText:
                              Valores.tensionArterialSystolica.toString(),
                          thirdText: "mmHg",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Tensión sistólica? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    Valores.tensionArterialSystolica =
                                        int.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        ValuePanel(
                          firstText: "T. Dyas",
                          secondText:
                              Valores.tensionArterialDyastolica.toString(),
                          thirdText: "mmHg",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Tensión diastólica? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    Valores.tensionArterialDyastolica =
                                        int.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        ValuePanel(
                          firstText: "F. Card.",
                          secondText: Valores.frecuenciaCardiaca.toString(),
                          thirdText: "Lat/min",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Frecuencia cardiaca? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    Valores.frecuenciaCardiaca =
                                        int.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        ValuePanel(
                          firstText: "F. Resp.",
                          secondText: Valores.frecuenciaRespiratoria.toString(),
                          thirdText: "Resp/min",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Frecuencia respiratoria? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    Valores.frecuenciaRespiratoria =
                                        int.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        ValuePanel(
                          firstText: "T. C.",
                          secondText: Valores.temperaturCorporal.toString(),
                          thirdText: "°C",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Temperatura corporal? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    Valores.temperaturCorporal =
                                        double.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        ValuePanel(
                          firstText: "SpO2",
                          secondText:
                              Valores.saturacionPerifericaOxigeno.toString(),
                          thirdText: "Resp/min",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message:
                                    "¿Saturación periférica de oxígeno? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    Valores.saturacionPerifericaOxigeno =
                                        int.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        // CrossLine(),
                        ValuePanel(
                          firstText: "P. Corporal",
                          secondText: Valores.pesoCorporalTotal.toString(),
                          thirdText: "Kg",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Peso corporal total? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    Valores.pesoCorporalTotal =
                                        double.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        ValuePanel(
                          firstText: "Estatura",
                          secondText: Valores.alturaPaciente.toString(),
                          thirdText: "mts",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Altura del paciente? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    Valores.alturaPaciente =
                                        double.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        ValuePanel(
                          firstText: "G. Cap.",
                          secondText: Valores.glucemiaCapilar.toString(),
                          thirdText: "mg/dL",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Glucemia capilar? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    Valores.glucemiaCapilar = int.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                        ValuePanel(
                          firstText: "Horas ayuno",
                          secondText: Valores.horasAyuno.toString(),
                          thirdText: "Horas",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Horas de ayuno? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    Valores.horasAyuno = int.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 11,
            child: Container(
              margin: const EdgeInsets.only(bottom: 12.0, top: 12.0),
              decoration: ContainerDecoration.roundedDecoration(),
              child: widget.actualView == 0
                  ? Container()
                  : widget.actualView == 1
                      ? biometrias()
                      : widget.actualView == 2
                          ? quimicas()
                          : widget.actualView == 3
                              ? electrolitos()
                              : widget.actualView == 4
                                  ? arteriales()
                                  : widget.actualView == 5
                                      ? venosos()
                                      : widget.actualView == 6
                                          ? hepaticos()
                                          : widget.actualView == 7
                                              ? electrolitos()
                                              : widget.actualView == 8
                                                  ? electrolitos()
                                                  : widget.actualView == 9
                                                      ? const BalanceHidrico()
                                                      : widget.actualView == 10
                                                          ? ventilaciones()
                                                          : widget.actualView ==
                                                                  11
                                                              ? const Hidricos()
                                                              : widget.actualView ==
                                                                      12
                                                                  ? const Metabolicos()
                                                                  : widget.actualView ==
                                                                          13
                                                                      ? const Antropometricos()
                                                                      : widget.actualView ==
                                                                              14
                                                                          ? const Cardiovasculares()
                                                                          : widget.actualView == 15
                                                                              ? const Ventilatorios()
                                                                              : widget.actualView == 16
                                                                                  ? const Gasometricos()
                                                                                  : widget.actualView == 17
                                                                                      ? const Hidricos()
                                                                                      : widget.actualView == 18
                                                                                          ? const Hidricos()
                                                                                          : widget.actualView == 19
                                                                                              ? const Hidricos()
                                                                                              : widget.actualView == 20
                                                                                                  ? const Hidricos()
                                                                                                  : widget.actualView == 21
                                                                                                      ? const Hemoderivados()
                                                                                                      : Container(),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: ContainerDecoration.roundedDecoration(),
              margin: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 10,
                    child: Wrap(
                      direction: Axis.vertical,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: [
                        GrandIcon(
                          iconData: Icons.bloodtype,
                          labelButton: 'Biometría Hemática',
                          onPress: () {
                            setState(() {
                              widget.actualView = 1;
                            });
                          },
                        ),
                        GrandIcon(
                          iconData: Icons.schema_outlined,
                          labelButton: 'Química Sanguínea',
                          onPress: () {
                            setState(() {
                              widget.actualView = 2;
                            });
                          },
                        ),
                        GrandIcon(
                          iconData: Icons.electric_bolt,
                          labelButton: 'Electrolitos Séricos',
                          onPress: () {
                            setState(() {
                              widget.actualView = 3;
                            });
                          },
                        ),
                        GrandIcon(
                          iconData: Icons.outbox,
                          labelButton: 'Gasometría Arterial',
                          onPress: () {
                            setState(() {
                              widget.actualView = 4;
                            });
                          },
                        ),
                        GrandIcon(
                          iconData: Icons.outbox,
                          labelButton: 'Gasometría Venosa',
                          onPress: () {
                            setState(() {
                              widget.actualView = 5;
                            });
                          },
                        ),
                        GrandIcon(
                          iconData: Icons.live_help,
                          labelButton: 'Hepáticos',
                          onPress: () {
                            setState(() {
                              widget.actualView = 6;
                            });
                          },
                        ),
                        GrandIcon(
                          iconData: Icons.balance,
                          labelButton: 'Balance Hídrico',
                          onPress: () {
                            setState(() {
                              widget.actualView = 9;
                            });
                          },
                        ),
                        GrandIcon(
                          iconData: Icons.air,
                          labelButton: 'Ventilatorios',
                          onPress: () {
                            setState(() {
                              widget.actualView = 10;
                            });
                          },
                        ),
                        GrandIcon(
                          iconData: Icons.air,
                          labelButton: 'Trasfusiones',
                          onPress: () {
                            setState(() {
                              widget.actualView = 21;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: GrandIcon(
                    iconData: Icons.update,
                    labelButton: "Actualizar",
                    onPress: () {
                      setState(() {});
                    },
                  )),
                  Expanded(
                      child: GrandIcon(
                    iconData: Icons.checklist_rtl,
                    labelButton: "Laboratorios",
                    onPress: () {
                      Operadores.selectOptionsActivity(
                        context: context,
                        tittle: "Elija la fecha de los estudios . . . ",
                        options: Listas.listWithoutRepitedValues(
                          Listas.listFromMapWithOneKey(
                            Pacientes.Paraclinicos!,
                            keySearched: 'Fecha_Registro',
                          ),
                        ),
                        onClose: (value) {
                          setState(() {
                            Datos.portapapeles(
                                context: context,
                                text: Auxiliares.porFecha(fechaActual: value));
                            Navigator.of(context).pop();
                          });
                        },
                      );
                    },
                  )),
                  Expanded(
                      child: GrandIcon(
                    iconData: Icons.checklist_sharp,
                    labelButton: "Laboratorios",
                    onPress: () {
                      Datos.portapapeles(
                          context: context, text: Auxiliares.historial());
                    },
                  )),
                  Expanded(
                      child: GrandIcon(
                    iconData: Icons.checklist_sharp,
                    labelButton: "Laboratorios",
                    onPress: () {
                      Datos.portapapeles(
                          context: context,
                          text: Auxiliares.historial(esAbreviado: true));
                    },
                  )),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: ContainerDecoration.roundedDecoration(),
              margin: const EdgeInsets.all(8.0),
              child: Center(
                child: Wrap(
                  direction: Axis.vertical,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    GrandIcon(
                      iconData: Icons.water_drop,
                      labelButton: 'Análisis Hidrico',
                      onPress: () {
                        setState(() {
                          widget.actualView = 11;
                        });
                      },
                    ),
                    GrandIcon(
                      iconData: Icons.bubble_chart,
                      labelButton: 'Análisis Metabólico',
                      onPress: () {
                        setState(() {
                          widget.actualView = 12;
                        });
                      },
                    ),
                    GrandIcon(
                      iconData: Icons.horizontal_rule_sharp,
                      labelButton: 'Análisis Antropométrico',
                      onPress: () {
                        setState(() {
                          widget.actualView = 13;
                        });
                      },
                    ),
                    GrandIcon(
                      iconData: Icons.monitor_heart_outlined,
                      labelButton: 'Análisis Cardiovascular',
                      onPress: () {
                        setState(() {
                          widget.actualView = 14;
                        });
                      },
                    ),
                    GrandIcon(
                      iconData: Icons.all_inclusive_rounded,
                      labelButton: 'Análisis Ventilatorio',
                      onPress: () {
                        setState(() {
                          widget.actualView = 15;
                        });
                      },
                    ),
                    GrandIcon(
                      iconData: Icons.g_mobiledata,
                      labelButton: 'Análisis Gasométrico',
                      onPress: () {
                        setState(() {
                          widget.actualView = 16;
                        });
                      },
                    ),
                    GrandIcon(
                      labelButton: 'Análisis Cerebrovascular',
                      onPress: () {
                        Operadores.alertActivity(
                            context: context,
                            tittle: "¡Disculpas!",
                            message: "Actividad en construcción");
                        // Operadores.openDialog(
                        //     context: context, chyldrim: const Hidricos());
                      },
                    ),
                    GrandIcon(
                      labelButton: 'Análisis Renal',
                      onPress: () {
                        Operadores.alertActivity(
                            context: context,
                            tittle: "¡Disculpas!",
                            message: "Actividad en construcción");
                        // Operadores.openDialog(
                        //     context: context, chyldrim: const Hidricos());
                      },
                    ),
                    GrandIcon(
                      labelButton: 'Análisis Sanguíneo Circulante',
                      onPress: () {
                        Operadores.alertActivity(
                            context: context,
                            tittle: "¡Disculpas!",
                            message: "Actividad en construcción");
                        // Operadores.openDialog(
                        //     context: context, chyldrim: const Hidricos());
                      },
                    ),
                    GrandIcon(
                      labelButton: 'Análisis Pulmonar',
                      onPress: () {
                        Operadores.alertActivity(
                            context: context,
                            tittle: "¡Disculpas!",
                            message: "Actividad en construcción");
                        // Operadores.openDialog(
                        //     context: context, chyldrim: const Hidricos());
                      },
                    ),
                    GrandIcon(
                      labelButton: 'Edad Corregida',
                      onPress: () {
                        Operadores.alertActivity(
                            context: context,
                            tittle: "¡Disculpas!",
                            message: "Actividad en construcción");
                        // Operadores.openDialog(
                        //     context: context, chyldrim: const Hidricos());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // **** ********** ********* *****************
  Column biometrias() {
    return Column(
      children: [
        Expanded(
          flex: isMobile(context) ? 1 : 1,
          child: ValuePanel(
            firstText: "",
            secondText: Valores.fechaBiometria.toString(),
            thirdText: "",
          ),
        ),
        Expanded(
          flex: 8,
          child: GridView(
            padding: const EdgeInsets.all(5.0),
            controller: ScrollController(),
            gridDelegate: GridViewTools.gridDelegate(
                crossAxisCount: isMobile(context) ? 2 : 5,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                mainAxisExtent: 66), //46
            children: [
              ValuePanel(
                firstText: "Hemoglobina",
                secondText: Valores.hemoglobina.toString(),
                thirdText: "g/dL",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      keyBoardType: TextInputType.number,
                      tittle: "Editar . . . ",
                      message: "¿Hemoglobina? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.hemoglobina = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "Eritrocitos",
                secondText: Valores.eritrocitos.toString(),
                thirdText: "K/uL",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Eritrocitos? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.eritrocitos = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "Hematocrito",
                secondText: Valores.hematocrito.toString(),
                thirdText: "%",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Hematocrito? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.hematocrito = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "CMHC",
                secondText: Valores.concentracionMediaHemoglobina.toString(),
                thirdText: "g/dL",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      keyBoardType: TextInputType.number,
                      tittle: "Editar . . . ",
                      message: "¿C. Media Hemoglobina Corpuscular? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.concentracionMediaHemoglobina =
                              double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "HCM",
                secondText: Valores.hemoglobinaCorpuscularMedia.toString(),
                thirdText: "fL",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      keyBoardType: TextInputType.number,
                      tittle: "Editar . . . ",
                      message: "¿Hemoglobina Corpuscular Media? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.hemoglobinaCorpuscularMedia =
                              double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "VCM",
                secondText: Valores.volumenCorpuscularMedio.toString(),
                thirdText: "pg",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      keyBoardType: TextInputType.number,
                      tittle: "Editar . . . ",
                      message: "¿Volumen Corpuscular Medio? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.volumenCorpuscularMedio = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "Plaquetas",
                secondText: Valores.plaquetas.toString(),
                thirdText: "K/uL",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Plaquetas? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.plaquetas = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              CrossLine(),
              ValuePanel(
                firstText: "Leucocitos",
                secondText: Valores.leucocitosTotales!.toStringAsFixed(2),
                thirdText: "K/uL",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Leucocitos? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.leucocitosTotales = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "Neutrofilos",
                secondText: Valores.leucocitosTotales.toString(),
                thirdText: "K/uL",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Neutrofilos? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.leucocitosTotales = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "Linfocitos",
                secondText: Valores.linfocitosTotales.toString(),
                thirdText: "K/uL",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Linfocitos? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.linfocitosTotales = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "Monocitos",
                secondText: Valores.monocitosTotales.toString(),
                thirdText: "K/uL",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Monocitos? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.monocitosTotales = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column quimicas() {
    return Column(
      children: [
        Expanded(
          flex: isMobile(context) ? 2 : 1,
          child: ValuePanel(
            firstText: "",
            secondText: Valores.fechaQuimicas.toString(),
            thirdText: "",
          ),
        ),
        Expanded(
          flex: 8,
          child: GridView(
            padding: const EdgeInsets.all(5.0),
            controller: ScrollController(),
            gridDelegate: GridViewTools.gridDelegate(
                crossAxisCount: isMobile(context) ? 2 : 5,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                mainAxisExtent: 66), //46
            children: [
              ValuePanel(
                firstText: "Glucosa Sérica",
                secondText: Valores.glucosa.toString(),
                thirdText: "mg/dL",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Glucosa Sérica? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.glucosa = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "Urea",
                secondText: Valores.urea.toString(),
                thirdText: "mg/dL",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Urea? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.urea = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "Creatinina",
                secondText: Valores.creatinina.toString(),
                thirdText: "mg/dL",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Creatinina? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.creatinina = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "Nitrógeno Uréico",
                secondText: Valores.nitrogenoUreico.toString(),
                thirdText: "mg/gL",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Nitrógeno Uréico? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.nitrogenoUreico = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              CrossLine(),
            ],
          ),
        ),
      ],
    );
  }

  Column electrolitos() {
    return Column(
      children: [
        Expanded(
          flex: isMobile(context) ? 2 : 1,
          child: ValuePanel(
            firstText: "",
            secondText: Valores.fechaElectrolitos.toString(),
            thirdText: "",
          ),
        ),
        Expanded(
          flex: 8,
          child: GridView(
            padding: const EdgeInsets.all(5.0),
            controller: ScrollController(),
            gridDelegate: GridViewTools.gridDelegate(
                crossAxisCount: isMobile(context) ? 2 : 5,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                mainAxisExtent: 66), //46
            children: [
              Container(),
              ValuePanel(
                firstText: "Sodio Sérico",
                secondText: Valores.sodio.toString(),
                thirdText: "mEq/L",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Sodio Sérico? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.sodio = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              Container(),
              ValuePanel(
                firstText: "Potasio Sérico",
                secondText: Valores.potasio.toString(),
                thirdText: "mEq/L",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Potasio Sérico? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.potasio = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              Container(),
              Container(),
              Container(),
              ValuePanel(
                firstText: "Cloro Sérico",
                secondText: Valores.cloro.toString(),
                thirdText: "mg/dL",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Cloro Sérico? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.cloro = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              Container(),
              Container(),
              Container(),
              ValuePanel(
                firstText: "Calcio Sérico",
                secondText: Valores.calcio.toString(),
                thirdText: "mg/gL",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Calcio Sérico? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.calcio = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "Fósforo Sérico",
                secondText: Valores.fosforo.toString(),
                thirdText: "mg/dL",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Fósforo Sérico? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.fosforo = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "Magnesio Sérico",
                secondText: Valores.magnesio.toString(),
                thirdText: "mg/gL",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Magnesio Sérico? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.magnesio = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column arteriales() {
    return Column(
      children: [
        Expanded(
          flex: isMobile(context) ? 2 : 1,
          child: ValuePanel(
            firstText: "",
            secondText: Valores.fechaGasometriaArterial.toString(),
            thirdText: "",
          ),
        ),
        Expanded(
          flex: 8,
          child: GridView(
            padding: const EdgeInsets.all(5.0),
            controller: ScrollController(),
            gridDelegate: GridViewTools.gridDelegate(
                crossAxisCount: isMobile(context) ? 2 : 5,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                mainAxisExtent: 66), //46
            children: [
              ValuePanel(
                firstText: "pH Arterial",
                secondText: Valores.pHArteriales.toString(),
                thirdText: "",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      keyBoardType: TextInputType.number,
                      tittle: "Editar . . . ",
                      message: "¿pH Arterial? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.pHArteriales = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "pCO2 Arterial",
                secondText: Valores.pcoArteriales.toString(),
                thirdText: "mmHg",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿pCO2 Arterial? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.pcoArteriales = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "pO2 Arterial",
                secondText: Valores.poArteriales.toString(),
                thirdText: "mmHg",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿pO2 Arteriales? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.poArteriales = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "HCO3- Arterial",
                secondText: Valores.bicarbonatoArteriales.toString(),
                thirdText: "mmol/L",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      keyBoardType: TextInputType.number,
                      tittle: "Editar . . . ",
                      message: "¿HCO3- Arterial? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.bicarbonatoArteriales = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "SaO2",
                secondText: Valores.soArteriales.toString(),
                thirdText: "%",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      keyBoardType: TextInputType.number,
                      tittle: "Editar . . . ",
                      message: "¿SO2 Arterial? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.soArteriales = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column venosos() {
    return Column(
      children: [
        Expanded(
          flex: isMobile(context) ? 2 : 1,
          child: ValuePanel(
            firstText: "",
            secondText: Valores.fechaGasometriaVenosa.toString(),
            thirdText: "",
          ),
        ),
        Expanded(
          flex: 8,
          child: GridView(
            padding: const EdgeInsets.all(5.0),
            controller: ScrollController(),
            gridDelegate: GridViewTools.gridDelegate(
                crossAxisCount: isMobile(context) ? 2 : 5,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                mainAxisExtent: 66), //46
            children: [
              ValuePanel(
                firstText: "pH Venoso",
                secondText: Valores.pHVenosos.toString(),
                thirdText: "",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      keyBoardType: TextInputType.number,
                      tittle: "Editar . . . ",
                      message: "¿pH Venoso? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.pHVenosos = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "pCO2 Venoso",
                secondText: Valores.pcoVenosos.toString(),
                thirdText: "mmHg",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿pCO2 Venoso? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.pcoVenosos = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "pO2 Venoso",
                secondText: Valores.poVenosos.toString(),
                thirdText: "mmHg",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿pO2 Venosos? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.poVenosos = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "HCO3- Venoso",
                secondText: Valores.bicarbonatoVenosos.toString(),
                thirdText: "mmol/L",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      keyBoardType: TextInputType.number,
                      tittle: "Editar . . . ",
                      message: "¿HCO3- Venoso? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.bicarbonatoVenosos = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "SaO2",
                secondText: Valores.soVenosos.toString(),
                thirdText: "%",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      keyBoardType: TextInputType.number,
                      tittle: "Editar . . . ",
                      message: "¿SO2 Venoso? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.soVenosos = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column balances() {
    return Column(
      children: [
        Expanded(
          flex: isMobile(context) ? 2 : 1,
          child: ValuePanel(
            firstText: "",
            secondText: Valores.fechaRealizacionBalances.toString(),
            thirdText: "",
          ),
        ),
        Expanded(
          flex: 8,
          child: GridView(
            padding: const EdgeInsets.all(5.0),
            controller: ScrollController(),
            gridDelegate: GridViewTools.gridDelegate(
                crossAxisCount: isMobile(context) ? 2 : 5,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                mainAxisExtent: 66), //46
            children: [
              ValuePanel(
                secondText: Valores.fechaRealizacionBalances,
              ),
              ValuePanel(
                firstText: "Ingresos",
                secondText: Valores.ingresosBalances.toStringAsFixed(0),
                thirdText: "mL",
              ),
              ValuePanel(
                firstText: "Egresos",
                secondText: Valores.egresosBalances.toStringAsFixed(0),
                thirdText: "mL",
              ),
              ValuePanel(
                firstText: "Balance Total",
                secondText: Valores.balanceTotal.toStringAsFixed(0),
                thirdText: "mL",
              ),
              CrossLine(),
              ValuePanel(
                firstText: "P. Insensibles",
                secondText: Valores.perdidasInsensibles.toStringAsFixed(0),
                thirdText: "mL",
              ),
              ValuePanel(
                firstText: "Uresis",
                secondText: Valores.uresis!.toStringAsFixed(0),
                thirdText: "mL",
              ),
              ValuePanel(
                firstText: "Diuresis",
                secondText: Valores.diuresis.toStringAsFixed(2),
                thirdText: "mL",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column hepaticos() {
    return Column(
      children: [
        Expanded(
          child: ValuePanel(
            firstText: "",
            secondText: Valores.fechaHepaticos.toString(),
            thirdText: "",
          ),
        ),
        Expanded(
          flex: 8,
          child: GridView(
            padding: const EdgeInsets.all(5.0),
            controller: ScrollController(),
            gridDelegate: GridViewTools.gridDelegate(
                crossAxisCount: isMobile(context) ? 2 : 5,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                mainAxisExtent: 66), //46
            children: [
              ValuePanel(
                secondText: Valores.fechaHepaticos ?? '',
              ),
              ValuePanel(
                firstText: "BT",
                secondText: Valores.bilirrubinasTotales!.toStringAsFixed(2),
                thirdText: "mg/dL",
              ),
              ValuePanel(
                firstText: "BD",
                secondText: Valores.bilirrubinaDirecta!.toStringAsFixed(2),
                thirdText: "mg/dL",
              ),
              ValuePanel(
                firstText: "BI",
                secondText: Valores.bilirrubinaIndirecta!.toStringAsFixed(2),
                thirdText: "mg/dL",
              ),
              ValuePanel(
                firstText: "ALT / TGA",
                secondText: Valores.alaninoaminotrasferasa!.toStringAsFixed(0),
                thirdText: "UI/L",
              ),
              ValuePanel(
                firstText: "AST / TGO",
                secondText:
                    Valores.aspartatoaminotransferasa!.toStringAsFixed(0),
                thirdText: "UI/L",
              ),
              ValuePanel(
                firstText: "GGT",
                secondText: Valores.glutrailtranspeptidasa!.toStringAsFixed(0),
                thirdText: "UI/L",
              ),
              ValuePanel(
                firstText: "FA",
                secondText: Valores.fosfatasaAlcalina!.toStringAsFixed(0),
                thirdText: "UI/L",
              ),
              ValuePanel(
                firstText: "Albúmina",
                secondText: Valores.albuminaSerica!.toStringAsFixed(1),
                thirdText: "g/dL",
              ),
              ValuePanel(
                firstText: "Proteínas Totales",
                secondText: Valores.proteinasTotales!.toStringAsFixed(1),
                thirdText: "g/dL",
              ),
              CrossLine(),
              ValuePanel(
                firstText: "AST/ALT",
                secondText: Hepatometrias.relacionASTALT.toStringAsFixed(2),
                thirdText: "",
              ),
              ValuePanel(
                firstText: "ALT/FA",
                secondText: Hepatometrias.relacionALTFA.toStringAsFixed(2),
                thirdText: "",
              ),
              ValuePanel(
                firstText: "Factor R",
                secondText: Hepatometrias.factorR.toStringAsFixed(2),
                thirdText: "",
              ),
            ],
          ),
        ),
      ],
    );
  }

  // **** ********** ********* *****************
  Column ventilaciones() {
    return Column(
      children: [
        Expanded(
          flex: isMobile(context) ? 3 : 1,
          child: ValuePanel(
            firstText: "",
            secondText: Valores.fechaVentilaciones.toString(),
            thirdText: "",
          ),
        ),
        Expanded(
            flex: isMobile(context) ? 4 : 1,
            child: ValuePanel(
              firstText: "",
              secondText: Valores.modalidadVentilatoria.toString(),
              thirdText: "",
              withEditMessage: true,
              onEdit: (value) {},
            )),
        Expanded(
          flex: 8,
          child: GridView(
            padding: const EdgeInsets.all(5.0),
            controller: ScrollController(),
            gridDelegate: GridViewTools.gridDelegate(
                crossAxisCount: isMobile(context) ? 2 : 5,
                mainAxisSpacing: 2.0,
                crossAxisSpacing: 2.0,
                mainAxisExtent: 66), //46
            children: [
              ValuePanel(
                firstText: "Vt",
                secondText: Valores.volumenTidal.toString(),
                thirdText: "mL/min",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      keyBoardType: TextInputType.number,
                      tittle: "Editar . . . ",
                      message: "¿Volumen Tidal? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.volumenTidal = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "F. Vent.",
                secondText: Valores.frecuenciaVentilatoria.toString(),
                thirdText: "Vent/min",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Frecuencia Ventilatoria? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.frecuenciaVentilatoria = int.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "P.E.E.P.",
                secondText: Valores.presionFinalEsiracion.toString(),
                thirdText: "cmH2O",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿P.E.E.P.? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.presionFinalEsiracion = int.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "FiO2",
                secondText: Valores.fraccionInspiratoriaVentilatoria.toString(),
                thirdText: "%",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿FiO2 Programado? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.fraccionInspiratoriaVentilatoria =
                              int.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "Presión Control",
                secondText: Valores.presionControl.toString(),
                thirdText: "cmH2O",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Presión Control? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.presionControl = int.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "P. Peak",
                secondText: Valores.presionInspiratoriaPico.toString(),
                thirdText: "cmH2O",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿P. Peak? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.presionInspiratoriaPico = int.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              ValuePanel(
                firstText: "V. Vent. ",
                secondText: Valores.volumenVentilatorio.toString(),
                thirdText: "mL/min",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Volumen Ventilatorio? . . . ",
                      onAcept: (value) {
                        Terminal.printSuccess(message: "recieve $value");
                        setState(() {
                          Valores.volumenVentilatorio = int.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
            ],
          ),
        ),
        // Expanded(
        //   flex: 4,
        //   child: GridView(
        //     padding: const EdgeInsets.all(5.0),
        //     controller: ScrollController(),
        //     gridDelegate: GridViewTools.gridDelegate(
        //         crossAxisCount: isMobile(context) ? 4 : 5, mainAxisExtent: 66), //46
        //     children: [
        //
        //       ValuePanel(
        //         firstText: "Vt",
        //         secondText: Valores.volumenTidal.toString(),
        //         thirdText: "mL/min",
        //         withEditMessage: true,
        //         onEdit: (value) {
        //           Operadores.editActivity(
        //               context: context,
        //               keyBoardType: TextInputType.number,
        //               tittle: "Editar . . . ",
        //               message: "¿Volumen Tidal? . . . ",
        //               onAcept: (value) {
        //                 Terminal.printSuccess(message: "recieve $value");
        //                 setState(() {
        //                   Valores.volumenTidal = double.parse(value);
        //                   Navigator.of(context).pop();
        //                 });
        //               });
        //         },
        //       ),
        //       ValuePanel(
        //         firstText: "F. Vent.",
        //         secondText: Valores.frecuenciaVentilatoria.toString(),
        //         thirdText: "Vent/min",
        //         withEditMessage: true,
        //         onEdit: (value) {
        //           Operadores.editActivity(
        //               context: context,
        //               tittle: "Editar . . . ",
        //               message: "¿Frecuencia Ventilatoria? . . . ",
        //               onAcept: (value) {
        //                 Terminal.printSuccess(message: "recieve $value");
        //                 setState(() {
        //                   Valores.frecuenciaVentilatoria = int.parse(value);
        //                   Navigator.of(context).pop();
        //                 });
        //               });
        //         },
        //       ),
        //       ValuePanel(
        //         firstText: "P.E.E.P.",
        //         secondText: Valores.presionFinalEsiracion.toString(),
        //         thirdText: "cmH2O",
        //         withEditMessage: true,
        //         onEdit: (value) {
        //           Operadores.editActivity(
        //               context: context,
        //               tittle: "Editar . . . ",
        //               message: "¿P.E.E.P.? . . . ",
        //               onAcept: (value) {
        //                 Terminal.printSuccess(message: "recieve $value");
        //                 setState(() {
        //                   Valores.presionFinalEsiracion = int.parse(value);
        //                   Navigator.of(context).pop();
        //                 });
        //               });
        //         },
        //       ),
        //       ValuePanel(
        //         firstText: "FiO2",
        //         secondText: Valores.fraccionInspiratoriaVentilatoria.toString(),
        //         thirdText: "%",
        //         withEditMessage: true,
        //         onEdit: (value) {
        //           Operadores.editActivity(
        //               context: context,
        //               tittle: "Editar . . . ",
        //               message: "¿FiO2 Programado? . . . ",
        //               onAcept: (value) {
        //                 Terminal.printSuccess(message: "recieve $value");
        //                 setState(() {
        //                   Valores.fraccionInspiratoriaVentilatoria = int.parse(value);
        //                   Navigator.of(context).pop();
        //                 });
        //               });
        //         },
        //       ),
        //       ValuePanel(
        //         firstText: "Presión Control",
        //         secondText: Valores.presionControl.toString(),
        //         thirdText: "cmH2O",
        //         withEditMessage: true,
        //         onEdit: (value) {
        //           Operadores.editActivity(
        //               context: context,
        //               tittle: "Editar . . . ",
        //               message: "¿Presión Control? . . . ",
        //               onAcept: (value) {
        //                 Terminal.printSuccess(message: "recieve $value");
        //                 setState(() {
        //                   Valores.presionControl = int.parse(value);
        //                   Navigator.of(context).pop();
        //                 });
        //               });
        //         },
        //       ),
        //       ValuePanel(
        //         firstText: "P. Peak",
        //         secondText: Valores.presionInspiratoriaPico.toString(),
        //         thirdText: "cmH2O",
        //         withEditMessage: true,
        //         onEdit: (value) {
        //           Operadores.editActivity(
        //               context: context,
        //               tittle: "Editar . . . ",
        //               message: "¿P. Peak? . . . ",
        //               onAcept: (value) {
        //                 Terminal.printSuccess(message: "recieve $value");
        //                 setState(() {
        //                   Valores.presionInspiratoriaPico = int.parse(value);
        //                   Navigator.of(context).pop();
        //                 });
        //               });
        //         },
        //       ),
        //       ValuePanel(
        //         firstText: "V. Vent. ",
        //         secondText: Valores.volumenVentilatorio.toString(),
        //         thirdText: "mL/min",
        //         withEditMessage: true,
        //         onEdit: (value) {
        //           Operadores.editActivity(
        //               context: context,
        //               tittle: "Editar . . . ",
        //               message: "¿Volumen Ventilatorio? . . . ",
        //               onAcept: (value) {
        //                 Terminal.printSuccess(message: "recieve $value");
        //                 setState(() {
        //                   Valores.volumenVentilatorio = int.parse(value);
        //                   Navigator.of(context).pop();
        //                 });
        //               });
        //         },
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
