import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Vocablos.dart';
import 'package:assistant/screens/home.dart';
import 'package:assistant/screens/vocablos/auxiliares/visualesVocablos.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CircleLabel.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/DialogSelector.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/WidgetsModels.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// # Clase .dart para la creación predeterminada de interfaces de registro, consulta y actualización.
// Contiene un botón que enn _OperacionesLexemasState.build que desplega una ventana emergente,
// de la cual es posible elegir desde un catálogo de opciones.
// # # INSTRUCCIONES DE USO
// # # # Reemplazar .Lexemas por el valor
// # # # Reemplazar Lexemas. por la clase que contiene el mapa .lexemas con las claves
// # # # # consultIdQuery
// # # # # registerQuery
// # # # # updateQuery
// # # # Reemplazar .lexemas por el nombre del Map() correspondiente.
//
class OperacionesLexemas extends StatefulWidget {
  String? operationActivity;

  String _operationButton = 'Nulo';

  OperacionesLexemas({Key? key, this.operationActivity = Constantes.Nulo})
      : super(key: key);

  @override
  State<OperacionesLexemas> createState() => _OperacionesLexemasState();
}

class _OperacionesLexemasState extends State<OperacionesLexemas> {
  String appBarTitile = "Gestión de Lexemas";
  String? consultIdQuery = Lexemas.lexemas['consultQuery'];
  String? registerQuery = Lexemas.lexemas['registerQuery'];
  String? updateQuery = Lexemas.lexemas['updateQuery'];

  int idOperation = 0;

  List<dynamic>? listOfValues;

  var tipoVocalValue = ''; //Lexemas.actualDiagno[0];
  var transliteracionTextController = TextEditingController();
  var subTipoVocalTextController = TextEditingController();

  var categoriaVocalTextController = TextEditingController();
  var nominacionVocalTextController = TextEditingController();
  String? fonematica;

  //
  var lexemasScroller = ScrollController();

  @override
  void initState() {
    //
    switch (widget.operationActivity) {
      case Constantes.Nulo:
        break;
      case Constantes.Consult:
        break;
      case Constantes.Register:
        widget._operationButton = 'Registrar';
        break;
      case Constantes.Update:
        setState(() {
          widget._operationButton = 'Actualizar';
          Terminal.printExpected(message: "${Lexemas.Lexema}");
          idOperation = Lexemas.Lexema['ID_Vocal'];
          tipoVocalValue = Lexemas.Lexema['Tipo_Vocal'];
          subTipoVocalTextController.text =
              Lexemas.Lexema['Subtipo_Vocal'] ?? '';

          categoriaVocalTextController.text =
              Lexemas.Lexema['Categoria_Vocal'] ?? '';
          nominacionVocalTextController.text =
              Lexemas.Lexema['Nominacion_Vocal'] ?? '';
          transliteracionTextController.text =
              Lexemas.Lexema['Trasliteracion'] ?? '';
          fonematica = Lexemas.Lexema['Fonematica'] ?? '';
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
      appBar: isMobile(context)
          ? AppBar(
              backgroundColor: Theming.primaryColor,
              title: Text(
                appBarTitile,
                style: Styles.textSyle,
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                tooltip: Sentences.regresar,
                onPressed: () {
                  onClose(context);
                },
              ))
          : null,
      body: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: ContainerDecoration.roundedDecoration(),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  controller: lexemasScroller,
                  child: Column(
                    children: component(context),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            GrandButton(
                labelButton: widget._operationButton,
                onPress: () {
                  operationMethod(context);
                })
          ],
        ),
      ),
    );
  }

