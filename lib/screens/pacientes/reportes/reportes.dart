import 'package:assistant/conexiones/actividades/pdfGenerete/PdfApi.dart';
import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';

import 'package:assistant/screens/pacientes/auxiliares/presentaciones/presentaciones.dart';
import 'package:assistant/screens/pacientes/auxiliares/revisiones/revisiones.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/padecimientoActual.dart';
import 'package:assistant/screens/pacientes/intensiva/contenidos/concentraciones.dart';
import 'package:assistant/screens/pacientes/intensiva/procedimientos/cateterTenckhoff.dart';
import 'package:assistant/screens/pacientes/intensiva/procedimientos/cateterVenosoCentral.dart';
import 'package:assistant/screens/pacientes/intensiva/procedimientos/intubacionEndotraqueal.dart';
import 'package:assistant/screens/pacientes/intensiva/procedimientos/sondaEndopleural.dart';
import 'package:assistant/screens/pacientes/intensiva/valoraciones/aereos.dart';
import 'package:assistant/screens/pacientes/intensiva/valoraciones/prequirurgicos.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/auxiliaresReportes.dart';
import 'package:assistant/conexiones/actividades/pdfGenerete/pdfGenereteFormats/formatosReportes.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/indicaciones.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/semiologicos.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/terapias.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reporteConsulta.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reporteEvolucion.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reporteIngreso.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reportePrequirurgico.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reporteTerapia.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reporteTransfusion.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CircleLabel.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/ListValue.dart';
import 'package:flutter/material.dart';

class ReportesMedicos extends StatefulWidget {
  int actualPage = 6;

  ReportesMedicos({super.key});

  @override
  State<ReportesMedicos> createState() => _ReportesMedicosState();
}

