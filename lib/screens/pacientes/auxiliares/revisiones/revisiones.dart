import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/antropometricos.dart';
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
import 'package:assistant/widgets/ThreeLabelText.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';

class Revisiones extends StatefulWidget {
  var actualView = 0;

  Revisiones({Key? key}) : super(key: key);

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: TittlePanel(textPanel: 'Revisión General'),
          ),
          Expanded(
            flex: 4,
            child: GridView(
              padding: const EdgeInsets.all(5.0),
              controller: ScrollController(),
              gridDelegate: GridViewTools.gridDelegate(
                  crossAxisCount: isMobile(context) ? 4 : 3,
                  mainAxisExtent: 65), //46
              children: [
                ValuePanel(
                  firstText: "T. Sys",
                  secondText: Valores.tensionArterialSystolica.toString(),
                  thirdText: "mmHg",
                  withEditMessage: true,
                  onEdit: (value) {
                    Operadores.editActivity(
                        context: context,
                        tittle: "Editar . . . ",
                        message: "¿Tensión sistólica? . . . ",
                        onAcept: (value) {
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            Valores.tensionArterialSystolica = int.parse(value);
                            Navigator.of(context).pop();
                          });
                        });
                  },
                ),
                ValuePanel(
                  firstText: "T. Dyas",
                  secondText: Valores.tensionArterialDyastolica.toString(),
                  thirdText: "mmHg",
                  withEditMessage: true,
                  onEdit: (value) {
                    Operadores.editActivity(
                        context: context,
                        tittle: "Editar . . . ",
                        message: "¿Tensión diastólica? . . . ",
                        onAcept: (value) {
                          Terminal.printSuccess(message: "recieve $value");
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
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            Valores.frecuenciaCardiaca = int.parse(value);
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
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            Valores.frecuenciaRespiratoria = int.parse(value);
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
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            Valores.temperaturCorporal = double.parse(value);
                            Navigator.of(context).pop();
                          });
                        });
                  },
                ),
                ValuePanel(
                  firstText: "SpO2",
                  secondText: Valores.saturacionPerifericaOxigeno.toString(),
                  thirdText: "Resp/min",
                  withEditMessage: true,
                  onEdit: (value) {
                    Operadores.editActivity(
                        context: context,
                        tittle: "Editar . . . ",
                        message: "¿Saturación periférica de oxígeno? . . . ",
                        onAcept: (value) {
                          Terminal.printSuccess(message: "recieve $value");
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
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            Valores.pesoCorporalTotal = double.parse(value);
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
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            Valores.alturaPaciente = double.parse(value);
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
                          Terminal.printSuccess(message: "recieve $value");
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
                          Terminal.printSuccess(message: "recieve $value");
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
              flex: 8,
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
                                  : widget.actualView == 3
                                      ? electrolitos()
                                      : widget.actualView == 3
                                          ? electrolitos()
                                          : widget.actualView == 3
                                              ? electrolitos()
                                              : Container())),
          Expanded(
            flex: 2,
            child: Container(
              decoration: ContainerDecoration.roundedDecoration(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                controller: ScrollController(),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    GrandButton(
                      weigth: 2000,
                      labelButton: 'Biometría Hemática',
                      onPress: () {
                        setState(() {
                          widget.actualView = 1;
                        });
                      },
                    ),
                    GrandButton(
                      weigth: 2000,
                      labelButton: 'Química Sanguínea',
                      onPress: () {
                        setState(() {
                          widget.actualView = 2;
                        });
                      },
                    ),
                    GrandButton(
                      weigth: 2000,
                      labelButton: 'Electrolitos Séricos',
                      onPress: () {
                        setState(() {
                          widget.actualView = 3;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: ContainerDecoration.roundedDecoration(),
              margin: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                controller: ScrollController(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GrandIcon(
                      iconData: Icons.water_drop,
                      labelButton: 'Análisis Hidrico',
                      onPress: () {
                        Operadores.openDialog(
                            context: context, chyldrim: const Hidricos());
                      },
                    ),
                    GrandIcon(
                      iconData: Icons.bubble_chart,
                      labelButton: 'Análisis Metabólico',
                      onPress: () {
                        Operadores.openDialog(
                            context: context, chyldrim: const Metabolicos());
                      },
                    ),
                    GrandIcon(
                      iconData: Icons.horizontal_rule_sharp,
                      labelButton: 'Análisis Antropométrico',
                      onPress: () {
                        Operadores.openDialog(
                            context: context,
                            chyldrim: const Antropometricos());
                      },
                    ),
                    GrandIcon(
                      labelButton: 'Análisis Cardiovascular',
                      onPress: () {
                        Operadores.openDialog(
                            context: context,
                            chyldrim: const Cardiovasculares());
                      },
                    ),
                    GrandIcon(
                      iconData: Icons.all_inclusive_rounded,
                      labelButton: 'Análisis Ventilatorio',
                      onPress: () {
                        Operadores.openDialog(
                            context: context, chyldrim: const Ventilatorios());
                      },
                    ),
                    GrandIcon(
                      iconData: Icons.g_mobiledata,
                      labelButton: 'Análisis Gasométrico',
                      onPress: () {
                        Operadores.openDialog(
                            context: context, chyldrim: const Gasometricos());
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

  tabletView() {
    return RoundedPanel(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Expanded(
          //   flex: 1,
          //   child: TittlePanel(textPanel: 'Revisión General'),
          // ),
          Expanded(
            flex: 4,
            child: GridView(
              padding: const EdgeInsets.all(5.0),
              controller: ScrollController(),
              gridDelegate: GridViewTools.gridDelegate(
                  crossAxisCount: isMobile(context) ? 4 : 2,
                  mainAxisExtent: 65), //46
              children: [
                ValuePanel(
                  firstText: "T. Sys",
                  secondText: Valores.tensionArterialSystolica.toString(),
                  thirdText: "mmHg",
                  withEditMessage: true,
                  onEdit: (value) {
                    Operadores.editActivity(
                        context: context,
                        tittle: "Editar . . . ",
                        message: "¿Tensión sistólica? . . . ",
                        onAcept: (value) {
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            Valores.tensionArterialSystolica = int.parse(value);
                            Navigator.of(context).pop();
                          });
                        });
                  },
                ),
                ValuePanel(
                  firstText: "T. Dyas",
                  secondText: Valores.tensionArterialDyastolica.toString(),
                  thirdText: "mmHg",
                  withEditMessage: true,
                  onEdit: (value) {
                    Operadores.editActivity(
                        context: context,
                        tittle: "Editar . . . ",
                        message: "¿Tensión diastólica? . . . ",
                        onAcept: (value) {
                          Terminal.printSuccess(message: "recieve $value");
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
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            Valores.frecuenciaCardiaca = int.parse(value);
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
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            Valores.frecuenciaRespiratoria = int.parse(value);
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
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            Valores.temperaturCorporal = double.parse(value);
                            Navigator.of(context).pop();
                          });
                        });
                  },
                ),
                ValuePanel(
                  firstText: "SpO2",
                  secondText: Valores.saturacionPerifericaOxigeno.toString(),
                  thirdText: "Resp/min",
                  withEditMessage: true,
                  onEdit: (value) {
                    Operadores.editActivity(
                        context: context,
                        tittle: "Editar . . . ",
                        message: "¿Saturación periférica de oxígeno? . . . ",
                        onAcept: (value) {
                          Terminal.printSuccess(message: "recieve $value");
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
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            Valores.pesoCorporalTotal = double.parse(value);
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
                          Terminal.printSuccess(message: "recieve $value");
                          setState(() {
                            Valores.alturaPaciente = double.parse(value);
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
                          Terminal.printSuccess(message: "recieve $value");
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
                          Terminal.printSuccess(message: "recieve $value");
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
              flex: 8,
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
                                  : widget.actualView == 3
                                      ? electrolitos()
                                      : widget.actualView == 3
                                          ? electrolitos()
                                          : widget.actualView == 3
                                              ? electrolitos()
                                              : Container())),
          Expanded(
            flex: 2,
            child: Container(
              decoration: ContainerDecoration.roundedDecoration(),
              margin: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                controller: ScrollController(),
                scrollDirection: Axis.vertical,
                child: Column(
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
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: ContainerDecoration.roundedDecoration(),
              margin: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                controller: ScrollController(),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    GrandIcon(
                      iconData: Icons.water_drop,
                      labelButton: 'Análisis Hidrico',
                      onPress: () {
                        Operadores.openDialog(
                            context: context, chyldrim: const Hidricos());
                      },
                    ),
                    GrandIcon(
                      iconData: Icons.bubble_chart,
                      labelButton: 'Análisis Metabólico',
                      onPress: () {
                        Operadores.openDialog(
                            context: context, chyldrim: const Metabolicos());
                      },
                    ),
                    GrandIcon(
                      iconData: Icons.horizontal_rule_sharp,
                      labelButton: 'Análisis Antropométrico',
                      onPress: () {
                        Operadores.openDialog(
                            context: context,
                            chyldrim: const Antropometricos());
                      },
                    ),
                    GrandIcon(
                      labelButton: 'Análisis Cardiovascular',
                      onPress: () {
                        Operadores.openDialog(
                            context: context,
                            chyldrim: const Cardiovasculares());
                      },
                    ),
                    GrandIcon(
                      iconData: Icons.all_inclusive_rounded,
                      labelButton: 'Análisis Ventilatorio',
                      onPress: () {
                        Operadores.openDialog(
                            context: context, chyldrim: const Ventilatorios());
                      },
                    ),
                    GrandIcon(
                      iconData: Icons.g_mobiledata,
                      labelButton: 'Análisis Gasométrico',
                      onPress: () {
                        Operadores.openDialog(
                            context: context, chyldrim: const Gasometricos());
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

  GridView biometrias() {
    return GridView(
      padding: const EdgeInsets.all(5.0),
      controller: ScrollController(),
      gridDelegate: GridViewTools.gridDelegate(
          crossAxisCount: isMobile(context) ? 4 : 5, mainAxisExtent: 65), //46
      children: [
        ValuePanel(
          firstText: "Hemoglobina",
          secondText: Valores.hemoglobina.toString(),
          thirdText: "g/dL",
          withEditMessage: true,
          onEdit: (value) {
            Operadores.editActivity(
                context: context,
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
        CrossLine(),
        ValuePanel(
          firstText: "Leucocitos",
          secondText: Valores.leucocitosTotales.toString(),
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
    );
  }

  GridView quimicas() {
    return GridView(
      padding: const EdgeInsets.all(5.0),
      controller: ScrollController(),
      gridDelegate: GridViewTools.gridDelegate(
          crossAxisCount: isMobile(context) ? 4 : 5, mainAxisExtent: 65), //46
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
    );
  }

  GridView electrolitos() {
    return GridView(
      padding: const EdgeInsets.all(5.0),
      controller: ScrollController(),
      gridDelegate: GridViewTools.gridDelegate(
          crossAxisCount: isMobile(context) ? 4 : 5, mainAxisExtent: 65), //46
      children: [
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
        CrossLine(),
      ],
    );
  }
}
