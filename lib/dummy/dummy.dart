import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CircleSwitched.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/DialogSelector.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/WidgetsModels.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// # Clase .dart para la creación predeterminada de interfaces de registro, consulta y actualización.
// Contiene un botón que enn _OperacionesDummyState.build que desplega una ventana emergente,
// de la cual es posible elegir desde un catálogo de opciones.
// # # INSTRUCCIONES DE USO
// # # # Reemplazar .Dummy por el valor
// # # # Reemplazar Alergicos. por la clase que contiene el mapa .alergias con las claves
// # # # # consultIdQuery
// # # # # registerQuery
// # # # # updateQuery
// # # # Reemplazar .alergias por el nombre del Map() correspondiente.
//
class OperacionesDummy extends StatefulWidget {
  String? operationActivity;

  String _operationButton = 'Nulo';

  OperacionesDummy({Key? key, this.operationActivity = Constantes.Nulo})
      : super(key: key);

  @override
  State<OperacionesDummy> createState() => _OperacionesDummyState();
}

class _OperacionesDummyState extends State<OperacionesDummy> {
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
          idOperation = Patologicos.Degenerativos['ID_PACE_APP_DEG'];

          isActualDiagoValue = Dicotomicos.fromInt(
                  Patologicos.Degenerativos['Pace_APP_DEG_SINO'])
              .toString();
          if (Patologicos.selectedDiagnosis == "") {
            cieDiagnoTextController.text =
                Patologicos.Degenerativos['Pace_APP_DEG'];
          } else {
            cieDiagnoTextController.text = Patologicos.selectedDiagnosis;
          }
          comenDiagnoTextController.text =
              Patologicos.Degenerativos['Pace_APP_DEG_com'];
          ayoDiagoTextController.text =
              Patologicos.Degenerativos['Pace_APP_DEG_dia'].toString();
          //
          isTratamientoDiagoValue = Dicotomicos.fromInt(
                  Patologicos.Degenerativos['Pace_APP_DEG_tra_SINO'])
              .toString();
          tratamientoTextController.text =
              Patologicos.Degenerativos['Pace_APP_DEG_tra'];
          isSuspendTratoValue = Dicotomicos.fromInt(
                  Patologicos.Degenerativos['Pace_APP_DEG_sus_SINO'])
              .toString();
          suspensionesTextController.text =
              Patologicos.Degenerativos['Pace_APP_DEG_sus'];
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
      appBar: isMobile(context) || isTablet(context)
          ? AppBar(
              foregroundColor: Colors.white,
              backgroundColor: Theming.primaryColor,
              title: AppBarText(appBarTitile),
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
        decoration: ContainerDecoration.roundedDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                  controller: patologicosScroller,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: component(context),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            GrandButton(
                weigth: 2000,
                labelButton: widget._operationButton,
                onPress: () {
                  operationMethod(context);
                })
          ],
        ),
      ),
    );
  }

  Future<void> reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");

    Pacientes.Patologicos!.clear();
    Actividades.consultarAllById(
            Databases.siteground_database_regpace,
            Patologicos.patologicos['consultByIdPrimaryQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      setState(() {
        Pacientes.Patologicos = value;
        Terminal.printSuccess(
            message:
                "Actualizando Repositorio de Patologías del Paciente . . . ${Pacientes.Patologicos}");

        Archivos.createJsonFromMap(Pacientes.Patologicos!,
            filePath: Patologicos.fileAssocieted);
      });
    });
  }

  // Componentes de la Interfaz *******************************
  List<Widget> component(BuildContext context) {
    return [
      CrossLine(
        height: 20,
        color: Colors.black,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: isMobile(context) ? 2 : 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CircleSwitched(
                  tittle: "¿Diagnóstico actual?",
                  onChangeValue: (value) {
                    setState(() {
                      isActualDiagoValue =
                      Dicotomicos.fromBoolean(value) as String;
                    });
                  },
                  isSwitched: Dicotomicos.fromString(isActualDiagoValue)),
            ),
          ),
          Expanded(
            flex: 5,
            child: EditTextArea(
              keyBoardType: TextInputType.text,
              inputFormat: MaskTextInputFormatter(),
              numOfLines: 3,
              labelEditText: 'Diagnóstico (CIE)',
              textController: cieDiagnoTextController,
            ),
          ),
          Expanded(
            child: GrandIcon(
              labelButton: "CIE-10",
              weigth: 5,
              onPress: () {
                Operadores.openDialog(
                    context: context,
                    chyldrim: DialogSelector(
                      onSelected: ((value) {
                        setState(() {
                          Diagnosticos.selectedDiagnosis = value;
                          cieDiagnoTextController.text =
                              Diagnosticos.selectedDiagnosis;
                        });
                      }),
                    ));
              },
            ),
          ),
        ],
      ),
      CrossLine(
        height: 10,
        color: Colors.black,
      ),
      EditTextArea(
        keyBoardType: TextInputType.text,
        limitOfChars: 700,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Comentario de diagnóstico',
        textController: comenDiagnoTextController,
        numOfLines: 1,
      ),
      Row(
        children: [
          Expanded(
            flex: 2,
            child: EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(
                  mask: '##',
                  filter: {"#": RegExp(r'[0-9]')},
                  type: MaskAutoCompletionType.lazy),
              labelEditText: 'Años de diagnóstico',
              textController: ayoDiagoTextController,
              numOfLines: 1,
            ),
          ),
          Expanded(
            flex: 3,
            child: Spinner(
                tittle: "¿Tratamiento actual?",
                onChangeValue: (String value) {
                  setState(() {
                    isTratamientoDiagoValue = value;
                    if (value == Dicotomicos.dicotomicos()[0]) {
                      tratamientoTextController.text = "";
                    } else {
                      tratamientoTextController.text = "Sin tratamiento actual";
                    }
                  });
                },
                items: Dicotomicos.dicotomicos(),
                initialValue: isTratamientoDiagoValue),
          ),
        ],
      ),
      CrossLine(
        height: 5,
        color: Colors.black,
      ),
      EditTextArea(
        keyBoardType: TextInputType.text,
        limitOfChars: 1000,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Comentario del tratamiento',
        textController: tratamientoTextController,
        numOfLines: 3,
      ),
      CrossLine(),
      Row(
        children: [
          Expanded(
            flex: isMobile(context) ? 2 : 1,
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 40,
              child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 30,
                child: GrandIcon(
                  onPress: () {
                    Operadores.openDialog(
                        context: context,
                        chyldrim: Container(
                            decoration: ContainerDecoration.roundedDecoration(),
                            child: const AnalisisDummy()),
                        onAction: () {
                          setState(() {
                            suspensionesTextController.text = '';
                          });
                        });
                  },
                ),
              ),
            ),

            // child: Spinner(
            //   width: 20,
            //     tittle: "¿Suspensión reciente?",
            //     onChangeValue: (String value) {
            //       setState(() {
            //         isSuspendTratoValue = value;
            //         if (value == Dicotomicos.dicotomicos()[0]) {
            //           suspensionesTextController.text =
            //               "Con suspensiones en el tratamiento";
            //         } else {
            //           suspensionesTextController.text =
            //               "Sin suspensiones en el tratamiento";
            //         }
            //       });
            //     },
            //     items: Dicotomicos.dicotomicos(),
            //     initialValue: isSuspendTratoValue),
          ),
          Expanded(
            flex: 4,
            child: EditTextArea(
              limitOfChars: 1000,
              keyBoardType: TextInputType.text,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Antecedentes del Diagnóstico',
              textController: suspensionesTextController,
              numOfLines: 6,
            ),
          ),
        ],
      ),
    ];
  }

  // Operación del Método ***********************************
  void operationMethod(BuildContext context) {
    try {
      listOfValues = [
        idOperation,
        Pacientes.ID_Paciente,
        Dicotomicos.toInt(isActualDiagoValue),
        cieDiagnoTextController.text,
        comenDiagnoTextController.text,
        ayoDiagoTextController.text,
        Dicotomicos.toInt(isTratamientoDiagoValue),
        tratamientoTextController.text,
        Dicotomicos.toInt(isSuspendTratoValue),
        suspensionesTextController.text,
        idOperation
      ];

      print(
          "${widget.operationActivity} listOfValues $listOfValues ${listOfValues!.length}");

      switch (widget.operationActivity) {
        case Constantes.Nulo:
        // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(Databases.siteground_database_regpace,
              registerQuery!, listOfValues!.removeLast());
          break;
        case Constantes.Consult:
          break;
        case Constantes.Register:
        // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(Databases.siteground_database_regpace,
              registerQuery!, listOfValues!)
              .then((value) {
            Archivos.deleteFile(filePath: Patologicos.fileAssocieted);
            reiniciar().then((value) => Operadores.alertActivity(
                context: context,
                tittle: "Anexión de registros",
                message: "Registros Agregados",
                onAcept: () {
                  onClose(context);
                }));
            // ******************************************** *** *
            // Pacientes.Patologicos = value;
            // Constantes.reinit(value: value);
            // ******************************************** *** *
          });
          break;
        case Constantes.Update:
          Actividades.actualizar(Databases.siteground_database_regpace,
              updateQuery!, listOfValues!, idOperation)
              .then((value) {
            Archivos.deleteFile(filePath: Patologicos.fileAssocieted);
            reiniciar().then((value) => Operadores.alertActivity(
                context: context,
                tittle: "Actualización de registros",
                message: "Registros Actualizados",
                onAcept: () {
                  onClose(context);
                }));
            // // ******************************************** *** *
            // Pacientes.Patologicos = value;
            // Constantes.reinit(value: value);
            // ******************************************** *** *
          });
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
    }
  }

  // Operación Final ******** *******************************
  void onClose(BuildContext context) {
    switch (isMobile(context)) {
      case true:
        Navigator.push(
            context,
            MaterialPageRoute(
              // maintainState: false,
                builder: (context) => GestionDummy()));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
              // maintainState: false,
                builder: (context) => GestionDummy()));
        break;
      default:
    }
  }
  
  // VARIABLES DE LA INTERFAZ ******** ******* * * *  *
  String appBarTitile = "Gestión de Patologicos";
  String? consultIdQuery = Patologicos.patologicos['consultIdQuery'];
  String? registerQuery = Patologicos.patologicos['registerQuery'];
  String? updateQuery = Patologicos.patologicos['updateQuery'];

  int idOperation = 0;

  List<dynamic>? listOfValues;

  var isActualDiagoValue = Patologicos.actualDiagno[0];
  var cieDiagnoTextController = TextEditingController();
  var comenDiagnoTextController = TextEditingController();
  var ayoDiagoTextController = TextEditingController();
  //
  var isTratamientoDiagoValue = Patologicos.actualTratamiento[0];
  var tratamientoTextController = TextEditingController();
  var isSuspendTratoValue = Patologicos.actualSuspendido[0];
  var suspensionesTextController = TextEditingController();

  //
  var patologicosScroller = ScrollController();
}

