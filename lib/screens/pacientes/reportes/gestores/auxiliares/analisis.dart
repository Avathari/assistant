import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Bibliotecarios.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Bibliografico extends StatefulWidget {
  const Bibliografico({Key? key}) : super(key: key);

  @override
  State<Bibliografico> createState() => _BibliograficoState();
}

class _BibliograficoState extends State<Bibliografico> {

  @override
  void initState() {
    setState(() {
      anysTextController.text = Reportes.analisisMedico;
    });
    _pullListRefresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(10.0),
          decoration: ContainerDecoration.roundedDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: EditTextArea(
                  labelEditText: "Análisis Médico",
                  textController: anysTextController,
                  keyBoardType: TextInputType.text,
                  numOfLines: 30,
                  inputFormat: MaskTextInputFormatter(),
                  onChange: ((value) {
                    Reportes.analisisMedico = "$value.";
                  }),
                ),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: "Referencias Bibliográficas",
                  textController: cytasTextController,
                  keyBoardType: TextInputType.text,
                  inputFormat: MaskTextInputFormatter(),
                  onChange: ((value) {
                    Reportes.bibliografias = "$value.";
                  }),
                ),
              ),
            ],
          ),
        )),
        Expanded(
            // labelEditText: "Registro de Fragmentos Bibliográficos",
            child: Container(
          padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.all(10.0),
          decoration: ContainerDecoration.roundedDecoration(),
          child: Column(
            children: [
              Expanded(
                child: TittlePanel(
                    padding: 0,
                    textPanel: "Registro de Fragmentos Bibliográficos"),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: EditTextArea(
                        textController: motivoAnysTextController,
                        labelEditText: "Diagnóstico del Fragmento Bibliográfico",
                        keyBoardType: TextInputType.multiline,
                        numOfLines: 1,
                        withShowOption: true,
                        selection: true,
                        onSelected: () {
                          Operadores.selectOptionsActivity(
                              context: context,
                              tittle: 'Seleccione un diagnóstico . . . ',
                              options: Pacientes.diagnosticosCie().split("\n"),
                              onClose: (value) {
                                setState(() {
                                  motivoAnysTextController.text = value;
                                  _runFilterSearch(value);
                                });
                                Navigator.of(context).pop();
                              });
                        },
                        onChange: (value) {
                          setState(() {
                            _runFilterSearch(value);
                            // Reportes.reportes['Motivo_Prequirurgico'] = Pacientes.motivoPrequirurgico();
                          });
                        },
                        inputFormat: MaskTextInputFormatter()),
                  ),
                  Expanded(child: GrandIcon(onPress: () {
                    _pullListRefresh();
                  },))
                ],
              ),
              Expanded(
                flex: 8,
                child: FutureBuilder<List>(
                    initialData: foundedFragments!,
                    future: Future.value(foundedFragments!),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? GridView.builder(
                          gridDelegate: GridViewTools.gridDelegate(crossAxisCount: 2),
                              controller: ScrollController(),
                              shrinkWrap: true,
                              itemCount: snapshot.data == null
                                  ? 0
                                  : snapshot.data.length,
                              itemBuilder: (context, posicion) {
                                return GestureDetector(
                                  onDoubleTap: () {
                                    var value = "${anysTextController.text}"
                                        "${snapshot.data[posicion]['Lyben_Fray']}\n";
                                    setState(() {
                                      Reportes.analisisMedico = "$value.";
                                      anysTextController.text = "$value.";
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    padding: const EdgeInsets.all(17),
                                    decoration:
                                        ContainerDecoration.roundedDecoration(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Concepto : ${snapshot.data[posicion]['Lyben_Concepto']}",
                                          maxLines: 2,
                                          style: Styles.textSyleGrowth(
                                              fontSize: 12),
                                        ),
                                        Text(
                                          "${snapshot.data[posicion]['Lyben_Fray']}",
                                          maxLines: 5,
                                          style: Styles.textSyleGrowth(
                                              fontSize: 8),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : Container();
                    }),
              ),
            ],
          ),
        )),
      ],
    );
  }

  void _runFilterSearch(String enteredKeyword) {
    List? results = [];

    if (enteredKeyword.isEmpty) {
      _pullListRefresh();
    } else {
      results = Listas.listFromMap(
          lista: foundedFragments!,
          keySearched: 'Lyben_Concepto',
          elementSearched: motivoAnysTextController.text);
      print("results $results");
      setState(() {
        foundedFragments = results;
      });
    }
  }

  Future<Null> _pullListRefresh() async {
    motivoAnysTextController.text = "";

    if (foundedFragments!.isEmpty) {
      Actividades.consultar(Databases.siteground_database_regasca,
          Fragmentos.fragmentos['consultQuery']!)
          .then((value) {
        setState(() {
          print("Gestion fragmentos $value");
          foundedFragments = value;
        });
      });
    }
  }

  // Variables *** ********* ****************
  late List? foundedFragments = [];
  var searchTextController = TextEditingController();

  String searchCriteria = "Buscar por Apellido";

  var anysTextController = TextEditingController();
  var cytasTextController = TextEditingController();
  var motivoAnysTextController = TextEditingController();
}
