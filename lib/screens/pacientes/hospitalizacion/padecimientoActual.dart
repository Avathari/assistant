import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/screens/pacientes/reportes/reportes.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PadecimientoActual extends StatefulWidget {
  bool? withAppBar;

  PadecimientoActual({super.key, this.withAppBar = true});

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
    fechaPadecimientoTextController.text = Valores.fechaPadecimientoActual ??
        Calendarios.today(format: "yyyy/MM/dd");
    //
    Actividades.consultarId(
            Databases.siteground_database_reghosp,
            Repositorios.repositorio['consultPadecimientoQuery'],
            Pacientes.ID_Hospitalizacion)
        .then((response) {
      Terminal.printWarning(
          message:
              "consultPadecimientoQuery : : ${Repositorios.repositorio['consultPadecimientoQuery']}");
      Terminal.printWarning(message: "response $response");
      //
      Valores.ID_Compendio = Pacientes.ID_Compendio = response['ID_Compendio'];
      // print("RESPUESTA $response"); **************************************************
      if (response['Error'] == 'No se encontraron datos') {
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
              Repositorios.registrarPadecimientoActual(context, Values: [
                Pacientes.ID_Paciente,
                Pacientes.ID_Hospitalizacion,
                Valores.fechaPadecimientoActual ??
                    Calendarios.today(format: 'yyyy/MM/dd'),
                Reportes.padecimientoActual,
                // Valores.servicioTratanteInicial,
                Valores.servicioTratante,
                Calendarios.today(format: 'yyyy/MM/dd'),
                //
                Reportes.impresionesDiagnosticas,
                //
                Reportes.reportes['Subjetivo'],
                Reportes.signosVitales,
                Reportes.exploracionFisica,
                //
                Reportes.auxiliaresDiagnosticos,
                Reportes.analisisComplementarios,
                // Reportes.eventualidadesOcurridas,
                // Reportes.terapiasPrevias,
                Reportes.analisisMedico,
                // Reportes.tratamientoPropuesto,
                Reportes.pronosticoMedico,
                // INDICACIONES MÉDICAS *******************************
                Reportes.dieta.toString(),
                Reportes.hidroterapia.toString(),
                Reportes.insulinoterapia.toString(),
                Reportes.hemoterapia.toString(),
                Reportes.oxigenoterapia.toString(),
                Reportes.medicamentosIndicados.toString(),
                Reportes.medidasGenerales.toString(),
                Reportes.pendientes.toString(),
                Repositorios.tipo_Analisis, // Items.tiposAnalisis[0] //
              ], ValuesEgreso: [
                Pacientes.ID_Paciente,
                Pacientes.ID_Hospitalizacion,
                Valores.fechaPadecimientoActual ??
                    Calendarios.today(format: 'yyyy/MM/dd'),
                Reportes.padecimientoActual,
                // Valores.servicioTratanteInicial,
                Valores.servicioTratante,
                Calendarios.today(format: 'yyyy/MM/dd'),
                Reportes.impresionesDiagnosticas,
                Reportes.reportes['Subjetivo'],
                Reportes.signosVitales,
                Reportes.exploracionFisica,
                //
                Reportes.auxiliaresDiagnosticos,
                Reportes.analisisComplementarios,
                //
                Reportes.analisisMedico,
                Reportes.pronosticoMedico,
                // INDICACIONES MÉDICAS *******************************
                Reportes.dieta.toString(),
                Reportes.hidroterapia.toString(),
                Reportes.insulinoterapia.toString(),
                Reportes.hemoterapia.toString(),
                Reportes.oxigenoterapia.toString(),
                Reportes.medicamentosIndicados.toString(),
                Reportes.medidasGenerales.toString(),
                Reportes.pendientes.toString(),
                Items.tiposAnalisis[3], // Repositorios.tipoAnalisis()
              ])
                  .onError((error, stackTrace) => Operadores.alertActivity(
                      context: context,
                      tittle: "ERROR al Recrear Padecimiento Actual",
                      message: "ERROR - $error : : $stackTrace"))
                  .whenComplete(() {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              });
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
          String respuesta =
              response['Padecimiento_Actual']; // response['Contexto'];
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
      Valores.padecimientoActual =
          "Inicia padecimiento actual ${fechaPadecimientoTextController.text}";
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
      appBar: widget.withAppBar == true
          ? AppBar(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              title: AppBarText('Padecimiento Actual'),
              actions: [
                GrandIcon(
                  iconData: Icons.list_outlined,
                  onPress: () {
                    Datos.portapapeles(
                        context: context,
                        text: "${Valores.padecimientoActual}");
                  },
                ),
                CrossLine(isHorizontal: false, thickness: 2, height: 15),
              ],
            )
          : null,
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ValuePanel(
                    firstText: "ID Hosp ",
                    secondText: Pacientes.ID_Hospitalizacion.toString(),
                  ),
                ),
                Expanded(
                  child: ValuePanel(
                    firstText: "ID Pace ",
                    secondText: Pacientes.ID_Paciente.toString(),
                  ),
                ),
                Expanded(
                  child: ValuePanel(
                    firstText: "Cama ",
                    secondText: Valores.numeroCama.toString(),
                  ),
                ),
                Expanded(
                  child: ValuePanel(
                    firstText: "ID Comp ",
                    secondText: Pacientes.ID_Compendio.toString(),
                  ),
                ),
                CrossLine(isHorizontal: false, thickness: 2, height: 15),
                Expanded(
                    child: GrandIcon(
                        labelButton: "ID del Ingreso",
                        iconData: Pacientes.ID_Compendio != 0
                            ? Icons.panorama_fish_eye
                            : Icons.radio_button_checked,
                        iconColor: Pacientes.ID_Compendio != 0
                            ? Colors.green
                            : Colors.red,
                        onPress: () => Pacientes.ID_Compendio == 0
                            ? Repositorios.registrarPadecimientoActual(context,
                                    Values: [
                                      Pacientes.ID_Paciente,
                                      Pacientes.ID_Hospitalizacion,
                                      Valores.fechaPadecimientoActual ?? Calendarios.today(format: 'yyyy/MM/dd'),
                                      Reportes.padecimientoActual ?? "Sin especificar",
                                      Valores.servicioTratante ?? "No asignado",
                                      Calendarios.today(format: 'yyyy/MM/dd'),
                                      Reportes.impresionesDiagnosticas ?? "Sin diagnóstico",
                                      Reportes.reportes['Subjetivo'] ?? "Sin datos subjetivos",
                                      Reportes.signosVitales ?? "No registrados",
                                      Reportes.exploracionFisica ?? "Sin exploración física",
                                      Reportes.auxiliaresDiagnosticos ?? "No hay auxiliares diagnósticos",
                                      Reportes.analisisComplementarios ?? "No hay análisis complementarios",
                                      Reportes.analisisMedico ?? "Análisis no disponible",
                                      Reportes.pronosticoMedico ?? "Sin pronóstico médico",
                                      Reportes.dieta?.toString() ?? "-",
                                      Reportes.hidroterapia?.toString() ?? "-",
                                      Reportes.insulinoterapia?.toString() ?? "-",
                                      Reportes.hemoterapia?.toString() ?? "-",
                                      Reportes.oxigenoterapia?.toString() ?? "-",
                                      Reportes.medicamentosIndicados?.toString() ?? "-",
                                      Reportes.medidasGenerales?.toString() ?? "-",
                                      Reportes.pendientes?.toString() ?? "-",
                                      Reportes.hitosHospitalarios?.toString() ?? "-",
                                      Repositorios.tipo_Analisis ?? "Análisis sin tipo",
                                    ],
                                    ValuesEgreso: [
                                      Pacientes.ID_Paciente,
                                      Pacientes.ID_Hospitalizacion,
                                      Valores.fechaPadecimientoActual ?? Calendarios.today(format: 'yyyy/MM/dd'),
                                      Reportes.padecimientoActual ?? "Sin especificar",
                                      Valores.servicioTratante ?? "No asignado",
                                      Calendarios.today(format: 'yyyy/MM/dd'),
                                      Reportes.impresionesDiagnosticas ?? "Sin diagnóstico",
                                      Reportes.reportes['Subjetivo'] ?? "Sin datos subjetivos",
                                      Reportes.signosVitales ?? "No registrados",
                                      Reportes.exploracionFisica ?? "Sin exploración física",
                                      Reportes.auxiliaresDiagnosticos ?? "No hay auxiliares diagnósticos",
                                      Reportes.analisisComplementarios ?? "No hay análisis complementarios",
                                      Reportes.analisisMedico ?? "Análisis no disponible",
                                      Reportes.pronosticoMedico ?? "Sin pronóstico médico",
                                      Reportes.dieta?.toString() ?? "-",
                                      Reportes.hidroterapia?.toString() ?? "-",
                                      Reportes.insulinoterapia?.toString() ?? "-",
                                      Reportes.hemoterapia?.toString() ?? "-",
                                      Reportes.oxigenoterapia?.toString() ?? "-",
                                      Reportes.medicamentosIndicados?.toString() ?? "-",
                                      Reportes.medidasGenerales?.toString() ?? "-",
                                      Reportes.pendientes?.toString() ?? "-",
                                      Reportes.hitosHospitalarios?.toString() ?? "-",
                                      Items.tiposAnalisis[3],
                                    ])
                                .onError((error, stackTrace) =>
                                    Operadores.alertActivity(
                                        context: context,
                                        tittle:
                                            "ERROR al Recrear Padecimiento Actual",
                                        message:
                                            "ERROR - $error : : $stackTrace"))
                                .whenComplete(() {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              }).whenComplete(() => setState(() => {}))
                            : Datos.portapapeles(
                                context: context,
                                text: Valores.padecimientoActual!))),
              ],
            ),
            CrossLine(thickness: 2, height: 20),
            // EditTextArea(
            //   labelEditText: 'Fecha de Inicio Padecimiento',
            //   textController: fechaPadecimientoTextController,
            //   keyBoardType: TextInputType.datetime,
            //   inputFormat: MaskTextInputFormatter(
            //       mask: '####/##/##', filter: {"#": RegExp(r'[0-9]')}),
            //   iconData: Icons.calendar_today,
            //   withShowOption: true,
            //   selection: true,
            //   onSelected: () {
            //     Valores.fechaPadecimientoActual =
            //         padecimientoActualTextController.text;
            //     //
            //     fechaPadecimientoTextController.text =
            //         Calendarios.today(format: 'yyyy/MM/dd');
            //     padecimientoActualTextController.text =
            //         "Inicia padecimiento actual el ${fechaPadecimientoTextController.text}";
            //   },
            //   numOfLines: 1,
            //   // onChange: (value) {
            //   //   setState(() {
            //   //     fechaPadecimientoTextController.text = value;
            //   //   });
            //   // },
            // ),
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
                      Reportes.reportes['Padecimiento_Actual'] =
                          "${Valores.padecimientoActual}. \n$value";
                });
              },
            ),
            EditTextArea(
              keyBoardType: TextInputType.text,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Descripción del Padecimiento Actual',
              textController: padecimientoActualTextController,
              limitOfChars: 500,
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
                  Valores.padecimientoActual =
                      Reportes.reportes['Padecimiento_Actual'] = value;
                });
              },
            ),
            CrossLine(height: 25, thickness: 2),
            // Row(
            //   children: [
            //     Expanded(
            //       child: ValuePanel(
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
            //                   atencionUrgenciasTextController.text =
            //                       "Es atendido en urgencias reportandose tensión arterial $tensionArterial mmHg, ";
            //                   Navigator.of(context).pop();
            //                 });
            //               });
            //         },
            //       ),
            //     ),
            //     Expanded(
            //       child: ValuePanel(
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
            //                   atencionUrgenciasTextController.text =
            //                       "Es atendido en urgencias reportandose tensión arterial $tensionArterial mmHg, "
            //                       "frecuencia cardiaca $frecuenciaCardiaca Lat/min, ";
            //                   Navigator.of(context).pop();
            //                 });
            //               });
            //         },
            //       ),
            //     ),
            //     Expanded(
            //       child: ValuePanel(
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
            //                   atencionUrgenciasTextController.text =
            //                       "Es atendido en urgencias reportandose tensión arterial $tensionArterial mmHg, "
            //                       "frecuencia cardiaca $frecuenciaCardiaca Lat/min, "
            //                       "frecuencia respiratoria $frecuenciaRespiratoria Resp/min, ";
            //                   Navigator.of(context).pop();
            //                 });
            //               });
            //         },
            //       ),
            //     ),
            //     Expanded(
            //       child: ValuePanel(
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
            //                   atencionUrgenciasTextController.text =
            //                       "Es atendido en urgencias reportandose tensión arterial $tensionArterial mmHg, "
            //                       "frecuencia cardiaca $frecuenciaCardiaca Lat/min, frecuencia respiratoria $frecuenciaRespiratoria Resp/min, "
            //                       "temperatura corporal $temperaturaCorporal, ";
            //                   Navigator.of(context).pop();
            //                 });
            //               });
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            EditTextArea(
              keyBoardType: TextInputType.text,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Atención en Urgencias',
              textController: atencionUrgenciasTextController,
              limitOfChars: 1500,
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
                  Valores.fechaPadecimientoActual =
                      fechaPadecimientoTextController.text;
                  //
                  Valores.padecimientoActual =
                      "${padecimientoActualTextController.text}. \n${atencionUrgenciasTextController.text}";
                  Future(() => Repositorios.actualizarPadecimientoRegistro())
                      .whenComplete(() => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  widget.withAppBar == true
                                      ? VisualPacientes(actualPage: 0)
                                      : ReportesMedicos())));
                }),
          ],
        ),
      ),
      floatingActionButton: CircleIcon(
        iconed: Icons.content_paste_go,
        onChangeValue: () {
          Operadores.editActivity(
              context: context,
              numOfLines: 30,
              tittle: "Agregar padecimiento actual",
              message: "Registrar padecimiento en un solo parrafo. ",
              keyBoardType: TextInputType.multiline,
              onAcept: (value) {
                if (value.split("\n").length <= 2) {
                  setState(() {
                    padecimientoActualTextController.text =
                        value.split("\n")[0];
                    atencionUrgenciasTextController.text = value.split("\n")[1];
                  });
                } else {
                  setState(() {
                    atencionUrgenciasTextController.text = value;
                  });
                }
                //
                Navigator.of(context).pop();
              });
        },
      ),
    );
  }
}
