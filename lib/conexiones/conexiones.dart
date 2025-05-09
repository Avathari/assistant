import 'dart:io';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/cupertino.dart';
import 'package:mysql1/mysql1.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

const String hostname = Databases.HOST_SITEGROUND;
const String username = Databases.siteground_user;
const String password = Databases.siteground_password;

class Env {
  static String URL_PREFIX = Direcciones.urlSite;
}

class Direcciones {
  static String urlLocal = "http://localhost:8080/flutter_api";
  static String urlSite =
      "https://luisr107.sg-host.com/"; // luisr107.sg-host.com // https://luisr107.sg-host.com/
  static String urlAnother = "http://192.168.0.19:8080/flutter_api";
}

class MySQL {
  MySQL();

//String user, String password, String database
  static Future<MySqlConnection> conexion({String? database}) async {
    return await MySqlConnection.connect(ConnectionSettings(
        host: hostname,
        port: 3306,
        user: username, // username,
        password: password, // password,
        db: database // Databases.siteground_database_regpace
        ));
  }

  static Future<List> consultar(String database, String query) async {
    List<Map<String, dynamic>> list = [];
    Map<String, dynamic> innerList = {};
    // **********************************************
    Indices.indice = 0;
    // **********************************************
    final conexion = await MySQL.conexion(database: database);
    final results = await conexion.query(query);
    // ******************* *****************************************************
    for (var element in results) {
      // ******************* ***************************************************
      Indices.indice = 0;
      innerList = {};
      // ******************* ***************************************************
      element.fields.forEach((key, value) {
        if (results.fields[Indices.indice].typeString == 'BLOB') {
          innerList[key] = base64Encode(value.toBytes());
        } else {
          innerList[key] = value;
        }
        // ******************* *************************************************
        Indices.indice++;
      });
      // ******************* ***************************************************
      list.add(innerList);
    }
    return list;
  }
}

class Actividades {
  String? operationsActividad = Constantes.Nulo;

  static Future<List> consultar(String database, String query,
      {bool emulated = false}) async {
    Terminal.printWarning(message: emulated.toString());
    final response = await http.post(
      Uri.parse("${Env.URL_PREFIX}/consultar.php"),
      encoding: Encoding.getByName('utf-8'),
      headers: {
        // 'Content-Type': 'application/json'
        // "Access-Control-Allow-Credentials: true"
      },
      body: <String, String>{
        "query": query,
        "database": database,
        "host": hostname,
        "username": username,
        "password": password,
        "emulated": emulated.toString(),
      },
    );
    Terminal.printAlert(
        message:
            "RESPONSE STATUS (consultar): : ${response.statusCode} : Body ${response.body.isEmpty} . ${response.body.toString()}");
    return json.decode(response.body).cast<Map<String, dynamic>>();
  }

  static Future<List<Map<String, dynamic>>> consultarAllById(
      String database, String query, int id,
      {bool emulated = false}) async {
    final response = await http.post(
      Uri.parse("${Env.URL_PREFIX}/consultarAllById.php"),
      encoding: Encoding.getByName('utf-8'),
      headers: {
        "Accept-Encoding": "gzip", // 📌 Solicitamos respuesta comprimida
      },
      body: <String, String>{
        "query": query,
        "database": database,
        "host": hostname,
        "username": username,
        "password": password,
        "emulated": emulated.toString(),
        "id": id.toString()
      },
    );

    if (response.statusCode == 200) {
      try {
        dynamic jsonResponse;

        if (response.headers["content-encoding"] == "gzip") {
          List<int> bytes = response.bodyBytes;
          var decompressed = utf8.decode(gzip.decode(bytes));
          jsonResponse = json.decode(decompressed);
        } else {
          jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        }

        // 📌 Verificar la estructura de la respuesta
        if (jsonResponse is List) {
          return jsonResponse.cast<Map<String, dynamic>>(); // ✅ Manejo de lista de objetos
        } else if (jsonResponse is Map<String, dynamic>) {
          return [jsonResponse]; // ✅ Convertir el objeto en lista
        } else {
          return [{'Error': 'Estructura de datos inesperada'}];
        }
      } catch (e) {
        print("Error al descomprimir o decodificar JSON: $e");
        return [
          {'Error': 'Error al procesar la respuesta'}
        ];
      }
    } else {
      return [
        {'Error': 'Hubo un error. Código: ${response.statusCode}'}
      ];
    }
  }

