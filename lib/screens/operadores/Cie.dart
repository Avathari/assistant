import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

class CieSelector extends StatefulWidget {
  final ValueChanged<String>? onSelected;

  String? keyMapSearch;
  String? pathForFileSource;
  String? secondaryKeyMap;

  String? tittle;
  String? searchCriteria;

  CieSelector({
    Key? key,
    this.tittle = 'Diagnósticos CIE-10',
    this.searchCriteria = "Buscar por Diagnóstico",
    this.keyMapSearch = 'Diagnostico_CIE',
    this.secondaryKeyMap = 'Codigo_CIE',
    this.pathForFileSource = 'assets/diccionarios/Cie.json',
    required this.onSelected,
  }) : super(key: key);

  @override
  State<CieSelector> createState() => _CieSelectorState();
}

class _CieSelectorState extends State<CieSelector> {
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  // ***************************** # # # *****************************
  late List? foundedItems = [];
  late int enteredKeyCount = 0;
  String lastEnteredKeyword = "";

  // ***************************** # # # *****************************
  @override
  void initState() {
    Archivos.mapFromJson(path: widget.pathForFileSource!).then((valax) {
      setState(() {
        foundedItems = valax['Diccionarios_Cie'];
      });
    });
    super.initState();
  }

  // ***************************** # # # *****************************
  void _runFilterSearch(String enteredKeyword) {
    List? results = [];
    //
    if (enteredKeyword.isEmpty) {
      enteredKeyCount = 0;
      _pullListRefresh();
    } else {
      lastEnteredKeyword = enteredKeyword;
      //
      if (enteredKeyword.length >= enteredKeyCount) {
        results = foundedItems!
            .where((user) => user["Diagnostico_CIE"].contains(enteredKeyword))
            .toList();
        setState(() {
          foundedItems = results;
        });
      } else {
        // Reinicia foundedItems con los registros del archivo.
        _pullListRefresh();
        // Nuevamente la búsqueda.
      }
      enteredKeyCount = enteredKeyword.length;
    }
  }

  // ***************************** # # # *****************************
  void _pullListRefresh() {
    Archivos.mapFromJson().then((valax) {
      setState(() {
        foundedItems = valax['Diccionarios_Cie'];
      });
    });
  }

  // ***************************** # # # *****************************
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.black,
      height: 900,
      width: 400,
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
                                widget.onSelected!(snapshot.data[pos]
                                    ['${widget.keyMapSearch}']);
                                Navigator.of(context).pop();
                                // ********************************
                              },
                              child: Card(
                                color: const Color.fromARGB(255, 54, 50, 50),
                                child: Container(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    "${snapshot.data[pos]['${widget.secondaryKeyMap}']} - ${snapshot.data[pos]['${widget.keyMapSearch}']}",
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