class _ReportesMedicosState extends State<ReportesMedicos> {
  @override
  void initState() {
    // Llamado a los ultimos registros agregados. ****************************
    setState(() {
      Diagnosticos.registros();
      Quirurgicos.consultarRegistro();
      //Pendientes.consultarRegistro();
      Balances.consultarRegistro();
      // Patologicos del Paciente *************************************
      Archivos.readJsonToMap(
              filePath: "${Pacientes.localRepositoryPath}patologicos.json")
          .then((value) {
        Pacientes.Patologicos = value;
      }).whenComplete(() =>
              Reportes.reportes["Antecedentes_Patologicos_Ingreso"] =
                  Pacientes.antecedentesIngresosPatologicos());
// Patologicos del Paciente *************************************
      Archivos.readJsonToMap(
              filePath: "${Pacientes.localRepositoryPath}patologicos.json")
          .then((value) {
        Pacientes.Patologicos = value;
      }).whenComplete(() =>
              Reportes.reportes["Antecedentes_Patologicos_Ingreso"] =
                  Pacientes.antecedentesIngresosPatologicos());
// Vitales del Paciente ****************************************
      Archivos.readJsonToMap(
              filePath: "${Pacientes.localRepositoryPath}vitales.json")
          .then((value) {
        Pacientes.Vitales = value;
      });
      Archivos.readJsonToMap(
              filePath: "${Pacientes.localRepositoryPath}diagnosticos.json")
          .then((value) {
        Pacientes.Diagnosticos = value;
      });

      Archivos.readJsonToMap(
              filePath: "${Pacientes.localRepositoryPath}ventilaciones.json")
          .then((value) {
        Pacientes.Ventilaciones = value;
      });

      Archivos.readJsonToMap(
              filePath: "${Pacientes.localRepositoryPath}alergicos.json")
          .then((value) {
        Pacientes.Alergicos = value;
      });

      // Archivos.readJsonToMap(
      //     filePath: "${Pacientes.localRepositoryPath}balances.json")
      //     .then((value) {
      //   Pacientes.Balances = value;
      //   Terminal.printExpected(message: "Balances seleccionados ${value[0].last}");
      //   Balances.fromJson(value.last);
      // });
// *********************************************
      if (Pacientes.ID_Hospitalizacion != 0) {
        // Repositorios.consultarRegistro();
        Archivos.readJsonToMap(
                filePath:
                    "${Pacientes.localRepositoryPath}/reportes/reportes.json")
            .then((value) {
          Pacientes.Notas = value;
          // VALUE almacenado en Json : : "${Pacientes.localRepositoryPath}/reportes/reportes.json"
          Terminal.printSuccess(
              message: "VALUE - ${value.last} "
                  ": ${value.runtimeType} "
                  ": : ${value.last.runtimeType}");
          // Actualizar . . .
          setState(() {
            // Del Padecimiento **************************************************
            Reportes.padecimientoActual =
                value.last['Padecimiento_Actual'] ?? '';
            Valores.fechaPadecimientoActual =
                value.last['Fecha_Padecimiento'] ?? '';
            // Primeras Variables **************************************************
            Reportes.exploracionFisica = value.last['Exploracion_Fisica'] ?? '';
            Reportes.signosVitales = value.last['Signos_Vitales'] ?? '';
            // Segundas Variables **************************************************
            Reportes.eventualidadesOcurridas =
                value.last['Eventualidades'] ?? '';
            Reportes.terapiasPrevias = value.last['Terapias_Previas'] ?? '';
            Reportes.analisisMedico = value.last['Analisis_Medico'] ?? '';
            Reportes.tratamientoPropuesto =
                value.last['Tratamiento_Propuesto'] ?? '';
            // Listados desde String  ************************************************
            // Reportes.dieta = ;

            // String aux = "";
            // aux.replaceAll(", ", ",");
            // print(""
            //     // "Opción A - ${jsonDecode(value.last['Dietoterapia'])} - ${jsonDecode(value.last['Dietoterapia']).runtimeType}"
            //     //"Opcion B - ${json.decode(value.last['Medidas_Generales']).cast<List<dynamic>>()}"
            //     "Opcion C - ${Listas.listFromString(value.last['Medidas_Generales'].replaceAll(", ", ","))} : ${value.last['Medidas_Generales'].runtimeType}");

            // Reportes.dieta = json
            //     .decode(value.last['Dietoterapia'].toString())
            //     .cast<String>();
            //     .toList();
            // Reportes.hidroterapia = json
            //     .decode(value.last['Hidroterapia'].toString())
            //     .cast<String>()
            //     .toList();
            // Reportes.insulinoterapia = json
            //     .decode(value.last['Insulinoterapia'].toString())
            //     .cast<String>()
            //     .toList();
            // Reportes.hemoterapia = json
            //     .decode(value.last['Hemoterapia'].toString())
            //     .cast<String>()
            //     .toList();
            // Reportes.oxigenoterapia = json
            //     .decode(value.last['Oxigenoterapia'].toString())
            //     .cast<String>()
            //     .toList();
            // Reportes.medicamentosIndicados = json
            //     .decode(value.last['Medicamentos'].toString())
            //     .cast<String>()
            //     .toList();
            // Reportes.medidasGenerales = json
            //     .decode(value.last['Medidas_Generales'].toString())
            //     .cast<String>()
            //     .toList();
            // Reportes.pendientes = json
            //     .decode(value.last['Pendientes'].toString())
            //     .cast<String>()
            //     .toList();
            // Crear Json desde Pacientes.Notas ***************************************
          });
        }).onError((error, stackTrace) {
          Terminal.printAlert(
              message: "ERROR - No fue posible acceder a "
                  "${"${Pacientes.localRepositoryPath}/reportes/reportes.json"} : $error : : $stackTrace");
// Consultar Base de Datos : pace_hosp_repo : : Donde están todos los Análisis descritos
          Repositorios.consultarAnalisis();
        });
      }
      // Paraclinicos del Paciente *************************************
      Archivos.readJsonToMap(
              filePath: "${Pacientes.localRepositoryPath}/paraclinicos.json")
          .then((value) {
        Pacientes.Paraclinicos = value;
      });

      // Valores del Paciente ****************************************
      Archivos.readJsonToMap(filePath: Pacientes.localPath).then((value) {
        Valores.fromJson(value[0]);
      }).onError((error, stackTrace) {
        Terminal.printAlert(
            message: "ERROR al Abrir ${Pacientes.localPath}"
                " - $error : : $stackTrace");
        Operadores.alertActivity(
            context: context,
            tittle: "Error al Abrir ${Pacientes.localPath}",
            message: " ERROR - $error : : $stackTrace\n"
                "Reiniciando Loading Activity . . . ");
        Pacientes.loadingActivity(context: context);
      });

      Terminal.printExpected(
          message: "Analisis Previos : : ${Reportes.analisisAnteriores}");
    });
    // # # # ############## #### ######## #### ########
    super.initState();
  }

// ******************************************************
  @override
  Widget build(BuildContext context) {
    print(
        "MediaQuery.of(context).size.width  ${MediaQuery.of(context).size.width}");
    return Scaffold(
      appBar: //isMobile(context)
          AppBar(
              backgroundColor: Theming.primaryColor,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                tooltip: Sentences.regresar,
                onPressed: () {
                  onClose(context);
                },
              ),
              title: isMobile(context)
                  ? null
                  : AppBarText(
                      Sentences.app_bar_reportes,
                    ),
              actions: <Widget>[
            IconButton(
              icon: const Icon(
                color: Colors.white,
                Icons.balance,
              ),
              tooltip: 'Concentraciones y Diluciones',
              onPressed: () async {
                setState(() {
                  widget.actualPage = 21;
                });
              },
            ),
            IconButton(
              icon: const Icon(
                color: Colors.white,
                Icons.remove_from_queue,
              ),
              tooltip: 'Refrescar . . . ',
              onPressed: () async {
                setState(() {});
              },
            ),
            IconButton(
              icon: const Icon(
                color: Colors.white,
                Icons.system_update_alt,
              ),
              tooltip: 'Cargando . . . ',
              onPressed: () async {
                Pacientes.loadingActivity(context: context).then((value) {
                  if (value == true) {
                    Terminal.printAlert(
                        message:
                            'Archivo ${Pacientes.localPath} Re-Creado $value');
                    Navigator.of(context).pop();
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.help,
                color: Colors.white,
              ),
              tooltip: Sentences.find_usuario,
              onPressed: () {
                //
                setState(() {
                  widget.actualPage = 19;
                });
              },
            ),
            CrossLine(isHorizontal: false, thickness: 4),
            IconButton(
              icon: const Icon(
                Icons.copy_all_sharp,
                color: Colors.white,
              ),
              tooltip: 'Copiar Esquema del Reporte',
              onPressed: () {
                //
                Datos.portapapeles(
                    context: context,
                    text: Reportes.copiarReporte(tipoReporte: getTypeReport()));
              },
            ),
          ]), //: null,
      floatingActionButton: isMobile(context) || isTablet(context)
          ? Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              FloatingActionButton(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.grey,
                tooltip: 'Indicaciones Médicas',
                onPressed: () {
                  //...
                  setState(() {
                    widget.actualPage = 9;
                  });
                },
                heroTag: null,
                child: const Icon(
                  Icons.line_weight,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              FloatingActionButton(
                backgroundColor: Colors.black87,
                foregroundColor: Colors.grey,
                tooltip: 'Vista Previa',
                onPressed: () async {
                  await imprimirDocumento()
                      .then((value) => Operadores.alertActivity(
                          context: context,
                          tittle: 'Petición de Registro de Análisis',
                          message:
                              '¿Desea registrar el análisis en la base de datos?',
                          onClose: () {
                            Navigator.of(context).pop();
                          },
                          onAcept: () {
                            Navigator.of(context).pop();
                            Repositorios.registrarRegistro();
                          }))
                      .onError((error, stackTrace) => Terminal.printAlert(
                          message: "ERROR - $error : : $stackTrace"));
                },
                heroTag: null,
                child: const Icon(
                  Icons.scale,
                  color: Colors.grey,
                ),
              )
            ])
          : Container(),
      body:
          isMobile(context) || isTablet(context) ? mobileView() : desktopView(),
    );
  }

  void onClose(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => VisualPacientes(
              actualPage: 0,
            )));
  }

