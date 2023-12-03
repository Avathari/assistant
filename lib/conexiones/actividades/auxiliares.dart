import 'dart:convert';
import 'dart:io';

import 'package:assistant/conexiones/actividades/pdfGenerete/PdfApi.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/LoadingScreen.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:path_provider/path_provider.dart';

Future<String> imageToBase(String pathFile) async {
  ByteData bytes = await rootBundle.load(pathFile);
  var buffer = bytes.buffer;
  return base64.encode(Uint8List.view(buffer));
}

class Directrices {
  static bool? coordenada = false;
}

class Calendarios {
  static String today({String format = "yyyy.MM.dd"}) {
    return DateFormat(format).format(DateTime.now());
  }

  static String completeToday() {
    return DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY)
        .format(DateTime.now());
  }

  static int differenceInDaysToNow (String fechaAnterior) {
    return DateTime.now()
        .difference(DateTime.parse(fechaAnterior))
        .inDays;
  }
  static int differenceBetweenInDays (String fechaActual, String fechaAnterior) {
    return DateTime.parse(fechaActual)
        .difference(DateTime.parse(fechaAnterior))
        .inDays;
  }
}

class Dicotomicos {
  static List<String> dicotomicos() {
    return ["Si", "No"];
  }

  static Object fromInt(int boolItem, {bool toBoolean = false}) {
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
      if (toBoolean) {
        return false;
      } else {
        return "No";
      }
    }
  }

  static bool fromString(String boolItem) {
    if (boolItem == 'Si') {
      return true;
    } else if (boolItem == 'No') {
      return false;
    } else {
      return false;
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

  static Object fromBoolean(bool boolItem, {bool toInt = false}) {
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

class Cambios {
  static void toNextPage(BuildContext context, screen) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => screen)));
  }

  static void toNextActivity(BuildContext context, {required chyld, String? tittle = '', void Function()? onClose}) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              leading: IconButton(onPressed: () {
                if(onClose == null) {
                  Navigator.of(context).pop();
                } else {
                  onClose();
                }
              }, icon: const Icon(Icons.arrow_back_ios)) ,
              title: AppBarText(tittle!),
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
            ),
            body: chyld)));
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
    List<dynamic> list = [];
    //
    if (Platform.isAndroid) {
      contents = await rootBundle.loadString(path);
      print("${file.runtimeType} :: $file");
      for (var elem in contents.split(splitChar)) {
        list.add(elem);
      }
    } else {
      file = File(path);
      //
      if (await file.exists()) {
        contents = await file.readAsString();
        for (var elem in contents.split(splitChar)) {
          list.add(elem);
        }
      } else {
        throw "No existe el archivo $path";
      }
    }
    // print(_list);
    //
    return list;
  }

  static createJsonFromMap(List<dynamic> map, {String filePath = ''}) async {
    // Terminal.printWarning(message: 'Creando archivo JSON en $filePath');
    if (Platform.isAndroid) {
      final directory = await getTemporaryDirectory();
      final File file = File("${directory.path}/$filePath");
      if (await file.exists()) {
        file.writeAsStringSync(json.encode(map));
/*        Terminal.printExpected(
            message: "Obtenido desde ${directory.path}/$filePath");*/
      } else {
        file.create(recursive: true).then((value) {
          file.writeAsStringSync(json.encode(map));
          // Terminal.printExpected(
          //     message: "Obtenido desde ${directory.path}/$filePath");
        }).onError((error, stackTrace) {
          /*Terminal.printAlert(
              message: "Error: $error desde ${directory.path}/$filePath");*/
        });
      }
    } else {
      final File file = File(filePath);
      if (await file.exists()) {
        file.writeAsStringSync(json.encode(map));
        // Terminal.printExpected(message: "Obtenido desde $filePath");
      } else {
        file.create(recursive: true).then((value) {
          file.writeAsStringSync(json.encode(map));
          // Terminal.printExpected(message: "Obtenido desde $filePath");
        }).onError((error, stackTrace) {
          Terminal.printAlert(message: "Error: $error desde $filePath");
        });
      }
    }
  }

  static Future readJsonToMap({required String filePath}) async {
    var file, contents;
    if (Platform.isAndroid) {
      final directory = await getTemporaryDirectory();
      final File file = File("${directory.path}/$filePath");

      contents = await file.readAsString();
      Terminal.printOther(
          message: "Obtenido desde ${directory.path}/$filePath");
      return jsonDecode(contents);
    } else {
      file = File(filePath);
      //
      if (await file.exists()) {
        contents = await file.readAsString();
        return jsonDecode(contents);
      } else {
        throw "No existe el archivo $filePath";
      }
    }
  }

  static Future deleteFile({required filePath}) async {
    if (Platform.isAndroid) {
      final directory = await getTemporaryDirectory();
      final File file = File("${directory.path}/$filePath");
      if (await file.exists()) {
        file.delete();
      } else {
        throw "\x1B[31mEl Archivo $filePath no Existe\x1B[0m";
      }
    } else {
      final file = File(filePath);
      if (await file.exists()) {
        file.delete(recursive: true);
        // throw "\x1B[35mEl Archivo FUE ELIMINADO\x1B[0m";
      } else {
        throw "\x1B[31mEl Archivo $filePath no Existe\x1B[0m";
      }
    }
  }

  static listDirectoriesFromPath({required filePath}) {
    List<String> paths = [];
    //
    var dir = Directory(filePath);
    List contents = dir.listSync();
    for (var fileOrDir in contents) {
      paths.add(fileOrDir.path.toString());
    }

    return paths;
  }
}

