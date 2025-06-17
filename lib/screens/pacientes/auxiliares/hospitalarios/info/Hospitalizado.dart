import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/gasometricos.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/Strings.dart';

class Internado {
  late int idPaciente, idHospitalizado;
  late String nombreCompleto, nssPaciente, nssAgregadoPaciente;
  late String localRepositoryPath,
      vitalesRepositoryPath,
      patologicosRepositoryPath,
      diagnosticosRepositoryPath,
      pendientesRepositoryPath,
      licenciasRepositoryPath,
      ventilacionesRepositoryPath,
      balancesRepositoryPath,
      paraclinicosRepositoryPath,
      imagenologicosRepositoryPath,
      electrocardiogramasRepositoryPath;
  //
  late List vitales = [],
      patologicos = [],
      diagnosticos = [],
      paraclinicos = [],
      //
      pendientes = [],
      licencias = [],
      //
      balances = [],
      imagenologicos = [],
      electrocardiogramas = [],
      ventilaciones = [];
  Map<String, dynamic>? generales, hospitalizedData, padecimientoActual, revisionHospitalaria;

  /// CONTRUCTOR de Pacientes Hospitalizados : Funciones básicas
  Internado(this.idPaciente, Map<String, dynamic> json) {
    generales = json;
    //
    if (json['Pace_Nome_SE'] == '' || json['Pace_Nome_SE'] == null) {
      nombreCompleto =
          "${json['Pace_Nome_PI']} ${json['Pace_Ape_Pat']} ${json['Pace_Ape_Mat']}";
    } else {
      nombreCompleto =
          "${json['Pace_Nome_PI']} ${json['Pace_Nome_SE']} ${json['Pace_Ape_Pat']} ${json['Pace_Ape_Mat']}";
    }

    //
    nssPaciente = json['Pace_NSS'].replaceAll(" ", "");
    nssAgregadoPaciente = "${json['Pace_NSS']} ${json['Pace_AGRE']}";
//
    localRepositoryPath = 'assets/vault/'
        '$nombreCompleto';
    //
    vitalesRepositoryPath = "$localRepositoryPath/vitales.json";
    patologicosRepositoryPath = "$localRepositoryPath/patologicos.json";
    diagnosticosRepositoryPath = "$localRepositoryPath/diagnosticos.json";
    pendientesRepositoryPath = "$localRepositoryPath/pendientes.json";
    licenciasRepositoryPath = "$localRepositoryPath/licencias.json";

    ventilacionesRepositoryPath = "$localRepositoryPath/ventilaciones.json";
    balancesRepositoryPath = "$localRepositoryPath/balances.json";

    imagenologicosRepositoryPath = "$localRepositoryPath/imagenologias.json";
    electrocardiogramasRepositoryPath =
        "$localRepositoryPath/electrocardiogramas.json";
    paraclinicosRepositoryPath = "$localRepositoryPath/paraclinicos.json";
    //
    Terminal.printExpected(
        message: "localRepositoryPath : : $localRepositoryPath");
    Terminal.printExpected(message: "nombreCompleto : : $nombreCompleto");
  }

  // OPERABLES *******************************************
  Map<String, dynamic> toJson() {
    return {
      "generales": generales,
      "hospitalizedData": hospitalizedData,
      "padecimientoActual": padecimientoActual,
      "revisionHospitalaria": revisionHospitalaria,
      "vitales": vitales,
      "patologicos": patologicos,
      "diagnosticos": diagnosticos,
      "paraclinicos": paraclinicos,
      "balances": balances,
      //
      "licencias": licencias,
      "pendientes": pendientes,
      "imagenologicos": imagenologicos,
      "electrocardiogramas": electrocardiogramas,
      "ventilaciones": ventilaciones,
    };
  }

  void fromJson(Map<String, dynamic> json) {}

  // FUNCTIONS *******************************************
  /// Padecimiento Actual registrados segun el idHospitalizado Actual, obtenido de un Orden Descendente del Registro.
  Future<Map<String, dynamic>> getPadecimientoActual() async =>
      await Actividades.consultarId(
        Databases.siteground_database_reghosp,
        Repositorios.repositorio['consultPadecimientoQuery'],
        idHospitalizado,
      ).then((value) => padecimientoActual = value);

