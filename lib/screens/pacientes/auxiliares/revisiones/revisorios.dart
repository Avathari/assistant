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
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/WidgetsModels.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// # Clase .dart para la creación predeterminada de interfaces de registro, consulta y actualización.
// Contiene un botón que enn _OperacionesRevisoriosState.build que desplega una ventana emergente,
// de la cual es posible elegir desde un catálogo de opciones.
// # # INSTRUCCIONES DE USO
// # # # Reemplazar .Revisorios por el valor
// # # # Reemplazar Alergicos. por la clase que contiene el mapa .alergias con las claves
// # # # # consultIdQuery
// # # # # registerQuery
// # # # # updateQuery
// # # # Reemplazar .alergias por el nombre del Map() correspondiente.
//
class OperacionesRevisorios extends StatefulWidget {
  String? operationActivity;

  String _operationButton = 'Nulo';

  OperacionesRevisorios({Key? key, this.operationActivity = Constantes.Nulo})
      : super(key: key);

  @override
  State<OperacionesRevisorios> createState() => _OperacionesRevisoriosState();
}

class _OperacionesRevisoriosState extends State<OperacionesRevisorios> {


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

        fechaEventoTextController.text = Calendarios.today(format: 'yyyy/MM/dd');
        break;
      case Constantes.Update:
        setState(() {
          Terminal.printSuccess(message: 'Situaciones :  ${Situaciones.Situacion}');
          widget._operationButton = 'Actualizar';
          idOperation = Situaciones.Situacion['ID_Sita'] ?? 0;
// *******************************************
          tipoIncidenciaTextController.text =
          Situaciones.Situacion['Sita_Tipo_Evento'] ?? '';
          eventualidadTextController.text =
              Situaciones.Situacion['Sita_Evento'] ?? '';
          fechaEventoTextController.text =
              Situaciones.Situacion['Sita_Fecha'].toString() ?? '';
          observacionesEventoTextController.text =
          Situaciones.Situacion['Sita_Obser'].toString() ?? '';
          otrosEventoTextController.text =
              Situaciones.Situacion['Sita_Otros'].toString() ?? '';
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

    Pacientes.Situacionario!.clear();
    Actividades.consultarAllById(
            databaseQuery,
            consultAllIdQuery,
            Pacientes.ID_Paciente)
        .then((value) {
      setState(() {
        Pacientes.Situacionario = value;
        Terminal.printSuccess(
            message:
                "Actualizando Situacionario del Paciente . . . ${Pacientes.Situacionario}");

        Archivos.createJsonFromMap(Pacientes.Situacionario!,
            filePath: Situaciones.fileAssocieted);
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
              numOfLines: 1,
              labelEditText: 'Tipo de Incidencias',
              textController: tipoIncidenciaTextController,
            ),
          ),
          Expanded(
            child: GrandIcon(
                labelButton: "Tipos de Incidencias",
                weigth: 5,
                onPress: () {
                  Operadores.selectOptionsActivity(
                    context: context,
                    options: Situaciones.Incidencias,
                    onClose: (String newValue) {
                      setState(() {
                        tipoEstudioValue = newValue;
                        // Actualización del Indice *************** *********** **************
                        index = Situaciones.Incidencias.indexOf(newValue);
                        // *************** *********** **************
                        tipoIncidenciaTextController.text = newValue;
                        // *************** *********** **************
                        Navigator.of(context).pop();
                      });
                    },
                  );
                }),
          ),
        ],
      ),
      CrossLine(
        height: 8,
        color: Colors.black,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: EditTextArea(
              keyBoardType: TextInputType.text,
              inputFormat: MaskTextInputFormatter(),
              numOfLines: 1,
              labelEditText: 'Eventualidad',
              textController: eventualidadTextController,
            ),
          ),
          Expanded(
            child: GrandIcon(
              iconData: Icons.list,
              labelButton: "Eventualidades",
              weigth: 5,
              onPress: () {
                Operadores.selectOptionsActivity(
                    context: context,
                    options: Situaciones
                        .Eventualidades[Situaciones.Incidencias[index]],
                    onClose: (String value) {
                      setState(() {
                        eventualidadTextController.text = value;
                        // *************** *********** **************
                        Navigator.of(context).pop();
                      });
                    });
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
        iconData: Icons.line_style,
        keyBoardType: TextInputType.datetime,
        inputFormat: MaskTextInputFormatter(
            mask: '####/##/##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Fecha del Evento',
        textController: fechaEventoTextController,
        numOfLines: 1,
        selection: true,
        withShowOption: true,
        onSelected: () {
          fechaEventoTextController.text = Calendarios.today(format: 'yyyy/MM/dd');
        },
      ),
      CrossLine(
        height: 5,
        color: Colors.black,
      ),
      EditTextArea(
        keyBoardType: TextInputType.text,
        limitOfChars: 1000,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Observaciones de la Incidencia',
        textController: observacionesEventoTextController,
        numOfLines: 3,
      ),
      EditTextArea(
        keyBoardType: TextInputType.text,
        limitOfChars: 1000,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Otros Comentarios de la Incidencia',
        textController: otrosEventoTextController,
        numOfLines: 3,
      ),
      CrossLine(),
    ];
  }

  // Operación del Método ***********************************
  void operationMethod(BuildContext context) {
    try {
      // Dicotomicos.toInt(isActualDiagoValue),
      listOfValues = [
        idOperation,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,

        tipoIncidenciaTextController.text,
        eventualidadTextController.text,
        fechaEventoTextController.text,
        observacionesEventoTextController.text,
        otrosEventoTextController.text,
        idOperation
      ];

      print(
          "${widget.operationActivity} "
              "listOfValues $listOfValues ${listOfValues!.length}");

      switch (widget.operationActivity) {
        case Constantes.Nulo:
          // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(databaseQuery,
              registerQuery!, listOfValues!.removeLast());
          break;
        case Constantes.Consult:
          break;
        case Constantes.Register:
          // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(databaseQuery,
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
          Actividades.actualizar(databaseQuery,
                  updateQuery!, listOfValues!, idOperation)
              .then((value) {
                Terminal.printSuccess(message: value);
            Archivos.deleteFile(filePath: Situaciones.fileAssocieted);
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
                builder: (context) => GestionRevisorios()));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionRevisorios()));
        break;
      default:
    }
  }

  // VARIABLES DE LA INTERFAZ ******** ******* * * *  *
  String appBarTitile = "Gestión de Patologicos";
  String? consultIdQuery = Situaciones.situacion['consultIdQuery'];
  String consultAllIdQuery = Situaciones.situacion['consultIdQuery'];
  String? registerQuery = Situaciones.situacion['registerQuery'];
  String? updateQuery = Situaciones.situacion['updateQuery'];
  // **************************************************** 
  String databaseQuery = Databases.siteground_database_reghosp;
// ****************************************************
  int idOperation = 0;
  List<dynamic>? listOfValues;

  // Variables de Operación *********************************
  var isActualDiagoValue = Patologicos.actualDiagno[0];
  var tipoIncidenciaTextController = TextEditingController();
  var eventualidadTextController = TextEditingController();
  var fechaEventoTextController = TextEditingController();
  var observacionesEventoTextController = TextEditingController();
  var otrosEventoTextController = TextEditingController();
  //
  var patologicosScroller = ScrollController();
  // Auxiliares *******************************************
  int index = 0;
  String? tipoEstudioValue;
}

class GestionRevisorios extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Pace_APP_ALE";
  // ****************** *** ****** **************

