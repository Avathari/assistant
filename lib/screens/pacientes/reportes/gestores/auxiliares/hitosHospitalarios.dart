import 'dart:async';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Hitoshospitalarios extends StatefulWidget {
  String analisisTemporalFile =
      "${Pacientes.localReportsPath}hitosHospitlarios.txt";

  Hitoshospitalarios({super.key});

  @override
  State<Hitoshospitalarios> createState() => _HitoshospitalariosState();
}

class _HitoshospitalariosState extends State<Hitoshospitalarios> {
  Timer? _timer; // Definir un temporizador
  //

  @override
  void initState() {
    setState(() {
      hitosTextController.text = Reportes.hitosHospitalarios =
          Reportes.reportes['Hitos_Hospitalarios'];
    });
    //
    _timer = Timer.periodic(
        Duration(seconds: 7), (timer) => _saveToFile(hitosTextController.text));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EditTextArea(
        textController: hitosTextController,
        labelEditText: "Hitos de la Hospitalización",
        keyBoardType: TextInputType.multiline,
        numOfLines: 25,
        limitOfChars: 3000,
        withShowOption: true,
        onSelected: ()=>_readFromFile(),
        onChange: (value) => Reportes.hitosHospitalarios = value,
        inputFormat: MaskTextInputFormatter());
  }

  // VARIABLES **********************************************
  var hitosTextController = TextEditingController();

  // FUNCIONES *********************************************
  Future<void> _saveToFile(String text) async {
    // final path = await _getFilePath();
    if (text.isNotEmpty) {
      Archivos.writeInFile(text, filePath: widget.analisisTemporalFile);

      // final file = File(widget.analisisTemporalFile);
      // await file.writeAsString(text).whenComplete(
      //     () => null); // print("Texto guardado automáticamente cada 10 segundos"));
    }
  }

  // Función opcional para leer el contenido del archivo (si quieres cargarlo después)
  Future<String> _readFromFile() async {
    return Archivos.readFromFile(filePath: widget.analisisTemporalFile);
    // return await File(widget.analisisTemporalFile).readAsString();
  }
}