  Future<Map<String, dynamic>> getRevisionHospitalaria() async {
    revisionHospitalaria = await Actividades.consultarId(
      Databases.siteground_database_reghosp,
      Repositorios.repositorio['consultRevisionQuery'],
      idHospitalizado,
    );
    return revisionHospitalaria!;
  }


  Future<Map<String, dynamic>> getHospitalizationRegister() async =>
      await Actividades.consultarId(
        Databases.siteground_database_reghosp,
        "SELECT * FROM pace_hosp WHERE ID_Pace = ? "
        "ORDER BY ID_Hosp DESC",
        idPaciente,
      ).then((value) {
        idHospitalizado = value['ID_Hosp'] ?? 0;
        return hospitalizedData = value;
      });

  // METHODS  *******************************************
  Future<List> getVitalesHistorial({reload: false}) async {
    if (reload) {
      await Actividades.consultarAllById(Databases.siteground_database_regpace,
              Vitales.vitales['consultByIdPrimaryQuery'], idPaciente)
          .then((value) async {
        Terminal.printNotice(message: " : : OBTENIDO DE REGISTRO . . . ");
        //
        return vitales = value;
      }).whenComplete(() => Archivos.createJsonFromMap(vitales,
              filePath: vitalesRepositoryPath));
    } else {
      //
      await Archivos.readJsonToMap(filePath: vitalesRepositoryPath)
          .then((value) {
        Terminal.printNotice(
            message: " : : OBTENIDO DE ARCHIVO . . . $vitalesRepositoryPath");
        //
        return vitales = value;
      }).onError((error, stackTrace) async {
        await Actividades.consultarAllById(
                Databases.siteground_database_regpace,
                Vitales.vitales['consultByIdPrimaryQuery'],
                idPaciente)
            .then((value) async {
          Terminal.printNotice(message: " : : OBTENIDO DE REGISTRO . . . ");
          //
          return vitales = value;
        }).whenComplete(() => Archivos.createJsonFromMap(vitales,
                filePath: vitalesRepositoryPath));
      });
    }

    return vitales;
  }

  Future<List> getCronicosHistorial() async {
    //
    await Archivos.readJsonToMap(filePath: patologicosRepositoryPath)
        .then((value) {
      Terminal.printNotice(
          message: " : : OBTENIDO DE ARCHIVO . . . $patologicosRepositoryPath");
      //
      return patologicos = value;
    }).onError((error, stackTrace) async {
      await Actividades.consultarAllById(Databases.siteground_database_regpace,
              Patologicos.patologicos['consultByIdPrimaryQuery'], idPaciente)
          .then((value) async {
        Terminal.printNotice(message: " : : OBTENIDO DE REGISTRO . . . ");
        //
        return patologicos = value;
      }).whenComplete(() => Archivos.createJsonFromMap(patologicos,
              filePath: patologicosRepositoryPath));
    });
    return patologicos;
  }

  Future<List> getDiagnosticosHistorial() async {
    //
    await Archivos.readJsonToMap(filePath: diagnosticosRepositoryPath)
        .then((value) {
      Terminal.printNotice(
          message:
              " : : OBTENIDO DE ARCHIVO . . . $diagnosticosRepositoryPath");
      //
      return diagnosticos = value;
    }).onError((error, stackTrace) async {
      await Actividades.consultarAllById(
        Databases.siteground_database_reghosp,
        "SELECT * FROM pace_dia WHERE ID_Pace = ? "
        "AND ID_Hosp = '$idHospitalizado'",
        idPaciente,
      ).then((value) async {
        Terminal.printNotice(message: " : : OBTENIDO DE REGISTRO . . . ");
        //
        return diagnosticos = value;
      }).whenComplete(() => Archivos.createJsonFromMap(diagnosticos,
          filePath: diagnosticosRepositoryPath));
    });
    return diagnosticos;
  }

