import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/screens/pacientes/paraclinicos/auxiliares/vistas/arteriales.dart';
import 'package:assistant/screens/pacientes/paraclinicos/auxiliares/vistas/biometria.dart';
import 'package:assistant/screens/pacientes/paraclinicos/auxiliares/vistas/cardiacos.dart';
import 'package:assistant/screens/pacientes/paraclinicos/auxiliares/vistas/coagulaciones.dart';
import 'package:assistant/screens/pacientes/paraclinicos/auxiliares/vistas/electrolitos.dart';
import 'package:assistant/screens/pacientes/paraclinicos/auxiliares/vistas/hepaticos.dart';
import 'package:assistant/screens/pacientes/paraclinicos/auxiliares/vistas/lipidicos.dart';
import 'package:assistant/screens/pacientes/paraclinicos/auxiliares/vistas/pancreaticos.dart';
import 'package:assistant/screens/pacientes/paraclinicos/auxiliares/vistas/quimicas.dart';
import 'package:assistant/screens/pacientes/paraclinicos/auxiliares/vistas/reactantes.dart';
import 'package:assistant/screens/pacientes/paraclinicos/auxiliares/vistas/tiroideos.dart';
import 'package:assistant/screens/pacientes/paraclinicos/auxiliares/vistas/venosos.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

class ConmutadorParaclinicos extends StatefulWidget {
  String? categoriaEstudio;

  ConmutadorParaclinicos({Key? key, required this.categoriaEstudio})
      : super(key: key);

  @override
  State<ConmutadorParaclinicos> createState() => _ConmutadorParaclinicosState();
}

class _ConmutadorParaclinicosState extends State<ConmutadorParaclinicos> {
  int indice = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ContainerDecoration.roundedDecoration(),
      child: Column(
        children: [
          Expanded(
              child: TittlePanel(
                  textPanel:
                      "Anexión de la ${widget.categoriaEstudio}")),
          Expanded(
              flex: 10,
              child: Container(
                padding: const EdgeInsets.all(5.0),
                margin: const EdgeInsets.all(5.0),
                decoration: ContainerDecoration.roundedDecoration(),
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: component(
                      context: context, categoria: widget.categoriaEstudio),
                ),
              ))
        ],
      ),
    );
  }

  Widget component({required BuildContext context, String? categoria}) {
    Terminal.printSuccess(
        message:
            "Conmutador Iniciado - Operador de ${widget.categoriaEstudio}");
    switch (widget.categoriaEstudio) {
      case "Biometría Hemática":
        return const Biometrias();
      case "Química Sanguínea":
        return const Quimicas();
      case "Electrolitos Séricos":
        return const Electrolitos();
      case "Pruebas de Funcionamiento Hepático":
        return const Hepaticos();
      case "Perfil Tiroideo":
        return const Tiroideos();
      case "Perfil Pancreático":
        return const Pancreaticos();
      case "Perfil Lipídico":
        return const Lipidicos();
      case "Tiempos de Coagulación":
        return const Coagulaciones();
      case "Reactantes de Fase Aguda":
        return const Reactantes();

      case "Gasometría Arterial":
        return const Arteriales();
      case "Gasometría Venosa":
        return const Venosos();

      case "Marcadores Cárdiacos":
        return const Cardiacos();
      default:
        return const Biometrias();
    }
  }
}
