import 'dart:convert';
import 'dart:io';

import 'package:assistant/conexiones/actividades/pdfGenerete/PdfApi.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/LoadingScreen.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:file_picker/file_picker.dart';
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

  static int differenceInDaysToNow(String fechaAnterior) {
    return DateTime.now().difference(DateTime.parse(fechaAnterior)).inDays;
  }

  static int differenceBetweenInDays(String fechaActual, String fechaAnterior) {
    return DateTime.parse(fechaActual)
        .difference(DateTime.parse(fechaAnterior))
        .inDays;
  }

  static String formatDate(String formattedString) {
    return DateFormat("dd.MM.yyyy").format(DateTime.parse(formattedString));
  }

  static Future<void> showPickedDate({required BuildContext context}) async {
    await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2055),
        builder: (BuildContext context, Widget? child) {
          return Theme(
              data: ThemeData.dark()
                  .copyWith(dialogBackgroundColor: Theming.cuaternaryColor),
              child: child!);
        });
  }

  static fromTextoLlano(String? fechaResultado) {
    // Mapa de meses en español
    Map<String, int> meses = {
      'enero': 1,
      'febrero': 2,
      'marzo': 3,
      'abril': 4,
      'mayo': 5,
      'junio': 6,
      'julio': 7,
      'agosto': 8,
      'septiembre': 9,
      'octubre': 10,
      'noviembre': 11,
      'diciembre': 12,
    };

    // Dividimos la cadena
    List<String> partesFecha = fechaResultado!.toLowerCase().split(' ');
    // Terminal.printSuccess(message: partesFecha.toString());

    int dia = int.parse(partesFecha[0]); // Obtenemos el día
    int mes = meses[partesFecha[2]] ??
        1; // Obtenemos el mes y lo convertimos a su representación numérica
    int anio = int.parse(partesFecha[4]); // Obtenemos el año
    String hora = partesFecha[5]; // Obtenemos la hora

    // Creamos el objeto DateTime a partir de la fecha y hora
    String fechaFormateada = "$anio-$mes-$dia $hora";
    DateTime fechaDateTime =
        DateFormat("yyyy-M-d HH:mm:ss").parse(fechaFormateada);

    // Imprimir el resultado
    // print(fechaDateTime);  // Output: 2022-10-12 07:52:11.000
    return fechaDateTime;
  }

  static String normalizarFecha(dynamic fecha) {
    if (fecha == null) return '';

    // Si viene como String tipo '2025-04-11 09:30:00'
    if (fecha is String) {
      return fecha.split(' ').first;
    }

    // Si ya viene como DateTime
    if (fecha is DateTime) {
      return "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}";
    }

    return fecha.toString(); // fallback
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

  static void toNextActivity(
    BuildContext context, {
    required chyld,
    String? tittle = '',
    void Function()? onClose,
    void Function()? onOption,
    Color? backgroundColor = Colors.black,
  }) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    if (onClose == null) {
                      Navigator.of(context).pop();
                    } else {
                      onClose();
                    }
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
              title: AppBarText(tittle!),
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              actions: [
                if (onOption != null)
                  IconButton(
                      onPressed: () {
                        onOption();
                      },
                      icon: const Icon(Icons.ac_unit_outlined))
              ],
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
    Terminal.printWarning(message: 'Creando archivo JSON en $filePath : : OBTENIDO : $map');
    //
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
    Terminal.printOther(message: filePath.toString());
    //
    var file, contents;
    if (Platform.isAndroid) {
      final directory = await getTemporaryDirectory();
      final File file = File("${directory.path}/$filePath");

      contents = await file.readAsString();
      // Terminal.printOther(
      //     message: "Obtenido desde ${directory.path}/$filePath");
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
      Terminal.printWarning(message: "File to Delete $filePath");
      final File file = File(filePath);
      if (await file.exists()) {
        try {
          // Esperamos a que se libere cualquier acceso pendiente (si fuera necesario)
          await file.openRead().drain();
          await file.delete(); // ✅ delete asincrónico

          if (await file.exists()) {
            Terminal.printWarning(
                message:
                    '⚠️ El archivo todavía existe después del intento de eliminación.');
          } else {
            Terminal.printSuccess(
                message: '✅ $filePath : Archivo eliminado correctamente.');
          }
        } catch (e) {
          Terminal.printAlert(message: '❌ Error al eliminar el archivo: $e');
        }
      } else {
        final Directory appDir = await getApplicationDocumentsDirectory();
        // Crea la ruta del directorio que deseas eliminar
        // final Directory targetDir = Directory('${appDir.path}/$filePath');
        final Directory targetDir = Directory(filePath);

        // Verifica si el directorio existe
        if (await targetDir.exists()) {
          await targetDir.delete(recursive: true);
          print('Directorio eliminado correctamente: ${targetDir.path}');
        } else {
          throw "\x1B[31mEl Archivo $filePath : : ${targetDir.path} no Existe\x1B[0m";
        }
      }
    } else {
      final File file = File(filePath);
      if (await file.exists()) {
        file.delete(recursive: true);
      } else {
        // Define el directorio que deseas eliminar
        final directory = Directory(filePath);
        if (await directory.exists()) {
          try {
            // Elimina el directorio y todo su contenido
            await directory.delete(recursive: true);
            print('Directorio eliminado correctamente.');
          } catch (e) {
            throw "\x1B[31mOcurrio un error al eliminar el directorio : : $e\x1B[0m";
          }
        } else {
          throw "\x1B[31mEl Archivo $filePath no Existe\x1B[0m";
        }
      }
    }
    //
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

  //
  static writeInFile(String text, {String filePath = ''}) async {
    // Terminal.printWarning(message: 'Creando archivo JSON en $filePath');
    if (Platform.isAndroid) {
      final directory = await getTemporaryDirectory();
      final File file = File("${directory.path}/$filePath");
      if (await file.exists()) {
        file.writeAsStringSync(text);
        // Terminal.printExpected(
        //     message: "Inscrito en ${directory.path}/$filePath");
      } else {
        file.create(recursive: true).then((value) {
          file.writeAsStringSync(text);
        }).onError((error, stackTrace) {
          // Terminal.printAlert(
          //     message: "Error: $error desde ${directory.path}/$filePath");
        });
      }
    } else {
      final File file = File(filePath);
      if (await file.exists()) {
        file.writeAsStringSync(text);
        // Terminal.printExpected(message: "Obtenido desde $filePath");
      } else {
        file.create(recursive: true).then((value) {
          file.writeAsStringSync(text);
          // Terminal.printExpected(message: "Obtenido desde $filePath");
        }).onError((error, stackTrace) {
          // Terminal.printAlert(message: "Error: $error desde $filePath");
        });
      }
    }
  }

  static Future<String> readFromFile({required String filePath}) async {
    Terminal.printOther(message: filePath.toString());
    //
    var file, contents;
    if (Platform.isAndroid) {
      final directory = await getTemporaryDirectory();
      final File file = File("${directory.path}/$filePath");

      contents = await file.readAsString();
      // Terminal.printOther(
      //     message: "Obtenido desde ${directory.path}/$filePath");
      return (contents);
    } else {
      file = File(filePath);
      //
      if (await file.exists()) {
        contents = await file.readAsString();
        return (contents);
      } else {
        throw "No existe el archivo $filePath";
      }
    }
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

  /// De la List<List<Map<String, dynamic> > >  aux, busca el firstKeySearched
  /// secondKeySearched : : Elemento Buscado desde una lista List<String>
  static List<dynamic> listFromMapWithTwoKey(List<dynamic> aux,
      {String firstKeySearched = 'Estudio',
      required List<String>? secondKeySearched,
      elementDeseado = 'Resultado'}) {
    List<dynamic> listado = [];
    //
    for (var item in aux) {
      //
      for (int index = 0; index <= secondKeySearched!.length - 1; index++) {
        if (item[firstKeySearched] == secondKeySearched[index]) {
          Terminal.printOther(
              message:
                  "${item["Fecha_Registro"]} : ${secondKeySearched[index]} . $index . . . ${item[elementDeseado]}");
          if (index == 0) {
            listado.add([
              item['Fecha_Registro'].toString(),
              item[elementDeseado] ?? 0.0
            ]);
          } else {
            // Terminal.printData(message: "Fecha : ${item['Fecha_Registro']} : ${listado[listado.length-1][0]}");
            if (item['Fecha_Registro'] == listado[listado.length - 1][0]) {
              listado[listado.length - 1]
                  .insert(index + 1, item[elementDeseado] ?? 0.0);
            }
            Terminal.printData(
                message:
                    "Listado . ${listado.length} : : ${listado[listado.length - 1].toString()}");
          }
          // listado.add(auxiliar);
        }
        //
      }
      //
    }
    //
    // Terminal.printSuccess(message: "\n\n");
    //
    // listado.forEach((elemento) {
    //   Terminal.printSuccess(
    //       message: "listFromMapWithTwoKey : : ${elemento.toString()}");
    // });

    return listado;
  }

  // static String? obtenerValorFromList(List<dynamic> aux,
  //     {String firstKeySearched = 'Estudio',
  //     required String fechaRegistro,
  //     required String secondKeySearched,
  //     elementDeseado = 'Resultado'}) {
  //     List<dynamic> listado = [];
  //     //
  //     List sinRepetir = Listas.listWithoutRepitedValues(secondKeySearched!);
  //     List fechasSinRepetir = Listas.listWithoutRepitedValues(Listas.listFromMapWithOneKey(aux, keySearched: "Fecha_Registro"));
  //     //
  //     Terminal.printWarning(
  //         message: "secondKeySearched.length : : ${secondKeySearched!.length}\n "
  //             "Valores buscados : : ${sinRepetir.toString()}\n "
  //             "Fechas Obtenidas : : ${fechasSinRepetir!.length} ${fechasSinRepetir.toString()}"
  //     );
  //     //
  //     for (var item in aux) {
  //       for (int index = 0; index <= secondKeySearched.length - 1; index++) {
  //         if (item[firstKeySearched] == secondKeySearched[index]) {
  //           Terminal.printOther(
  //               message:
  //               "${item["Fecha_Registro"]} : ${secondKeySearched[index]} . . . ${item[elementDeseado]}");
  //
  //           // Terminal.printNotice(message: auxiliar.toString());
  //
  //           listado.add(
  //             [
  //               item['Fecha_Registro'].toString(),
  //               item[elementDeseado], // I
  //               item[elementDeseado], // II
  //             ],
  //           );
  //           // Terminal.printData(message: "${listado.toString()}");
  //         }
  //       }
  //       // for (var entis in secondKeySearched) {
  //       //   //
  //       //
  //       // }
  //     }
  //     Terminal.printData(
  //         message: "listFromMapWithTwoKey : : ${listado.toString()}");
  //     return listado;
  // }
  //
  // static List<dynamic> listFromMapWithTwoKey(List<dynamic> aux,
  //     {String firstKeySearched = 'Estudio',
  //       required List<String>? secondKeySearched,
  //       elementDeseado = 'Resultado'}) {
  //   List<dynamic> listado = [];
  //   //
  //   List sinRepetir = Listas.listWithoutRepitedValues(secondKeySearched!);
  //   List fechasSinRepetir = Listas.listWithoutRepitedValues(Listas.listFromMapWithOneKey(aux, keySearched: "Fecha_Registro"));
  //   //
  //   Terminal.printWarning(
  //       message: "secondKeySearched.length : : ${secondKeySearched!.length}\n "
  //           "Valores buscados : : ${sinRepetir.toString()}\n "
  //           "Fechas Obtenidas : : ${fechasSinRepetir!.length} ${fechasSinRepetir.toString()}"
  //   );
  //   //
  //   for (var item in aux) {
  //     for (int index = 0; index <= secondKeySearched.length - 1; index++) {
  //       if (item[firstKeySearched] == secondKeySearched[index]) {
  //         Terminal.printOther(
  //             message:
  //             "${item["Fecha_Registro"]} : ${secondKeySearched[index]} . . . ${item[elementDeseado]}");
  //
  //         // Terminal.printNotice(message: auxiliar.toString());
  //
  //         listado.add(
  //           [
  //             item['Fecha_Registro'].toString(),
  //             item[elementDeseado], // I
  //             item[elementDeseado], // II
  //           ],
  //         );
  //         // Terminal.printData(message: "${listado.toString()}");
  //       }
  //     }
  //     // for (var entis in secondKeySearched) {
  //     //   //
  //     //
  //     // }
  //   }
  //   Terminal.printData(
  //       message: "listFromMapWithTwoKey : : ${listado.toString()}");
  //   return listado;
  // }

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

  static String traduceToString(List collection) {
    String string = "";
    for (var element in collection) {
      // print('element $element');
      if (string == "") {
        string = "     - $element\n";
      } else {
        string = "$string     - $element\n";
      }
    }
    return string;
  }

  static List<String> traslateFromString(String value,
      {String charSplit = '\n'}) {
    if (charSplit != "\n") {
      return value.split(charSplit);
    } else {
      List<String> list = [];
      value
          .replaceAll('[', '')
          .replaceAll(']', '')
          .split(',')
          .forEach((element) {
        list.add(element);
      });
      //
      return list;
    }
  }

  static List compareList(List estudiosPresentes, List especiales) {
    return {...especiales, ...estudiosPresentes}.toList();
  }

  /// Filtra los elementos de la lista Pacientes.Paraclinicos,
  /// Si withEspeciales es false, entonces excluyendo aquellos cuyo Tipo_Estudio
  /// que se encuentra en la lista Auxiliares.especiales.
  /// Si withEspeciales es true, entonces incluyendo aquellos cuyo Tipo_Estudio
  /// que se encuentra en la lista Auxiliares.especiales.
  ///
  /// Encuentra la fecha más reciente en la clave Fecha_Registro de los elementos restantes, y ordena de forma ascendente.
  /// Devuelve un List<Map<String, dynamic>> siendo el primer valor el más reciente .
  ///
  static List filterAndFindRecent(List paraclinicos, List especiales,
      {bool? withEspeciales = false}) {
    // Filtrar los elementos excluyendo los `Tipo_Estudio` que están en `Auxiliares.especiales`
    final filtered = paraclinicos.where((element) {
      if (withEspeciales!) {
        return especiales.contains(element['Tipo_Estudio']);
      } else {
        return !especiales.contains(element['Tipo_Estudio']);
      }
    }).toList();

    if (filtered.isEmpty) {
      return []; // Retornar vacío si no hay elementos que cumplan la condición
    }

    // Encontrar la fecha más reciente
    filtered.sort((a, b) {
      final dateA = DateTime.parse(a['Fecha_Registro']);
      final dateB = DateTime.parse(b['Fecha_Registro']);
      return dateB.compareTo(dateA);
    });

    // Retornar la lista filtrada y ordenada (el primero es el más reciente)
    return filtered;
  }

  static List compareOneListWithAnother(List primeraLista, List listaBase) {
    List aux = [];
    for (var element in listaBase) {
      if (primeraLista.contains(element)) aux.add(element);
    }
    return [
      ...{...aux}
    ];
  }

  static String fromEachListToString(List<List> list) {
    String listado = "";
    for (var elemente in list) {
      Terminal.printSuccess(message: "${elemente}");
      listado = "$listado$elemente\n";
    }

    return listado;
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
    final request = http.MultipartRequest(
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

  static choiseFromClipboard(BuildContext context, String text) async {
    try {
      // final Map<String, dynamic>? result = await SystemChannels.platform.invokeMethod(
      //   'Clipboard.getData',
      //   // format,
      // );
      //
      // ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
      // Terminal.printData(message: "${result!}");
      // return data!.text;
      //
      // Imagen desde String
      // final picker = Datos.portapapeles(context: context, text: text);
      // XFile? xFileImage = await picker.pickImage(source: ImageSource.gallery);
      // if (xFileImage != null) {
      //   Uint8List bytes = await xFileImage.readAsBytes();
      //   return bytes;
      // }
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

  /// Open a PDF file from the local device's storage.
  static Future<FilePickerResult?> choiseFromInternalDocuments(
      BuildContext context) async {
    try {
      FilePickerResult? filePickerResult = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      if (filePickerResult != null) {
        return filePickerResult;
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

  static Future<List<PlatformFile>?> choiseSeveralFromInternalDocuments(
      BuildContext context) async {
    // Utilizar FilePicker para seleccionar archivos
    // await FilePicker.platform.clearTemporaryFiles();
    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Solo archivos PDF
      allowMultiple: true, // Permitir selección de múltiples archivos
      // withData: true,
    );

    if (filePickerResult != null) {
      // Retornar la lista de archivos seleccionados
      return filePickerResult.files;
    } else {
      // Retornar null si no se seleccionaron archivos
      return null;
    }
  }
  // static choiseDocumentFromDirectory() async {
  //   var dir = await getApplicationDocumentsDirectory();
  //   File file = File('${dir.path}/$pName.pdf');
  //
  //   bool  fileExists = File(await '${dir.path}/$pName.pdf')
  //       .existsSync();
  //
  //   if(fileExists)
  //   {
  //     urlPdfPath = file.toString();
  //     print('url pdf path $urlPdfPath');
  //     Navigator.push(context, MaterialPageRoute(builder: (context) {
  //       return PdfViewer(
  //         path: urlPdfPath,
  //         product: pName,
  //       );
  //     }));
  //
  //   }
  //
  // }
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
              backgroundColor: Colors.black54,
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
                child: SizedBox(height: 700, width: 300, child: chyldrim),
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

  static void dummyLoadingActivity({
    required BuildContext context,
    String? tittle,
    String? message,
    required Future<void> task,
    Function? onCloss,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialogos.dummyLoadingActivity(
            tittle: tittle,
            msg: message,
            task: task,
            onCloss: onCloss,
          );
        });
  }

  static void loadingActivity({
    required BuildContext context,
    String? tittle,
    String? message,
    Function? onCloss,
    bool dismisable = true,
  }) {
    showDialog(
        barrierDismissible: dismisable,
        context: context,
        builder: (context) {
          return Dialogos.loadingActivity(
            tittle: tittle,
            msg: message,
            onCloss: onCloss,
          );
        });
  }

  static void selectOptionsActivity(
      {required BuildContext context,
      String? tittle = "Manejo de Opciones",
      String? message = "Seleccione una opción . . . ",
      required List<dynamic> options,
      Function(String)? onClose,
      Function(String)? onLongCloss}) {
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

  static void selectWithTittleOptionsActivity(
      {required BuildContext context,
      String? tittle = "Manejo de Opciones",
      String? message = "Seleccione una opción . . . ",
      required List<dynamic> options,
      Function(String)? onClose,
      Function(String)? onLongCloss}) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialogos.selectWithTittleOptionsActivity(
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
    Terminal.printAlert(message: "$message");
    //
    showDialog(
        barrierDismissible: false,
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
          return Dialogos.notifyDialog(
            tittle, message,
            onAcept,
            //         () {
            //   Navigator.of(context).pop();
            // }
          );
        });
  }

  static void editActivity({
    required BuildContext context,
    TextInputType keyBoardType = TextInputType.number,
    String? tittle = "Manejo de registro",
    String? message = "El registro ha sido actualizado / creado",
    onClose,
    Function(String)? onAcept,
    int numOfLines = 1,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialogos.editDialog(context, keyBoardType, tittle, message, () {
            Navigator.of(context).pop();
          }, onAcept, numOfLines: numOfLines);
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
          return Dialogos.editTwoValuesDialog(keyBoardType, tittle, message,
              () {
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
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.grey, fontSize: 16),
      ),
      content: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            CrossLine(height: 10),
            Text(
              msg!,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        // OutlinedButton(
        //     onPressed: () {
        //       onCloss();
        //     },
        //     child:
        //         const Text("Cancelar", style: TextStyle(color: Colors.white))),
        CircleIcon(
            iconed: Icons.transit_enterexit,
            onChangeValue: () {
              onAcept();
            }),
        // ElevatedButton(
        //     style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        //     onPressed: () {
        //       onAcept();
        //     },
        //     child: const Text("Aceptar", style: TextStyle(color: Colors.white)))
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
              // Navigator.of(context).pop();
            },
            child: const Text("Aceptar", style: TextStyle(color: Colors.white)))
      ],
    );
  }

  static AlertDialog editDialog(BuildContext context, TextInputType keyBoardType, String? tittle,
      String? msg, onCloss, ValueChanged<String>? onAcept,
      {int numOfLines = 1}) {
    var textEditController = TextEditingController();

    return AlertDialog(
      backgroundColor: Theming.secondaryColor,
      title: Text(
          tittle ?? '',
        style: const TextStyle(color: Colors.grey),
      ),
      content: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (msg != null)
              Text(
                msg,
                style: const TextStyle(color: Colors.grey),
              ),
            CrossLine(thickness: 3,height: 16),
            EditTextArea(
              labelEditText: msg ?? '',
              numOfLines: numOfLines,
              keyBoardType: keyBoardType,
              inputFormat: MaskTextInputFormatter(),
              textController: textEditController,
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

  static AlertDialog editTwoValuesDialog(TextInputType keyBoardType,
      String? tittle, String? msg, onCloss, ValueChanged<String>? onAcept) {
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
              auxyl = double.parse(textAEditController.text) +
                  double.parse(textBEditController.text) +
                  double.parse(textCEditController.text);
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
      content: SingleChildScrollView(
        controller: ScrollController(),
        child: Text(
          msg!,
          style: const TextStyle(color: Colors.grey, fontSize: 10),
        ),
      ),
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // if (optionB != null) SizedBox(width: 0) else SizedBox(width: 30),
            if (optionB != null)
              Expanded(
                  child: CircleIcon(
                      radios: 30,
                      difRadios: 5,
                      iconed: Icons.camera,
                      tittle: textOptionB!,
                      onChangeValue: () {
                        optionB();
                      })),
            Expanded(
              child: OutlinedButton(
                  onPressed: () {
                    onCloss!();
                  },
                  child: const Text("Cancelar",
                      style: TextStyle(color: Colors.white, fontSize: 8))),
            ),

            // Expanded(
            //   child: ElevatedButton(
            //       onPressed: () {
            //         optionB();
            //       },
            //       child: Text(textOptionB!,
            //           style:
            //               const TextStyle(color: Colors.black, fontSize: 8))),
            // ),
            Expanded(
                child: CircleIcon(
                    radios: 35,
                    iconed: Icons.confirmation_num,
                    tittle: textOptionA!,
                    onChangeValue: () {
                      optionA!();
                    })),
          ],
        )
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
              Terminal.printWarning(message: "OPENING ${element[1]}");
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

  static AlertDialog selectWithTittleOptionsActivity({
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
              onCloss!(element[1]);
            },
            title: Text(
              "${element[0]}",
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

  static AlertDialog dummyLoadingActivity({
    String? tittle,
    String? msg,
    required Future<void> task,
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
                task: task,
                error: msg, // 'Iniciando Interfaz . . . ',
              ),
            ],
          )),
      actions: [
        ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(Colors.black),
            ),
            onPressed: () {
              onCloss!();
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
              Transform.scale(
                scale: 0.5,
                child: CircularProgressIndicator(),
              ),
              SizedBox(height: 20),
              Text(
                msg.toString(),
                style: Styles.textSyleGrowth(),
              ),
            ],
          )),
      actions: [
        ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(Colors.black),
            ),
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

  static bool isMiddleValue(
      {required num? value, required num? min, required num? max}) {
    if (value! > min! && value < max!) {
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
    if (value < lim) {
      return true;
    } else {
      return false;
    }
  }

  static bool isUpperValue({required double value, required int lim}) {
    if (value > lim) {
      return true;
    } else {
      return false;
    }
  }

  /// Empleado para la comparación de dos Strings
  /// Mientras que el s1 es el parámetro para comparar; es decir, el vallor que desea buscarse
  /// s2 es el parametro con el que se va a comparar; es decir un x de X
  /// v.g. en for (var s2 in Strings)
  ///
  static int calcularDistanciaLevenshtein(String s1, String s2) {
    int m = s1.length;
    int n = s2.length;

    // Si alguna cadena está vacía, la distancia es la longitud de la otra cadena.
    if (m == 0) return n;
    if (n == 0) return m;

    // Crear una matriz de m+1 x n+1
    List<List<int>> dp = List.generate(m + 1, (i) => List.filled(n + 1, 0));

    // Inicializar las fronteras de la matriz
    for (int i = 0; i <= m; i++) {
      dp[i][0] = i;
    }

    for (int j = 0; j <= n; j++) {
      dp[0][j] = j;
    }

    // Rellenar la matriz de distancias
    for (int i = 1; i <= m; i++) {
      for (int j = 1; j <= n; j++) {
        int costo = s1[i - 1] == s2[j - 1] ? 0 : 1;

        dp[i][j] = [
          dp[i - 1][j] + 1, // Eliminación
          dp[i][j - 1] + 1, // Inserción
          dp[i - 1][j - 1] + costo // Sustitución
        ].reduce((a, b) => a < b ? a : b);
      }
    }

    // La distancia de Levenshtein es el valor en dp[m][n]
    return dp[m][n];
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

class Documentos {}