  //
  Future<List> getPendientesHistorial({bool reload = true}) async {
    //
    if (reload) {
      await Actividades.consultarAllById(
        Databases.siteground_database_reghosp,
        "SELECT * FROM pace_pen WHERE ID_Pace = ? "
        "AND ID_Hosp = $idHospitalizado",
        // "AND Pace_PEN_realized = '0'",
        idPaciente,
      ).then((value) async {
        Terminal.printNotice(message: " : : OBTENIDO DE REGISTRO . . . ");
        //
        return pendientes = value;
      }).whenComplete(() => Archivos.createJsonFromMap(pendientes,
          filePath: pendientesRepositoryPath));
      return pendientes;
    } else {
      await Archivos.readJsonToMap(filePath: pendientesRepositoryPath)
          .then((value) {
        Terminal.printNotice(
            message:
                " : : OBTENIDO DE ARCHIVO . . . $pendientesRepositoryPath");
        //
        return pendientes = value;
      }).onError((error, stackTrace) async {
        await Actividades.consultarAllById(
          Databases.siteground_database_reghosp,
          "SELECT * FROM pace_pen WHERE ID_Pace = ? "
          "AND ID_Hosp = '$idHospitalizado' "
          "AND Pace_PEN_realized = '0'",
          idPaciente,
        ).then((value) async {
          Terminal.printNotice(message: " : : OBTENIDO DE REGISTRO . . . ");
          //
          return pendientes = value;
        }).whenComplete(() => Archivos.createJsonFromMap(pendientes,
            filePath: pendientesRepositoryPath));
      });
      return pendientes;
    }
  }

  Future<List> getLicenciasHistorial() async {
    //
    await Archivos.readJsonToMap(filePath: licenciasRepositoryPath)
        .then((value) {
      Terminal.printNotice(
          message: " : : OBTENIDO DE ARCHIVO . . . $licenciasRepositoryPath");
      //
      return licencias = value;
    }).onError((error, stackTrace) async {
      await Actividades.consultarAllById(
        Databases.siteground_database_reghosp,
        "SELECT * FROM licen_med WHERE ID_Pace = ?",
        idPaciente,
      ).then((value) async {
        Terminal.printNotice(message: " : : OBTENIDO DE REGISTRO . . . ");
        //
        return licencias = value;
      }).whenComplete(() => Archivos.createJsonFromMap(licencias,
          filePath: licenciasRepositoryPath));
    });
    return licencias;
  }

  //
  Future<List> getVentilacionnesHistorial({reload: false}) async {
    if (reload) {
      await Actividades.consultarAllById(Databases.siteground_database_reghosp,
              Ventilaciones.ventilacion['consultIdQuery'], idPaciente)
          .then((value) async {
        Terminal.printNotice(message: " : : OBTENIDO DE REGISTRO . . . ");
        //
        return ventilaciones = value;
      }).whenComplete(() => Archivos.createJsonFromMap(ventilaciones,
              filePath: ventilacionesRepositoryPath));
    } else {
      //
      await Archivos.readJsonToMap(filePath: ventilacionesRepositoryPath)
          .then((value) {
        Terminal.printNotice(
            message:
                " : : OBTENIDO DE ARCHIVO . . . $ventilacionesRepositoryPath");
        //
        return ventilaciones = value;
      }).onError((error, stackTrace) async {
        await Actividades.consultarAllById(
                Databases.siteground_database_reghosp,
                Ventilaciones.ventilacion['consultIdQuery'],
                idPaciente)
            .then((value) async {
          Terminal.printNotice(message: " : : OBTENIDO DE REGISTRO . . . ");
          //
          return ventilaciones = value;
        }).whenComplete(() => Archivos.createJsonFromMap(ventilaciones,
                filePath: ventilacionesRepositoryPath));
      });
    }

    return ventilaciones;
  }

  //
  Future<List> getBalancesHistorial({reload: false}) async {
    if (reload) {
      await Actividades.consultarAllById(Databases.siteground_database_reghosp,
              Balances.balance['consultIdQuery'], idPaciente)
          .then((value) async {
        // Terminal.printNotice(message: " : : OBTENIDO DE REGISTRO . . . $value");
        return balances = value;
      }).whenComplete(() => Archivos.createJsonFromMap(balances,
              filePath: balancesRepositoryPath));
    } else {
      //
      await Archivos.readJsonToMap(filePath: balancesRepositoryPath)
          .then((value) {
        Terminal.printNotice(
            message: " : : OBTENIDO DE ARCHIVO . . . $balancesRepositoryPath"
                "");
        //
        return balances = value;
      }).onError((error, stackTrace) async {
        await Actividades.consultarAllById(
                Databases.siteground_database_reghosp,
                Balances.balance['consultIdQuery'],
                idPaciente)
            .then((value) async {
          Terminal.printNotice(
              message: " : : OBTENIDO DE REGISTRO . . . ");
          //
          return balances = value;
        }).whenComplete(() => Archivos.createJsonFromMap(balances,
                filePath: balancesRepositoryPath));
      });
    }

    return balances;
  }