  List<Widget> component(BuildContext context) {
    return [
      Row(
        children: [
          Expanded(
              child:
                  CircleLabel(tittle: Lexemas.Lexema['ID_Vocal'].toString())),
          Expanded(
            flex: 2,
            child: Spinner(
                width: isTablet(context)
                    ? 250
                    : isMobile(context)
                        ? 115
                        : 300,
                tittle: "Categoria Vocal",
                onChangeValue: (String value) {
                  setState(() {
                    tipoVocalValue = value;
                  });
                },
                items: Lexemas.tipoVocal,
                initialValue: tipoVocalValue),
          ),
        ],
      ),
      const Divider(
        color: Colors.grey,
        height: 30,
      ),
      EditTextArea(
        keyBoardType: TextInputType.text,
        inputFormat: MaskTextInputFormatter(),
        numOfLines: 1,
        labelEditText: 'Sub-Tipo Vocal',
        textController: subTipoVocalTextController,
      ),
      EditTextArea(
        keyBoardType: TextInputType.text,
        inputFormat: MaskTextInputFormatter(),
        numOfLines: 1,
        labelEditText: 'Categoria Vocal',
        textController: categoriaVocalTextController,
      ),
      EditTextArea(
        keyBoardType: TextInputType.text,
        inputFormat: MaskTextInputFormatter(),
        numOfLines: 1,
        labelEditText: 'Nominación Vocal',
        textController: nominacionVocalTextController,
      ),
      EditTextArea(
        keyBoardType: TextInputType.text,
        inputFormat: MaskTextInputFormatter(),
        numOfLines: 7,
        labelEditText: 'Transliteración',
        textController: transliteracionTextController,
      ),
      TittlePanel(textPanel: fonematica),
      // Row(
      //   children: [
      //     Expanded(
      //       flex: 2,
      //       child: EditTextArea(
      //         keyBoardType: TextInputType.text,
      //         inputFormat: MaskTextInputFormatter(),
      //         numOfLines: 1,
      //         labelEditText: 'Antecedente alérgico',
      //         textController: transliteracionTextController,
      //       ),
      //     ),
      //     GrandIcon(
      //       labelButton: "Antecedente alérgico",
      //       weigth: 5,
      //       onPress: () {},
      //     ),
      //   ],
      // ),
      // EditTextArea(
      //   keyBoardType: TextInputType.text,
      //   inputFormat: MaskTextInputFormatter(),
      //   labelEditText: 'Comentario de antecedente alérgico',
      //   textController: subTipoVocalTextController,
      //   numOfLines: 1,
      // ),
      // EditTextArea(
      //   keyBoardType: TextInputType.number,
      //   inputFormat: MaskTextInputFormatter(
      //       mask: '##',
      //       filter: {"#": RegExp(r'[0-9]')},
      //       type: MaskAutoCompletionType.lazy),
      //   labelEditText: 'Años de antecedente alérgico',
      //   textController: ayoDiagoTextController,
      //   numOfLines: 1,
      // ),
      // CrossLine(),
      // Spinner(
      //     tittle: "¿Tratamiento actual?",
      //     onChangeValue: (String value) {
      //       setState(() {
      //         isTratamientoDiagoValue = value;
      //         if (value == Dicotomicos.dicotomicos()[0]) {
      //           tratamientoTextController.text = "";
      //         } else {
      //           tratamientoTextController.text = "Sin tratamiento actual";
      //         }
      //       });
      //     },
      //     items: Dicotomicos.dicotomicos(),
      //     initialValue: isTratamientoDiagoValue),
      // EditTextArea(
      //   keyBoardType: TextInputType.text,
      //   inputFormat: MaskTextInputFormatter(),
      //   labelEditText: 'Comentario del tratamiento',
      //   textController: tratamientoTextController,
      //   numOfLines: 3,
      // ),
      // CrossLine(),
    ];
  }