class GestionDummy extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Pace_APP_ALE";
  // ****************** *** ****** **************

  GestionDummy({Key? key, this.actualSidePage}) : super(key: key);

  @override
  State<GestionDummy> createState() => _GestionDummyState();
}

class _GestionDummyState extends State<GestionDummy> {
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
          foregroundColor: Colors.white,
          backgroundColor: Theming.primaryColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            tooltip: Sentences.regresar,
            onPressed: () {
              Constantes.reinit();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VisualPacientes(actualPage: 6)));
            },
          ),
          title: AppBarText(appTittle),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.replay_outlined,
              ),
              tooltip: Sentences.reload,
              onPressed: () {
                reiniciar(); // _pullListRefresh();
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
                    child: EditTextArea(
                      labelEditText: searchCriteria,
                      textController: searchTextController,
                      inputFormat: MaskTextInputFormatter(),
                      keyBoardType: TextInputType.text,
                      withShowOption: true,
                      onChange: (value) {
                        _runFilterSearch(value);
                      },
                    )),
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
                              controller: ScrollController(),
                              padding: const EdgeInsets.all(4.0),
                              gridDelegate: GridViewTools.gridDelegate(
                                  crossAxisCount: isMobile(context) ? 1 : 3,
                                  mainAxisExtent:
                                      isMobile(context) ? 150 : 160),
                              shrinkWrap: false,
                              itemCount: snapshot.data == null
                                  ? 0
                                  : snapshot.data.length,
                              itemBuilder: (context, posicion) {
                                return itemListView(
                                    context: context,
                                    snapshot: snapshot,
                                    posicion: posicion);
                              })
                          : Container();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        isDesktop(context)
            ? widget.actualSidePage != null
                ? Expanded(
                    flex: 1,
                    child: Container(
                        decoration: ContainerDecoration.roundedDecoration(),
                        child: widget.actualSidePage!))
                : Expanded(flex: 1, child: Container())
            : Container()
      ]),
    );
  }

  // Funciones de Inicio  *****************************************
  void iniciar() {
    Terminal.printWarning(
        message:
            " . . . Iniciando Actividad - Repositorio Dummy del Pacientes");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        foundedItems = value;
        Pacientes.Balances = value;
        Terminal.printSuccess(
            message: 'Repositorio Dummy del Pacientes Obtenido');
      });
    }).onError((error, stackTrace) {
      Terminal.printAlert(
          message:
              'ERROR : No se abrio repositorio local - $error : : $stackTrace');
      reiniciar();
    });
    Terminal.printOther(message: " . . . Actividad Iniciada");
  }

  Future<void> reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");
    Actividades.consultarAllById(
      databaseQuery,
      consultQuery,
      Pacientes.ID_Paciente,
    ).then((value) {
      setState(() {
        foundedItems = value;
        Archivos.createJsonFromMap(foundedItems!, filePath: fileAssocieted);
      });
    }).onError((error, stackTrace) {
      Terminal.printAlert(
          message:
              'ERROR : No se realizó conexión con base de datos - $error : : $stackTrace');
      Operadores.alertActivity(
          context: context,
          tittle: "Error al Consultar Información",
          message: 'ERROR :  $error : : $stackTrace',
          onAcept: () {
            Navigator.of(context).pop();
          });
    });
  }

  // Funciones de Listado *****************************************
  GestureDetector itemListView(
      {required AsyncSnapshot snapshot,
      required int posicion,
      required BuildContext context}) {
    // print("posicion ${snapshot.data}");
    return GestureDetector(
      onTap: () {
        Balances.fromJson(snapshot.data[posicion]);
        Operadores.openDialog(
            context: context, chyldrim: const AnalisisDummy());
      },
      onDoubleTap: () {
        onSelected(snapshot, posicion, context, Constantes.Update);
      },
      child: Container(
        padding:
            const EdgeInsets.only(top: 5.0, bottom: 5.0, right: 2.0, left: 2.0),
        margin:
            const EdgeInsets.only(top: 2.5, bottom: 2.5, right: 2.0, left: 2.0),
        decoration: ContainerDecoration.roundedDecoration(),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.all(5.0),
                decoration: ContainerDecoration.roundedDecoration(),
                child: const CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text(
                    'ID no Asignado', // snapshot.data[posicion][idKey].toString(),
                    style: Styles.textSyle,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: CrossLine(
                  isHorizontal: false,
                  thickness: 3,
                )),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CrossLine(
                    thickness: 2,
                  ),
                  Row(
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSelected(AsyncSnapshot<dynamic> snapshot, int posicion,
      BuildContext context, String operaciones) {
    Balances.Balance = snapshot.data[posicion];
    // Balances.selectedDiagnosis = Balances.balance['Pace_APP_ALE'];
    Pacientes.Balances = snapshot.data;
    //
    Balances.fromJson(Balances.Balance);
    // ************** ********** ************
    toOperaciones(context, operaciones);
  }

  void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  // Funciones de Operación ****************************************
  void deleteRegister(
      AsyncSnapshot<dynamic> snapshot, int posicion, BuildContext context) {
    try {
      Actividades.eliminar(
          databaseQuery, deleteQuery, snapshot.data[posicion][idKey]);
      setState(() {
        snapshot.data.removeAt(posicion);
      });
    } finally {
      Navigator.of(context).pop();
    }
  }

  void toOperaciones(BuildContext context, String operationActivity) {
    init();
    // *********** ************* ********
    if (isDesktop(context)) {
      Constantes.operationsActividad = operationActivity;
      Constantes.reinit(value: foundedItems!);
      _pullListRefresh();
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => OperacionesDummy(
                operationActivity: operationActivity,
              )));
    }
  }

  // Funciones de Búsqueda *****************************************
  void _runFilterSearch(String enteredKeyword) {
    List? results = [];

    if (enteredKeyword.isEmpty) {
      _pullListRefresh();
    } else {
      Actividades.consultar(databaseQuery, consultAllQuery).then((value) {
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
            pageBuilder: (a, b, c) => GestionDummy(
                  actualSidePage: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OperacionesDummy(
                      operationActivity: Constantes.operationsActividad,
                    ),
                  ),
                ),
            transitionDuration: const Duration(seconds: 0)));
  }

  // Reinicio de Valores de Operación **********************************
  init() {
// Reinicio de Valores para la Operación *******************************
  }

  // VARIABLES *************************************************
  String appTittle = "Gestion del Dummy";
  String searchCriteria = "Buscar por Fecha";
  String idKey = 'ID_Bala';

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  // Variables de Conexión ******************************************
  String databaseQuery = Databases.siteground_database_reghosp;
  // ************************************************************
  String consultQuery = Balances.balance['consultIdQuery'];
  String deleteQuery = Balances.balance['deleteQuery'];
  String consultAllQuery = Balances.balance['consultByIdPrimaryQuery'];
 // Archivo Asociado **********************************************
  var fileAssocieted = Balances.fileAssocieted;
}

class AnalisisDummy extends StatefulWidget {
  const AnalisisDummy({Key? key}) : super(key: key);

  @override
  State<AnalisisDummy> createState() => _AnalisisDummyState();
}

class _AnalisisDummyState extends State<AnalisisDummy> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