  //
  Future<List> getParaclinicosHistorial({bool reload = true}) async {
    //
    if (reload) {
      await Actividades.consultarAllById(Databases.siteground_database_reggabo,
              Auxiliares.auxiliares['consultByIdPrimaryQuery'], idPaciente)
          .then((value) async {
        Terminal.printNotice(message: " : : OBTENIDO DE REGISTRO . . . ");
        //
        return paraclinicos = value;
      }).whenComplete(() => Archivos.createJsonFromMap(paraclinicos,
              filePath: paraclinicosRepositoryPath));
    } else {
      await Archivos.readJsonToMap(filePath: paraclinicosRepositoryPath)
          .then((value) {
        Terminal.printNotice(
            message:
                " : : OBTENIDO DE ARCHIVO . . . $paraclinicosRepositoryPath");
        //
        return paraclinicos = value;
      }).onError((error, stackTrace) async {
        await Actividades.consultarAllById(
                Databases.siteground_database_reggabo,
                Auxiliares.auxiliares['consultByIdPrimaryQuery'],
                idPaciente)
            .then((value) async {
          Terminal.printNotice(message: " : : OBTENIDO DE REGISTRO . . . ");
          //
          return paraclinicos = value;
        }).whenComplete(() => Archivos.createJsonFromMap(paraclinicos,
                filePath: paraclinicosRepositoryPath));
      });
    }
    return paraclinicos;
  }

  Future<List> getImagenologicosHistorial() async {
    //
    await Archivos.readJsonToMap(filePath: imagenologicosRepositoryPath)
        .then((value) {
      Terminal.printNotice(
          message:
              " : : OBTENIDO DE ARCHIVO . . . $imagenologicosRepositoryPath");
      //
      return imagenologicos = value;
    }).onError((error, stackTrace) async {
      await Actividades.consultarAllById(
        Databases.siteground_database_reggabo,
        Imagenologias.imagenologias["consultByIdPrimaryQuery"],
        idPaciente,
      ).then((value) async {
        Terminal.printNotice(message: " : : OBTENIDO DE REGISTRO . . . ");
        //
        return imagenologicos = value;
      }).whenComplete(() => Archivos.createJsonFromMap(imagenologicos,
          filePath: imagenologicosRepositoryPath));
    });
    return imagenologicos;
  }

  Future<List> getElectrocardiogramasHistorial() async {
    //
    await Archivos.readJsonToMap(filePath: electrocardiogramasRepositoryPath)
        .then((value) {
      Terminal.printNotice(
          message:
              " : : OBTENIDO DE ARCHIVO . . . $electrocardiogramasRepositoryPath");
      //
      return electrocardiogramas = value;
    }).onError((error, stackTrace) async {
      await Actividades.consultarAllById(
        Databases.siteground_database_reggabo,
        Electrocardiogramas.electrocardiogramas["consultByIdPrimaryQuery"],
        idPaciente,
      ).then((value) async {
        Terminal.printNotice(message: " : : OBTENIDO DE REGISTRO . . . ");
        //
        return electrocardiogramas = value;
      }).whenComplete(() => Archivos.createJsonFromMap(electrocardiogramas,
          filePath: electrocardiogramasRepositoryPath));
    });
    return electrocardiogramas;
  }