  // ******************************************************
  Column mobileView() {
    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colores.backgroundPanel,
                borderRadius: BorderRadius.circular(20)),
            child: sideLeft(),
          ),
        )),
        Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.all(7.0),
              decoration: ContainerDecoration.roundedDecoration(
                  colorBackground: Colores.backgroundPanel),
              child: pantallasReportesMedicos(widget.actualPage),
            )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(
              right: 82.0, left: 8.0, top: 8.0, bottom: 8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colores.backgroundPanel,
                borderRadius: BorderRadius.circular(20)),
            child: sideRight(),
          ),
        )),
      ],
    );
  }

  Row desktopView() {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              decoration: ContainerDecoration.containerDecoration(),
              child: sideLeft(),
            )),
        Expanded(
            flex: 8,
            child: Container(
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.all(8.0),
              decoration: ContainerDecoration.containerDecoration(),
              child: pantallasReportesMedicos(widget.actualPage),
            )),
        Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              decoration: ContainerDecoration.containerDecoration(),
              child: sideRight(),
            )),
      ],
    );
  }

  // ******************************************************
  Widget sideLeft() {
    if (isMobile(context) || isTablet(context)) {
      return Expanded(
        child: Row(
          children: [
            isTablet(context)
                ? const Expanded(flex: 3, child: PresentacionPacientesSimple())
                : Container(),
            Expanded(
              flex: isTablet(context) ? 7 : 2,
              child: isMobile(context)
                  ? Row(
                      children: [
                        isMobile(context)
                            ? Expanded(
                                child: Container(
                                  height: isMobile(context) ? 100 : 0,
                                  margin: const EdgeInsets.all(8.0),
                                  decoration:
                                      ContainerDecoration.roundedDecoration(
                                          radius: 50),
                                  child: GrandIcon(
                                    iconData: Icons.account_balance_sharp,
                                    labelButton: "Tipo de Nota Médica",
                                    onPress: () {
                                      Cambios.toNextActivity(context,
                                          tittle: 'Revisión de Valores',
                                          chyld: Revisiones(withTitle: false));
                                      // setState(() {
                                      //   widget.actualPage = 19;
                                      // });
                                    },
                                  ),
                                ),
                                //     child: Container(
                                //   decoration: ContainerDecoration.roundedDecoration(),
                                //   child: TittlePanel(
                                //       padding: isTablet(context) ? 4 : 2,
                                //       textPanel: "Tipo de Nota Médica"),
                                // ),
                              )
                            : Expanded(
                                child: GrandButton(
                                  weigth: 2000,
                                  fontSize: 10.0,
                                  labelButton: "Tipo de Nota Médica",
                                  onPress: () {
                                    setState(() {
                                      widget.actualPage = 19;
                                    });
                                  },
                                ),
                                //     child: Container(
                                //   decoration: ContainerDecoration.roundedDecoration(),
                                //   child: TittlePanel(
                                //       padding: isTablet(context) ? 4 : 2,
                                //       textPanel: "Tipo de Nota Médica"),
                                // ),
                              ),
                        Expanded(
                            flex: 2,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              controller: ScrollController(),
                              child: Column(
                                children: tiposReportes(),
                              ),
                            )),
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: GrandButton(
                            weigth: 2000,
                            labelButton: "Tipo de Nota Médica",
                            onPress: () {
                              setState(() {
                                widget.actualPage = 19;
                              });
                            },
                          ),
                          //     child: Container(
                          //   decoration: ContainerDecoration.roundedDecoration(),
                          //   child: TittlePanel(
                          //       padding: isTablet(context) ? 4 : 2,
                          //       textPanel: "Tipo de Nota Médica"),
                          // ),
                        ),
                        Expanded(
                            flex: isTablet(context) ? 2 : 1,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              controller: ScrollController(),
                              child: Column(
                                children: tiposReportes(),
                              ),
                            )),
                      ],
                    ),
            ),
          ],
        ),
      );
    } else {
      return Column(
        children: [
          isMobile(context) || isTablet(context)
              ? const PresentacionPacientesSimple()
              : isTabletAndDesktop(context)
                  ? const PresentacionPacientesSimple()
                  : isDesktop(context)
                      ? const PresentacionPacientesSimple()
                      : isLargeDesktop(context)
                          ? const PresentacionPacientes()
                          : Container(),
          CrossLine(),
          GrandButton(
              weigth: 2000,
              labelButton: "Tipo de Nota Médica",
              onPress: () {
                setState(() {
                  widget.actualPage = 20;
                });
              }),
          CrossLine(),
          // TittlePanel(textPanel: "Tipo de Nota Médica"),
          Expanded(
              flex: 8,
              child: ListView(
                padding: const EdgeInsets.all(12.0),
                controller: ScrollController(),
                children: tiposReportes(),
              )),
          Expanded(child: CrossLine()),
          // ListValue(
          //   title: "",
          //   onPress: () {},
          // ),
        ],
      );
    }
  }

  Widget sideRight() {
    if (isMobile(context) || isTablet(context)) {
      return Expanded(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
        child: Row(
          children: [
            Expanded(
              flex: isMobile(context) ? 2 : 6,
              child: SingleChildScrollView(
                  controller: ScrollController(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: actionsReportes(),
                  )),
            ),
            // Expanded(child: Container(color: Colors.black,decoration: ContainerDecoration.roundedDecoration(),child: Container,))
            // Expanded(
            //   child: Column(
            //     children: [
            //       Expanded(
            //         child: GrandButton(
            //             weigth: 200,
            //             labelButton: "Indicaciones Médicas",
            //             onPress: () {
            //               setState(() {
            //                 widget.actualPage = 9;
            //               });
            //             }),
            //       ),
            //       Expanded(
            //         child: GrandButton(
            //             weigth: 200,
            //             labelButton: "Vista previa",
            //             onPress: () async {
            //               await imprimirDocumento();
            //             }),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ));
    } else {
      return Column(
        children: [
          SizedBox(
            height: 80,
            child: CircleIcon(
              tittle: "Prescripciones",
              iconed: Icons.line_weight_sharp,
              onChangeValue: () {
                setState(() {
                  widget.actualPage = 9;
                });
              },
            ),
          ),
          SizedBox(
            height: 20,
            child: CrossLine(),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: actionsReportes(),
              ),
            ),
          ),
          SizedBox(
            height: 20,
            child: CrossLine(),
          ),
          if (isLargeDesktop(context)) Expanded(
            child: GrandButton(
                labelButton: "Vista previa",
                onPress: () async {
                  await imprimirDocumento()
                      .then((value) => Operadores.alertActivity(
                      context: context,
                      tittle: 'Petición de Registro de Análisis',
                      message:
                      '¿Desea registrar el análisis en la base de datos?',
                      onClose: () {
                        Navigator.of(context).pop();
                      },
                      onAcept: () {
                        Navigator.of(context).pop();
                        Repositorios.registrarRegistro();
                      }))
                      .onError((error, stackTrace) => Terminal.printAlert(
                      message: "ERROR - $error : : $stackTrace"));
                }),
          ),
          if (isDesktop(context)) SizedBox(
            height: 80,
            child: CircleIcon(
              tittle: "Vista Previa . . . ",
              radios: 30,
              iconed: Icons.signal_wifi_statusbar_null_sharp,
              onChangeValue: () async {
                await imprimirDocumento()
                    .then((value) => Operadores.alertActivity(
                    context: context,
                    tittle: 'Petición de Registro de Análisis',
                    message:
                    '¿Desea registrar el análisis en la base de datos?',
                    onClose: () {
                      Navigator.of(context).pop();
                    },
                    onAcept: () {
                      Navigator.of(context).pop();
                      Repositorios.registrarRegistro();
                    }))
                    .onError((error, stackTrace) => Terminal.printAlert(
                    message: "ERROR - $error : : $stackTrace"));
              },
            ),
          ),
        ],
      );
    }
  }

  Future<void> imprimirDocumento() async {
    Contextos.contexto = context;
    // final pdfFile = await PdfApi.generateCenterText("Prueba");
    final pdfFile = await PdfParagraphsApi.generate(
        withIndicationReport: false,
        indexOfTypeReport: getTypeReport(),
        paraph: Reportes.reportes,
        name: Reportes.nombreReporte(indefOfReport: widget.actualPage));
    final pdfFileTwo = await PdfParagraphsApi.generate(
        withIndicationReport: true,
        indexOfTypeReport: TypeReportes.indicacionesHospitalarias,
        paraph: Reportes.reportes,
        name:
            "(IH) - ${Pacientes.nombreCompleto} - (${Calendarios.today()}).pdf");

    // Crear JSON local de Reportes
    if (Pacientes.Notas!.isNotEmpty) {
      if (Pacientes.Notas!.last['Fecha_Realizacion'] !=
          Calendarios.today(format: 'yyyy/MM/dd')) {
        Pacientes.Notas!.add({
          'ID_Pace': Pacientes.ID_Paciente,
          'ID_Hosp': Pacientes.ID_Hospitalizacion,
          'Fecha_Padecimiento': Valores.fechaPadecimientoActual,
          'Padecimiento_Actual': Reportes.padecimientoActual,
          "Servicio_Inicial": Valores.servicioTratanteInicial,
          "Servicio_Medico": Valores.servicioTratante,
          'Fecha_Realizacion': Calendarios.today(format: 'yyyy/MM/dd'),
          'Subjetivo': Reportes.reportes['Subjetivo'],
          "Signos_Vitales": Reportes.signosVitales,
          "Exploracion_Fisica": Reportes.exploracionFisica,
          "Eventualidades": Reportes.eventualidadesOcurridas,
          "Terapias_Previas": Reportes.terapiasPrevias,
          "Analisis_Medico": Reportes.analisisMedico,
          "Tratamiento_Propuesto": Reportes.tratamientoPropuesto,
          // INDICACIONES MÉDICAS *******************************
          "Dieta": Reportes.dieta.toString(),
          "Hidroterapia": Reportes.hidroterapia,
          "Insulinoterapia": Reportes.insulinoterapia,
          "Hemoterapia": Reportes.hemoterapia,
          "Oxigenoterapia": Reportes.oxigenoterapia,
          "Medicamentos": Reportes.medicamentosIndicados,
          "Medidas_Generales": Reportes.medidasGenerales,
          "Pendientes": Reportes.pendientes, // ['Sin pendientes'],
        });
      } else {
        var index = Pacientes.Notas!.indexWhere((v) =>
            v['Fecha_Realizacion'] == Calendarios.today(format: 'yyyy/MM/dd'));
        Terminal.printAlert(message: "index $index");

        Pacientes.Notas![index] = {
          'ID_Pace': Pacientes.ID_Paciente,
          'ID_Hosp': Pacientes.ID_Hospitalizacion,
          'Fecha_Padecimiento': Valores.fechaPadecimientoActual,
          'Padecimiento_Actual': Reportes.padecimientoActual,
          "Servicio_Inicial": Valores.servicioTratanteInicial,
          "Servicio_Medico": Valores.servicioTratante,
          'Fecha_Realizacion': Calendarios.today(format: 'yyyy/MM/dd'),
          'Subjetivo': Reportes.reportes['Subjetivo'],
          "Signos_Vitales": Reportes.signosVitales,
          "Exploracion_Fisica": Reportes.exploracionFisica,
          "Eventualidades": Reportes.eventualidadesOcurridas,
          "Terapias_Previas": Reportes.terapiasPrevias,
          "Analisis_Medico": Reportes.analisisMedico,
          "Tratamiento_Propuesto": Reportes.tratamientoPropuesto,
          // INDICACIONES MÉDICAS *******************************
          "Dieta": Reportes.dieta.toString(),
          "Hidroterapia": Reportes.hidroterapia,
          "Insulinoterapia": Reportes.insulinoterapia,
          "Hemoterapia": Reportes.hemoterapia,
          "Oxigenoterapia": Reportes.oxigenoterapia,
          "Medicamentos": Reportes.medicamentosIndicados,
          "Medidas_Generales": Reportes.medidasGenerales,
          "Pendientes": Reportes.pendientes, // ['Sin pendientes'],
        };
      }
    } else if (Pacientes.Notas!.isEmpty) {
      Pacientes.Notas!.add({
        'ID_Pace': Pacientes.ID_Paciente,
        'ID_Hosp': Pacientes.ID_Hospitalizacion,
        'Fecha_Padecimiento': Valores.fechaPadecimientoActual,
        'Padecimiento_Actual': Reportes.padecimientoActual,
        "Servicio_Inicial": Valores.servicioTratanteInicial,
        "Servicio_Medico": Valores.servicioTratante,
        'Fecha_Realizacion': Calendarios.today(format: 'yyyy/MM/dd'),
        'Subjetivo': Reportes.reportes['Subjetivo'],
        "Signos_Vitales": Reportes.signosVitales,
        "Exploracion_Fisica": Reportes.exploracionFisica,
        "Eventualidades": Reportes.eventualidadesOcurridas,
        "Terapias_Previas": Reportes.terapiasPrevias,
        "Analisis_Medico": Reportes.analisisMedico,
        "Tratamiento_Propuesto": Reportes.tratamientoPropuesto,
        // INDICACIONES MÉDICAS *******************************
        "Dieta": Reportes.dieta.toString(),
        "Hidroterapia": Reportes.hidroterapia,
        "Insulinoterapia": Reportes.insulinoterapia,
        "Hemoterapia": Reportes.hemoterapia,
        "Oxigenoterapia": Reportes.oxigenoterapia,
        "Medicamentos": Reportes.medicamentosIndicados,
        "Medidas_Generales": Reportes.medidasGenerales,
        "Pendientes": Reportes.pendientes, // ['Sin pendientes'],
      });
    }

    // Repositorios.tipo_Analisis = Repositorios.tipoAnalisis(widgetPage: widget.actualPage);
    // ignore: use_build_context_synchronously
    Operadores.listOptionsActivity(
        context: context,
        tittle: 'Seleccione un reporte . . . ',
        options: [
          ["Nota Médica", pdfFile.path, Calendarios.today()],
          ["Indicaciones Médicas", pdfFileTwo.path, Calendarios.today()],
        ],
        onClose: () {
          Navigator.of(context).pop();
        });
    // PdfApi.openFile(pdfFile);
    // PdfApi.openFile(pdfFileTwo);
  }

  TypeReportes getTypeReport() {
    switch (widget.actualPage) {
      case 0:
        Repositorios.tipo_Analisis = Items.tiposAnalisis[0];
        return TypeReportes.reporteIngreso;
      case 1:
        Repositorios.tipo_Analisis = Items.tiposAnalisis[1];
        return TypeReportes
            .reporteEvolucion; // return TypeReportes.reporteIngreso;
      case 2:
        return TypeReportes.reporteConsulta;
      case 3:
        // Repositorios.tipo_Analisis = Items.tiposAnalisis[1];
        return TypeReportes.reporteTerapiaIntensiva;
      case 4:
        return TypeReportes.reportePrequirurgica;
      case 5:
        return TypeReportes.reportePreanestesica;
      case 6:
        Repositorios.tipo_Analisis = Items.tiposAnalisis[4];
        return TypeReportes.reporteEgreso;
      case 7:
        Repositorios.tipo_Analisis = Items.tiposAnalisis[3];
        return TypeReportes.reporteRevision;
      case 8:
        return TypeReportes.reporteTraslado;
      case 9:
        return TypeReportes.reportePreanestesica;
      case 10:
        return TypeReportes.reportePreanestesica;
      case 11:
        return TypeReportes.reportePreanestesica;
      case 12:
        return TypeReportes.procedimientoCVC;
      case 13:
        return TypeReportes.procedimientoIntubacion;
      case 14:
        return TypeReportes.procedimientoSondaEndopleural;
      case 15:
        return TypeReportes.procedimientoTenckoff;
      case 16:
        return TypeReportes.procedimientoLumbar; // 16 : Punción Lumbar
      case 17:
        return TypeReportes.reporteTransfusion; // 17 : Transfusión
      default:
        return TypeReportes.reporteIngreso;
    }
  }

  Widget pantallasReportesMedicos(int actualPage) {
    List<Widget> list = [
      const ReporteIngreso(), // 0 : Reporte de
      const ReporteEvolucion(), // 1 : Reporte de
      const ReporteConsulta(), // 2 : Reporte de
      const ReporteTerapia(), // 3 : Reporte de Reporte tipado
      const ReportePrequirurgico(), // 4 : Reporte de
      Container(), // 5 : Reporte de Preanestésico
      Container(), // 6 : Reporte de Egreso
      Container(), // 7 : Reporte de Revisión
      Container(), // 8 : Reporte de Traslado
      Pacientes.esHospitalizado == true
          ? const IndicacionesHospital()
          : const IndicacionesConsulta(), // Container(),
      const Prequirurgicos(), // 10 :
      const Aereas(), // 11 :
      const CateterVenosoCentral(), // 12 :
      const IntubacionEndotraqueal(), // 13 :
      const SondaEndopleural(), // 14 :
      const CateterTenckhoff(), // 15 :
      Container(), // 16 : Punción Lumbar
      const ReporteTransfusion(), // 17 : Reporte de Transfusión
      TerapiasItems(
        esCorto: true,
      ), // 18: Evaluación de Terapia
      Revisiones(), // 19 : Revisión
      const Semiologicos(), // 20 : Revisión
      const Concentraciones(), // 21 : Concentraciones
    ];

    return list[actualPage];
  }

  List<Widget> tiposReportes() {
    return [
      ListValue(
        title: "Nota de Ingreso Hospitalario",
        onPress: () {
          setState(() {
            widget.actualPage = 0;
          });
        },
      ),
      ListValue(
        title: "Nota de Evolución",
        onPress: () {
          setState(() {
            widget.actualPage = 1;
          });
        },
      ),
      ListValue(
        title: "Nota de Consulta",
        onPress: () {
          Licencias.consultarRegistro();
          setState(() {
            widget.actualPage = 2;
          });
        },
      ),
      ListValue(
        title: "Nota de Terapia Intensiva",
        onPress: () {
          setState(() {
            widget.actualPage = 3;
          });
        },
      ),
      ListValue(
        title: "Nota de Valoración Prequirúrgica",
        onPress: () {
          setState(() {
            widget.actualPage = 4;
          });
        },
      ),
      ListValue(
        title: "Nota de Valoración Preanestésica",
        onPress: () {
          setState(() {
            widget.actualPage = 5;
          });
        },
      ),
      ListValue(
        title: "Nota de Egreso",
        onPress: () {
          setState(() {
            widget.actualPage = 6;
          });
        },
      ),
      ListValue(
        title: "Nota de Revisión",
        onPress: () {
          setState(() {
            widget.actualPage = 7;
          });
        },
      ),
      ListValue(
        title: "Nota de Traslado",
        onPress: () {
          setState(() {
            widget.actualPage = 8;
          });
        },
      ),
      ListValue(
        title: "Nota de Transfusión",
        onPress: () {
          setState(() {
            widget.actualPage = 17;
          });
        },
      ),
    ];
  }

  List<Widget> actionsReportes() {
    return [
      GrandIcon(
          iconData: Icons.medical_information_outlined,
          weigth: 2000,
          labelButton: "Padecimiento Actual",
          onPress: () {
            Operadores.openDialog(
                context: context, chyldrim: const PadecimientoActual());
          }),
      GrandIcon(
          iconData: Icons.subtitles_rounded,
          weigth: 2000,
          labelButton: "Valoración Prequirúrgica",
          onPress: () {
            setState(() {
              widget.actualPage = 10;
            });
          }),
      GrandIcon(
          iconData: Icons.medication_outlined,
          weigth: 2000,
          labelButton: "Valoración de Terapia",
          onPress: () {
            setState(() {
              widget.actualPage = 18;
            });
          }),
      GrandIcon(
          iconData: Icons.bedroom_child_outlined,
          weigth: 2000,
          labelButton: "Valoración de la Vía Aerea",
          onPress: () {
            setState(() {
              widget.actualPage = 11;
            });
          }),
      CrossLine(),
      GrandIcon(
          iconData: Icons.vaccines,
          weigth: 2000,
          labelButton: "Catéter Venoso Central",
          onPress: () {
            setState(() {
              widget.actualPage = 12;
            });
          }),
      GrandIcon(
          weigth: 2000,
          labelButton: "Intubación Endotraqueal",
          onPress: () {
            setState(() {
              widget.actualPage = 13;
            });
          }),
      GrandIcon(
          weigth: 2000,
          labelButton: "Sonda Endopleural",
          onPress: () {
            setState(() {
              widget.actualPage = 14;
            });
          }),
      GrandIcon(
          weigth: 2000,
          labelButton: "Catéter Tenckhoff",
          onPress: () {
            setState(() {
              widget.actualPage = 15;
            });
          }),
      GrandIcon(
          weigth: 2000,
          labelButton: "Punción Lumbar",
          onPress: () {
            setState(() {
              widget.actualPage = 16;
            });
          }),
      CrossLine(),
      GrandIcon(
          iconData: Icons.local_police,
          weigth: 2000,
          labelButton: "Licencia médica",
          onPress: () {
            // print("Pacientes.Licencias ${Pacientes.Licencias}\n ");
            // print("Reportes.licenciasMedicas ${Reportes.licenciasMedicas}");
            // Consultar última licencia médica.
            // setState(() {
            //   Reportes.licenciasMedicas.clear();
            //   Licencias.ultimoRegistro();
            //   Reportes.licenciasMedicas.add(Formatos.licenciaMedica);
            // });

            // Consultar todas las Incapacidades
            // for (var item in Pacientes.Licencias!) {
            //   print("item ${item.runtimeType} $item");
            //   Licencias.fromJson(item);
            //   Reportes.licenciasMedicas.add(Formatos.licenciaMedica);
            // }
            // ****************** *************************
            var opciones = Listas.listWithoutRepitedValues(
              Listas.listFromMapWithOneKey(Pacientes.Licencias!,
                  keySearched: "Fecha_Realizacion"),
            );
            opciones.add('Sin licencia médica otorgada.');
            // ****************** *************************
            Operadores.selectOptionsActivity(
              context: context,
              tittle: "Elija la fecha de la incapacidad a anexar . . . ",
              options: opciones,
              onClose: (value) {
                setState(() {
                  Reportes.licenciasMedicas.clear();
                  if (value == 'Sin licencia médica otorgada.') {
                    Reportes.licenciasMedicas.add(value);
                  } else {
                    for (var element in Pacientes.Licencias!) {
                      if (value == element['Fecha_Realizacion']) {
                        Licencias.fromJson(element);
                        Reportes.licenciasMedicas.add(Formatos.licenciaMedica);
                      }
                    }
                  }
                });
                // ****************** *************************
                Navigator.of(context).pop();
              },
            );
          }),
    ];
  }
}
