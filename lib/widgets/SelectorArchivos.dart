import 'dart:io';

import 'package:assistant/widgets/GrandButton.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class SelectorArchivos extends StatefulWidget {
  const SelectorArchivos({super.key});

  @override
  State<SelectorArchivos> createState() => _SelectorArchivosState();
}

class _SelectorArchivosState extends State<SelectorArchivos> {
  var imageFile = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(32),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (imageFile == "")
            const Image(
              image: AssetImage('assets/images/person.png'),
              width: 500,
              height: 500,
            )
          else
            Image.file(
              File(imageFile),
              width: 500,
              height: 500,
            ),
          GrandButton(
            labelButton: 'Buscar Archivo',
            onPress: () async {
              final result = await FilePicker.platform.pickFiles(
                  allowMultiple: true,
                  type: FileType.custom,
                  allowedExtensions: ['jpg', 'png']);
              // Open one file.
              final file = result!.files.first;
              setState(() {
                imageFile = file.path!;
              });
              print("Name: ${file.name}");
              print("Bytes: ${file.bytes}");
              print("Size: ${file.size}");
              print("Extension: ${file.extension}");
              print("Path: ${file.path}");

              // Save permanently.
              // await saveFilePermanently(file);
              // Open Files.
              //openFile(file);
            },
          ),
        ],
      ),
    );
  }
}

saveFilePermanently(PlatformFile file) async {
  final appStorage = await getApplicationDocumentsDirectory();
  final newFile = File("${appStorage.path}/${file.name}");

  return File(file.path!).copy(newFile.path);
}

void openFile(PlatformFile filePath) {
  OpenFile.open(filePath.path);
}