  // METHODS
  static String getUltimo(
      {required List listadoFrom,
      bool esAbreviado = false,
      bool withoutInsighs = false}) {
    String prosa = "";

    var fechar = Listas.listWithoutRepitedValues(
      Listas.listFromMapWithOneKey(
        // Pacientes.Paraclinicos!,
        Listas.filterAndFindRecent(listadoFrom, Auxiliares.especiales),
        keySearched: 'Fecha_Registro',
      ),
    );

    if (fechar.isNotEmpty) {
      if (fechar.first.isNotEmpty) {
        if (esAbreviado) {
          List<dynamic>? alam = listadoFrom;
          //
          var aux = alam
              .where((user) => user["Fecha_Registro"].contains(fechar.first))
              .toList();
          String fecha = "          Paraclínicos (${fechar.first})", max = "";

          for (var element in aux) {
            // ***************************** *****************
            if (element['Tipo_Estudio'] != "Examen General de Orina" &&
                element['Tipo_Estudio'] != "Depuración de Orina de 24 Horas" &&
                element['Tipo_Estudio'] != "Líquido de Diálisis Peritoneal" &&
                element['Tipo_Estudio'] != "Gasometría Arterial" &&
                element['Tipo_Estudio'] != "Gasometría Venosa" &&
                element['Tipo_Estudio'] != "Reactantes de Fase Aguda" &&
                element['Tipo_Estudio'] != "Cultivos" &&
                element['Tipo_Estudio'] != "Panel Viral" &&
                element['Tipo_Estudio'] !=
                    "Citoquímico de Líquido Cefalorraquídeo" &&
                element['Tipo_Estudio'] !=
                    "Citológico de Líquido Cefalorraquídeo") {
              if (max == "") {
                max =
                    "${Auxiliares.abreviado(estudio: element['Estudio'], tipoEstudio: element['Tipo_Estudio'])} ${element['Resultado']} ${element['Unidad_Medida']}";
              } else {
                max =
                    "$max, ${Auxiliares.abreviado(estudio: element['Estudio'], tipoEstudio: element['Tipo_Estudio'])} ${element['Resultado']} ${element['Unidad_Medida']}";
              }
            }
          }
          // COMPROBACIÓN
          if (max != "") {
            prosa = "$prosa$fecha: ${Sentences.capitalize(max)}\n";
          }
        } else if (withoutInsighs) {
          List<dynamic>? alam = listadoFrom;
          var aux = alam
              .where((user) => user["Fecha_Registro"].contains(fechar.first))
              .toList();
          String fecha = "          Paraclínicos (${fechar.first})", max = "";

          for (var element in aux) {
            // ***************************** *****************
            if (element['Tipo_Estudio'] != "Examen General de Orina" &&
                element['Tipo_Estudio'] != "Depuración de Orina de 24 Horas" &&
                element['Tipo_Estudio'] != "Líquido de Diálisis Peritoneal" &&
                element['Tipo_Estudio'] != "Gasometría Arterial" &&
                element['Tipo_Estudio'] != "Gasometría Venosa" &&
                element['Tipo_Estudio'] != "Reactantes de Fase Aguda" &&
                element['Tipo_Estudio'] != "Cultivos" &&
                element['Tipo_Estudio'] !=
                    "Citoquímico de Líquido Cefalorraquídeo" &&
                element['Tipo_Estudio'] !=
                    "Citológico de Líquido Cefalorraquídeo") {
              if (max == "") {
                max =
                    "${Auxiliares.abreviado(estudio: element['Estudio'], tipoEstudio: element['Tipo_Estudio'])} ${element['Resultado']}";
              } else {
                max =
                    "$max, ${Auxiliares.abreviado(estudio: element['Estudio'], tipoEstudio: element['Tipo_Estudio'])} ${element['Resultado']}";
              }
            }
          }
          // COMPROBACIÓN
          if (max != "") {
            prosa = "$prosa$fecha: ${Sentences.capitalize(max)}\n";
          }
        } else {
          List<dynamic>? alam = listadoFrom;
          var aux = alam
              .where((user) => user["Fecha_Registro"].contains(fechar.first))
              .toList();
          String fecha = "          Paraclínicos (${fechar.first})", max = "";

          for (var element in aux) {
            // ***************************** *****************
            if (element['Tipo_Estudio'] != "Examen General de Orina" &&
                element['Tipo_Estudio'] != "Depuración de Orina de 24 Horas" &&
                element['Tipo_Estudio'] != "Líquido de Diálisis Peritoneal" &&
                element['Tipo_Estudio'] != "Gasometría Arterial" &&
                element['Tipo_Estudio'] != "Gasometría Venosa" &&
                element['Tipo_Estudio'] != "Reactantes de Fase Aguda" &&
                element['Tipo_Estudio'] != "Cultivos" &&
                element['Tipo_Estudio'] !=
                    "Citoquímico de Líquido Cefalorraquídeo" &&
                element['Tipo_Estudio'] !=
                    "Citológico de Líquido Cefalorraquídeo") {
              if (max == "") {
                max =
                    "${element['Estudio'].toLowerCase()} ${element['Resultado']} ${element['Unidad_Medida']}";
              } else {
                max =
                    "$max, ${element['Estudio'].toLowerCase()} ${element['Resultado']} ${element['Unidad_Medida']}";
              }
            }
          }
          // COMPROBACIÓN
          if (max != "") {
            prosa = "$prosa$fecha: ${Sentences.capitalize(max)}\n";
          }
        }
      }
    }
    // ************** ***************** ***************
    return prosa;
  }