  void operationMethod(BuildContext context) {
    try {
      listOfValues = [
        idOperation,
        tipoVocalValue,
        subTipoVocalTextController.text,
        categoriaVocalTextController.text,
        nominacionVocalTextController.text,
        transliteracionTextController.text,
        fonematica,
        idOperation,
      ];

      print(
          "${widget
              .operationActivity} listOfValues $listOfValues ${listOfValues!
              .length}");

        switch (widget.operationActivity) {
          case Constantes.Nulo:
            // ******************************************** *** *
            listOfValues!.removeAt(0);
            listOfValues!.removeLast();
            // ******************************************** *** *
            Actividades.registrar(Databases.siteground_database_vocal,
                registerQuery!, listOfValues!.removeLast());
            break;
          case Constantes.Consult:
            break;
          case Constantes.Register:
            // ******************************************** *** *
            listOfValues!.removeAt(0);
            listOfValues!.removeLast();
            // ******************************************** *** *
            Actividades.registrar(Databases.siteground_database_vocal,
                    registerQuery!, listOfValues!)
                .then((value) => Actividades.consultar(
                            Databases.siteground_database_vocal,
                            consultIdQuery!) // idOperation)
                        .then((value) {
                      // ******************************************** *** *
                      Vocablos.Lexemas = value;
                      Constantes.reinit(value: value);
                      // ******************************************** *** *
                    }).then((value) => onClose(context)));
            break;
          case Constantes.Update:
            Actividades.actualizar(Databases.siteground_database_vocal,
                    updateQuery!, listOfValues!, idOperation)
                .then((value) => Actividades.consultar(
                            Databases.siteground_database_vocal,
                            consultIdQuery!) // idOperation)
                        .then((value) {
                      // ******************************************** *** *
                      // Vocablos.Lexemas = value;
                      Archivos.createJsonFromMap(value,
                          filePath: Lexemas.fileAssocieted);

                      Constantes.reinit(value: value);
                      // ******************************************** *** *
                    }).then((value) => onClose(context)));
            break;
          default:
        }
      } catch (ex) {
        showDialog(
            context: context,
            builder: (context) {
              return alertDialog("Error al operar con los valores", "$ex", () {
                Navigator.of(context).pop();
              }, () {});
            });


  }}

  void onClose(BuildContext context) {
    switch (isMobile(context)) {
      case true:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionLexemas()));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionLexemas()));
        break;
      default:
    }
  }
}

class GestionLexemas extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Concepto_Recurso";
  // ****************** *** ****** **************

  GestionLexemas({Key? key, this.actualSidePage}) : super(key: key);

  @override
  State<GestionLexemas> createState() => _GestionLexemasState();
}

