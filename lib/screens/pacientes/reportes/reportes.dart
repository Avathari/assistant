import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';

import 'package:assistant/screens/pacientes/auxiliares/presentaciones/presentaciones.dart';
import 'package:assistant/screens/pacientes/auxiliares/revisiones/revisiones.dart';
import 'package:assistant/screens/pacientes/auxiliares/revisiones/revisorios.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/hospitalizado.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/padecimientoActual.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/analisisLaterales/analisisLaterales.dart';
import 'package:assistant/screens/pacientes/intensiva/contenidos/concentraciones.dart';
import 'package:assistant/screens/pacientes/intensiva/procedimientos/cateterTenckhoff.dart';
import 'package:assistant/screens/pacientes/intensiva/procedimientos/cateterVenosoCentral.dart';
import 'package:assistant/screens/pacientes/intensiva/procedimientos/intubacionEndotraqueal.dart';
import 'package:assistant/screens/pacientes/intensiva/procedimientos/sondaEndopleural.dart';
import 'package:assistant/screens/pacientes/intensiva/valoraciones/aereos.dart';
import 'package:assistant/screens/pacientes/intensiva/valoraciones/prequirurgicos.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/indicaciones.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/semiologicos.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reporteConsulta.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reporteEgreso.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reporteEvolucion.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reporteIngreso.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reportePrequirurgico.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reporteRevision.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reporteTerapia.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reporteTransfusion.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/operadores/reporteTraslado.dart';
import 'package:assistant/screens/pacientes/reportes/info/reportesAuxiliares.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CircleLabel.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/ListValue.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:flutter/material.dart';

class ReportesMedicos extends StatefulWidget {
  int actualPage = 6, indexNote = -1, actualLateralPage = 0;
  int? analysis;
  String? fechaRealizacion;

  ReportesMedicos({super.key, this.analysis = 0});

  @override
  State<ReportesMedicos> createState() => _ReportesMedicosState();
}

class _ReportesMedicosState extends State<ReportesMedicos> {
  List? listNotes = [];

  @override
  void initState() {
    // Llamado a los ultimos registros agregados. ****************************
    setState(() {
      // Diagnosticos.registros(); // Diagnósticos
      Quirurgicos.consultarRegistro(); // Quirúrgicos
      Repositorios.consultarAnalisis();
      Balances.consultarRegistro();
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
      // Diagnósticos del Paciente ****************************************
      Archivos.readJsonToMap(
              filePath: "${Pacientes.localRepositoryPath}diagnosticos.json")
          .then((value) {
        Pacientes.Diagnosticos = value;
      });
      // Ventilaciones del Paciente ****************************************
      Archivos.readJsonToMap(
              filePath: "${Pacientes.localRepositoryPath}ventilaciones.json")
          .then((value) {
        Pacientes.Ventilaciones = value;
      });
      // Alérgias del Paciente ****************************************
      Archivos.readJsonToMap(
              filePath: "${Pacientes.localRepositoryPath}alergicos.json")
          .then((value) {
        Pacientes.Alergicos = value;
      });

// *********************************************
      if (Pacientes.ID_Hospitalizacion != 0) {
        Repositorios.consultarAnalisis();
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
        // Terminal.printAlert(message: "ERROR al Abrir ${Pacientes.localPath}" - $error : : $stackTrace");
        Operadores.alertActivity(
            context: context,
            tittle: "Error al Abrir ${Pacientes.localPath}",
            message: " ERROR - $error : : $stackTrace\n"
                "Reiniciando Loading Activity . . . ");
        Pacientes.loadingActivity(context: context);
      });

      // CONSULTAR NOTACIONES PREVIAS ****************************************
      Reportes.consultarNotasHospitalizacion().then((value) => setState(() {
            if (value.isNotEmpty) {
              widget.indexNote = 0;
              listNotes = value;
            }
          }));
    });
    // # # # ############## #### ######## #### ########
    super.initState();
  }