  static String getCultivos({
    required List listadoFrom,
    bool esAbreviado = true,
  }) {
    String prosa = "";

    var fechar = Listas.listWithoutRepitedValues(
      Listas.listFromMapWithOneKey(
        // Pacientes.Paraclinicos!,
        Listas.filterAndFindRecent(listadoFrom, ["Cultivos"],
            withEspeciales: true),
        keySearched: 'Fecha_Registro',
      ),
    );

    Terminal.printExpected(message: fechar.toString());

    if (fechar.isNotEmpty) {
      for (var fecha in fechar) {
        var aux =
            listadoFrom.where((user) => user["Fecha_Registro"].contains(fecha));
        // String fechado = "          .          ${fecha})";
        String max = "";
        //
        for (var element in aux) {
          Terminal.printExpected(
              message: "$fecha : ${element['Tipo_Estudio']}");
          // Terminal.printExpected(message: "${Auxiliares.abreviado(estudio: element['Estudio'], tipoEstudio: element['Tipo_Estudio'])} ${element['Resultado']} ${element['Unidad_Medida']}");

          // ***************************** *****************
          if (element['Tipo_Estudio'] == "Cultivos") {
            max = "$max"
                "          .          ${element['Estudio']} del ${Calendarios.formatDate(fecha)}. .  ${element['Resultado']} . ";
            // max =
            // "$max${Auxiliares.abreviado(estudio: element['Estudio'], tipoEstudio: element['Tipo_Estudio'])} "
            //     "${element['Resultado']}, ";
          }
        }
        // COMPROBACIÓN

        prosa = "$prosa $max\n";
      }
    }
    // ************** ***************** ***************
    return prosa;
  }

