import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  String? error;
  late Future<void> task;

  LoadingScreen({super.key, this.error, required this.task});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Theming.secondaryColor,
      child: Center(
        child: FutureBuilder(
          future: widget.task!,
          builder: (context, snapshot) {
            Terminal.printSuccess(message: "${snapshot.data}");
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Muestra un indicador de carga mientras el Future está en proceso
              return Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text("${snapshot.data}", style: Styles.textSyleGrowth(),),
                ],
              );
            } else {
              // Muestra el contenido una vez que el Future se completa
              return Text("Proceso Completado");
            }
          },
        ),
      ),
    );
  }
}