class Listas {
  static listFromString(String stringOfList) {
    return json.decode(stringOfList).cast<String>().toList();
  }

  static List<dynamic> listFromMap(
      {required List<dynamic> lista, // <Map<String, dynamic>>
      required String keySearched,
      required String elementSearched,
      bool exactValue = false}) {
    if (exactValue) {
      return lista
          .where((user) => user[keySearched] == elementSearched)
          .toList();
    } else {
      return lista
          .where((user) => user[keySearched].contains(elementSearched))
          .toList();
    }
  }

  static List<dynamic> listWithoutRepitedValues(List<dynamic> listado) {
    var seen = <dynamic>{};
    List uniquelist = listado.where((country) => seen.add(country)).toList();
    return (uniquelist..sort()).reversed.toList();

    // uniquelist..sort() Ordenar de menor a mayor
    //(uniquelist..sort()).reversed.toList() Ordenar de mayor a menor
  }

  static List<dynamic> listFromMapWithOneKey(List<dynamic> aux,
      {String keySearched = 'Fecha_Registro'}) {
    List<dynamic> listado = [];
    for (var item in aux) {
      listado.add(item[keySearched]);
    }
    // Terminal.printOther(message: listado.toString());
    return listado;
  }

  static List<String> listOfRange({required int maxNum, bool withNull = true}) {
    List<String> list =
        List<String>.generate(maxNum, (i) => (i + 1).toString());
    if (withNull) {
      list.add("N/A");
    }
    // ******* ************ ******** ********* ***
    return list;
  }

  static String stringFromList({required List listValues}) {
    String val = '';
    for (var element in listValues) {
      if (val == '') {
        val = "$element";
      } else {
        val = "$val\n$element";
      }
    }
    return val;
  }

  static sumFromMap(List<dynamic> data,
      {String keySearched = 'Monto_Pagado',
      String conditionalKey = 'Tipo_Recurso',
      String conceptSearched = 'Ingresos'}) {
    double totalScores = 0;

    // Terminal.printExpected(message: "$data");
    for (var item in data) {
      //getting the key direectly from the name of the key
      if (item[conditionalKey] == conceptSearched) {
        Terminal.printExpected(message: "${item[keySearched]}");
        totalScores += double.parse(item[keySearched]);
      }
    }

    return totalScores;
  }

  static String traduceToString(List<String> collection) {
    String string = "";
    for (var element in collection) {
      // print('element $element');
      if (string == "") {
        string = "$element\n";
      } else {
        string = "$string$element\n";
      }
    }
    return string;
  }