  static String getEspeciales(
      {required List listadoFrom,
      bool esAbreviado = true,
      bool withoutInsighs = false}) {
    String prosa = "";

    var fechar = Listas.listWithoutRepitedValues(
      Listas.listFromMapWithOneKey(
        Listas.filterAndFindRecent(listadoFrom, Auxiliares.especiales,
            withEspeciales: true),
        keySearched: 'Fecha_Registro',
      ),
    );

    Terminal.printExpected(message: fechar.toString());

    if (fechar.isNotEmpty) {
      for (var fecha in fechar) {
        var aux =
            listadoFrom.where((user) => user["Fecha_Registro"].contains(fecha));
        // String fechado = "          .          Paraclínicos (${fecha})",
        String tipoEstudio = "";
        String fechado = "";
        String max = "";
        //
        for (var element in aux) {
          Terminal.printExpected(
              message: "$fecha : ${element['Tipo_Estudio']}");
          // Terminal.printExpected(message: "${Auxiliares.abreviado(estudio: element['Estudio'], tipoEstudio: element['Tipo_Estudio'])} ${element['Resultado']} ${element['Unidad_Medida']}");

          // ***************************** *****************
          if (element['Tipo_Estudio'] == "Examen General de Orina" ||
              element['Tipo_Estudio'] == "Depuración de Orina de 24 Horas" ||
              element['Tipo_Estudio'] == "Líquido de Diálisis Peritoneal" ||
              // element['Tipo_Estudio'] == "Gasometría Arterial" ||
              // element['Tipo_Estudio'] == "Gasometría Venosa" ||
              // element['Tipo_Estudio'] == "Reactantes de Fase Aguda" ||
              // element['Tipo_Estudio'] == "Cultivos" ||
              // element['Tipo_Estudio'] == "Tiempos de Coagulación" ||
              element['Tipo_Estudio'] ==
                  "Citoquímico de Líquido Cefalorraquídeo" ||
              element['Tipo_Estudio'] == "Panel Viral" ||
              element['Tipo_Estudio'] ==
                  "Citológico de Líquido Cefalorraquídeo") {
            tipoEstudio = element['Tipo_Estudio'];

            if (element['Resultado'] != "" &&
                element['Resultado'] != "Negativo" &&
                element['Resultado'] != "negativo" &&
                element['Resultado'] != "No Se Observan" &&
                element['Resultado'] != "No se Observan") {
              if (element['Unidad_Medida'] != "") {
                // fechado = "          .          ($fecha): ";
                fechado = " ($fecha): ";
                max =
                    "$max${Auxiliares.abreviado(estudio: element['Estudio'], tipoEstudio: element['Tipo_Estudio'])} "
                    "${element['Resultado']} ${element['Unidad_Medida']}, ";
              } else {
                max =
                    "$max${Auxiliares.abreviado(estudio: element['Estudio'], tipoEstudio: element['Tipo_Estudio'])} "
                    "${element['Resultado']}, ";
              }
            }
          }
        }
        // COMPROBACIÓN
        if (fechado != "") {
          prosa = "$prosa "
              "          .          "
              "$tipoEstudio $fechado ${Sentences.capitalize(max)}\n";
        }
      }
    }
    // ************** ***************** ***************
    return prosa;
  }

  static String getGasometrico({
    required List listadoFrom,
    bool esAbreviado = true,
  }) {
    String prosa = "", fecha = "", max = "";

    var fechar = Listas.listFromMapWithOneKey(
      // Pacientes.Paraclinicos!,
      Listas.filterAndFindRecent(
          listadoFrom,
          [
            "Gasometría Arterial",
            "Gasometría Venosa",
            // "Biometría Hemática",
            // "Electrolitos Séricos",
          ],
          withEspeciales: true),
      keySearched: 'Fecha_Registro',
    );

    // if (fechar.isNotEmpty) {
    //     //
    //     var aux = listadoFrom
    //         .where((user) => user.containsKey("Fecha_Registro") &&
    //         user["Fecha_Registro"] != null &&
    //         user["Fecha_Registro"].toString().contains(fechar.first))
    //         .toList();
    //     // Terminal.printSuccess(message: aux.toString());
    //     Gasometricos.fromJson(aux);
    //   }
    if (fechar.isNotEmpty) {
      var aux = listadoFrom
          .where((user) => user["Fecha_Registro"].contains(fechar.first))
          .toList();
      fecha = "          Paraclínicos (${fechar.first})";

      for (var element in aux) {
        // ***************************** *****************
        if (element['Tipo_Estudio'] != "Gasometría Arterial" ||
            element['Tipo_Estudio'] != "Gasometría Venosa") {
          if (max == "") {
            max =
                "${Auxiliares.abreviado(estudio: element['Estudio'], tipoEstudio: element['Tipo_Estudio'])} ${element['Resultado']} "
                "${element['Unidad_Medida'] != "" ? element['Unidad_Medida'] : ""}";
          } else {
            max =
                "$max, ${Auxiliares.abreviado(estudio: element['Estudio'], tipoEstudio: element['Tipo_Estudio'])} ${element['Resultado']} "
                "${element['Unidad_Medida'] != "" ? element['Unidad_Medida'] : ""}";
          }
        }
      }

      // COMPROBACIÓN
      if (max != "") {
        prosa = "$prosa$fecha: ${Sentences.capitalize(max)}\n\n";
      }
    }
    // ************** ***************** ***************
    return prosa;
  }

