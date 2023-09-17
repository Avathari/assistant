import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PadecimientoActual extends StatefulWidget {
  const PadecimientoActual({Key? key}) : super(key: key);

  @override
  State<PadecimientoActual> createState() => _PadecimientoActualState();
}

class _PadecimientoActualState extends State<PadecimientoActual> {
  var fechaPadecimientoTextController = TextEditingController();
  var motivoAtencionTextController = TextEditingController();
  var padecimientoActualTextController = TextEditingController();
  var atencionUrgenciasTextController = TextEditingController();

  String tensionArterial = '',
      frecuenciaCardiaca = '',
      frecuenciaRespiratoria = '',
      temperaturaCorporal = '';

  @override
  void initState() {
    Terminal.printNotice(message: "${Repositorios.repositorio['consultPadecimientoQuery']}");
    //
    Actividades.consultarId(
            Databases.siteground_database_reghosp,
            Repositorios.repositorio['consultPadecimientoQuery'],
            Pacientes.ID_Hospitalizacion)
        .then((response) {
      // print("RESPUESTA $response"); **************************************************
      if (response['Error'] == 'Hubo un error') {
        Operadores.alertActivity(
            context: context,
            tittle: 'Error en la Consulta',
            message:
                'ERROR - No se pudo consultar el Padecimiento Actual . . . \n'
                'Creando nuevo padecimiento actual',
            onClose: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            onAcept: () {
              Repositorios.registrarRegistro();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            });

      } else {
        // Terminal.printExpected(message: "PA : : $respuesta");
        setState(() {
          Valores.fechaPadecimientoActual = response['FechaPadecimiento'];
          Valores.padecimientoActual = response['Padecimiento_Actual'];
          // ************************************
          fechaPadecimientoTextController.text =
              response['FechaPadecimiento'] ??
                  Calendarios.today(format: 'yyyy/MM/dd');
          String respuesta = response['Padecimiento_Actual']; // response['Contexto'];
          // Asignación del Padecimiento Actual *******************************************
          padecimientoActualTextController.text =
              respuesta.split('\n')[0] ?? '';
          atencionUrgenciasTextController.text = respuesta.split('\n')[1] ?? '';
        });
      }
    }).onError((error, stackTrace) {
      Valores.fechaPadecimientoActual = Calendarios.today(format: 'yyyy/MM/dd');
      fechaPadecimientoTextController.text =
          Calendarios.today(format: 'yyyy/MM/dd');
      padecimientoActualTextController.text =
          "Inicia padecimiento actual ${fechaPadecimientoTextController.text}";
      Valores.padecimientoActual = "Inicia padecimiento actual ${fechaPadecimientoTextController.text}";
      atencionUrgenciasTextController.text =
          "Es atendido en urgencias reportandose tensión arterial $tensionArterial mmHg, "
          "frecuencia cardiaca $frecuenciaCardiaca Lat/min, frecuencia respiratoria $frecuenciaRespiratoria Resp/min, "
          "temperatura corporal $temperaturaCorporal, ";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: AppBarText('Padecimiento Actual'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.list_outlined,
            ),
            onPressed: () {
              Operadores.notifyActivity(
                  context: context,
                  tittle: 'Padecimiento Actual',
                  message: "${Valores.padecimientoActual}");
            },
          )
        ],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: [
                  // TittlePanel(textPanel: 'Padecimiento Actual'),
                  EditTextArea(
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##', filter: {"#": RegExp(r'[0-9]')}),
                    labelEditText: 'Fecha de Inicio Padecimiento',
                    textController: fechaPadecimientoTextController,
                    iconData: Icons.calendar_today,
                    withShowOption: true,
                    selection: true,
                    onSelected: () {
                      fechaPadecimientoTextController.text =
                          Calendarios.today(format: 'yyyy/MM/dd');
                      padecimientoActualTextController.text =
                          "Inicia padecimiento actual el ${fechaPadecimientoTextController.text}";
                    },
                    numOfLines: 1,
                    onChange: (value) {
                      setState(() {
                        fechaPadecimientoTextController.text = value;
                      });
                    },
                  ),
                  EditTextArea(
                    keyBoardType: TextInputType.multiline,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Motivo de Atención',
                    textController: motivoAtencionTextController,
                    numOfLines: isTablet(context) ? 2 : 1,
                    iconData: Icons.segment,
                    selection: true,
                    withShowOption: true,
                    onSelected: () {
                      Operadores.selectOptionsActivity(
                          context: context,
                          options: ['Disnea', 'Tos', 'Cianosis'],
                          onClose: (value) {
                            motivoAtencionTextController.text =
                                "${motivoAtencionTextController.text}.\n $value";
                            Navigator.pop(context);
                          });
                    },
                    onChange: (value) {
                      setState(() {
                        Valores.padecimientoActual =
                            "${Valores.padecimientoActual}. \n$value";
                      });
                    },
                  ),
                  EditTextArea(
                    keyBoardType: TextInputType.text,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Descripción del Padecimiento Actual',
                    textController: padecimientoActualTextController,
                    numOfLines: isTablet(context) ? 10 : 10,
                    iconData: Icons.segment,
                    selection: true,
                    withShowOption: true,
                    onSelected: () {
                      Operadores.selectOptionsActivity(
                          context: context,
                          options: ['Disnea', 'Tos', 'Cianosis'],
                          onClose: (value) {
                            padecimientoActualTextController.text =
                                "${padecimientoActualTextController.text} $value";
                            Navigator.pop(context);
                          });
                    },
                    onChange: (value) {
                      setState(() {
                        Valores.padecimientoActual = value;
                      });
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ValuePanel(
                          firstText: "T. Sys",
                          secondText: tensionArterial.toString(),
                          thirdText: "mmHg",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                keyBoardType: TextInputType.datetime,
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Tensión sistólica? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    tensionArterial = value;
                                    atencionUrgenciasTextController.text =
                                        "Es atendido en urgencias reportandose tensión arterial $tensionArterial mmHg, ";
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                      ),
                      Expanded(
                        child: ValuePanel(
                          firstText: "F. Card.",
                          secondText: frecuenciaCardiaca.toString(),
                          thirdText: "Lat/min",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                keyBoardType: TextInputType.datetime,
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Frecuencia Cardiaca? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    frecuenciaCardiaca = value;
                                    atencionUrgenciasTextController.text =
                                        "Es atendido en urgencias reportandose tensión arterial $tensionArterial mmHg, "
                                        "frecuencia cardiaca $frecuenciaCardiaca Lat/min, ";
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                      ),
                      Expanded(
                        child: ValuePanel(
                          firstText: "F. Resp.",
                          secondText: frecuenciaRespiratoria.toString(),
                          thirdText: "Resp/min",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                keyBoardType: TextInputType.datetime,
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Frecuencia Respiratoria? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    frecuenciaRespiratoria = value;
                                    atencionUrgenciasTextController.text =
                                        "Es atendido en urgencias reportandose tensión arterial $tensionArterial mmHg, "
                                        "frecuencia cardiaca $frecuenciaCardiaca Lat/min, "
                                        "frecuencia respiratoria $frecuenciaRespiratoria Resp/min, ";
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                      ),
                      Expanded(
                        child: ValuePanel(
                          firstText: "T. Corp.",
                          secondText: temperaturaCorporal.toString(),
                          thirdText: "°C",
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                keyBoardType: TextInputType.datetime,
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Temperatura Corporal? . . . ",
                                onAcept: (value) {
                                  Terminal.printSuccess(
                                      message: "recieve $value");
                                  setState(() {
                                    temperaturaCorporal = value;
                                    atencionUrgenciasTextController.text =
                                        "Es atendido en urgencias reportandose tensión arterial $tensionArterial mmHg, "
                                        "frecuencia cardiaca $frecuenciaCardiaca Lat/min, frecuencia respiratoria $frecuenciaRespiratoria Resp/min, "
                                        "temperatura corporal $temperaturaCorporal, ";
                                    Navigator.of(context).pop();
                                  });
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                  EditTextArea(
                    keyBoardType: TextInputType.text,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Atención en Urgencias',
                    textController: atencionUrgenciasTextController,
                    numOfLines: isTablet(context) ? 10 : 15,
                    onChange: (value) {
                      setState(() {
                        Valores.padecimientoActual =
                            "${Valores.padecimientoActual}. \n$value";
                      });
                    },
                  ),
                  GrandButton(
                      weigth: 1000,
                      labelButton: "Actualizar Padecimiento Actual",
                      onPress: () {
                        Valores.padecimientoActual =
                            "${padecimientoActualTextController.text}. \n${atencionUrgenciasTextController.text}";
                        Future(() =>
                                Repositorios.actualizarPadecimientoRegistro())
                            .whenComplete(() => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        VisualPacientes(actualPage: 0))));
                      }),
                ],
              ),
            ),
          ),
          // Expanded(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       ValuePanel(
          //         firstText: "T. Sys",
          //         secondText: tensionArterial.toString(),
          //         thirdText: "mmHg",
          //         withEditMessage: true,
          //         onEdit: (value) {
          //           Operadores.editActivity(
          //               keyBoardType: TextInputType.datetime,
          //               context: context,
          //               tittle: "Editar . . . ",
          //               message: "¿Tensión sistólica? . . . ",
          //               onAcept: (value) {
          //                 Terminal.printSuccess(message: "recieve $value");
          //                 setState(() {
          //                   tensionArterial = value;
          //                   Navigator.of(context).pop();
          //                 });
          //               });
          //         },
          //       ),
          //       ValuePanel(
          //         firstText: "F. Card.",
          //         secondText: frecuenciaCardiaca.toString(),
          //         thirdText: "Lat/min",
          //         withEditMessage: true,
          //         onEdit: (value) {
          //           Operadores.editActivity(
          //               keyBoardType: TextInputType.datetime,
          //               context: context,
          //               tittle: "Editar . . . ",
          //               message: "¿Frecuencia Cardiaca? . . . ",
          //               onAcept: (value) {
          //                 Terminal.printSuccess(message: "recieve $value");
          //                 setState(() {
          //                   frecuenciaCardiaca = value;
          //                   Navigator.of(context).pop();
          //                 });
          //               });
          //         },
          //       ),
          //       ValuePanel(
          //         firstText: "F. Resp.",
          //         secondText: frecuenciaRespiratoria.toString(),
          //         thirdText: "Resp/min",
          //         withEditMessage: true,
          //         onEdit: (value) {
          //           Operadores.editActivity(
          //               keyBoardType: TextInputType.datetime,
          //               context: context,
          //               tittle: "Editar . . . ",
          //               message: "¿Frecuencia Respiratoria? . . . ",
          //               onAcept: (value) {
          //                 Terminal.printSuccess(message: "recieve $value");
          //                 setState(() {
          //                   frecuenciaRespiratoria = value;
          //                   Navigator.of(context).pop();
          //                 });
          //               });
          //         },
          //       ),
          //       ValuePanel(
          //         firstText: "T. Corp.",
          //         secondText: temperaturaCorporal.toString(),
          //         thirdText: "°C",
          //         withEditMessage: true,
          //         onEdit: (value) {
          //           Operadores.editActivity(
          //               keyBoardType: TextInputType.datetime,
          //               context: context,
          //               tittle: "Editar . . . ",
          //               message: "¿Temperatura Corporal? . . . ",
          //               onAcept: (value) {
          //                 Terminal.printSuccess(message: "recieve $value");
          //                 setState(() {
          //                   temperaturaCorporal = value;
          //                   Navigator.of(context).pop();
          //                 });
          //               });
          //         },
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