  static Future<Map<String, dynamic>> consultarId(
      String database, String query, int id,
      {bool emulated = false}) async {
    try {
      final response = await http.post(
        Uri.parse("${Env.URL_PREFIX}/consultarId.php"),
        encoding: Encoding.getByName('utf-8'),
        headers: {
          "Accept-Encoding": "gzip",
        },
        body: <String, String>{
          "query": query,
          "database": database,
          "host": hostname,
          "username": username,
          "password": password,
          "emulated": emulated.toString(),
          "id": id.toString()
        },
      );

      if (response.statusCode == 200) {
        String jsonString;

        // Revisamos si la respuesta está comprimida
        if (response.headers["content-encoding"] == "gzip") {
          List<int> bytes = response.bodyBytes;
          jsonString = utf8.decode(gzip.decode(bytes));
        } else {
          jsonString = response.body;
        }

        // Validamos si el JSON no está vacío
        if (jsonString.trim().isEmpty) {
          print("⚠️ Respuesta vacía del servidor");
          return {'Error': 'Respuesta vacía del servidor'};
        }

        // Intentamos decodificar el JSON
        try {
          final decoded = json.decode(jsonString);
          if (decoded is Map<String, dynamic>) {
            return decoded;
          } else {
            print("⚠️ Respuesta no es un mapa JSON válido");
            return {'Error': 'Formato JSON no válido'};
          }
        } catch (e) {
          print("⚠️ Error al decodificar JSON: $e");
          print("🔹Contenido recibido: $jsonString");
          return {'Error': 'Error al procesar JSON'};
        }
      } else {
        print("⚠️ Código de respuesta HTTP: ${response.statusCode}");
        return {'Error': 'Respuesta no exitosa del servidor'};
      }
    } catch (e) {
      print("❌ Excepción: $e");
      return {'Error': 'Excepción en la solicitud'};
    }
  }


  static Future<Map<String, dynamic>> detalles(String database, String query,
      {bool emulated = false}) async {
    final response = await http.post(
      Uri.parse("${Env.URL_PREFIX}/detalles.php"),
      encoding: Encoding.getByName('utf-8'),
      body: <String, String>{
        "query": query,
        "database": database,
        "host": hostname,
        "username": username,
        "password": password,
        "emulated": emulated.toString(),
      },
    );

    // Terminal.printAlert(message: "RESPONSE STATUS (Detalles) : : ${response.statusCode}"
    //     ":: :: Body ${response.body.isEmpty} . ${response.body.toString()}");
    return json.decode(response.body) as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> detallesById(
      String database, String query, int id,
      {bool emulated = false}) async {
    // List elements //
    Terminal.printWarning(
        message: ""
            "\n"
            "\n"
            "$emulated . ID_Pace $id . \n"
            "$database \n"
            "$hostname \n"
            "$username \n"
            "$password \n"
            "\n"
            // "$query"
            "");

    final response = await http.post(
      Uri.parse("${Env.URL_PREFIX}/detallesById.php"),
      encoding: Encoding.getByName('utf-8'),
      body: <String, String>{
        "query": query,
        "database": database,
        "host": hostname,
        "username": username,
        "password": password,
        "emulated": emulated.toString(),
        "id": id.toString()
      },
    );
    // Terminal.printNotice(message: "${response.headers}");
    // //
    // Terminal.printAlert(message: "RESPONSE STATUS (detallesById)"
    //     " : : ${response.statusCode} "
    //     " :: ${response.body.isEmpty}"
    //     " : : Body ${response.body.toString()}");
    return json.decode(response.body) as Map<String, dynamic>;
  }

  static Future<String> registrar(String database, String query, List elements,
      {bool emulated = false}) async {
    final response = await http.post(
      Uri.parse("${Env.URL_PREFIX}/registrar.php"),
      encoding: Encoding.getByName('utf-8'),
      body: <String, dynamic>{
        "query": query,
        "database": database,
        "host": hostname,
        "username": username,
        "password": password,
        "emulated": emulated.toString(),
        "elements": jsonEncode(elements),
      },
    );
    Terminal.printAlert(
        message: ""
            "RESPONSE STATUS (REGISTER) : : ${response.statusCode} :: \n "
            ":: Body ${response.body.toString()}");
    return response.body;
  }

  static Future<String> registrarAnidados(
      String database, String query, List<List> elements,
      {bool emulated = false}) async {
    final response = await http.post(
      Uri.parse("${Env.URL_PREFIX}/registrarAnidados.php"),
      encoding: Encoding.getByName('utf-8'),
      body: <String, dynamic>{
        "query": query,
        "database": database,
        "host": hostname,
        "username": username,
        "password": password,
        "emulated": emulated.toString(),
        "elements": jsonEncode(elements),
      },
    );
    // Terminal.printAlert(message: ""
    //     "RESPONSE STATUS (REGISTER_Anidados) : : ${response.statusCode} :: \n "
    //     ":: Body ${response.body.toString()}");
    return response.body;
  }

  static Future<String> actualizar(
      String database, String query, List elements, int id,
      {bool emulated = false}) async {
    final response = await http.post(
      Uri.parse("${Env.URL_PREFIX}/actualizar.php"),
      encoding: Encoding.getByName('utf-8'),
      body: <String, dynamic>{
        "query": query,
        "database": database,
        "host": hostname,
        "username": username,
        "password": password,
        "elements": jsonEncode(elements),
        "emulated": emulated.toString(),
        "id": id.toString(),
      },
    );
    // Terminal.printAlert(message: "RESPONSE STATUS (ACTUALIZAR) : : ${response.statusCode} :: :: Body ${response.body}");
    return response.body;
  }

  static Future eliminar(String database, String query, int id,
      {bool emulated = false}) async {
    final response = await http.post(
      Uri.parse("${Env.URL_PREFIX}/eliminar.php"),
      encoding: Encoding.getByName('utf-8'),
      body: <String, dynamic>{
        "query": query,
        "database": database,
        "host": hostname,
        "username": username,
        "password": password,
        "id": id.toString(),
      },
    );
    //print("RESPONSE STATUS (ELIMINAR) : : ${response.statusCode} :: :: Body ${response.body.toString()}");
    return response.body.toString();
  }
}

class Constantes {
  static String? operationsActividad = Constantes.Nulo;