  static String getReactantes({
    required List listadoFrom,
    bool esAbreviado = true,
  }) {
    String prosa = "", fecha = "", max = "";

    var fechar = Listas.listFromMapWithOneKey(
      // Pacientes.Paraclinicos!,
      Listas.filterAndFindRecent(
          listadoFrom,
          [
            "Reactantes de Fase Aguda",
          ],
          withEspeciales: true),
      keySearched: 'Fecha_Registro',
    );

    //
    if (fechar.isNotEmpty) {
      var aux = listadoFrom
          .where((user) => user["Fecha_Registro"].contains(fechar.first))
          .toList();
      fecha = "          Paraclínicos (${fechar.first})";

      for (var element in aux) {
        // ***************************** *****************
        if (element['Tipo_Estudio'] == "Reactantes de Fase Aguda") {
          if (max == "") {
            max =
                "${Auxiliares.abreviado(estudio: element['Estudio'], tipoEstudio: element['Tipo_Estudio'])} ${element['Resultado']} "
                "${element['Unidad_Medida'] != "" ? element['Unidad_Medida'] : ""}";
          } else {
            max =
                "$max, ${Auxiliares.abreviado(estudio: element['Estudio'], tipoEstudio: element['Tipo_Estudio'])} ${element['Resultado']} "
                "${element['Unidad_Medida'] != "" ? element['Unidad_Medida'] : ""}";
          }
        }
      }

      // COMPROBACIÓN
      if (max != "") {
        prosa = "$prosa$fecha: ${Sentences.capitalize(max)}\n";
      }
    }
    // ************** ***************** ***************
    return prosa;
  }

  static String getCoagulacion({
    required List listadoFrom,
    bool esAbreviado = true,
  }) {
    String prosa = "", fecha = "", max = "";

    var fechar = Listas.listFromMapWithOneKey(
      // Pacientes.Paraclinicos!,
      Listas.filterAndFindRecent(listadoFrom, ["Tiempos de Coagulación"],
          withEspeciales: true),
      keySearched: 'Fecha_Registro',
    );

    //
    if (fechar.isNotEmpty) {
      var aux = listadoFrom
          .where((user) => user["Fecha_Registro"].contains(fechar.first))
          .toList();
      fecha = "          Paraclínicos (${fechar.first})";

      for (var element in aux) {
        // ***************************** *****************
        if (element['Tipo_Estudio'] == "Tiempos de Coagulación") {
          if (max == "") {
            max =
                "${Auxiliares.abreviado(estudio: element['Estudio'], tipoEstudio: element['Tipo_Estudio'])} ${element['Resultado']} "
                "${element['Unidad_Medida'] != "" ? element['Unidad_Medida'] : ""}";
          } else {
            max =
                "$max, ${Auxiliares.abreviado(estudio: element['Estudio'], tipoEstudio: element['Tipo_Estudio'])} ${element['Resultado']} "
                "${element['Unidad_Medida'] != "" ? element['Unidad_Medida'] : ""}";
          }
        }
      }
    }

    // COMPROBACIÓN
    if (max != "") {
      prosa = "$prosa$fecha: ${Sentences.capitalize(max)}\n";
    }
    // ************** ***************** ***************
    return prosa;
  }

  // OTROS METODOS
  static updateStatus({required listadoFrom}) async {
    Terminal.printExpected(
        message: "${listadoFrom.generales['ID_Pace']} . . "
            "${listadoFrom.hospitalizedData['ID_Hosp']}");
    //
    int _idPace = listadoFrom.generales['ID_Pace'],
        _idHosp = listadoFrom.hospitalizedData['ID_Hosp'];
    String motivoEgresoValue = Escalas.motivosEgresos[2];
    //
    await Actividades.actualizar(
        Databases.siteground_database_reghosp,
        "UPDATE pace_hosp "
        "SET Dia_Estan = ?,  Feca_EGE_Hosp = ?,  EGE_Motivo = ? "
        "WHERE ID_Hosp =  ?",
        [
          Calendarios.differenceInDaysToNow(
              listadoFrom.hospitalizedData['Feca_INI_Hosp']),
          motivoEgresoValue,
          //
          _idHosp
        ],
        _idHosp);
    await Actividades.actualizar(
        Databases.siteground_database_regpace,
        "UPDATE pace_iden_iden "
        "SET Pace_Hosp = ? "
        "WHERE ID_Pace = ?",
        [Pacientes.Atencion[2], _idPace],
        _idPace);
  }
}
