// ignore: file_names
import 'dart:io';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/screens/home.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/LoadingScreen.dart';
import 'package:assistant/widgets/ReproductorVideos.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:path_provider/path_provider.dart';

class FtpAccount extends StatefulWidget {
  const FtpAccount({super.key});

  @override
  State<FtpAccount> createState() => _FtpAccountState();
}

class _FtpAccountState extends State<FtpAccount> {
  FTPConnect ftpConnect = FTPConnect("ftp.luisr107.sg-host.com",
      user: "compuesto@luisr107.sg-host.com",
      pass: "SeRakin263",
      port: 21,
      // debug: true,
      // isSecured: false
      );
  late List foundedItems = [];

  @override
  void initState() {
    consult();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GrandIcon(
            weigth: 10,
            iconData: Icons.upload,
            labelButton: 'Cargar archivo',
            onPress: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => const Home())));
            }),
        actions: [
          GrandIcon(
              weigth: 10,
              iconData: Icons.upload,
              labelButton: 'Cargar archivo',
              onPress: () {
                pickVideo().then((value) {
                  setState(() {
                    print("picked  file ${value.path}");
                    upload(value.path);
                  });
                });
              }),
          GrandIcon(
              weigth: 10,
              iconData: Icons.update,
              labelButton: 'Consultar',
              onPress: () {
                consult().then((value) {
                  setState(() {
                    foundedItems = value;
                  });
                });
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            foundedItems.isEmpty
                ? Expanded(
                    child: CircularProgressIndicator(), // LoadingScreen(
                    //   error: "Buscando elementos . . . ",
                    // ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      controller: ScrollController(),
                      child: Column(
                        children: [
                          GrandButton(
                              labelButton: 'Atrás',
                              onPress: () async {
                                final currentDir =
                                    await ftpConnect.currentDirectory();
                                consult(sDirectory: "$currentDir/..")
                                    .then((value) {
                                  setState(() {
                                    foundedItems = value;
                                  });
                                });
                              }),
                          FutureBuilder<List>(
                            initialData: foundedItems,
                            future: Future.value(foundedItems),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) print(snapshot.error);
                              return snapshot.hasData
                                  ? GridView.builder(
                                      controller: ScrollController(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 3 / 2,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data == null
                                          ? 0
                                          : snapshot.data.length,
                                      itemBuilder: (context, pos) {
                                        return Container(
                                          padding: const EdgeInsets.all(2.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              onTouch(snapshot, pos);
                                            },
                                            child: Card(
                                              color: const Color.fromARGB(
                                                  255, 54, 50, 50),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      snapshot.data[pos]
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : loading(snapshot);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Center loading(AsyncSnapshot<dynamic> snapshot) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 50),
          Text(
            snapshot.hasError
                ? snapshot.error.toString()
                : snapshot.error.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Future consult({String? sDirectory}) async {
    print("sDirectory $sDirectory");
    if (sDirectory != null) {
      ftpConnect.changeDirectory("/$sDirectory").then((value) async {
        ftpConnect.listDirectoryContent().then((value) {
          setState(() {
            foundedItems =
                value.map((f) => f.name).whereType<String>().toList();
            print("respuesta al cambiar ${value.toString()}");
          });
        });
      });
    } else {
      await ftpConnect.connect();
      ftpConnect.listDirectoryContent().then((value) {
        setState(() {
          foundedItems = value.map((f) => f.name).whereType<String>().toList();
          print("respuesta al cambiar ${value.toString()}");
        });
      });
    }
  }

  void upload(String? fileToUpload) async {
    bool res = await ftpConnect.uploadFileWithRetry(
      File(fileToUpload!),
      pRetryCount: 2,
      onProgress: (progressInPercent, totalReceived, fileSize) {
        showDialog(
            context: context,
            builder: (context) {
              return downloadingWidget('Cargando archivo', progressInPercent,
                  totalReceived, fileSize, context);
            });
      },
    );
    // return res;
    await ftpConnect.disconnect();
    print("resultado de la carga de archivo $res");
  }

  void disconnect() async {
    Directorios.videoTemporalPath = "";
    await ftpConnect.disconnect();
  }

  Future<bool> download({String? filePath, String? newNameFile}) async =>
      fileExist(newNameFile!).then((value) async {
        if (value) {
          return true;
        } else {
          final fileName = await saveFile(newNameFile);
          bool res = await ftpConnect.downloadFileWithRetry(
            filePath!,
            File(fileName!),
            onProgress: (progressInPercent, totalReceived, fileSize) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return downloadingWidget('Descargando archivo ',
                        progressInPercent, totalReceived, fileSize, context);
                  });
            },
          );
          return res;
        }
      });

  AlertDialog downloadingWidget(String tittle, double progressInPercent,
      int totalReceived, int fileSize, BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 97, 87, 87),
      title: Text(
        '$tittle... $progressInPercent %',
        style: const TextStyle(color: Colors.white),
      ),
      content:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        CircularProgressIndicator(
          value: progressInPercent,
        ),
        Text(
          "Total recibido ${(totalReceived / 1000000).toStringAsFixed(2)}",
          style: const TextStyle(color: Colors.white),
        ),
        Text(
          "Tamaño del archivo ${(fileSize / 1000000).toStringAsFixed(2)}",
          style: const TextStyle(color: Colors.white),
        ),
      ]),
      actions: [
        GrandButton(
            weigth: 50,
            labelButton: "Cancelar",
            onPress: () {
              Navigator.of(context).pop();
            })
      ],
    );
  }

  Future<bool> fileExist(String filePathFTP) async {
    final appStorage = await getTemporaryDirectory();
    // Creación de File con path hacia directorio temporal.
    final temporalFile = File("${appStorage.path}/$filePathFTP");
    // Comprobar si existe el archivo en directorio temporal.
    final res = await temporalFile.exists();
    // Validación del resultado.
    if (res) {
      Directorios.videoTemporalPath = temporalFile.path;
      return true;
    } else {
      return false;
    }
  }

  Future<File> pickVideo() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    return File(result!.files.first.path!);
  }

  saveFile(String filePathFTP) async {
    final appStorage = await getTemporaryDirectory();
    // final temporalPath = File("${appStorage.path}/$filePathFTP");

    Directorios.videoTemporalPath = "${appStorage.path}/$filePathFTP";

    return "${appStorage.path}/$filePathFTP";
  }

  saveFilePermanently(String? filePathFTP) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File("${appStorage.path}/$filePathFTP");

    return File(filePathFTP!).copy(newFile.path);
  }

  void onTouch(AsyncSnapshot snapshot, int pos) async {
    // * * * * * * * * * * * * * * * * * * * * * * * *
    var archive = snapshot.data[pos];
    final path = await ftpConnect.currentDirectory();
    var ext = "";
    // * * * * * * * * * * * * * * * * * * * * * * * *
    if (archive.contains('.')) {
      ext = archive.split('.')[1];
      print("path $path ext $ext");
    }
    // * * * * * * * * * * * * * * * * * * * * * * * *
    final filePath = '$path/$archive';
    // * * * * * * * * * * * * * * * * * * * * * * * *
    if (ext == 'mp4' || ext == 'png') {
      final response =
          download(filePath: filePath, newNameFile: '$archive').then((value) {
        print("response for download $value");
        if (value) {
          toVideoPlayer();
        }
      });
    } else {
      consult(sDirectory: filePath).then((value) {
        setState(() {
          foundedItems = value;
        });
      });
    }
  }

  void toVideoPlayer() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ReproductorVideo(
              isAsset: false,
            )));
  }
}
