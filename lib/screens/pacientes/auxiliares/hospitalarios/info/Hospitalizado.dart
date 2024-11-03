import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';

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
  late Map<String, dynamic> generales, hospitalizedData, padecimientoActual;

  /// CONTRUCTOR de Pacientes Hospitalizados : Funciones básicas
  Internado(this.idPaciente, Map<String, dynamic> json) {
    //
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
    vitalesRepositoryPath = "${localRepositoryPath}/vitales.json";
    patologicosRepositoryPath = "${localRepositoryPath}/patologicos.json";
    diagnosticosRepositoryPath = "${localRepositoryPath}/diagnosticos.json";
    pendientesRepositoryPath = "${localRepositoryPath}/pendientes.json";
    licenciasRepositoryPath = "${localRepositoryPath}/licencias.json";

    ventilacionesRepositoryPath = "${localRepositoryPath}/ventilaciones.json";
    balancesRepositoryPath = "${localRepositoryPath}/balances.json";

    imagenologicosRepositoryPath = "${localRepositoryPath}/imagenologias.json";
    electrocardiogramasRepositoryPath =
        "${localRepositoryPath}/electrocardiogramas.json";
    paraclinicosRepositoryPath = "${localRepositoryPath}/paraclinicos.json";
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

  Future<Map<String, dynamic>> getHospitalizationRegister() async =>
      await Actividades.consultarId(
        Databases.siteground_database_reghosp,
        "SELECT * FROM pace_hosp WHERE ID_Pace = ? "
        "ORDER BY ID_Hosp ASC",
        idPaciente,
      ).then((value) {
        idHospitalizado = value['ID_Hosp'] ?? 0;
        return hospitalizedData = value;
      });

  // METHODS  *******************************************
  Future<List> getVitalesHistorial() async {
    //
    await Archivos.readJsonToMap(filePath: vitalesRepositoryPath).then((value) {
      Terminal.printNotice(
          message: " : : OBTENIDO DE ARCHIVO . . . $vitalesRepositoryPath");
      //
      return vitales = value;
    }).onError((error, stackTrace) async {
      await Actividades.consultarAllById(Databases.siteground_database_regpace,
              Vitales.vitales['consultByIdPrimaryQuery'], idPaciente)
          .then((value) async {
        Terminal.printNotice(message: " : : OBTENIDO DE REGISTRO . . . ");
        //
        return vitales = value;
      }).whenComplete(() => Archivos.createJsonFromMap(vitales,
              filePath: vitalesRepositoryPath));
    });
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
  Future<List> getVentilacionnesHistorial() async {
    //
    await Archivos.readJsonToMap(filePath: ventilacionesRepositoryPath)
        .then((value) {
      Terminal.printNotice(
          message:
              " : : OBTENIDO DE ARCHIVO . . . $ventilacionesRepositoryPath");
      //
      return ventilaciones = value;
    }).onError((error, stackTrace) async {
      await Actividades.consultarAllById(Databases.siteground_database_reghosp,
              Ventilaciones.ventilacion['consultIdQuery'], idPaciente)
          .then((value) async {
        Terminal.printNotice(message: " : : OBTENIDO DE REGISTRO . . . ");
        //
        return ventilaciones = value;
      }).whenComplete(() => Archivos.createJsonFromMap(ventilaciones,
              filePath: ventilacionesRepositoryPath));
    });
    return ventilaciones;
  }

  //
  Future<List> getBalancesHistorial({reload: false}) async {
    if (reload) {
      await Actividades.consultarAllById(Databases.siteground_database_reghosp,
          Balances.balance['consultIdQuery'], idPaciente)
          .then((value) async {
        Terminal.printNotice(message: " : : OBTENIDO DE REGISTRO . . . $value");
        //
        return balances = value;
      }).whenComplete(() => Archivos.createJsonFromMap(balances,
          filePath: balancesRepositoryPath));

    } else {
      //
      await Archivos.readJsonToMap(filePath: balancesRepositoryPath)
          .then((value) {
        Terminal.printNotice(
            message: " : : OBTENIDO DE ARCHIVO . . . $balancesRepositoryPath"
                "$value");
        //
        return balances = value;
      }).onError((error, stackTrace) async {
        await Actividades.consultarAllById(Databases.siteground_database_reghosp,
            Balances.balance['consultIdQuery'], idPaciente)
            .then((value) async {
          Terminal.printNotice(message: " : : OBTENIDO DE REGISTRO . . . $value");
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
  static String getCultivos({
    required List listadoFrom,
    bool esAbreviado = true,
  }) {
    String prosa = "", max = "", fecha = "";

    // ***************************** *****************
    var estudiosPresentes = Listas.listWithoutRepitedValues(
      Listas.listFromMapWithOneKey(
        listadoFrom,
        keySearched: 'Estudio',
      ),
    );
    // Terminal.printSuccess(message: "presentes: ${estudiosPresentes}");
    var newList = Listas.compareOneListWithAnother(
        estudiosPresentes, Auxiliares.cultivos);
    // Terminal.printSuccess(message: "newList: ${newList}");
    //
    for (var elem in newList) {
      listadoFrom
          .where((element) => element["Estudio"].contains(elem))
          .forEach((eacher) {
        fecha =
            "          ${eacher['Estudio']} (${eacher['Fecha_Registro']}) - ";
        // Terminal.printExpected(message: "eacher: ${eacher}");
        max = "$max${eacher['Resultado']}, ";
      });
      //
      prosa = "$prosa$fecha$max. \n";
      max = "";
    }

    // ************** ***************** ***************
    return prosa;
  }
}
