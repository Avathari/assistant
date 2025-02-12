import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

class DialogSelector extends StatefulWidget {
  final ValueChanged<String>? onSelected;

  String? typeOfDocument;
  String? splitChar;

  String? keyMapSearch;
  String? pathForFileSource;
  String? secondaryKeyMap;

  String? tittle;
  String? searchCriteria;

  DialogSelector({
    super.key,
    this.tittle = 'Diagnósticos CIE-10',
    this.searchCriteria = "Buscar por Diagnóstico",
    this.keyMapSearch = 'Diagnostico_CIE',
    this.secondaryKeyMap = 'Codigo_CIE',
    this.typeOfDocument = 'json',
    this.splitChar = '\n',
    this.pathForFileSource = 'assets/diccionarios/Cie.json',
    required this.onSelected,
  });

  @override
  State<DialogSelector> createState() => _DialogSelectorState();
}

class _DialogSelectorState extends State<DialogSelector> {
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  // ***************************** # # # *****************************
  late List? foundedItems = [], originalItems = [];
  late int enteredKeyCount = 0;
  String lastEnteredKeyword = "";

  // ***************************** # # # *****************************
  @override
  void initState() {
    // if (widget.typeOfDocument == 'json') {
    //   Archivos.mapFromJson(path: widget.pathForFileSource!).then((valax) {
    //     setState(() {
    //       foundedItems = valax['Diccionarios_Cie'];
    //     });
    //   });
    // } else {
    //   Archivos.listFromText(
    //           path: widget.pathForFileSource!, splitChar: widget.splitChar!)
    //       .then((valax) {
    //     setState(() {
    //       foundedItems = valax;
    //     });
    //   });
    // }

    _pullListRefresh();
    super.initState();
  }

  // ***************************** # # # *****************************
  void _runFilterSearch(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      setState(() {
        // foundedItems = [];
        enteredKeyCount = 0;
      });

      // Restablecer la lista original desde la fuente de datos
      _pullListRefresh();
      return;
    }
    //
    lastEnteredKeyword = enteredKeyword;

    // Asegurarse de que foundedItems no sea null antes de filtrar
    if (widget.typeOfDocument == 'json') {
      List<dynamic> results = Listas.listFromMap(
        lista:
            originalItems ?? [], // Filtrar desde foundedItems en todo momento
        keySearched: 'Diagnostico_CIE',
        elementSearched: Sentences.capitalizeAllWord(enteredKeyword),
      );
      setState(() {
        foundedItems = results;
        enteredKeyCount = enteredKeyword.length;

      });
    } else {
      List<dynamic> results = originalItems!
          .where((user) => user.contains(Sentences.capitalizeAllWord(enteredKeyword)))
          .toList();
      setState(() {
        foundedItems = results;
        enteredKeyCount = enteredKeyword.length;
      });
    }
  }

  // ***************************** # # # *****************************
  void _pullListRefresh() {
    if (widget.typeOfDocument == 'json') {
      Archivos.mapFromJson(path: widget.pathForFileSource!).then((valax) {
        setState(() {
          foundedItems = originalItems = valax['Diccionarios_Cie'];
        });
      });
    } else {
      Archivos.listFromText(
              path: widget.pathForFileSource!, splitChar: widget.splitChar!)
          .then((valax) {
        setState(() {
          foundedItems = originalItems = valax;
        });
      });
    }
  }

  // ***************************** # # # *****************************
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.black,
      height: 900,
      width: 2000, // 400
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: TittlePanel(textPanel: widget.tittle),
          ),
          Expanded(
            child: TextField(
                onChanged: (value) {
                  _runFilterSearch(value);
                },
                controller: searchTextController,
                autofocus: false,
                keyboardType: TextInputType.text,
                autocorrect: true,
                obscureText: false,
                style: const TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  helperStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  labelText: widget.searchCriteria,
                  labelStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  contentPadding: const EdgeInsets.all(20),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  focusColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.replay_outlined,
                      color: Colors.white,
                    ),
                    tooltip: Sentences.reload,
                    onPressed: () {
                      _pullListRefresh();
                    },
                  ),
                )),
          ),
          Expanded(
            flex: 6,
            child: FutureBuilder<List>(
              initialData: foundedItems!,
              future: Future.value(foundedItems!),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) print(snapshot.error);
                return snapshot.hasData
                    ? ListView.builder(
                        controller: gestionScrollController,
                        shrinkWrap: true,
                        itemCount:
                            snapshot.data == null ? 0 : snapshot.data.length,
                        itemBuilder: (context, pos) {
                          return Container(
                            padding: const EdgeInsets.all(2.0),
                            child: GestureDetector(
                              onTap: () {
                                // ********************************
                                if (widget.typeOfDocument == 'json') {
                                  widget.onSelected!(snapshot.data[pos]
                                      ['${widget.keyMapSearch}']);
                                  print(
                                      "Seleccionado ${snapshot.data[pos]['${widget.keyMapSearch}']}");
                                } else {
                                  widget.onSelected!(snapshot.data[pos]);
                                  print("Seleccionado ${snapshot.data[pos]}");
                                }

                                Navigator.of(context).pop();
                                // ********************************
                              },
                              child: Card(
                                color: const Color.fromARGB(255, 54, 50, 50),
                                child: Container(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    widget.typeOfDocument == 'json'
                                        ? "${snapshot.data[pos]['${widget.secondaryKeyMap}']} - ${snapshot.data[pos]['${widget.keyMapSearch}']}"
                                        : "${snapshot.data[pos]}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(height: 50),
                            Text(
                              snapshot.hasError
                                  ? snapshot.error.toString()
                                  : snapshot.error.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                          ],
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
