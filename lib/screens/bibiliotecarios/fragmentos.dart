import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Bibliotecarios.dart';
import 'package:assistant/screens/bibiliotecarios/bibliotecas.dart';
import 'package:assistant/screens/home.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/DialogSelector.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/ViewDocument.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class OperacionesFragmentos extends StatefulWidget {
  String? operationActivity;

  String _operationButton = 'Nulo';

  OperacionesFragmentos({Key? key, this.operationActivity = Constantes.Nulo})
      : super(key: key);

  @override
  State<OperacionesFragmentos> createState() => _OperacionesFragmentosState();
}

class _OperacionesFragmentosState extends State<OperacionesFragmentos> {
  String appBarTitile =
      "Operación del Fragmento Obtenido del Recurso Bibliográfico";

  String? consultQuery = Fragmentos.fragmentos['consultQuery'];
  String? registerQuery = Fragmentos.fragmentos['registerQuery'];
  String? updateQuery = Fragmentos.fragmentos['updateQuery'];

  @override
  void initState() {
    // getImage();
    //
    switch (widget.operationActivity) {
      case Constantes.Nulo:
        break;
      case Constantes.Consult:
        break;
      case Constantes.Register:
        widget._operationButton = 'Registrar';

        keyWordsFragmentosTextController.text =
        Bibliotecas.palabrasClave!;

        break;
      case Constantes.Update:
        // ******** ********** ******** *******
        setState(() {
          widget._operationButton = 'Actualizar';
          // ******** ********** ******** *******
          idOperation = Fragmentos.biblioteca['ID_Lyben_fray'];
          Fragmentos.ID_Fragmento = idOperation;
          // ******** ********** ******** *******
          catysAbaValue = Fragmentos.biblioteca['Lyben_Catego_A'];
          catysEbeValue = Fragmentos.biblioteca['Lyben_Catego_B'];
          catysIbyValue = Fragmentos.biblioteca['Lyben_Catego_C'];

          keyWordsFragmentosTextController.text = Fragmentos.biblioteca['Lyben_Keywords'];
          conceptoFragmentosTextController.text =
              Fragmentos.biblioteca['Lyben_Concepto'];
          fragmentoFragmentosTextController.text =
              Fragmentos.biblioteca['Lyben_Fray'];
        });

        super.initState();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Theming.primaryColor,
          title: Text(appBarTitile),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            tooltip: Sentences.regresar,
            onPressed: () {
              onClose(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.bookmark_add_outlined,
              ),
              tooltip: "Abrir documento",
              onPressed: () {
                setState(() {});
              },
            ),
          ],
        ),
        body: isTablet(context) || isMobile(context)
            ? Column(
                children: [
                  Expanded(
                      child: ViewDocument(
                          messageError: "Cargando documento",
                          isFromMemory: true,
                          filePath: Bibliotecas.documentoBibliografia)),
                  Expanded(child: operativity()),
                ],
              )
            : Row(
                children: [
                  Expanded(
                      child: ViewDocument(
                          messageError: "Cargando documento",
                          isFromMemory: true,
                          filePath: Bibliotecas.documentoBibliografia)),
                  Expanded(child: operativity()),
                ],
              ));
  }

  Container operativity() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: ContainerDecoration.roundedDecoration(),
      child: Column(
        children: [
          Expanded(
            flex: 11,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              decoration: ContainerDecoration.roundedDecoration(),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10.0),
                controller: ScrollController(),
                child: Column(children: [
                  TittlePanel(
                    textPanel: Bibliotecas.tituloBibliografia,
                  ),
                  TittlePanel(
                    textPanel: Bibliotecas.nombreAutores,
                  ),
                  Spinner(
                      width: SpinnersValues.maximumWidth(context: context),
                      tittle: "Familia de Categorias del Articulo",
                      onChangeValue: (String value) {
                        setState(() {
                          catysAbaValue = value;
                        });
                      },
                      items: Fragmentos.catyeA,
                      initialValue: catysAbaValue),
                  Spinner(
                      width: SpinnersValues.maximumWidth(context: context),
                      tittle: "Categoria del Articulo",
                      onChangeValue: (String value) {
                        setState(() {
                          catysEbeValue = value;
                        });
                      },
                      items: Fragmentos.catyeB,
                      initialValue: catysEbeValue),
                  Spinner(
                      width: SpinnersValues.maximumWidth(context: context),
                      tittle: "Sub-Categoria del Articulo",
                      onChangeValue: (String value) {
                        setState(() {
                          catysIbyValue = value;
                        });
                      },
                      items: Fragmentos.catyeC,
                      initialValue: catysIbyValue),
                  EditTextArea(
                    keyBoardType: TextInputType.text,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Palabras Clave',
                    textController: keyWordsFragmentosTextController,
                    numOfLines: 1,
                    withShowOption: true,
                  ),
                  EditTextArea(
                    keyBoardType: TextInputType.text,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Diagnóstico del Recurso',
                    textController: conceptoFragmentosTextController,
                    numOfLines: 1,
                    withShowOption: true,
                    selection: true,
                    onSelected: () {
                      Operadores.openDialog(
                        context: context,
                        chyldrim: DialogSelector(
                          onSelected: (String value) {
                            setState(() {
                              conceptoFragmentosTextController.text = value;
                            });
                          },
                        ),
                      );
                    },
                    onChange: (value) {
                      setState(() {});
                    },
                  ),
                  EditTextArea(
                    keyBoardType: TextInputType.text,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Fragmento del Recurso',
                    textController: fragmentoFragmentosTextController,
                    numOfLines: 7,
                    withShowOption: true,
                  ),
                ]),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: ContainerDecoration.roundedDecoration(),
              child: GrandButton(
                  labelButton: widget._operationButton,
                  weigth: 2000,
                  onPress: () {
                    operationMethod(context);
                  }),
            ),
          )
        ],
      ),
    );
  }

  void operationMethod(BuildContext context) {
    try {
      Operadores.alertActivity(
          context: context,
          tittle: "Operación . . . ",
          message: "Operado registro");

      listOfValues = [
        idOperation,
        Bibliotecas.ID_Bibliografia,
        //
        catysAbaValue,
        catysEbeValue,
        catysIbyValue,
        keyWordsFragmentosTextController.text,
        conceptoFragmentosTextController.text,
        fragmentoFragmentosTextController.text,
        //
        idOperation
      ];

      print(
          "${widget.operationActivity} listOfValues ${listOfValues!.length} $listOfValues");

      switch (widget.operationActivity) {
        case Constantes.Nulo:
          // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(Databases.siteground_database_regasca,
              registerQuery!, listOfValues!.removeLast());
          break;
        case Constantes.Consult:
          break;
        case Constantes.Register:
          // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(Databases.siteground_database_regasca,
                  registerQuery!, listOfValues!)
              .then((value) => Actividades.consultar(
                    Databases.siteground_database_regasca,
                    consultQuery!,
                  ).then((value) {
                    // ******************************************** *** *
                    Fragmentos.fragmentaciones = value;
                    Constantes.reinit(value: value);
                    // ******************************************** *** *
                  }).then((value) => onClose(context)));
          break;
        case Constantes.Update:
          Actividades.actualizar(Databases.siteground_database_regasca,
                  updateQuery!, listOfValues!, idOperation)
              .then((value) => Actividades.consultar(
                    Databases.siteground_database_regasca,
                    consultQuery!,
                  ).then((value) {
                    // ******************************************** *** *
                    Fragmentos.fragmentaciones = value;
                    Constantes.reinit(value: value);
                    // ******************************************** *** *
                  }).then((value) => onClose(context)));
          break;
        default:
      }
    } catch (ex) {
      Operadores.alertActivity(
          context: context,
          tittle: "Error al Actualizar registro",
          message: "$ex");
    }
  }

  void onClose(BuildContext context) {
    Constantes.reinit();
    Navigator.push(
      context,
      MaterialPageRoute(
        // maintainState: false,
        builder: (context) => GestionFragmentos(),
      ),
    );
  }