  static List<String> traslateFromString(String value, {String charSplit = '\n'}) {
    return value.split(charSplit);
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
    try {
      final picker = ImagePicker();
      XFile? xFileImage = await picker.pickImage(source: ImageSource.gallery);
      if (xFileImage != null) {
        Uint8List bytes = await xFileImage.readAsBytes();
        return bytes;
      }
    } on Exception catch (e) {
      Terminal.printAlert(
          message: "ERROR : : No se pudo cargar imagen desde Galeria : $e");
      Dialogos.notifyDialog(
        "ERROR - Imagenes de Galeria",
        'No se pudo cargar imagen desde Galeria : $e',
        () {},
      );
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
      {required BuildContext context,
      required Widget chyldrim,
      bool? withAction = true,
      Function? onAction}) {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          return Dialog(
              backgroundColor: Colors.black54 ,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 15, child: chyldrim),
                    withAction == true
                        ? Expanded(
                            flex: isDesktop(context) ? 2 : 1,
                            child: Container(
                                width: 2000,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    border: Border.all(
                                      color: Colors.grey,
                                    )),
                                child: GrandButton(
                                  height: 10,
                                  labelButton: 'Aceptar',
                                  onPress: () {
                                    if (onAction == null || onAction == Null) {
                                      Navigator.of(context).pop();
                                    } else {
                                      onAction();
                                      Navigator.of(context).pop();
                                    }
                                  },
                                )))
                        : Container()
                  ],
                ),
              ));
        });
  }

  static Future<void> openActivity(
      {required BuildContext context,
      required Widget chyldrim,
      String? labelButton = 'Cerrar',
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
                  labelButton: labelButton,
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

  static void openWindow(
      {required BuildContext context,
      required Widget chyldrim,
      Function? onAction}) {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          if (isTablet(context)) {
            return Dialog(
              backgroundColor: Theming.secondaryColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(height: 700, child: chyldrim),
              ),
            );
          } else {
            return AlertDialog(
              backgroundColor: Colors.black,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              content: SizedBox(height: 700, child: chyldrim),
            );
          }
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

  static void loadingActivity({
    required BuildContext context,
    String? tittle,
    String? message,
    Function? onCloss,
  }) {

    showDialog(
        context: context,
        builder: (context) {
          return Dialogos.loadingActivity(
            tittle: tittle,
            msg: message,
            onCloss: onCloss,
          );
        });
  }

  static void selectOptionsActivity({
    required BuildContext context,
    String? tittle = "Manejo de Opciones",
    String? message = "Seleccione una opción . . . ",
    required List<dynamic> options,
    Function(String)? onClose,
    Function(String)? onLongCloss
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialogos.selectOptionsActivity(
            tittle: tittle,
            msg: message,
            options: options,
            onCloss: onClose,
              onLongCloss: onLongCloss,
          );
        });
  }

  static void alertActivity({
    required BuildContext context,
    String? tittle = "Manejo de registro",
    String? message = "El registro ha sido actualizado / creado",
    onClose,
    onAcept,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialogos.alertDialog(tittle, message, () {
            Navigator.of(context).pop();
          }, onAcept);
        });
  }

  static void notifyActivity({
    required BuildContext context,
    String? tittle = "Manejo de registro",
    String? message = "El registro ha sido actualizado / creado",
    onClose,
    onAcept,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialogos.notifyDialog(tittle, message, () {
            Navigator.of(context).pop();
          });
        });
  }

  static void editActivity({
    required BuildContext context,
    TextInputType keyBoardType = TextInputType.number,
    String? tittle = "Manejo de registro",
    String? message = "El registro ha sido actualizado / creado",
    onClose,
    Function(String)? onAcept,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialogos.editDialog(keyBoardType, tittle, message, () {
            Navigator.of(context).pop();
          }, onAcept);
        });
  }

  static void editTwoValuesDialog({
    required BuildContext context,
    TextInputType keyBoardType = TextInputType.number,
    String? tittle = "Manejo de registro",
    String? message = "El registro ha sido actualizado / creado",
    onClose,
    Function(String)? onAcept,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialogos.editTwoValuesDialog(keyBoardType, tittle, message, () {
            Navigator.of(context).pop();
          }, onAcept);
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
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            onPressed: () {
              onAcept();
            },
            child: const Text("Aceptar", style: TextStyle(color: Colors.white)))
      ],
    );
  }

  static AlertDialog notifyDialog(String? tittle, String? msg, onAcept) {
    return AlertDialog(
      backgroundColor: Theming.secondaryColor,
      title: Text(
        tittle!,
        style: const TextStyle(color: Colors.grey),
      ),
      content: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Text(
              msg!,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              onAcept();
            },
            child: const Text("Aceptar", style: TextStyle(color: Colors.white)))
      ],
    );
  }

  static AlertDialog editDialog(TextInputType keyBoardType, String? tittle,
      String? msg, onCloss, ValueChanged<String>? onAcept) {
    var textEditController = TextEditingController();

    return AlertDialog(
      backgroundColor: Theming.secondaryColor,
      title: Text(
        tittle!,
        style: const TextStyle(color: Colors.grey),
      ),
      content: SizedBox(
        height: 150,
        child: Column(
          children: [
            Text(
              msg!,
              style: const TextStyle(color: Colors.grey),
            ),
            CrossLine(),
            Expanded(
              child: EditTextArea(
                labelEditText: msg,
                numOfLines: 1,
                keyBoardType: keyBoardType, // TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                textController: textEditController,
              ),
            ),
          ],
        ),
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
              onAcept!(textEditController.text);
            },
            child: const Text("Aceptar", style: TextStyle(color: Colors.white)))
      ],
    );
  }

  static AlertDialog editTwoValuesDialog(TextInputType keyBoardType, String? tittle,
      String? msg, onCloss, ValueChanged<String>? onAcept) {
    var textAEditController = TextEditingController();
    var textBEditController = TextEditingController();
    var textCEditController = TextEditingController();

    return AlertDialog(
      backgroundColor: Theming.secondaryColor,
      title: Text(
        tittle!,
        style: const TextStyle(color: Colors.grey),
      ),
      content: SizedBox(
        height: 250,
        child: TittleContainer(
          tittle: msg!,
          child: Column(
            children: [
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Primer Valor',
                  numOfLines: 1,
                  keyBoardType: keyBoardType, // TextInputType.text,
                  inputFormat: MaskTextInputFormatter(),
                  textController: textAEditController,
                ),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Segundo Valor',
                  numOfLines: 1,
                  keyBoardType: keyBoardType, // TextInputType.text,
                  inputFormat: MaskTextInputFormatter(),
                  textController: textBEditController,
                ),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Tercer Valor',
                  numOfLines: 1,
                  keyBoardType: keyBoardType, // TextInputType.text,
                  inputFormat: MaskTextInputFormatter(),
                  textController: textCEditController,
                ),
              ),
            ],
          ),
        ),
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
              double auxyl = 0.0;
              //
              auxyl = double.parse(textAEditController.text) + double.parse(textBEditController.text) + double.parse(textCEditController.text);
              //
              onAcept!(auxyl.toStringAsFixed(0));
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
              onCloss!();
            },
            title: Text(
              element[0],
              style: const TextStyle(color: Colors.grey),
            ),
            subtitle: Text(
              element[2],
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
          CrossLine(),
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

  static AlertDialog selectOptionsActivity({
    String? tittle,
    String? msg,
    ValueChanged<String>? onCloss,
    ValueChanged<String>? onLongCloss,
    required List<dynamic> options,
  }) {
    List<Widget> list = [];
    var selected = "";

    for (var element in options) {
      list.add(Column(
        children: [
          ListTile(
            onTap: () {
              onCloss!(element);
            },
            title: Text(
              "$element",
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          CrossLine(),
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
          onLongPress: () {
            onLongCloss!(selected);
          },
            onPressed: () {
              onCloss!(selected);
            },
            child:
                const Text("Cancelar", style: TextStyle(color: Colors.white))),
      ],
    );
  }

  static AlertDialog loadingActivity({
    String? tittle,
    String? msg,
    Function? onCloss,
  }) {
    Terminal.printAlert(
        message: "$tittle : : \n "
            "$msg . . .");

    return AlertDialog(
      backgroundColor: Theming.secondaryColor,
      title: Text(
        tittle!,
        style: const TextStyle(color: Colors.grey, fontSize: 18),
      ),
      content: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              LoadingScreen(
                error: msg, // 'Iniciando Interfaz . . . ',
              ),
            ],
          )),
      actions:  [
        ElevatedButton(
          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.black),),
            onPressed: () {
              onCloss!();
            },
            child:
                const Text("Cancelar", style: TextStyle(color: Colors.white))),
      ],
    );
  }
}

