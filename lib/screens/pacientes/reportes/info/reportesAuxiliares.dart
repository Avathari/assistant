import 'package:assistant/conexiones/actividades/pdfGenerete/PdfApi.dart';
import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';

import 'package:assistant/conexiones/actividades/pdfGenerete/pdfGenereteFormats/formatosReportes.dart';

import 'package:flutter/material.dart';

class ReportsMethods {
  static Future<void> imprimirDocumento({
    required BuildContext context,
    required TypeReportes getTypeReport,
    required int actualPage,
  }) async {
    Contextos.contexto = context;
    // *
    final pdfFile = await PdfParagraphsApi.generate(
        withIndicationReport: false,
        indexOfTypeReport: getTypeReport,
        paraph: Reportes.reportes,
        name: Reportes.nombreReporte(indefOfReport: actualPage));
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
          "Pronostico_Medico": Reportes.pronosticoMedico,
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
        // Terminal.printAlert(message: "index $index");

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
          "Pronostico_Medico": Reportes.pronosticoMedico,
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
        "Pronostico_Medico": Reportes.pronosticoMedico,
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

  static guardarNota(
      {required BuildContext context,
      required TypeReportes getTypeReport,
      required int actualPage,
      required String? fechaRealizacion,
      required List values,
      required List valuesEgreso}) async {
    Terminal.printWarning(
        message:
            ": : : guardarNota - - fechaRealizacion . . . $fechaRealizacion "
            ": ${fechaRealizacion! == Calendarios.today(format: "yyyy-MM-dd")}\n "
            ": : $getTypeReport . . . "
            // ". . . Reportes.impresionesDiagnosticas ${Reportes.impresionesDiagnosticas}"
            "\n\n");
    //
    await ReportsMethods.imprimirDocumento(
      context: context,
      actualPage: actualPage,
      getTypeReport: getTypeReport,
    )
        .then((value) => Operadores.optionsActivity(
            context: context,
            tittle: 'Petición de Registro de Análisis',
            message: "Desea registrar el análisis en la base de datos?\n\n"
                "     Fecha de Realización : : $fechaRealizacion \n"
                "          : ${fechaRealizacion! == Calendarios.today(format: "yyyy-MM-dd")}\n "
                "     Tipo de Reporte . . $getTypeReport\n ",
            textOptionB: "Cerrar . . . ",
            onClose: () => Navigator.of(context).pop(),
            textOptionA: "Registrar análisis en base de datos . . . ",
            optionA: () {
              Navigator.of(context).pop();
              //|| getTypeReport == TypeReportes.reporteEgreso
              if (getTypeReport == TypeReportes.reporteIngreso) {
                Repositorios.actualizarRegistro(
                        context: context, values: values)
                    .onError((onError, stackTrace) => Operadores.alertActivity(
                          context: context,
                          tittle: "ERROR  Al Actualizar registro de Nota",
                          message: "ERROR : $onError : : $stackTrace",
                          onAcept: () => Navigator.of(context).pop(),
                        ));
              } else if (getTypeReport == TypeReportes.reporteEgreso) {
                Repositorios.actualizarRegistro(
                        context: context, values: values, isNotte: true)
                    .onError((onError, stackTrace) => Operadores.alertActivity(
                          context: context,
                          tittle: "ERROR  Al Actualizar registro de Nota",
                          message: "ERROR : $onError : : $stackTrace",
                          onAcept: () => Navigator.of(context).pop(),
                        ));
              } else {
                if (fechaRealizacion ==
                    Calendarios.today(format: "yyyy-MM-dd")) {
                  Repositorios.actualizarRegistro(
                          context: context, values: values, isNotte: true)
                      .onError(
                          (onError, stackTrace) => Operadores.alertActivity(
                                context: context,
                                tittle: "ERROR  Al Actualizar registro de Nota",
                                message: "ERROR : $onError : : $stackTrace",
                                onAcept: () => Navigator.of(context).pop(),
                              ));
                } else {
                  Repositorios.registrarRegistro(
                          context: context,
                          Values: values,
                          ValuesEgreso: valuesEgreso)
                      .onError(
                          (onError, stackTrace) => Operadores.alertActivity(
                                context: context,
                                tittle: "ERROR  Al Registrar Nota . . . ",
                                message: "ERROR : $onError : : $stackTrace",
                                onAcept: () => Navigator.of(context).pop(),
                              ));
                }
              }
            }))
        .onError((error, stackTrace) => Operadores.alertActivity(
              context: context,
              tittle: "ERROR  Al guardar nota",
              message: "ERROR : $error : : $stackTrace",
              onAcept: () => Navigator.of(context).pop(),
            ));
  }

  static int setTypeReport({required String tipoAnalisis}) {
    if (tipoAnalisis == Items.tiposAnalisis[0]) {
      return 0;
    } else if (tipoAnalisis == Items.tiposAnalisis[1]) {
      return 1;
    } else if (tipoAnalisis == Items.tiposAnalisis[2]) {
      return 7;
    } else if (tipoAnalisis == Items.tiposAnalisis[3]) {
      return 6;
    } else if (tipoAnalisis == Items.tiposAnalisis[4]) {
      return 3;
    } else if (tipoAnalisis == Items.tiposAnalisis[5]) {
      return 8;
    } else if (tipoAnalisis == Items.tiposAnalisis[6]) {
      return 4;
    } else {
      return 0;
    }
  }

  static TypeReportes getTypeReport({
    required int actualPage,
  }) {
    // Terminal.printExpected(message: "getTypeReport . : $actualPage");
    switch (actualPage) {
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
        Repositorios.tipo_Analisis = Items.tiposAnalisis[4];
        return TypeReportes.reporteTerapiaIntensiva;
      case 4:
        Repositorios.tipo_Analisis = Items.tiposAnalisis[6];
        return TypeReportes.reportePrequirurgica;
      case 5:
        return TypeReportes.reportePreanestesica;
      case 6:
        Repositorios.tipo_Analisis = Items.tiposAnalisis[3];
        return TypeReportes.reporteEgreso;
      case 7:
        Repositorios.tipo_Analisis = Items.tiposAnalisis[2];
        return TypeReportes.reporteRevision;
      case 8:
        Repositorios.tipo_Analisis = Items.tiposAnalisis[5];
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
}

class PanelesAuxiliares {}