// ****************************************
  void getImage() {
    if (Bibliotecas.documentoBibliografia == "") {
      Actividades.consultarId(
              Databases.siteground_database_regasca,
              Bibliotecas.bibliotecas['consultDocument'],
              Bibliotecas.ID_Bibliografia)
          .then((value) {
        setState(() {
          print("consultImage ${Bibliotecas.ID_Bibliografia} $value");
          Bibliotecas.documentoBibliografia = value['Lyben_File'];
        });
      });
    } else {
      setState(() {
        Bibliotecas.documentoBibliografia;
      });
    }
  }

// ****************************************
  int idOperation = 0;

  List<dynamic>? listOfValues;

  var catysAbaValue = Fragmentos.catyeA[0];
  var catysEbeValue = Fragmentos.catyeB[0];
  var catysIbyValue = Fragmentos.catyeC[0];
  var keyWordsFragmentosTextController = TextEditingController();
  var conceptoFragmentosTextController = TextEditingController();
  var fragmentoFragmentosTextController = TextEditingController();
  //
  var carouselController = CarouselController();
}

class GestionFragmentos extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Feca_PEN";
  // ****************** *** ****** **************

  GestionFragmentos({Key? key, this.actualSidePage}) : super(key: key);

  @override
  State<GestionFragmentos> createState() => _GestionFragmentosState();
}

