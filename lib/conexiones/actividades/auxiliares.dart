import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:assistant/conexiones/actividades/pdfGenerete/PdfApi.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

Future<String> imageToBase(String pathFile) async {
  ByteData bytes = await rootBundle.load(pathFile);
  var buffer = bytes.buffer;
  return base64.encode(Uint8List.view(buffer));
}

class Calendarios {
  static String today({String format = "yyyy.MM.dd"}) {
    return DateFormat(format).format(DateTime.now());
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

  static Object fromInt(int boolItem, {toBoolean = false}) {
    if (boolItem == 1) {
      if (toBoolean) {
        return true;
      } else {
        return "Si";
      }
    } else if (boolItem == 0) {
      if (toBoolean) {
        return false;
      } else {
        return "No";
      }
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

  static Object fromBoolean(bool boolItem, {toInt = false}) {
    if (boolItem) {
      if (toInt) {
        return 1;
      } else {
        return "Si";
      }
    } else {
      if (toInt) {
        return 0;
      } else {
        return "No";
      }
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
    // var file = File(path), contents;
    var file, contents;
    //
    if (Platform.isAndroid) {
      contents = await rootBundle.loadString(path);
      return jsonDecode(contents);
    } else {
      file = File(path);
      if (await file.exists()) {
        contents = await file.readAsString();
        return json.decode(await contents);
      } else {
        throw "No existe el archivo $path";
      }
    }
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
    // print(_list);
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

  static choiseFromCamara() async {
    final picker = ImagePicker();
    XFile? xFileImage = await picker.pickImage(source: ImageSource.camera);
    if (xFileImage != null) {
      Uint8List bytes = await xFileImage.readAsBytes();
      return bytes;
    }
  }

  static choiseFromDirectory() async {
    final picker = ImagePicker();
    XFile? xFileImage = await picker.pickImage(source: ImageSource.gallery);
    if (xFileImage != null) {
      Uint8List bytes = await xFileImage.readAsBytes();
      return bytes;
    }
  }
}

class Opciones {
  static List<String> horarios() {
    return ['2', '4', '8', '10', '12', '16', '24'];
  }
}

class Operadores {
  static void openDialog(
      {required BuildContext context, required Widget chyldrim,
        Function? onAction}) {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          return Dialog(
              backgroundColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: chyldrim),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: Colors.grey,
                          )),
                      child: GrandButton(
                        labelButton: 'Cerrar',
                        onPress: () {
                          if (onAction == null || onAction == Null) {
                            Navigator.of(context).pop();
                          } else {
                            onAction();
                            Navigator.of(context).pop();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ));
        });
  }

  static Future<void> openActivity(
      {required BuildContext context,
      required Widget chyldrim,
      Function? onAction}) async {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          print("ON ACTION $onAction ${onAction.runtimeType}");
          return SimpleDialog(
            backgroundColor: Colors.black,
            children: [
              Flexible(child: chyldrim),
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: Colors.grey,
                    )),
                child: GrandButton(
                  labelButton: 'Cerrar',
                  onPress: () {
                    if (onAction == null || onAction == Null) {
                      Navigator.of(context).pop();
                    } else {
                      onAction();
                      Navigator.of(context).pop();
                    }
                    //
                  },
                ),
              ),
            ],
          );
        });
  }

  static void optionsActivity({
    required BuildContext context,
    String? tittle = "Manejo de Opciones",
    String? message = "Seleccione una opción . . . ",
    Function? onClose,
    Function? optionA,
    Function? optionB,
    String? textOptionA = 'Opción A',
    String? textOptionB = 'Option B',
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialogos.optionsDialog(
            tittle: tittle,
            msg: message,
            onCloss: onClose,
            optionA: optionA,
            optionB: optionB,
            textOptionA: textOptionA,
            textOptionB: textOptionB,
          );
        });
  }

  static void listOptionsActivity({
    required BuildContext context,
    String? tittle = "Manejo de Opciones",
    String? message = "Seleccione una opción . . . ",
    required List<List<String>> options,
    Function? onClose,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialogos.listOptionsDialog(
            tittle: tittle,
            msg: message,
            options: options,
            onCloss: onClose,
          );
        });
  }

  static void alertActivity(
      {required BuildContext context,
      String? tittle = "Manejo de registro",
      String? message = "El registro ha sido actualizado / creado"}) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialogos.alertDialog(tittle, message, () {
            Navigator.of(context).pop();
          }, () {});
        });
  }
}

class Dialogos {
  static AlertDialog alertDialog(
      String? tittle, String? msg, onCloss, onAcept) {
    return AlertDialog(
      backgroundColor: Theming.secondaryColor,
      title: Text(
        tittle!,
        style: const TextStyle(color: Colors.grey),
      ),
      content: Text(
        msg!,
        style: const TextStyle(color: Colors.grey),
      ),
      actions: [
        OutlinedButton(
            onPressed: () {
              onCloss();
            },
            child:
                const Text("Cancelar", style: TextStyle(color: Colors.white))),
        ElevatedButton(
            onPressed: () {
              onAcept();
            },
            child: const Text("Aceptar", style: TextStyle(color: Colors.white)))
      ],
    );
  }

  static AlertDialog optionsDialog({
    String? tittle,
    String? msg,
    Function? onCloss,
    Function? optionA,
    Function? optionB,
    String? textOptionA = 'Opción A',
    String? textOptionB = 'Option B',
  }) {
    return AlertDialog(
      backgroundColor: Theming.secondaryColor,
      title: Text(
        tittle!,
        style: const TextStyle(color: Colors.grey),
      ),
      content: Text(
        msg!,
        style: const TextStyle(color: Colors.grey),
      ),
      actions: [
        OutlinedButton(
            onPressed: () {
              onCloss!();
            },
            child:
                const Text("Cancelar", style: TextStyle(color: Colors.white))),
        ElevatedButton(
            onPressed: () {
              optionA!();
            },
            child: Text(textOptionA!,
                style: const TextStyle(color: Colors.white))),
        ElevatedButton(
            onPressed: () {
              optionB!();
            },
            child:
                Text(textOptionB!, style: const TextStyle(color: Colors.white)))
      ],
    );
  }

  static AlertDialog listOptionsDialog({
    String? tittle,
    String? msg,
    Function? onCloss,
    required List<List<String>> options,
  }) {
    List<Widget> list = [];

    for (var element in options) {
      list.add(Column(
        children: [
          ListTile(
            onTap: () {
              PdfApi.openFile(File(element[1]));
            },
            title: Text(
              element[0],
              style: const TextStyle(color: Colors.grey),
            ),
            subtitle: Text(
              element[2],
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 10,color: Colors.grey),
            ),
          ),
          const CrossLine(),
        ],
      ));
    }

    return AlertDialog(
      backgroundColor: Theming.secondaryColor,
      title: Text(
        tittle!,
        style: const TextStyle(color: Colors.grey),
      ),
      content: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: list,
          )),
      actions: [
        ElevatedButton(
            onPressed: () {
              onCloss!();
            },
            child:
                const Text("Cancelar", style: TextStyle(color: Colors.white))),
      ],
    );
  }
}
