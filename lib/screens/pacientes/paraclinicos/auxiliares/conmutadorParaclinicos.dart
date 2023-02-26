import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/paraclinicos/auxiliares/vistas/biometria.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
                      "Anexión de Valores de ${widget.categoriaEstudio}")),
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
        return Biometrias();
      case "Química Sanguínea":
        return Biometrias();
      case "Electrolitos Séricos":
        return Biometrias();
      default:
        return Biometrias();
    }
  }
}