class _GestionFragmentosState extends State<GestionFragmentos> {
  String appTittle =
      "Gestion de fragmentos de ${Bibliotecas.tituloBibliografia}";
  String searchCriteria = "Buscar por Fecha";
  String? consultQuery = Fragmentos.fragmentos['consultIdQuery'];

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  @override
  void initState() {
    print(" . . . Iniciando array ");
    if (Constantes.dummyArray!.isNotEmpty) {
      if (Constantes.dummyArray![0] == "Vacio") {
        Actividades.consultarAllById(Databases.siteground_database_regasca,
                consultQuery!, Bibliotecas.ID_Bibliografia)
            .then((value) {
          setState(() {
            print(" . . . Buscando items \n $value");
            foundedItems = value;
          });
        });
      } else {
        print(" . . . Fragmentos array iniciado");
        foundedItems = Constantes.dummyArray;
      }
    }
    super.initState();
  }

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
              Bibliotecas.documentoBibliografia = "";
              Constantes.reinit();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GestionBibliotecas()));
            },
          ),
          title: Text(appTittle),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.replay_outlined,
              ),
              tooltip: Sentences.reload,
              onPressed: () {
                // _pullListRefresh();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.add_card,
              ),
              tooltip: Sentences.add_vitales,
              onPressed: () {
                toOperaciones(context, Constantes.Register);
              },
            ),
          ]),
      body: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                        labelText: searchCriteria,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        contentPadding: const EdgeInsets.all(20),
                        enabledBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
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
              ),
              Expanded(
                flex: 9,
                child: RefreshIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.black,
                  onRefresh: _pullListRefresh,
                  child: FutureBuilder<List>(
                    initialData: foundedItems!,
                    future: Future.value(foundedItems!),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? GridView.builder(
                              controller: gestionScrollController,
                              padding: const EdgeInsets.all(10),
                              shrinkWrap: true,
                              itemCount: snapshot.data == null
                                  ? 0
                                  : snapshot.data.length,
                              itemBuilder: (context, posicion) {
                                return itemListView(
                                    snapshot, posicion, context);
                              },
                              gridDelegate: GridViewTools.gridDelegate(
                                crossAxisCount: 2,
                                mainAxisExtent: 320,
                              ),
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
              ),
            ],
          ),
        ),
        isDesktop(context) || isTabletAndDesktop(context)
            ? widget.actualSidePage != null
                ? Expanded(flex: 1, child: widget.actualSidePage!)
                : Expanded(flex: 1, child: Container())
            : Container()
      ]),
    );
  }

  Container itemListView(
      AsyncSnapshot snapshot, int posicion, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: ContainerDecoration.roundedDecoration(),
      child: GestureDetector(
        onTap: () {
          // onSelected(snapshot, posicion, context, Constantes.Update);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Text(
                      snapshot.data[posicion]['ID_Lyben_fray'].toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 24),
                    ),
                  ),
                  GrandIcon(
                    labelButton: "Actualizar registro",
                    iconData: Icons.update,
                    onPress: () {
                      onSelected(
                          snapshot, posicion, context, Constantes.Update);
                    },
                  ),
                  GrandIcon(
                    labelButton: "Eliminar registro",
                    iconData: Icons.delete,
                    onPress: () {
                      Operadores.optionsActivity(
                        context: context,
                        tittle: "Eliminar registro . . .",
                        message: '¿Esta seguro de querer eliminar el registro?',
                        textOptionA: "No",
                        optionA: () {
                          Navigator.of(context).pop();
                        },
                        textOptionB: "Aceptar",
                        optionB: () {
                          deleteRegister(snapshot, posicion, context);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      snapshot.data[posicion]['Lyben_Catego_A'].toString(),
                      maxLines: 2,
                      style: Styles.textSyleGrowth(fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      snapshot.data[posicion]['Lyben_Catego_B'].toString(),
                      style: Styles.textSyleGrowth(fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                  ),
                   Expanded(child: CrossLine()),
                  Expanded(
                    child: Text(
                      snapshot.data[posicion]['Lyben_Catego_C'].toString(),
                      style: Styles.textSyle,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      snapshot.data[posicion]['Lyben_Keywords'].toString(),
                      style: Styles.textSyle,
                      maxLines: 2,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      snapshot.data[posicion]['Lyben_Concepto'].toString(),
                      maxLines: 7,
                      style: Styles.textSyle,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onSelected(AsyncSnapshot<dynamic> snapshot, int posicion,
      BuildContext context, String operaciones,
      {bool isFragment = false}) {
    Fragmentos.biblioteca = snapshot.data[posicion];
    Fragmentos.fragmentaciones = snapshot.data;
    //
    toOperaciones(context, operaciones);
  }

  void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void deleteRegister(
      AsyncSnapshot<dynamic> snapshot, int posicion, BuildContext context) {
    try {
      Actividades.eliminar(
          Databases.siteground_database_regasca,
          Fragmentos.fragmentos['deleteQuery'],
          snapshot.data[posicion]['ID_Lyben_fray']);
      setState(() {
        snapshot.data.removeAt(posicion);
      });
    } finally {
      Navigator.of(context).pop();
    }
  }

  void toOperaciones(BuildContext context, String operationActivity) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => OperacionesFragmentos(
              operationActivity: operationActivity,
            )));

    // if (isDesktop(context) || isTabletAndDesktop(context)) {
    //   Constantes.operationsActividad = operationActivity;
    //   Constantes.reinit(value: foundedItems!);
    //   _pullListRefresh();
    // } else {
    //   Navigator.of(context).push(MaterialPageRoute(
    //       builder: (BuildContext context) => OperacionesFragmentos(
    //             operationActivity: operationActivity,
    //           )));
    // }
  }

  void _runFilterSearch(String enteredKeyword) {
    List? results = [];

    if (enteredKeyword.isEmpty) {
      _pullListRefresh();
    } else {
      Actividades.consultar(
              Databases.siteground_database_regasca, consultQuery!)
          .then((value) {
        results = value
            .where((user) => user[widget.keySearch].contains(enteredKeyword))
            .toList();

        setState(() {
          foundedItems = results;
        });
      });
    }
  }

  Future<Null> _pullListRefresh() async {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (a, b, c) => GestionFragmentos(
                  actualSidePage: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OperacionesFragmentos(
                      operationActivity: Constantes.operationsActividad,
                    ),
                  ),
                ),
            transitionDuration: const Duration(seconds: 0)));
  }
}