  GestionRevisorios({Key? key, this.actualSidePage}) : super(key: key);

  @override
  State<GestionRevisorios> createState() => _GestionRevisoriosState();
}

class _GestionRevisoriosState extends State<GestionRevisorios> {
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
                  builder: (context) => VisualPacientes(actualPage: 0)));
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
            " . . . Iniciando Actividad - Repositorio Revisorios del Pacientes");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        foundedItems = value;
        Pacientes.Situacionario = value;
        Terminal.printSuccess(
            message: 'Repositorio Revisorios del Pacientes Obtenido');
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
        onSelected(snapshot, posicion, context, Constantes.Update);
      },
      onDoubleTap: () {
        Situaciones.fromJson(snapshot.data[posicion]);
        Operadores.openDialog(
            context: context, chyldrim: const AnalisisRevisorios());
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
                child:  CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Text(
                    snapshot.data[posicion][idKey].toString(),
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
                  Column(
                    children: [
                      Text(snapshot.data[posicion]['Sita_Fecha'], style: Styles.textSyleGrowth(),),
                      Text(snapshot.data[posicion]['Sita_Tipo_Evento'], style: Styles.textSyleGrowth(),),
                      Text(snapshot.data[posicion]['Sita_Evento'], style: Styles.textSyleGrowth(),),
                    ],
                  ),
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
    Situaciones.Situacion = snapshot.data[posicion];
    //
    Pacientes.Situacionario = snapshot.data;
    //
    Situaciones.fromJson(Situaciones.Situacion);
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
          builder: (BuildContext context) => OperacionesRevisorios(
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
            pageBuilder: (a, b, c) => GestionRevisorios(
                  actualSidePage: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OperacionesRevisorios(
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
  String appTittle = "Gestion del Revisorios";
  String searchCriteria = "Buscar por Fecha";
  String idKey = 'ID_Sita';

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  // Variables de Conexión ******************************************
  String databaseQuery = Databases.siteground_database_reghosp;
  // ************************************************************
  String consultQuery = Situaciones.situacion['consultIdQuery'];
  String deleteQuery = Situaciones.situacion['deleteQuery'];
  String consultAllQuery = Situaciones.situacion['consultByIdPrimaryQuery'];
  // Archivo Asociado **********************************************
  var fileAssocieted = Situaciones.fileAssocieted;
}

class AnalisisRevisorios extends StatefulWidget {
  const AnalisisRevisorios({Key? key}) : super(key: key);

  @override
  State<AnalisisRevisorios> createState() => _AnalisisRevisoriosState();
}

class _AnalisisRevisoriosState extends State<AnalisisRevisorios> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