class Datos {
  static double fromInt(int value) {
    return double.parse(value.toString());
  }

  static bool isNullValue({required num? value}) {
    if (value != 0 && value != null) {
      return true;
    } else {
      return false;
    }
  }

  static bool isMiddleValue({required num? value, required num? min, required num? max}) {
    if (value! > min! && value< max!) {
      return true;
    } else {
      return false;
    }
  }

  static void portapapeles(
      {required BuildContext context, required String text}) {
    Clipboard.setData(ClipboardData(text: text)).whenComplete(() =>
        Operadores.notifyActivity(
            context: context,
            tittle: "Portapapeles . . . ",
            message: "Copiado en Portapapeles . . . \n$text"));
  }

  static bool isInnerValue({required double value, required int lim}) {
    if (value< lim) {
      return true;
    } else {
      return false;
    }
  }
  static bool isUpperValue({required double value, required int lim}) {
    if (value>lim) {
      return true;
    } else {
      return false;
    }
  }
}

class Terminal {
  static void printNotice({required String message}) {
    print("\x1B[30m$message\x1B[0m"); // Black
  }

  static void printAlert({required String message}) {
    print("\x1B[31m$message\x1B[0m"); // Red
  }

  static void printSuccess({required String message}) {
    print("\x1B[32m$message\x1B[0m"); // Green
  }

  static void printWarning({required String message}) {
    print("\x1B[33m$message\x1B[0m"); // Yellow
  }

  static void printOther({required String message}) {
    print("\x1B[34m$message\x1B[0m"); // Blue
  }

  static void printData({required String message}) {
    print("\x1B[35m$message\x1B[0m"); // Magenta
  }

  static void printExpected({required String message}) {
    print("\x1B[36m$message\x1B[0m"); // Cyan
  }

  static void printWhite({required String message}) {
    print("\x1B[37m$message\x1B[0m"); //White
  }
}

class Numeros {
  static double toDoubleFromInt(
      {required Map<String, dynamic> json, required String keyEntered}) {
    return double.parse(
        json[keyEntered] != null ? json[keyEntered].toString() : '0');
  }

  static List<String> get orderOfItems {
    List<String> list = [];
    list.addAll(Listas.listOfRange(maxNum: 1000000));
    return list;
  }
}