class _GestionLexemasState extends State<GestionLexemas> {
  String appTittle = "Gestion de Lexemas del Usuario";
  String searchCriteria = "Buscar transliteración";
  String? consultQuery = Lexemas.Lexema['consultQuery'];

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  @override
  void initState() {
    iniciar();
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
              Vocablos.Lexemas.clear();
              Constantes.reinit();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Home()));
            },
          ),
          title: Text(
            appTittle,
            style: Styles.textSyle,
          ),
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                          child: EditTextArea(
                        labelEditText: searchCriteria,
                        textController: searchTextController,
                        keyBoardType: TextInputType.text,
                        inputFormat: MaskTextInputFormatter(),
                        onChange: (value) {
                          _runFilterSearch(value);
                        },
                      )),
                      GrandIcon(
                          iconData: Icons.voicemail,
                          labelButton: 'Vacios',
                          onPress: () {
                            _runVaciosSearch();
                          }),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Expanded(
                  flex: 9,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
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
                                  ? ListView.builder(
                                      controller: gestionScrollController,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data == null
                                          ? 0
                                          : snapshot.data.length,
                                      itemBuilder: (context, posicion) {
                                        return itemListView(
                                            snapshot, posicion, context);
                                      },
                                    )
                                  : Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const CircularProgressIndicator(),
                                          const SizedBox(height: 50),
                                          Text(
                                            snapshot.hasError
                                                ? snapshot.error.toString()
                                                : snapshot.error.toString(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    );
                            },
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        margin: const EdgeInsets.only(left: 8.0),
                        decoration: ContainerDecoration.roundedDecoration(),
                        child: SingleChildScrollView(
                          controller: ScrollController(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GrandIcon(
                                  iconData: Icons.attractions,
                                  labelButton: 'Formas Verbales',
                                  onPress: () {
                                    _runFormasSearch(
                                        enteredKeyword: 'Formas Verbales');
                                  }),
                              GrandIcon(
                                  iconData: Icons.straighten_sharp,
                                  labelButton: 'Formas Lexémicas',
                                  onPress: () {
                                    _runFormasSearch(
                                        enteredKeyword: 'Formas Lexémicas');
                                  }),
                              GrandIcon(
                                  iconData: Icons.attractions,
                                  labelButton: 'Formas Adjetivales',
                                  onPress: () {
                                    _runFormasSearch(
                                        enteredKeyword: 'Formas Adjetivales');
                                  }),
                              GrandIcon(
                                  iconData: Icons.all_out,
                                  labelButton: 'Todos',
                                  onPress: () {
                                    _pullListRefresh();
                                  }),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }

  // OPERACIONES DE LA INTERFAZ ****************** ******** * * * *
  void iniciar() {
    Terminal.printWarning(
        message: " . . . Iniciando Actividad - Repositorio de Pacientes");
    Archivos.readJsonToMap(filePath: Lexemas.fileAssocieted).then((value) {
      setState(() {
        foundedItems = value;
        print(Listas.listWithoutRepitedValues(Listas.listFromMapWithOneKey(
            foundedItems!,
            keySearched: 'Tipo_Vocal')));
      });
    }).onError((error, stackTrace) {
      reiniciar();
    });
    Terminal.printWarning(message: " . . . Actividad Iniciada");
  }

  void reiniciar() {
    Terminal.printAlert(
        message: "Iniciando actividad : : \n "
            "Consulta de Lexemas del Usuario . . .");

    Actividades.consultar(
            Databases.siteground_database_vocal, consultQuery!) // idOperation)
        .then((value) {
      setState(() {
        Terminal.printSuccess(
            message: "Actualizando repositorio de pacientes . . . ");
        foundedItems = value;
        Archivos.createJsonFromMap(foundedItems!,
            filePath: Lexemas.fileAssocieted);
      });
    }).whenComplete(() => Operadores.alertActivity(
            context: context,
            tittle: "Datos Recargados",
            message: "Registro Actualizado",
            onAcept: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => GestionLexemas(),
                ),
              );
            }));
  }

  void deleteRegister(
      AsyncSnapshot<dynamic> snapshot, int posicion, BuildContext context) {
    try {
      Actividades.eliminar(Databases.siteground_database_vocal,
          Lexemas.Lexema['deleteQuery'], snapshot.data[posicion]['ID_Vocal']);
      setState(() {
        snapshot.data.removeAt(posicion);
      });
    } finally {
      Navigator.of(context).pop();
    }
  }

  void toOperaciones(BuildContext context, String operationActivity) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const VisualVocablos(

            )));
    // if (isMobile(context)) {
    //   Navigator.of(context).push(MaterialPageRoute(
    //       builder: (BuildContext context) => OperacionesLexemas(
    //             operationActivity: operationActivity,
    //           )));
    // } else {
    //   Constantes.operationsActividad = operationActivity;
    //   Constantes.reinit(value: foundedItems!);
    //   _pullListRefresh();
    // }
  }

  Container itemListView(
      AsyncSnapshot snapshot, int posicion, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          onSelected(snapshot, posicion, context, Constantes.Update);
        },
        child: Container(
          decoration: ContainerDecoration.roundedDecoration(),
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleLabel(
                      radios: 30,
                      tittle: snapshot.data[posicion]['ID_Vocal'].toString(),
                    ),
                    const Divider(
                      height: 15,
                    ),
                    CircleIcon(
                      tittle: snapshot.data[posicion]['Tipo_Vocal'] ==
                              'Formas Verbales'
                          ? 'Formas Verbales'
                          : snapshot.data[posicion]['Tipo_Vocal'] ==
                                  'Formas Lexémicas'
                              ? 'Formas Lexémicas'
                              : snapshot.data[posicion]['Tipo_Vocal'] ==
                                      'Formas Adjetivales'
                                  ? 'Formas Adjetivales'
                                  : snapshot.data[posicion]['Tipo_Vocal'] ==
                                          'Formas Verbales'
                                      ? 'Formas ALA'
                                      : 'Otro',
                      iconed: snapshot.data[posicion]['Tipo_Vocal'] ==
                              'Formas Verbales'
                          ? Icons.attractions
                          : snapshot.data[posicion]['Tipo_Vocal'] ==
                                  'Formas Lexémicos'
                              ? Icons.straighten_sharp
                              : snapshot.data[posicion]['Tipo_Vocal'] ==
                                      'Formas Adjetivales '
                                  ? Icons.attractions
                                  : snapshot.data[posicion]['Tipo_Vocal'] ==
                                          'Formas Verbales'
                                      ? Icons.attractions
                                      : Icons.add, onChangeValue: () {  },
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    TittlePanel(
                      color: Colors.black,
                      textPanel: "${snapshot.data[posicion]['Subtipo_Vocal']}",
                    ),
                    Text(
                      "${snapshot.data[posicion]['Categoria_Vocal']}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 14),
                    ),
                    Text(
                      "${snapshot.data[posicion]['Fonematica']}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 14),
                    ),
                    Text(
                      "${snapshot.data[posicion]['Trasliteracion']}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      color: Colors.grey,
                      icon: const Icon(Icons.update_rounded),
                      onPressed: () {
                        //
                        onSelected(
                            snapshot, posicion, context, Constantes.Update);
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      color: Colors.grey,
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alertDialog(
                                'Eliminar registro',
                                '¿Esta seguro de querer eliminar el registro?',
                                () {
                                  closeDialog(context);
                                },
                                () {
                                  deleteRegister(snapshot, posicion, context);
                                },
                              );
                            });
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSelected(AsyncSnapshot<dynamic> snapshot, int posicion,
      BuildContext context, String operaciones) {
    Terminal.printExpected(message: "${snapshot.data[posicion]}");
    Lexemas.Lexema = snapshot.data[posicion];
    // Lexemas.selectedDiagnosis = Lexemas.Lexema['Concepto_Recurso'];
    // Vocablos.Lexemas = snapshot.data;
    //
    toOperaciones(context, operaciones);
  }

  void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  // ACTIVIDADES DE BÚSQUEDA ************ ************ ***** * ** *
  Future<Null> _pullListRefresh() async {
    iniciar();
  }

  void _runFilterSearch(String enteredKeyword) {
    List? results = [];

    if (enteredKeyword.isEmpty) {
      _pullListRefresh();
    } else {
      results = Listas.listFromMap(
          lista: foundedItems!,
          keySearched: 'Trasliteracion',
          elementSearched: Sentences.capitalize(enteredKeyword));

      setState(() {
        foundedItems = results;
      });
    }
  }

  void _runFormasSearch({required enteredKeyword}) {
    Terminal.printWarning(
        message: " . . . Iniciando Actividad - Repositorio de Pacientes");
    Archivos.readJsonToMap(filePath: Lexemas.fileAssocieted).then((value) {
      setState(() {
        foundedItems = value;
      });
    }).onError((error, stackTrace) {
      reiniciar();
    }).whenComplete(() {
      Terminal.printWarning(message: " . . . Actividad Iniciada");
      List? results = [];

      if (enteredKeyword.isEmpty) {
        _pullListRefresh();
      } else {
        results = Listas.listFromMap(
            lista: foundedItems!,
            keySearched: 'Tipo_Vocal',
            elementSearched: Sentences.capitalize(enteredKeyword));

        // Terminal.printNotice(message: " . . . ${results.length} Pacientes Encontrados".toUpperCase());
        setState(() {
          foundedItems = results;
        });
      }
    });
  }

  void _runVaciosSearch() {
    List? results = [];

    results = Listas.listFromMap(
        lista: foundedItems!,
        keySearched: 'Trasliteracion',
        elementSearched: '');

    for (var item in results) {
      Terminal.printExpected(message: "${item['Trasliteracion']}");
    }
    setState(() {
      foundedItems = results;
    });
  }
}
