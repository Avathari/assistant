import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

Future<String> imageToBase(String pathFile) async {
  ByteData bytes = await rootBundle.load(pathFile);
  var buffer = bytes.buffer;
  return base64.encode(Uint8List.view(buffer));
}

class Calendarios {
  static String today() {
    return DateFormat("yyyy.MM.dd").format(DateTime.now());
  }

  static String completeToday() {
    return DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY)
        .format(DateTime.now());
  }
}

class Dicotomicos {
  static List<String> dicotomicos() {
    return ["Si", "No"];
  }

  static String fromInt(int boolItem) {
    if (boolItem == 1) {
      return "Si";
    } else if (boolItem == 0) {
      return "No";
    } else {
      return "No";
    }
  }

  static int toInt(String boolItem) {
    if (boolItem == "Si") {
      return 1;
    } else if (boolItem == "No") {
      return 0;
    } else {
      return 0;
    }
  }

  static String fromBoolean(bool boolItem) {
    if (boolItem) {
      return "Si";
    } else {
      return "No";
    }
  }
}

class Archivos {
  static Future<String> textFormTxt(
      {String path = 'assets/diccionarios/Cirugias.txt'}) async {
    var file = File(path), contents;
    //
    if (await file.exists()) {
      contents = await file.readAsString();
    } else {
      throw "No existe el archivo $path";
    }
    return contents;
  }

  static Future<Map<String, dynamic>> mapFromJson(
      {String path = 'assets/diccionarios/Cie.json'}) async {
    var file = File(path), contents;
    //
    if (await file.exists()) {
      contents = await file.readAsString();
    } else {
      throw "No existe el archivo $path";
    }
    return json.decode(await contents);
  }

  static Future<List<dynamic>> listFromText(
      {required String path, required String splitChar}) async {
    // var file = File(path), contents;
    var file, contents;
    //
    List<dynamic> _list = [];
    //
    if (Platform.isAndroid) {
      contents = await rootBundle.loadString(path);
      print("${file.runtimeType} :: $file");
      for (var elem in contents.split(splitChar)) {
        _list.add(elem);
      }
    } else {
      file = File(path);
      //
      if (await file.exists()) {
        contents = await file.readAsString();
        for (var elem in contents.split(splitChar)) {
          _list.add(elem);
        }
      } else {
        throw "No existe el archivo $path";
      }
    }
    print(_list);
    //
    return _list;
  }
}

class Alertas {
  static void showAlert({BuildContext? context, required String error}) {
    showDialog(
        context: context!,
        builder: (context) => AlertDialog(
              title: const Text('Error al guardar documento'),
              content: Text(error),
            ));
  }
}

class Directorios {
  static String? videoTemporalPath;
  //
  static Future<String> convtoImage(String name) async {
    Directory tempDir = await getLibraryDirectory();
    String tempPath = tempDir.path;
    return tempPath;
  }

  static upload(String urlPath, {required dynamic filePath}) async {
    final request = await http.MultipartRequest(
        'POST', Uri.parse("${Env.URL_PREFIX}/directorios.php"));
    request.files
        .add(await http.MultipartFile.fromPath('file', filePath!.toString()));
    var response = await request.send();
    if (response.statusCode == 200) {
      Alertas.showAlert(error: "Archivo actualizado a Servidor");
    } else {
      Alertas.showAlert(error: "Error al actualizar archivo al Servidor");
    }
  }
}

class Opciones {
  static List<String> horarios() {
    return ['2', '4', '8', '10', '12', '16', '24'];
  }
}
