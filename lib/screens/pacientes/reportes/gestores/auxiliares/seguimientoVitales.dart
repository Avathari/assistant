import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';

class SeguimientoVitales extends StatefulWidget {
  bool? isTerapia;

  int actualView = 0;

  SeguimientoVitales({super.key, this.isTerapia = false});

  @override
  State<SeguimientoVitales> createState() => _SeguimientoVitalesState();
}

class _SeguimientoVitalesState extends State<SeguimientoVitales> {
  @override
  void initState() {
    setState(() {
      Reportes.reportes['Seguimiento_Vitales'] = ""
          " - SIGNOS VITALES DE INICIO: Tensión arterial sistémica en $tensionArterialSystolicaInicio/$tensionArterialDyastolicaInicio mmHg, "
          "frecuencia cardiaca de $frecuenciaCardiacaInicio L/min, "
          "frecuencia respiratoria de $frecuenciaRespiratoriaInicio L/min, "
          "temperatura corporal ${temperaturCorporalInicio!.toStringAsFixed(1)}°C, "
          "saturación periférica de oxígeno $saturacionPerifericaOxigenoInicio%, "
          "FiO2 $fioInicio%.\n"
          " - SIGNOS VITALES DURANTE LA TRANSFUSIÓN: "
          "Tensión arterial sistémica en $tensionArterialSystolicaDurante/$tensionArterialDyastolicaDurante mmHg, "
          "frecuencia cardiaca de $frecuenciaCardiacaDurante L/min, "
          "frecuencia respiratoria de $frecuenciaRespiratoriaDurante L/min, "
          "temperatura corporal ${temperaturCorporalDurante!.toStringAsFixed(1)}°C, "
          "saturación periférica de oxígeno $saturacionPerifericaOxigenoDurante%, "
          "FiO2 $fioDurante%. \n"
          " - SIGNOS VITALES AL TÉRMINO DE LA TRANSFUSIÓN: "
          "Tensión arterial sistémica en $tensionArterialSystolicaTermino/$tensionArterialDyastolicaTermino mmHg, "
          "frecuencia cardiaca de $frecuenciaCardiacaTermino L/min, "
          "frecuencia respiratoria de $frecuenciaRespiratoriaTermino L/min, "
          "temperatura corporal ${temperaturCorporalTermino!.toStringAsFixed(1)}°C, "
          "saturación periférica de oxígeno $saturacionPerifericaOxigenoTermino%, "
          "FiO2 $fioTermino%.  "
          "";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(
        flex: 1,
        child: TittlePanel(textPanel: 'Signos Vitales en la Transfusión'),
      ),
      Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GrandIcon(
            iconData: Icons.first_page,
            labelButton: "Signos Vitales al Inicio",
            onPress: () {
              setState(() {
                widget.actualView = 0;
              });
            },
          ),
          GrandIcon(
              iconData: Icons.pages_rounded,
              labelButton: "Signos Vitales durante",
              onPress: () {
                setState(() {
                  widget.actualView = 1;
                });
              }),
          GrandIcon(
              iconData: Icons.last_page,
              labelButton: "Signos Vitales al Final",
              onPress: () {
                setState(() {
                  widget.actualView = 2;
                });
              }),
        ],
      )),
      Expanded(
          flex: 4,
          child: Container(
              decoration: ContainerDecoration.roundedDecoration(),
              child: widget.actualView == 0
                  ? seguimientoInicio()
                  : widget.actualView == 1
                      ? seguimientoDurante()
                      : widget.actualView == 2
                          ? seguimientoTermino()
                          : Container())),
    ]);
  }

  Column seguimientoInicio() {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(
        flex: 1,
        child: TittlePanel(textPanel: 'Signos Vitales de Inicio'),
      ),
      Expanded(
        flex: 3,
        child: GridView(
          padding: const EdgeInsets.all(5.0),
          controller: ScrollController(),
          gridDelegate: GridViewTools.gridDelegate(
              crossAxisCount: isMobile(context) ? 4 : 3,
              mainAxisExtent: 65), //46
          children: [
            ValuePanel(
              firstText: "T. Sys",
              secondText: tensionArterialSystolicaInicio.toString(),
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
                        tensionArterialSystolicaInicio = int.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
            ValuePanel(
              firstText: "T. Dyas",
              secondText: tensionArterialDyastolicaInicio.toString(),
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
                        tensionArterialDyastolicaInicio = int.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
            ValuePanel(
              firstText: "F. Card.",
              secondText: frecuenciaCardiacaInicio.toString(),
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
                        frecuenciaCardiacaInicio = int.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
            ValuePanel(
              firstText: "F. Resp.",
              secondText: frecuenciaRespiratoriaInicio.toString(),
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
                        frecuenciaRespiratoriaInicio = int.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
            ValuePanel(
              firstText: "T. C.",
              secondText: temperaturCorporalInicio.toString(),
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
                        temperaturCorporalInicio = double.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
            Container(),
            ValuePanel(
              firstText: "SpO2",
              secondText: saturacionPerifericaOxigenoInicio.toString(),
              thirdText: "%",
              withEditMessage: true,
              onEdit: (value) {
                Operadores.editActivity(
                    context: context,
                    tittle: "Editar . . . ",
                    message: "¿Saturación periférica de oxígeno? . . . ",
                    onAcept: (value) {
                      Terminal.printSuccess(message: "recieve $value");
                      setState(() {
                        saturacionPerifericaOxigenoInicio = int.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
            ValuePanel(
              firstText: "FiO2",
              secondText: fioInicio.toString(),
              thirdText: "%",
              withEditMessage: true,
              onEdit: (value) {
                Operadores.editActivity(
                    context: context,
                    tittle: "Editar . . . ",
                    message: "¿Peso corporal total? . . . ",
                    onAcept: (value) {
                      Terminal.printSuccess(message: "recieve $value");
                      setState(() {
                        fioInicio = int.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
          ],
        ),
      ),
    ]);
  }

  Column seguimientoDurante() {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(
        flex: 1,
        child: TittlePanel(textPanel: 'Signos Vitales de Durante'),
      ),
      Expanded(
        flex: 3,
        child: GridView(
          padding: const EdgeInsets.all(5.0),
          controller: ScrollController(),
          gridDelegate: GridViewTools.gridDelegate(
              crossAxisCount: isMobile(context) ? 4 : 3,
              mainAxisExtent: 65), //46
          children: [
            ValuePanel(
              firstText: "T. Sys",
              secondText: tensionArterialSystolicaDurante.toString(),
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
                        tensionArterialSystolicaDurante = int.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
            ValuePanel(
              firstText: "T. Dyas",
              secondText: tensionArterialDyastolicaDurante.toString(),
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
                        tensionArterialDyastolicaDurante = int.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
            ValuePanel(
              firstText: "F. Card.",
              secondText: frecuenciaCardiacaDurante.toString(),
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
                        frecuenciaCardiacaDurante = int.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
            ValuePanel(
              firstText: "F. Resp.",
              secondText: frecuenciaRespiratoriaDurante.toString(),
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
                        frecuenciaRespiratoriaDurante = int.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
            ValuePanel(
              firstText: "T. C.",
              secondText: temperaturCorporalDurante.toString(),
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
                        temperaturCorporalDurante = double.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
            Container(),
            ValuePanel(
              firstText: "SpO2",
              secondText: saturacionPerifericaOxigenoDurante.toString(),
              thirdText: "%",
              withEditMessage: true,
              onEdit: (value) {
                Operadores.editActivity(
                    context: context,
                    tittle: "Editar . . . ",
                    message: "¿Saturación periférica de oxígeno? . . . ",
                    onAcept: (value) {
                      Terminal.printSuccess(message: "recieve $value");
                      setState(() {
                        saturacionPerifericaOxigenoDurante = int.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
            ValuePanel(
              firstText: "FiO2",
              secondText: fioDurante.toString(),
              thirdText: "%",
              withEditMessage: true,
              onEdit: (value) {
                Operadores.editActivity(
                    context: context,
                    tittle: "Editar . . . ",
                    message: "¿Peso corporal total? . . . ",
                    onAcept: (value) {
                      Terminal.printSuccess(message: "recieve $value");
                      setState(() {
                        fioDurante = int.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
          ],
        ),
      ),
    ]);
  }

  Column seguimientoTermino() {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(
        flex: 1,
        child: TittlePanel(textPanel: 'Signos Vitales de Termino'),
      ),
      Expanded(
        flex: 3,
        child: GridView(
          padding: const EdgeInsets.all(5.0),
          controller: ScrollController(),
          gridDelegate: GridViewTools.gridDelegate(
              crossAxisCount: isMobile(context) ? 4 : 3,
              mainAxisExtent: 65), //46
          children: [
            ValuePanel(
              firstText: "T. Sys",
              secondText: tensionArterialSystolicaTermino.toString(),
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
                        tensionArterialSystolicaTermino = int.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
            ValuePanel(
              firstText: "T. Dyas",
              secondText: tensionArterialDyastolicaTermino.toString(),
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
                        tensionArterialDyastolicaTermino = int.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
            ValuePanel(
              firstText: "F. Card.",
              secondText: frecuenciaCardiacaTermino.toString(),
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
                        frecuenciaCardiacaTermino = int.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
            ValuePanel(
              firstText: "F. Resp.",
              secondText: frecuenciaRespiratoriaTermino.toString(),
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
                        frecuenciaRespiratoriaTermino = int.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
            ValuePanel(
              firstText: "T. C.",
              secondText: temperaturCorporalTermino.toString(),
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
                        temperaturCorporalTermino = double.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
            Container(),
            ValuePanel(
              firstText: "SpO2",
              secondText: saturacionPerifericaOxigenoTermino.toString(),
              thirdText: "%",
              withEditMessage: true,
              onEdit: (value) {
                Operadores.editActivity(
                    context: context,
                    tittle: "Editar . . . ",
                    message: "¿Saturación periférica de oxígeno? . . . ",
                    onAcept: (value) {
                      Terminal.printSuccess(message: "recieve $value");
                      setState(() {
                        saturacionPerifericaOxigenoTermino = int.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
            ValuePanel(
              firstText: "FiO2",
              secondText: fioTermino.toString(),
              thirdText: "%",
              withEditMessage: true,
              onEdit: (value) {
                Operadores.editActivity(
                    context: context,
                    tittle: "Editar . . . ",
                    message: "¿Peso corporal total? . . . ",
                    onAcept: (value) {
                      Terminal.printSuccess(message: "recieve $value");
                      setState(() {
                        fioTermino = int.parse(value);
                        actualizar();
                        Navigator.of(context).pop();
                      });
                    });
              },
            ),
          ],
        ),
      ),
    ]);
  }

  // // Controladores de widgets tipo valores. ************** ************ *****
  void actualizar() {
    setState(() {
      Reportes.reportes['Seguimiento_Vitales'] = ""
          " - SIGNOS VITALES DE INICIO: Tensión arterial sistémica en $tensionArterialSystolicaInicio/$tensionArterialDyastolicaInicio mmHg, "
          "frecuencia cardiaca de $frecuenciaCardiacaInicio L/min, "
          "frecuencia respiratoria de $frecuenciaRespiratoriaInicio L/min, "
          "temperatura corporal ${temperaturCorporalInicio!.toStringAsFixed(1)}°C, "
          "saturación periférica de oxígeno $saturacionPerifericaOxigenoInicio%, "
          "FiO2 $fioInicio%.\n"
          " - SIGNOS VITALES DURANTE LA TRANSFUSIÓN: "
          "Tensión arterial sistémica en $tensionArterialSystolicaDurante/$tensionArterialDyastolicaDurante mmHg, "
          "frecuencia cardiaca de $frecuenciaCardiacaDurante L/min, "
          "frecuencia respiratoria de $frecuenciaRespiratoriaDurante L/min, "
          "temperatura corporal ${temperaturCorporalDurante!.toStringAsFixed(1)}°C, "
          "saturación periférica de oxígeno $saturacionPerifericaOxigenoDurante%, "
          "FiO2 $fioDurante%. \n"
          " - SIGNOS VITALES AL TÉRMINO DE LA TRANSFUSIÓN: "
          "Tensión arterial sistémica en $tensionArterialSystolicaTermino/$tensionArterialDyastolicaTermino mmHg, "
          "frecuencia cardiaca de $frecuenciaCardiacaTermino L/min, "
          "frecuencia respiratoria de $frecuenciaRespiratoriaTermino L/min, "
          "temperatura corporal ${temperaturCorporalTermino!.toStringAsFixed(1)}°C, "
          "saturación periférica de oxígeno $saturacionPerifericaOxigenoTermino%, "
          "FiO2 $fioTermino%. "
          "";
    });
  }
  //
  // void vitalesInicio() {
  //   setState(() {
  //     var valoresInicio = "Signos vitales con "
  //         "tensión arterial sistémica en $tensionArterialSystolicaInicio/$tensionArterialDyastolicaInicio mmHg, "
  //         "frecuencia cardiaca de $frecuenciaCardiacaInicio L/min, "
  //         "frecuencia respiratoria de $frecuenciaRespiratoriaInicio L/min, "
  //         "temperatura corporal ${temperaturCorporalInicio!.toStringAsFixed(1)}°C, "
  //         "saturación periférica de oxígeno $saturacionPerifericaOxigenoInicio%, "
  //         "estatura $fioInicio mts, ";
  //   });
  // }
  //
  // void vitalesDurante() {
  //   setState(() {
  //     var valoresDurante = "Signos vitales con "
  //         "tensión arterial sistémica en $tensionArterialSystolicaDurante/$tensionArterialDyastolicaDurante mmHg, "
  //         "frecuencia cardiaca de $frecuenciaCardiacaDurante L/min, "
  //         "frecuencia respiratoria de $frecuenciaRespiratoriaDurante L/min, "
  //         "temperatura corporal ${temperaturCorporalDurante!.toStringAsFixed(1)}°C, "
  //         "saturación periférica de oxígeno $saturacionPerifericaOxigenoDurante%, "
  //         "estatura $fioDurante mts, ";
  //   });
  // }
  //
  // void vitalesTermino() {
  //   setState(() {
  //     var valoresTermino = "Signos vitales con "
  //         "tensión arterial sistémica en $tensionArterialSystolicaTermino/$tensionArterialDyastolicaTermino mmHg, "
  //         "frecuencia cardiaca de $frecuenciaCardiacaTermino L/min, "
  //         "frecuencia respiratoria de $frecuenciaRespiratoriaTermino L/min, "
  //         "temperatura corporal ${temperaturCorporalTermino!.toStringAsFixed(1)}°C, "
  //         "saturación periférica de oxígeno $saturacionPerifericaOxigenoTermino%, "
  //         "estatura $fioTermino mts, ";
  //   });
  // }

  // // Controladores de widgets tipo valores. ************** ************ *****
  int? tensionArterialDyastolicaInicio = 120,
      tensionArterialSystolicaInicio = 80,
      frecuenciaCardiacaInicio = 75,
      frecuenciaRespiratoriaInicio = 18,
      saturacionPerifericaOxigenoInicio = 98,
      fioInicio = 21;
  double? temperaturCorporalInicio = 36.7;
  //
  int? tensionArterialDyastolicaDurante = 120,
      tensionArterialSystolicaDurante = 80,
      frecuenciaCardiacaDurante = 75,
      frecuenciaRespiratoriaDurante = 18,
      saturacionPerifericaOxigenoDurante = 98,
      fioDurante = 21;
  double? temperaturCorporalDurante = 36.7;
  //
  int? tensionArterialDyastolicaTermino = 120,
      tensionArterialSystolicaTermino = 80,
      frecuenciaCardiacaTermino = 75,
      frecuenciaRespiratoriaTermino = 18,
      saturacionPerifericaOxigenoTermino = 98,
      fioTermino = 21;
  double? temperaturCorporalTermino = 36.7;
//
}