// ******************************************************
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      endDrawer: drawerForm(context),
      appBar: appBar(context),
      floatingActionButton: !isLargeDesktop(context) && !isDesktop(context)
          ? floattingActionButton(context)
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomNavigationBar(context),
      body: isMobile(context) || isTablet(context)
          ? _mobileView()
          : isDesktop(context)
              ? _largeDesktopView() // _desktopView()
              : isLargeDesktop(context)
                  ? _largeDesktopView()
                  : _largeDesktopView(),
    );
  }

  void onClose(BuildContext context) {
    dispose();
    //
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => VisualPacientes(
              actualPage: 0,
            )));
  }

  // ******************************************************
  Widget _mobileView() {
    return Row(
      children: [
        // Expanded(
        //     child: Container(
        //       padding: const EdgeInsets.all(8.0),
        //       decoration: BoxDecoration(
        //           color: Colores.backgroundPanel,
        //           borderRadius: BorderRadius.circular(20)),
        //       child: sideLeft(),
        //     )),
        Expanded(
            flex: isMobile(context) ? 20 : 9,
            child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colores.backgroundPanel,
                    borderRadius: BorderRadius.circular(20)),
                child: pantallasReportesMedicos(widget.actualPage))),
        if (isTablet(context))
          Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colores.backgroundPanel,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Expanded(flex: 9, child: _notasPrevias(context)),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  widget.analysis = 1;
                                  _key.currentState!.openEndDrawer();
                                });
                              },
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              child: const Icon(Icons.menu_open_outlined,
                                  color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: FloatingActionButton(
                              onPressed: () {
                                Datos.portapapeles(
                                    context: context,
                                    text: Reportes.copiarReporte(
                                        tipoReporte:
                                            ReportsMethods.getTypeReport(
                                                actualPage:
                                                    widget.actualPage)));
                              },
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              child: const Icon(Icons.copy_rounded,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
      ],
    );
  }

  Container _desktopView() {
    return Container(
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.all(8.0),
      decoration: ContainerDecoration.containerDecoration(),
      child: pantallasReportesMedicos(widget.actualPage),
    );
  }

  Row _largeDesktopView() {
    return Row(
      children: [
        Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              decoration: ContainerDecoration.containerDecoration(),
              child: sideLeft(),
            )),
        Expanded(flex: 2, child: Column(
          children: [
            Expanded(flex: 5, child: Hospitalizado(isVertical: true)),
            Expanded(
              child: CircleIcon(
                iconed: Icons.system_update_alt,
                tittle: 'Cargando . . . ',
                onChangeValue: () async {
                  Pacientes.loadingActivity(context: context).then((value) {
                    if (value == true) {
                      // Terminal.printAlert( message:'Archivo ${Pacientes.localPath} Re-Creado $value');
                      Navigator.of(context).pop();
                    }
                  });
                  _key.currentState!.closeEndDrawer();
                },
              ),
            ),
          ],
        )),
        Expanded(
            flex: isDesktop(context) ? 18 : 14,
            child: Container(
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.all(8.0),
              decoration: ContainerDecoration.containerDecoration(),
              child: pantallasReportesMedicos(widget.actualPage),
            )),
        // Expanded(flex: 2, child: _notasPrevias(context)),
        if (isDesktop(context))
          Expanded(
              flex: isDesktop(context) ? 3 : 2,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: Colores.backgroundPanel,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Expanded(flex: 9, child: _notasPrevias(context)),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                widget.analysis = 0;
                                _key.currentState!.openEndDrawer();
                              });
                            },
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            child: const Icon(Icons.menu_open_outlined,
                                color: Colors.white),
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              Datos.portapapeles(
                                  context: context,
                                  text: Reportes.copiarReporte(
                                      tipoReporte: ReportsMethods.getTypeReport(
                                          actualPage: widget.actualPage)));
                            },
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            child: const Icon(Icons.copy_rounded,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        // if (!isDesktop(context))
        //   Expanded(
        //       flex: 2,
        //       child: Container(
        //         padding: const EdgeInsets.all(8.0),
        //         margin: const EdgeInsets.all(8.0),
        //         decoration: ContainerDecoration.containerDecoration(),
        //         child: sideRight(),
        //       )),
      ],
    );
  }

  // ******************************************************
  Widget sideLeft() {
    if (isMobile(context) || isTablet(context)) {
      return Row(
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
                            )
                          : Expanded(
                              child: GrandButton(
                                weigth: 2000,
                                fontSize: 10.0,
                                labelButton: "Tipo de Nota Médica",
                                onPress: () {
                                  if (isMobile(context)) {
                                    Navigator.of(context).pop();
                                  }
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
                          child: ListView(
                            children: tiposReportes(),
                          )),
                      // Expanded(
                      //     flex: 2,
                      //     child: SingleChildScrollView(
                      //       scrollDirection: Axis.vertical,
                      //       controller: ScrollController(),
                      //       child: Column(
                      //         children: tiposReportes(),
                      //       ),
                      //     )),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: GrandButton(
                          weigth: 2000,
                          labelButton: "Tipo de Nota Médica",
                          onPress: () {
                            if (isMobile(context)) {
                              Navigator.of(context).pop();
                            }
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
    if (isMobile(context)) {
      return SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: actionsReportes(),
        ),
      );
    } else if (isTablet(context)) {
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
          Expanded(
            flex: 1,
            child: CircleIcon(
              radios: 30,
              difRadios: 5,
              tittle: 'Copiar Esquema del Reporte',
              iconed: Icons.copy_all_sharp,
              onChangeValue: () {
                Datos.portapapeles(
                    context: context,
                    text: Reportes.copiarReporte(
                        tipoReporte: ReportsMethods.getTypeReport(
                            actualPage: widget.actualPage)));
                _key.currentState!.closeEndDrawer();
              },
            ),
          ),
          if (isDesktop(context) || isLargeDesktop(context))
            SizedBox(
              height: 80,
              child: CircleIcon(
                tittle: "Vista Previa . . . ",
                radios: 30,
                iconed: Icons.signal_wifi_statusbar_null_sharp,
                onChangeValue: () async {
                  await ReportsMethods.guardarNota(
                      context: context,
                      getTypeReport: ReportsMethods.getTypeReport(
                          actualPage: widget.actualPage),
                      actualPage: widget.actualPage,
                      fechaRealizacion: widget.fechaRealizacion!,
                      values: [
                        Pacientes.ID_Paciente,
                        Pacientes.ID_Hospitalizacion,
                        Valores.fechaPadecimientoActual ??
                            Calendarios.today(format: 'yyyy/MM/dd'),
                        Reportes.padecimientoActual,
                        // Valores.servicioTratanteInicial,
                        Valores.servicioTratante,
                        Calendarios.today(format: 'yyyy/MM/dd'),
                        // **********************************************
                        Reportes.personalesNoPatologicos,
                        Reportes.personalesPatologicos,
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
                        //
                        Reportes.hitosHospitalarios.toString(),
                        Repositorios.tipo_Analisis, // Items.tiposAnalisis[0] //
                      ],
                      valuesEgreso: [
                        Pacientes.ID_Paciente,
                        Pacientes.ID_Hospitalizacion,
                        Valores.fechaPadecimientoActual ??
                            Calendarios.today(format: 'yyyy/MM/dd'),
                        Reportes.padecimientoActual,
                        // Valores.servicioTratanteInicial,
                        Valores.servicioTratante,
                        Calendarios.today(format: 'yyyy/MM/dd'),
                        // ***************************************************
                        Reportes.personalesNoPatologicos,
                        Reportes.personalesPatologicos,
                        Reportes.impresionesDiagnosticas,
                        //
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
                        //
                        Reportes.hitosHospitalarios.toString(),
                        Items.tiposAnalisis[3], // Repositorios.tipoAnalisis()
                      ]);
                  // await ReportsMethods.imprimirDocumento(
                  //   context: context,
                  //   actualPage: widget.actualPage,
                  //   getTypeReport: getTypeReport(),
                  // )
                  //     .then((value) => Operadores.alertActivity(
                  //         context: context,
                  //         tittle: 'Petición de Registro de Análisis',
                  //         message:
                  //             '¿Desea registrar el análisis en la base de datos?',
                  //         onClose: () {
                  //           Navigator.of(context).pop();
                  //         },
                  //         onAcept: () {
                  //           Navigator.of(context).pop();
                  //           if (getTypeReport() ==
                  //                   TypeReportes.reporteIngreso ||
                  //               getTypeReport() == TypeReportes.reporteEgreso) {
                  //             Repositorios.actualizarRegistro();
                  //           } else {
                  //             if (widget.fechaRealizacion! ==
                  //                     Calendarios.today(format: "yyyy-MM-dd") &&
                  //                 widget.fechaRealizacion! != null) {
                  //               Repositorios.actualizarRegistro();
                  //             } else {
                  //               Repositorios.registrarRegistro();
                  //             }
                  //           }
                  //         }))
                  //     // onAcept: () {
                  //     //   Navigator.of(context).pop();
                  //     //   Repositorios.registrarRegistro().whenComplete(() =>
                  //     //       Reportes.consultarNotasHospitalizacion()
                  //     //           .then((value) => setState(() {
                  //     //         if (value.isNotEmpty) {
                  //     //           widget.indexNote = 0;
                  //     //           listNotes = value;
                  //     //         }
                  //     //               })));
                  //     //   //
                  //     // }))
                  //     .onError((error, stackTrace) => Terminal.printAlert(
                  //         message: "ERROR - $error : : $stackTrace"));
                },
              ),
            ),
        ],
      );
    }
  }

  Widget partialVisor() {
    return Container();
  }

  Widget pantallasReportesMedicos(int actualPage, {int? index}) {
    List<Widget> list = [
      const ReporteIngreso(), // 0 : Reporte de
      const ReporteEvolucion(), // 1 : Reporte de
      const ReporteConsulta(), // 2 : Reporte de
      const ReporteTerapia(), // 3 : Reporte de Reporte tipado
      const ReportePrequirurgico(), // 4 : Reporte de
      Container(), // 5 : Reporte de Preanestésico
      const ReporteEgreso(), // 6 : Reporte de Egreso
      const ReporteRevision(), // 7 : Reporte de Revisión
      const ReporteTraslado(), // 8 : Reporte de Traslado
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
      AnalisisRevisorios(
          isInOther: true), // 18: Revisorios | Evaluación de Terapia
      Revisiones(), // 19 : Revisión
      Semiologicos(withoutAppBar: true), // 20 : Revisión
      const Concentraciones(), // 21 : Concentraciones
      Container(), // 22
      Container(), //23
      Container(), // 24
      _notaPrevia(context), //25
    ];

    return list[actualPage];
  }

  List<Widget> tiposReportes() {
    return [
      ListValue(
        title: "Nota de Ingreso Hospitalario",
        onPress: () {
          if (isMobile(context)) Navigator.of(context).pop();
          setState(() {
            widget.actualPage = 0;
          });
        },
      ),
      ListValue(
        title: "Nota de Evolución",
        onPress: () {
          if (isMobile(context)) Navigator.of(context).pop();
          setState(() {
            widget.actualPage = 1;
          });
        },
      ),
      ListValue(
        title: "Nota de Consulta",
        onPress: () {
          if (isMobile(context)) Navigator.of(context).pop();
          setState(() {
            widget.actualPage = 2;
          });
        },
      ),
      ListValue(
        title: "Nota de Terapia Intensiva",
        onPress: () {
          if (isMobile(context)) Navigator.of(context).pop();
          setState(() {
            widget.actualPage = 3;
          });
        },
      ),
      ListValue(
        title: "Nota de Valoración Prequirúrgica",
        onPress: () {
          if (isMobile(context)) Navigator.of(context).pop();
          setState(() {
            widget.actualPage = 4;
          });
        },
      ),
      ListValue(
        title: "Nota de Valoración Preanestésica",
        onPress: () {
          if (isMobile(context)) Navigator.of(context).pop();
          setState(() {
            widget.actualPage = 5;
          });
        },
      ),
      ListValue(
        title: "Nota de Egreso",
        onPress: () {
          if (isMobile(context)) Navigator.of(context).pop();
          setState(() {
            widget.actualPage = 6;
          });
        },
      ),
      ListValue(
        title: "Nota de Revisión",
        onPress: () {
          if (isMobile(context)) Navigator.of(context).pop();
          setState(() {
            widget.actualPage = 7;
          });
        },
      ),
      ListValue(
        title: "Nota de Traslado",
        onPress: () {
          if (isMobile(context)) Navigator.of(context).pop();
          setState(() {
            widget.actualPage = 8;
          });
        },
      ),
      ListValue(
        title: "Nota de Transfusión",
        onPress: () {
          if (isMobile(context)) Navigator.of(context).pop();
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
                context: context, chyldrim: PadecimientoActual());
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

  // COMPONENTES ****************************************************
  drawerForm(BuildContext context, {int? analysis = 1}) => Drawer(
        width: widget.analysis == 0 // !isLargeDesktop(context)
            ? 310
            : widget.analysis == 1
                ? 100
                : 270, // 350
        backgroundColor: Theming.cuaternaryColor,
        child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey),
                bottom: BorderSide(color: Colors.grey),
                left: BorderSide(color: Colors.grey),
              ),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  topLeft: Radius.circular(16)),
            ),
            child: widget.analysis == 0 //isLargeDesktop(context)
                ? AnalisisLaterales()
                : widget.analysis == 1
                    ? _optionsLaterales(context)
                    : _notasPrevias(context)),
      );

  bottomNavigationBar(BuildContext context) => BottomAppBar(
        color: Colors.black,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                splashColor: Theming.terciaryColor,
                icon: const Icon(Icons.line_weight, color: Colors.grey),
                tooltip: "Indicaciones Médicas",
                onPressed: () => setState(() {
                      widget.actualPage = 9;
                    })),
            IconButton(
                splashColor: Theming.terciaryColor,
                icon: const Icon(Icons.bed, color: Colors.grey),
                tooltip: "Semiologías",
                onPressed: () =>
                    Cambios.toNextPage(context, AnalisisRevisorios())),
            //
            const SizedBox(width: 25),
            IconButton(
                splashColor: Theming.terciaryColor,
                icon: const Icon(Icons.menu_open_sharp, color: Colors.grey),
                tooltip: "Otras Opciones . . . ",
                onPressed: () => setState(() {
                      widget.analysis = 1;
                      _key.currentState!.openEndDrawer();
                    })),
            IconButton(
                icon: const Icon(Icons.scale, color: Colors.grey),
                tooltip: 'Vista Previa',
                onPressed: () async => await ReportsMethods.guardarNota(
                        context: context,
                        getTypeReport: ReportsMethods.getTypeReport(
                            actualPage: widget.actualPage),
                        actualPage: widget.actualPage,
                        fechaRealizacion: widget.fechaRealizacion ?? "",
                        values: [
                          Pacientes.ID_Paciente,
                          Pacientes.ID_Hospitalizacion,
                          Valores.fechaPadecimientoActual ??
                              Calendarios.today(format: 'yyyy/MM/dd'),
                          Reportes.padecimientoActual,
                          // Valores.servicioTratanteInicial,
                          Valores.servicioTratante,
                          Calendarios.today(format: 'yyyy/MM/dd'),
                          //
                          Reportes.personalesNoPatologicos,
                          Reportes.personalesPatologicos,
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
                          //
                          Reportes.hitosHospitalarios.toString(),
                          //
                          Repositorios
                              .tipo_Analisis, // Items.tiposAnalisis[0] //
                        ],
                        valuesEgreso: [
                          Pacientes.ID_Paciente,
                          Pacientes.ID_Hospitalizacion,
                          Valores.fechaPadecimientoActual ??
                              Calendarios.today(format: 'yyyy/MM/dd'),
                          Reportes.padecimientoActual,
                          // Valores.servicioTratanteInicial,
                          Valores.servicioTratante,
                          Calendarios.today(format: 'yyyy/MM/dd'),
                          //
                          Reportes.personalesNoPatologicos,
                          Reportes.personalesPatologicos,
                          Reportes.impresionesDiagnosticas,
                          //
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
                          //
                          Reportes.hitosHospitalarios.toString(),
                          Items.tiposAnalisis[3], // Repositorios.tipoAnalisis()
                        ])),
          ],
        ),
      );

  floattingActionButton(BuildContext context) => FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                width: 350,
                padding: const EdgeInsets.all(8.0),
                // margin: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: Theming.cuaternaryColor,
                  border: Border(
                      top: BorderSide(color: Colors.grey),
                      right: BorderSide(color: Colors.grey),
                      left: BorderSide(color: Colors.grey)),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16)),
                ),
                child: sideLeft(),
              );
            }),
        shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(100)),
        child: const Icon(
          Icons.hdr_strong,
          color: Colors.grey,
        ),
      );

  appBar(BuildContext context) => AppBar(
          backgroundColor: Theming.primaryColor,
          leading: GrandIcon(
              labelButton: Sentences.regresar,
              iconData: Icons.arrow_back,
              iconColor: Colors.white,
              onPress: () => onClose(context)),
          centerTitle: true,
          toolbarHeight: 80,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(90.0),
              bottomRight: Radius.circular(90.0),
            ),
          ),
          title: CircleIcon(
            iconed: Icons.lens_blur,
            radios: 30,
            onChangeValue: () {
              setState(() {
                widget.analysis = 3;
              });
              _key.currentState!.openEndDrawer();
            },
          ),
          // title: AppBarText(Sentences.app_bar_reportes),
          actions: <Widget>[
            // if (!isMobile(context))
            GrandIcon(
                labelButton: 'Esquema de Análisis . . . ',
                iconData: Icons.remove_red_eye_outlined,
                iconColor: Colors.white,
                onPress: () {
                  setState(() {
                    widget.analysis = 0;
                  });
                  _key.currentState!.openEndDrawer();
                }),
            const SizedBox(width: 15),
            GrandIcon(
                labelButton: 'Copiar Esquema del Reporte',
                iconData: Icons.menu_open_sharp,
                iconColor: Colors.white,
                onPress: () {
                  setState(() {
                    widget.analysis = 3;
                  });
                  _key.currentState!.openEndDrawer();
                }),
            const SizedBox(width: 20),
          ]);

  //
  _notasPrevias(BuildContext context) {
    return Padding(
      padding: widget.analysis == 3
          ? const EdgeInsets.only(
              top: 32.0, bottom: 16.0, left: 16.0, right: 16.0)
          : const EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: Column(
        children: [
          CrossLine(height: 10, thickness: 4, color: Colors.black),
          Expanded(
            flex: 8,
            child: FutureBuilder<List>(
                initialData: listNotes!,
                future: Future.value(listNotes!),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return ListView.separated(
                      controller: ScrollController(),
                      itemCount: listNotes!.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Terminal.printWarning(
                        //     message: "${listNotes![index].keys}");
                        return Container(
                          decoration: ContainerDecoration.roundedDecoration(),
                          child: ListTile(
                            title: Text(
                              listNotes![index]['FechaRealizacion'],
                              style: Styles.textSyleGrowth(fontSize: 11),
                            ),
                            subtitle: Text(
                              listNotes![index]['Tipo_Analisis'],
                              style: Styles.textSyleGrowth(fontSize: 8),
                            ),
                            onTap: () {
                              if (widget.analysis == 3)
                                Navigator.of(context).pop();
                              //
                              setState(() {
                                widget.indexNote = index;
                                widget.actualPage = 25;
                              });
                            },
                            onLongPress: () {
                              Operadores.openWindow(
                                  context: context,
                                  chyldrim: _notaPrevia(context));
                            },
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 10));
                }),
          ),
          CrossLine(height: 10, thickness: 4, color: Colors.black),
          CircleIcon(
              iconed: Icons.remove_road,
              onChangeValue: () {
                // CONSULTAR NOTACIONES PREVIAS ****************************************
                Operadores.loadingActivity(
                    context: context,
                    tittle: "Consultando Registro de Notas previas . . .",
                    message: "Actualizando . . . ");
                //
                Reportes.consultarNotasHospitalizacion()
                    .then((value) => setState(() {
                          if (value.isNotEmpty) {
                            widget.indexNote = 0;
                            listNotes = value;
                            //
                            Archivos.createJsonFromMap(Pacientes.Notas!,
                                filePath:
                                    "${Pacientes.localRepositoryPath}/reportes/reportes.json");
                          }
                        }))
                    .whenComplete(() => Navigator.of(context).pop());
              }),
          CrossLine(height: 10, thickness: 2, color: Colors.black),
          CircleLabel(
            tittle: "${Pacientes.ID_Hospitalizacion}",
            radios: 25,
            difRadios: 3,
            fontSize: 8,
            onChangeValue: () async {
              await Actividades.registrar(
                Databases.siteground_database_reghosp,
                Repositorios.repositorio['registerQuery'],
                [
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
                  //
                  Reportes.hitosHospitalarios.toString(),
                  Items.tiposAnalisis[3], // Repositorios.tipoAnalisis()
                ],
              )
                  .whenComplete(() => Archivos.createJsonFromMap(
                      Pacientes.Notas!,
                      filePath:
                          "${Pacientes.localRepositoryPath}/reportes/reportes.json"))
                  .whenComplete(() {
                Reportes.consultarNotasHospitalizacion()
                    .then((value) => setState(() {
                          if (value.isNotEmpty) {
                            widget.indexNote = 0;
                            listNotes = value;
                          }
                        }));
              });
              // Repositorios.consultarAnalisis();
            },
          ),
        ],
      ),
    );
  }

  _notaPrevia(BuildContext context) {
    //
    if (widget.indexNote > -1) {
      // Terminal.printWarning(
      //     message: listNotes![widget.indexNote]['Diagnosticos_Hospital']);
      widget.fechaRealizacion =
          listNotes![widget.indexNote]['FechaRealizacion'];
      //
      listNotes![widget.indexNote]['Tipo_Analisis'] == 'Análisis de Revisión'
          ? Reportes.reportes['Datos_Generales_Simple'] =
              Pacientes.prosa(isTerapia: true, otherForm: true)
          : "";
      //
      Reportes.impresionesDiagnosticas =
          Reportes.reportes['Impresiones_Diagnosticas'] =
              listNotes![widget.indexNote]['Diagnosticos_Hospital'];
      //
      Reportes.padecimientoActual = Reportes.reportes['Padecimiento_Actual'] =
          listNotes![widget.indexNote]['Padecimiento_Actual'];
      Reportes.reportes['Exploracion_Fisica'] = Reportes.exploracionFisica =
          listNotes![widget.indexNote]['Exploracion_Fisica'];
      Reportes.analisisMedico = listNotes![widget.indexNote]['Analisis_Medico'];
      //
      Reportes.reportes['Auxiliares_Diagnosticos'] =
          Reportes.auxiliaresDiagnosticos =
              listNotes![widget.indexNote]['Auxiliares_Diagnosticos'] ?? "";
      Reportes.reportes['Analisis_Complementario'] =
          Reportes.analisisComplementarios =
              listNotes![widget.indexNote]['Analisis_Complementario'] ?? "";
      //
      Reportes.reportes['Hitos_Hospitalarios'] = Reportes.hitosHospitalarios =
          listNotes![widget.indexNote]['Hitos_Hospitalarios'] ?? "";
      //
      return TittleContainer(
        tittle:
            listNotes![widget.indexNote]['FechaRealizacion'] ?? "0000/00/00",
        padding: 10,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PRESENTACION

              Text(
                listNotes![widget.indexNote]['Tipo_Analisis'],
                style: Styles.textSyleGrowth(fontSize: 12),
              ),
              Text(
                "Inicio de Padecimiento - ${listNotes![widget.indexNote]['FechaPadecimiento']}",
                style: Styles.textSyleGrowth(fontSize: 12),
              ),
              //
              CrossLine(thickness: 4),
              listNotes![widget.indexNote]['Tipo_Analisis'] !=
                          'Análisis de Gravedad' &&
                      listNotes![widget.indexNote]['Tipo_Analisis'] !=
                          'Análisis de Ingreso' &&
                      listNotes![widget.indexNote]['Tipo_Analisis'] !=
                          'Análisis de Egreso'
                  ? CrossLine(thickness: 3)
                  : Container(),
              // DIAGNOSTICOS ********************************************
              Text(
                  listNotes![widget.indexNote]['Diagnosticos_Hospital']
                      .toUpperCase(),
                  maxLines: 20,
                  style: Styles.textSyleGrowth(fontSize: 9)),
              listNotes![widget.indexNote]['Tipo_Analisis'] !=
                      'Análisis de Gravedad'
                  ? CrossLine(thickness: 4)
                  : Container(),
              // PATOLÓGICOS ********************************************
              listNotes![widget.indexNote]['Tipo_Analisis'] ==
                      'Análisis de Egreso'
                  ? Text(
                      listNotes![widget.indexNote]['Tipo_Analisis'] ==
                              'Análisis de Egreso'
                          ? Pacientes
                              .patologicos() // ${listNotes![widget.indexNote]['Antecedentes_Patologicos_Otros']}"
                          : "",
                      maxLines: 25,
                      style: Styles.textSyleGrowth(fontSize: 8))
                  : Container(),
              //
              listNotes![widget.indexNote]['Tipo_Analisis'] ==
                          'Análisis de Gravedad' ||
                      listNotes![widget.indexNote]['Tipo_Analisis'] ==
                          'Análisis de Ingreso' ||
                      listNotes![widget.indexNote]['Tipo_Analisis'] ==
                          'Análisis de Egreso'
                  ? CrossLine(thickness: 3)
                  : Container(),
              // MOTIVO DE INGRESO ********************************************
              Text(
                  listNotes![widget.indexNote]['Tipo_Analisis'] ==
                              "Análisis de Ingreso" ||
                          // listNotes![widget.indexNote]['Tipo_Analisis'] ==
                          //     'Análisis de Gravedad' ||
                          listNotes![widget.indexNote]['Tipo_Analisis'] ==
                              'Análisis de Revisión' ||
                          listNotes![widget.indexNote]['Tipo_Analisis'] ==
                              'Análisis de Egreso'
                      ? "MOTIVO DE INGRESO: ${listNotes![widget.indexNote]['Padecimiento_Actual']}"
                      : listNotes![widget.indexNote]['Tipo_Analisis'] ==
                              "Análisis de Evolución"
                          ? "" // listNotes![widget.indexNote]['Analisis_Medico']
                          : "",
                  maxLines: 50,
                  style: Styles.textSyleGrowth(fontSize: 8)),
              // SUBJETIVO ********************************************
              listNotes![widget.indexNote]['Tipo_Analisis'] ==
                          'Análisis de Gravedad' ||
                      listNotes![widget.indexNote]['Tipo_Analisis'] ==
                          'Análisis de Ingreso' ||
                      listNotes![widget.indexNote]['Tipo_Analisis'] ==
                          'Análisis de Egreso'
                  ? CrossLine(thickness: 3)
                  : Container(),

              //
              listNotes![widget.indexNote]['Tipo_Analisis'] ==
                      'Análisis de Revisión'
                  ? Text(
                      "\n${listNotes![widget.indexNote]['Hitos_Hospitalarios']}\n",
                      maxLines: 150,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.textSyleGrowth(fontSize: 9),
                    )
                  : Container(),

              //
              listNotes![widget.indexNote]['Tipo_Analisis'] !=
                          'Análisis de Gravedad' &&
                      listNotes![widget.indexNote]['Tipo_Analisis'] !=
                          'Análisis de Ingreso' &&
                      listNotes![widget.indexNote]['Tipo_Analisis'] !=
                          'Análisis de Egreso'
                  ? Text(
                      listNotes![widget.indexNote]['Subjetivo'],
                      maxLines: 3,
                      style: Styles.textSyleGrowth(fontSize: 9),
                    )
                  : Container(),
              // VITALES ********************************************
              Text(listNotes![widget.indexNote]['Signos_Vitales'],
                  maxLines: 3, style: Styles.textSyleGrowth(fontSize: 8)),
              listNotes![widget.indexNote]['Tipo_Analisis'] !=
                          'Análisis de Gravedad' &&
                      listNotes![widget.indexNote]['Tipo_Analisis'] !=
                          'Análisis de Ingreso' &&
                      listNotes![widget.indexNote]['Tipo_Analisis'] !=
                          'Análisis de Revisión' &&
                      listNotes![widget.indexNote]['Tipo_Analisis'] !=
                          'Análisis de Evolución' &&
                      listNotes![widget.indexNote]['Tipo_Analisis'] !=
                          'Análisis de Egreso'
                  ? CrossLine(thickness: 3)
                  : Container(),
              if (listNotes![widget.indexNote]['Tipo_Analisis'] !=
                  'Análisis de Egreso')
                // EXPLORACIÓN FÍSICA ********************************************
                Text(
                  listNotes![widget.indexNote]['Exploracion_Fisica'],
                  maxLines: 20,
                  style: Styles.textSyleGrowth(fontSize: 9),
                ),

              // AUXILIARES DIAGNÓSTICOS *****************************************
              Text(
                  listNotes![widget.indexNote]['Auxiliares_Diagnosticos'] ?? "",
                  maxLines: 30,
                  style: Styles.textSyleGrowth(
                      fontSize: 8)), // AUXILIARES DIAGNÓSTICOS
              // ANÁLISIS COMPLEMENTARIO *****************************************
              Text(
                  listNotes![widget.indexNote]['Analisis_Complementario'] ?? "",
                  maxLines: 30,
                  style: Styles.textSyleGrowth(fontSize: 8)),
              //
              listNotes![widget.indexNote]['Tipo_Analisis'] !=
                          'Análisis de Gravedad' ||
                      listNotes![widget.indexNote]['Tipo_Analisis'] !=
                          'Análisis de Revisión' ||
                      listNotes![widget.indexNote]['Tipo_Analisis'] !=
                          'Análisis de Egreso'
                  ? CrossLine(thickness: 1)
                  : Container(),
              // ANÁLISIS MÉDICO ********************************************
              Text(
                listNotes![widget.indexNote]['Analisis_Medico'],
                maxLines: listNotes![widget.indexNote]['Tipo_Analisis'] ==
                        'Análisis de Egreso'
                    ? 100
                    : 100,
                style: Styles.textSyleGrowth(fontSize: 9),
              ),

              CrossLine(thickness: 1),
              // PRONÓSTICO MÉDICO ********************************************
              Text(
                listNotes![widget.indexNote]['Pronostico_Medico'] ?? "",
                maxLines: 20,
                style: Styles.textSyleGrowth(fontSize: 9),
              ),
              // Text(
              //   listNotes![widget.indexNote]['Tratamiento_Propuesto'],
              //   maxLines: 20,
              //   style: Styles.textSyleGrowth(fontSize: 9),
              // ),
              CrossLine(thickness: 4),
              CrossLine(thickness: 3),
              Text(listNotes![widget.indexNote]['Pendientes'],
                  style: Styles.textSyleGrowth(fontSize: 8)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleIcon(onChangeValue: () {
                    Datos.portapapeles(
                        context: context,
                        text: Reportes.copiarReporte(
                            tipoReporte: ReportsMethods.getTypeReport(
                                actualPage: ReportsMethods.setTypeReport(
                                    tipoAnalisis: listNotes![widget.indexNote]
                                        ['Tipo_Analisis']))));
                  }),
                ],
              )
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  //
  _optionsLaterales(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: DrawerHeader(
              child: CircleIcon(
            difRadios: 15,
            iconed: Icons.line_weight_sharp,
            onChangeValue: () {},
          )),
        ),
        Expanded(
          flex: 16,
          child: GridView(
              controller: ScrollController(),
              gridDelegate: GridViewTools.gridDelegate(
                  crossAxisCount: 1, mainAxisExtent: 20.0),
              children: actionsReportes()),
        ),
        CrossLine(thickness: 3, color: Colors.grey),
        Expanded(
          flex: 4,
          child: GridView(
            controller: ScrollController(),
            gridDelegate: GridViewTools.gridDelegate(
                mainAxisSpacing: 25.0,
                crossAxisSpacing: 7.0,
                crossAxisCount: 2,
                mainAxisExtent: 25.0),
            children: [
              IconButton(
                icon: const Icon(
                  color: Colors.white,
                  Icons.balance,
                ),
                tooltip: 'Concentraciones y Diluciones',
                onPressed: () async {
                  setState(() {
                    widget.actualPage = 21;
                    _key.currentState!.closeEndDrawer();
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
                  setState(() {
                    _key.currentState!.closeEndDrawer();
                  });
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
                      // Terminal.printAlert( message:'Archivo ${Pacientes.localPath} Re-Creado $value');
                      Navigator.of(context).pop();
                    }
                  });
                  _key.currentState!.closeEndDrawer();
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
                    _key.currentState!.closeEndDrawer();
                  });
                },
              ),
              // CrossLine(isHorizontal: false, thickness: 4),
            ],
          ),
        ),
        CrossLine(thickness: 3, height: 20, color: Colors.grey),
        Expanded(
          flex: 3,
          child: CircleIcon(
            radios: 30,
            difRadios: 5,
            tittle: 'Copiar Esquema del Reporte',
            iconed: Icons.copy_all_sharp,
            onChangeValue: () {
              Datos.portapapeles(
                  context: context,
                  text: Reportes.copiarReporte(
                      tipoReporte: ReportsMethods.getTypeReport(
                          actualPage: widget.actualPage)));
              _key.currentState!.closeEndDrawer();
            },
          ),
        ),
      ],
    );
  }

  // _analisisLaterales(BuildContext context) {
  //   return Column(
  //     children: [
  //       Expanded(
  //         flex: 8,
  //         child: widget.actualLateralPage == 0
  //             ? Container()
  //             : widget.actualLateralPage == 1
  //                 ? Hidricos(isLateral: true)
  //                 : widget.actualLateralPage == 2
  //                     ? Ventilatorios()
  //                     : widget.actualLateralPage == 3
  //                         ? const Gasometricos()
  //                         : widget.actualLateralPage == 4
  //                             ? Cardiovasculares()
  //                             : widget.actualLateralPage == 5
  //                                 ? const Antropometricos()
  //                                 : widget.actualLateralPage == 6
  //                                     ? const BalanceHidrico()
  //                                     : Container(),
  //       ),
  //       // CrossLine(color:Colors.grey),
  //       Expanded(
  //           child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           GrandIcon(
  //               labelButton: 'Concentraciones',
  //               iconData: Icons.menu_rounded,
  //               onPress: () => setState(() {
  //                     widget.actualLateralPage = 0;
  //                   })),
  //           GrandIcon(
  //               labelButton: "Hídricos",
  //               iconData: Icons.water_drop,
  //               onPress: () => setState(() {
  //                     widget.actualLateralPage = 1;
  //                   })),
  //           GrandIcon(
  //               labelButton: "Ventilatorios",
  //               iconData: Icons.air,
  //               onPress: () => setState(() {
  //                     widget.actualLateralPage = 2;
  //                   })),
  //           GrandIcon(
  //               labelButton: "Gasométricos",
  //               onPress: () => setState(() {
  //                     widget.actualLateralPage = 3;
  //                   })),
  //           GrandIcon(
  //               labelButton: "Cardiovasculares",
  //               iconData: Icons.monitor_heart_outlined,
  //               onPress: () => setState(() {
  //                     widget.actualLateralPage = 4;
  //                   })),
  //           GrandIcon(
  //               labelButton: "Antropometrías",
  //               iconData: Icons.monitor_weight_outlined,
  //               onPress: () => setState(() {
  //                     widget.actualLateralPage = 5;
  //                   })),
  //           GrandIcon(
  //               labelButton: "Balances",
  //               iconData: Icons.waterfall_chart,
  //               onPress: () => setState(() {
  //                     widget.actualLateralPage = 6;
  //                   })),
  //           GrandIcon(
  //               onPress: () => setState(() {
  //                     widget.actualLateralPage = 7;
  //                   })),
  //         ],
  //       )),
  //       Expanded(
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             GrandIcon(
  //               iconData: Icons.checklist_rtl,
  //               labelButton: "Laboratorios",
  //               onPress: () {
  //                 Operadores.selectOptionsActivity(
  //                   context: context,
  //                   tittle: "Elija la fecha de los estudios . . . ",
  //                   options: Listas.listWithoutRepitedValues(
  //                     Listas.listFromMapWithOneKey(
  //                       Pacientes.Paraclinicos!,
  //                       keySearched: 'Fecha_Registro',
  //                     ),
  //                   ),
  //                   onClose: (value) {
  //                     setState(() {
  //                       Datos.portapapeles(
  //                           context: context,
  //                           text: Auxiliares.porFecha(fechaActual: value));
  //                       Navigator.of(context).pop();
  //                     });
  //                   },
  //                 );
  //               },
  //             ),
  //             GrandIcon(
  //               iconData: Icons.list_alt_sharp,
  //               labelButton: "Laboratorios",
  //               onPress: () {
  //                 Datos.portapapeles(
  //                     context: context, text: Auxiliares.historial());
  //               },
  //               onLongPress: () {
  //                 Datos.portapapeles(
  //                     context: context,
  //                     text: Auxiliares.historial(esAbreviado: true));
  //               },
  //             ),
  //             GrandIcon(
  //               iconData: Icons.line_style,
  //               labelButton: "Laboratorios",
  //               onPress: () {
  //                 Datos.portapapeles(
  //                     context: context, text: Auxiliares.getUltimo());
  //               },
  //               onLongPress: () {
  //                 Datos.portapapeles(
  //                     context: context,
  //                     text: Auxiliares.getUltimo(esAbreviado: true));
  //               },
  //             ),
  //             GrandIcon(
  //               iconData: Icons.linear_scale_rounded,
  //               labelButton: "Actual e Historial",
  //               onPress: () {
  //                 Datos.portapapeles(
  //                     context: context,
  //                     text: Auxiliares.getUltimo(withoutInsighs: true));
  //               },
  //               onLongPress: () {
  //                 Datos.portapapeles(
  //                     context: context,
  //                     text: Auxiliares.historial(withoutInsighs: true));
  //               },
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
