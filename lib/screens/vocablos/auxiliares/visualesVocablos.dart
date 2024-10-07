import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/screens/vocablos/vocablos.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';

class VisualVocablos extends StatefulWidget {
  const VisualVocablos({super.key});

  @override
  State<VisualVocablos> createState() => _VisualVocablosState();
}

class _VisualVocablosState extends State<VisualVocablos> {
  String appTittle = 'Visual del Vocáblo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Theming.primaryColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            tooltip: Sentences.regresar,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => GestionLexemas()));
            },
          ),
          title: Text(
            appTittle,
            style: Styles.textSyle,
          ),
          actions: <Widget>[

            IconButton(
              icon: const Icon(
                Icons.add_card,
              ),
              tooltip: Sentences.add_vitales,
              onPressed: () {
                toOperaciones(context, Constantes.Update);
              },
            ),
          ]),
      body: const Placeholder()
    );
  }

  void toOperaciones(BuildContext context, String operationActivity) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => OperacionesLexemas(
                operationActivity: operationActivity,
              )));
  }


}
