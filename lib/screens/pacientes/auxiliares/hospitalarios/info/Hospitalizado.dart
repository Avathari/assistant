import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';

class Internado {
  late int idPaciente, idHospitalizado;
  late String nombreCompleto;
  late String localRepositoryPath,
      vitalesRepositoryPath,
      patologicosRepositoryPath,
      paraclinicosRepositoryPath;
  //
  late List vitales = [],
      patologicos = [],
      paraclinicos = [],
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
    localRepositoryPath = 'assets/vault/'
        '$nombreCompleto/';
    //
    vitalesRepositoryPath = "${localRepositoryPath}vitales.json";
    paraclinicosRepositoryPath = "${localRepositoryPath}paraclinicos.json";
    patologicosRepositoryPath = "${localRepositoryPath}patologicos.json";
    //
    Terminal.printExpected(
        message: "localRepositoryPath : : $localRepositoryPath");
    Terminal.printExpected(message: "nombreCompleto : : $nombreCompleto");
  }

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
        idHospitalizado = value['ID_Hosp'];
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

  Future<List> getParaclinicosHistorial() async {
    //
    await Archivos.readJsonToMap(filePath: paraclinicosRepositoryPath)
        .then((value) {
      Terminal.printNotice(
          message:
              " : : OBTENIDO DE ARCHIVO . . . $paraclinicosRepositoryPath");
      //
      return paraclinicos = value;
    }).onError((error, stackTrace) async {
      await Actividades.consultarAllById(Databases.siteground_database_reggabo,
              Auxiliares.auxiliares['consultByIdPrimaryQuery'], idPaciente)
          .then((value) async {
        Terminal.printNotice(message: " : : OBTENIDO DE REGISTRO . . . ");
        //
        return paraclinicos = value;
      }).whenComplete(() => Archivos.createJsonFromMap(paraclinicos,
              filePath: paraclinicosRepositoryPath));
    });
    return paraclinicos;
  }
}