  static const Nulo = 'NULO.nulo';
  static const Consult = 'CONSULT.consult';
  static const Register = 'REGISTER.register';
  static const Update = 'UPDATE.update';

  static List? dummyArray = ["Vacio"];

  static void reinit({List<dynamic>? value}) {
    Constantes.dummyArray = ["Vacio"];
    Directrices.coordenada =
        false; // Variable Global para VisualPacientes NO devuelva a Hospitalizados.dart
    // *********************************************
    // print("Constantes reinit value $value ");
    // *********************************************
    if (value == [] || value == null) {
      Constantes.dummyArray = ["Vacio"];
      // print("Constantes reinit dummyArray value1 ${Constantes.dummyArray}");
    } else {
      Constantes.dummyArray = value;
      // print("Constantes reinit dummyArray value2 ${Constantes.dummyArray}");
    }
  }
}

class Contextos {
  static BuildContext? contexto;
}

class Databases {
  // # ###############################################################
  // # Credenciales de MySQL Heroku
  // # ###############################################################
  static const HOST_HEROKU = "us-cdbr-east-05.cleardb.net";
  static const heroku_user = "b0579eb37be76c";
  static const heroku_password = "786c040e";
  static const heroku_database = "heroku_ffb1cccf9e66543";

  // # ###############################################################
  // # Credenciales de MySQL Siteground
  // # ###############################################################
  static const HOST_SITEGROUND = '35.209.114.34'; // 35.209.114.34
  static const siteground_user = "ux1ge4kaeg7w7";
  static const siteground_password = "41R.n#@1@4td";
  // # ###############################################################
  static const siteground_database_regasca = "dbwpodcchpxgbf";
  static const siteground_database_regusua =
      "dbqbfrmbo2sohg"; // "bd_regusua"; //
  static const siteground_database_regpace =
      "dbji9hkjtrf1hg"; // "bd_regpace"; //
  static const siteground_database_reggabo =
      "dbxg9atlfmttlp"; // "bd_reglabo"; //
  static const siteground_database_reghosp = "dbpuqlawq9wmpr"; // bd_reghosp
  static const siteground_database_cie = "db0wn9tets9si4";
  static const siteground_database_regepi = "dbqzcdqcuq5gi7";
  static const siteground_database_regfarma = "dbz7jeytfabs8a";
  static const siteground_database_regenolo = "dbqpxyzw1clbvt";
  static const siteground_database_regheral = "dbcpkhlf0274u5";
  static const siteground_database_vocal = "dbonsgifmtnolo";

  static const siteground_database_regfine = "dbwpodcchpxgbf";

  // # ###############################################################
  // #
  // # ###############################################################
  static const HOST_LOCAL = "Localhost"; //"192.168.0.17"; //"Localhost";
  static const local_user = "root";
  static const local_password = "";
}

class Locals {}

class Controladores {
  String? operationsActividad = Constantes.Nulo;

  static Future<List> consultar(String database, String query) async {
    final response = await http.post(
      Uri.parse("${Env.URL_PREFIX}/consultar.php"),
      encoding: Encoding.getByName('utf-8'),
      body: <String, String>{
        "query": query,
        "database": database,
        "host": hostname,
        "username": username,
        "password": password,
      },
    );
    print(
        "RESPONSE STATUS (consultar): : ${response.statusCode} : ${response.body.toString()}");
    return json.decode(response.body).cast<Map<String, dynamic>>();
  }

  static Future<List> consultarAllById(
      String database, String query, int id) async {
    final response = await http.post(
      Uri.parse("${Env.URL_PREFIX}/consultarAllById.php"),
      encoding: Encoding.getByName('utf-8'),
      body: <String, String>{
        "query": query,
        "database": database,
        "host": hostname,
        "username": username,
        "password": password,
        "id": id.toString()
      },
    );
    print(
        "RESPONSE STATUS (consultarAllById) : : ${response.statusCode} : ${response.body.toString()}");
    return json.decode(response.body).cast<Map<String, dynamic>>();
  }

  static Future<Map<String, dynamic>> consultarId(
      String database, String query, int id) async {
    final response = await http.post(
      Uri.parse("${Env.URL_PREFIX}/consultarId.php"),
      encoding: Encoding.getByName('utf-8'),
      body: <String, String>{
        "query": query,
        "database": database,
        "host": hostname,
        "username": username,
        "password": password,
        "id": id.toString()
      },
    );

    print(
        "RESPONSE STATUS (CONSULT_ID) : : ${response.statusCode}"); // : ${response.body.toString()}");
    return json.decode(response.body) as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> detalles(
      String database, String query) async {
    final response = await http.post(
      Uri.parse("${Env.URL_PREFIX}/detalles.php"),
      encoding: Encoding.getByName('utf-8'),
      body: <String, String>{
        "query": query,
        "database": database,
        "host": hostname,
        "username": username,
        "password": password,
      },
    );

    return json.decode(response.body) as Map<String, dynamic>;
  }

  static Future<String> registrar(
      String database, String query, List elements) async {
    final response = await http.post(
      Uri.parse("${Env.URL_PREFIX}/registrar.php"),
      encoding: Encoding.getByName('utf-8'),
      body: <String, dynamic>{
        "query": query,
        "database": database,
        "host": hostname,
        "username": username,
        "password": password,
        "elements": jsonEncode(elements),
      },
    );
    print(
        "RESPONSE STATUS (REGISTER) : : ${response.statusCode} :: :: Body ${response.body.toString()}");
    return response.body;
  }

  static Future<String> actualizar(
      String database, String query, List elements, int id) async {
    final response = await http.post(
      Uri.parse("${Env.URL_PREFIX}/actualizar.php"),
      encoding: Encoding.getByName('utf-8'),
      body: <String, dynamic>{
        "query": query,
        "database": database,
        "host": hostname,
        "username": username,
        "password": password,
        "elements": jsonEncode(elements),
        "id": id.toString(),
      },
    );
    print(
        "RESPONSE STATUS (ACTUALIZAR) : : ${response.statusCode} :: :: Body ${response.body}");
    return response.body;
  }

  static Future eliminar(String database, String query, int id) async {
    final response = await http.post(
      Uri.parse("${Env.URL_PREFIX}/eliminar.php"),
      encoding: Encoding.getByName('utf-8'),
      body: <String, dynamic>{
        "query": query,
        "database": database,
        "host": hostname,
        "username": username,
        "password": password,
        "id": id.toString(),
      },
    );
    print(
        "RESPONSE STATUS (ELIMINAR) : : ${response.statusCode} :: :: Body ${response.body.toString()}");
    return response.body.toString();
  }
}
