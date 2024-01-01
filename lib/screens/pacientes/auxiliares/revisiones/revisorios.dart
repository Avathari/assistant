import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/terapias.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CircleLabel.dart';
import 'package:assistant/widgets/CircleSwitched.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/TittleContainer.dart';
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

        fechaEventoTextController.text =
            Calendarios.today(format: 'yyyy/MM/dd');
        break;
      case Constantes.Update:
        setState(() {
          Terminal.printSuccess(
              message: 'Situaciones :  ${Situaciones.Situacion}');
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
              child: component(context),
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
            databaseQuery, consultAllIdQuery, Pacientes.ID_Paciente)
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
  TittleContainer component(BuildContext context) {
    return TittleContainer(
      tittle: "                                      ",
      color: Theming.quincuaryColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: [
                CircleSwitched(
                    tittle: "¿Diagnóstico actual?",
                    onChangeValue: (bool value) {
                      Terminal.printExpected(message: "${!value}");
                      setState(() {
                        isActualDiagoValue =
                            Dicotomicos.fromBoolean(!value) as String;
                      });
                    },
                    isSwitched: Dicotomicos.fromString(isActualDiagoValue)),
                CrossLine(thickness: 3, height: 25),
                EditTextArea(
                  keyBoardType: TextInputType.text,
                  inputFormat: MaskTextInputFormatter(),
                  numOfLines: 1,
                  labelEditText: 'Tipo de Incidencias',
                  textController: tipoIncidenciaTextController,
                ),
                const SizedBox(height: 10),
                GrandIcon(
                    labelButton: "Tipos de Incidencias",
                    iconData: Icons.disc_full,
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
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
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
                    fechaEventoTextController.text =
                        Calendarios.today(format: 'yyyy/MM/dd');
                  },
                ),
                CrossLine(thickness: 4, height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: EditTextArea(
                        keyBoardType: TextInputType.text,
                        inputFormat: MaskTextInputFormatter(),
                        numOfLines: 3,
                        labelEditText: 'Eventualidad',
                        textController: eventualidadTextController,
                        selection: true,
                        withShowOption: true,
                        onSelected: () {
                          Operadores.selectOptionsActivity(
                              context: context,
                              options: Situaciones.Eventualidades[
                                  Situaciones.Incidencias[index]],
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
                EditTextArea(
                  keyBoardType: TextInputType.text,
                  limitOfChars: 1000,
                  inputFormat: MaskTextInputFormatter(),
                  labelEditText: 'Observaciones de la Incidencia',
                  textController: observacionesEventoTextController,
                  numOfLines: 1,
                ),
                EditTextArea(
                  keyBoardType: TextInputType.text,
                  limitOfChars: 1000,
                  inputFormat: MaskTextInputFormatter(),
                  labelEditText: 'Otros Comentarios de la Incidencia',
                  textController: otrosEventoTextController,
                  numOfLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

      print("${widget.operationActivity} "
          "listOfValues $listOfValues ${listOfValues!.length}");

      switch (widget.operationActivity) {
        case Constantes.Nulo:
          // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(
              databaseQuery, registerQuery!, listOfValues!.removeLast());
          break;
        case Constantes.Consult:
          break;
        case Constantes.Register:
          // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(databaseQuery, registerQuery!, listOfValues!)
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
          Actividades.actualizar(
                  databaseQuery, updateQuery!, listOfValues!, idOperation)
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
            context: context, chyldrim:  AnalisisRevisorios());
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
                child: CircleAvatar(
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
                      Text(
                        snapshot.data[posicion]['Sita_Fecha'],
                        style: Styles.textSyleGrowth(),
                      ),
                      Text(
                        snapshot.data[posicion]['Sita_Tipo_Evento'],
                        style: Styles.textSyleGrowth(),
                      ),
                      Text(
                        snapshot.data[posicion]['Sita_Evento'],
                        style: Styles.textSyleGrowth(),
                      ),
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
    // Situaciones.fromJson(Situaciones.Situacion);
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

  bool? isInOther;

  AnalisisRevisorios({Key? key,
  this.isInOther = false,
  }) : super(key: key);

  @override
  State<AnalisisRevisorios> createState() => _AnalisisRevisoriosState();
}

class _AnalisisRevisoriosState extends State<AnalisisRevisorios> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final _pageController = PageController();

  int _activePage = 0;


  @override
  void initState() {
    Situaciones.consultarRegistro();
    //
    _iniciar();
    super.initState();
  }

  void _iniciar() {
    // 0: CVP **************************************************************
    tipoIncidenciaCVPTextController.text = Situaciones.Incidencias[1];
    eventualidadCVPTextController.text =
        Situaciones.Eventualidades['Dispositivos'][0];
    // 1: CVLP **************************************************************
    tipoIncidenciaCVLPTextController.text = Situaciones.Incidencias[1];
    eventualidadCVLPTextController.text =
        Situaciones.Eventualidades['Dispositivos'][1];
    // 2: CVC **************************************************************
    tipoIncidenciaCVCTextController.text = Situaciones.Incidencias[1];
    eventualidadCVCTextController.text =
        Situaciones.Eventualidades['Dispositivos'][2];
    // 3: MAHA **************************************************************
    tipoIncidenciaMAHATextController.text = Situaciones.Incidencias[1];
    eventualidadMAHATextController.text =
        Situaciones.Eventualidades['Dispositivos'][3];
    // 4: FOL **************************************************************
    tipoIncidenciaFOLTextController.text = Situaciones.Incidencias[1];
    eventualidadFOLTextController.text =
        Situaciones.Eventualidades['Dispositivos'][4];
    // 5: SNG **************************************************************
    tipoIncidenciaSNGTextController.text = Situaciones.Incidencias[1];
    eventualidadSNGTextController.text =
        Situaciones.Eventualidades['Dispositivos'][5];
    // 6: SOG **************************************************************
    tipoIncidenciaSOGTextController.text = Situaciones.Incidencias[1];
    eventualidadSOGTextController.text =
        Situaciones.Eventualidades['Dispositivos'][6];
    // 7: PEN **************************************************************
    tipoIncidenciaPENTextController.text = Situaciones.Incidencias[1];
    eventualidadPENTextController.text =
        Situaciones.Eventualidades['Dispositivos'][7];
    // 8 : COL **************************************************************
    tipoIncidenciaCOLTextController.text = Situaciones.Incidencias[1];
    eventualidadCOLTextController.text =
        Situaciones.Eventualidades['Dispositivos'][8];
    // 9 : SEP ***************************************************************
    tipoIncidenciaSEPTextController.text = Situaciones.Incidencias[1];
    eventualidadSEPTextController.text =
        Situaciones.Eventualidades['Dispositivos'][9];
    // 10 : GAS **************************************************************
    tipoIncidenciaGASTextController.text = Situaciones.Incidencias[1];
    eventualidadGASTextController.text =
        Situaciones.Eventualidades['Dispositivos'][10];
    // 11: TNK **************************************************************
    tipoIncidenciaTNKTextController.text = Situaciones.Incidencias[1];
    eventualidadTNKTextController.text =
        Situaciones.Eventualidades['Dispositivos'][11];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Theming.quincuaryColor,
      appBar: widget.isInOther == false ?
      AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Theming.primaryColor,
          title: AppBarText(appBarTitile))
      : null,
      // endDrawer: _drawerForm(context),
      floatingActionButton:  widget.isInOther == false ?_floattingActionButton(context):null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:  widget.isInOther == false ?_bottomNavigationBar(context) : null,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 2,
              child: ListView(
                controller: ScrollController(),
                children: [
                  // 0: CVP **************************************************************
                  TittleContainer(
                    tittle: "                                      CVP ",
                    color: Theming.quincuaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: CircleSwitched(
                              tittle: "¿Diagnóstico actual?",
                              radios: 30,
                              difRadios: 5,
                              onChangeValue: (bool value) {
                                Terminal.printExpected(
                                    message:
                                        "Value $value : not value : ${!value}");
                                setState(() {
                                  isActualCVPValue =
                                      Dicotomicos.fromBoolean(!value) as String;
                                  if (isActualCVPValue == 'Si') {
                                    fechaEventoCVPTextController.text =
                                        Calendarios.today(format: 'yyyy/MM/dd');
                                  } else {
                                    fechaEventoCVPTextController.text = '';
                                  }
                                });
                              },
                              isSwitched:
                                  Dicotomicos.fromString(isActualCVPValue)),
                        ),
                        Expanded(
                          child: CircleLabel(
                            radios: 20,
                            difRadios: 5,
                            fontSize: 8,
                            tittle: 'CVP',
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: EditTextArea(
                            iconData: Icons.line_style,
                            keyBoardType: TextInputType.datetime,
                            inputFormat: MaskTextInputFormatter(
                                mask: '####/##/##',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy),
                            labelEditText: 'Fecha del Evento',
                            textController: fechaEventoCVPTextController,
                            numOfLines: 1,
                            selection: true,
                            withShowOption: true,
                            onSelected: () {
                              fechaEventoCVPTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 1: CVLP **************************************************************
                  TittleContainer(
                    tittle: "                                      CVLP ",
                    color: Theming.quincuaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: CircleSwitched(
                              tittle: "¿Diagnóstico actual?",
                              radios: 30,
                              difRadios: 5,
                              onChangeValue: (bool value) {
                                Terminal.printExpected(
                                    message:
                                        "Value $value : not value : ${!value}");
                                setState(() {
                                  isActualCVLPValue =
                                      Dicotomicos.fromBoolean(!value) as String;
                                  if (isActualCVLPValue == 'Si') {
                                    fechaEventoCVLPTextController.text =
                                        Calendarios.today(format: 'yyyy/MM/dd');
                                  } else {
                                    fechaEventoCVLPTextController.text = '';
                                  }
                                });
                              },
                              isSwitched:
                                  Dicotomicos.fromString(isActualCVLPValue)),
                        ),
                        Expanded(
                          child: CircleLabel(
                            radios: 20,
                            difRadios: 5,
                            fontSize: 8,
                            tittle: 'CVLP',
                            // child: Text('CVLP', style: Styles.textSyleGrowth(fontSize: 10)),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: EditTextArea(
                            iconData: Icons.line_style,
                            keyBoardType: TextInputType.datetime,
                            inputFormat: MaskTextInputFormatter(
                                mask: '####/##/##',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy),
                            labelEditText: 'Fecha del Evento',
                            textController: fechaEventoCVLPTextController,
                            numOfLines: 1,
                            selection: true,
                            withShowOption: true,
                            onSelected: () {
                              fechaEventoCVLPTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 2: CVC **************************************************************
                  TittleContainer(
                    tittle: "                                      CVC ",
                    color: Theming.quincuaryColor,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: CircleSwitched(
                              tittle: "¿Diagnóstico actual?",
                              radios: 30,
                              difRadios: 5,
                              onChangeValue: (bool value) {
                                Terminal.printExpected(
                                    message:
                                        "Value $value : not value : ${!value}");
                                setState(() {
                                  isActualCVCValue =
                                      Dicotomicos.fromBoolean(!value) as String;
                                  if (isActualCVCValue == 'Si') {
                                    fechaEventoCVCTextController.text =
                                        Calendarios.today(format: 'yyyy/MM/dd');
                                  } else {
                                    fechaEventoCVCTextController.text = '';
                                  }
                                });
                              },
                              isSwitched:
                                  Dicotomicos.fromString(isActualCVCValue)),
                        ),
                        Expanded(
                          child: CircleLabel(
                            radios: 20,
                            difRadios: 5,
                            fontSize: 8,
                            tittle: 'CVC',
                            // child: Text('CVC', style: Styles.textSyleGrowth(fontSize: 10)),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: EditTextArea(
                            iconData: Icons.line_style,
                            keyBoardType: TextInputType.datetime,
                            inputFormat: MaskTextInputFormatter(
                                mask: '####/##/##',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy),
                            labelEditText: 'Fecha del Evento',
                            textController: fechaEventoCVCTextController,
                            numOfLines: 1,
                            selection: true,
                            withShowOption: true,
                            onSelected: () {
                              fechaEventoCVCTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 3: MAHA **************************************************************
                  TittleContainer(
                    tittle: "                                      MAHA ",
                    color: Theming.quincuaryColor,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: CircleSwitched(
                              tittle: "¿Diagnóstico actual?",
                              radios: 30,
                              difRadios: 5,
                              onChangeValue: (bool value) {
                                Terminal.printExpected(
                                    message:
                                        "Value $value : not value : ${!value}");
                                setState(() {
                                  isActualMAHAValue =
                                      Dicotomicos.fromBoolean(!value) as String;
                                  if (isActualMAHAValue == 'Si') {
                                    fechaEventoMAHATextController.text =
                                        Calendarios.today(format: 'yyyy/MM/dd');
                                  } else {
                                    fechaEventoMAHATextController.text = '';
                                  }
                                });
                              },
                              isSwitched:
                                  Dicotomicos.fromString(isActualMAHAValue)),
                        ),
                        Expanded(
                          child: CircleLabel(
                            radios: 20,
                            difRadios: 5,
                            fontSize: 8,
                            tittle: 'MAHA',
                            // child: Text('MAHA', style: Styles.textSyleGrowth(fontSize: 10)),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: EditTextArea(
                            iconData: Icons.line_style,
                            keyBoardType: TextInputType.datetime,
                            inputFormat: MaskTextInputFormatter(
                                mask: '####/##/##',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy),
                            labelEditText: 'Fecha del Evento',
                            textController: fechaEventoMAHATextController,
                            numOfLines: 1,
                            selection: true,
                            withShowOption: true,
                            onSelected: () {
                              fechaEventoMAHATextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 4: FOL **************************************************************
                  TittleContainer(
                    tittle: "                                      FOL ",
                    color: Theming.quincuaryColor,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: CircleSwitched(
                              tittle: "¿Diagnóstico actual?",
                              radios: 30,
                              difRadios: 5,
                              onChangeValue: (bool value) {
                                Terminal.printExpected(
                                    message:
                                        "Value $value : not value : ${!value}");
                                setState(() {
                                  isActualFOLValue =
                                      Dicotomicos.fromBoolean(!value) as String;
                                  if (isActualFOLValue == 'Si') {
                                    fechaEventoFOLTextController.text =
                                        Calendarios.today(format: 'yyyy/MM/dd');
                                  } else {
                                    fechaEventoFOLTextController.text = '';
                                  }
                                });
                              },
                              isSwitched:
                                  Dicotomicos.fromString(isActualFOLValue)),
                        ),
                        Expanded(
                          child: CircleLabel(
                            radios: 20,
                            difRadios: 5,
                            fontSize: 8,
                            tittle: 'FOL',
                            // child: Text('FOL', style: Styles.textSyleGrowth(fontSize: 10)),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: EditTextArea(
                            iconData: Icons.line_style,
                            keyBoardType: TextInputType.datetime,
                            inputFormat: MaskTextInputFormatter(
                                mask: '####/##/##',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy),
                            labelEditText: 'Fecha del Evento',
                            textController: fechaEventoFOLTextController,
                            numOfLines: 1,
                            selection: true,
                            withShowOption: true,
                            onSelected: () {
                              fechaEventoFOLTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 5: SNG **************************************************************
                  TittleContainer(
                    tittle: "                                      SNG ",
                    color: Theming.quincuaryColor,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: CircleSwitched(
                              tittle: "¿Diagnóstico actual?",
                              radios: 30,
                              difRadios: 5,
                              onChangeValue: (bool value) {
                                Terminal.printExpected(
                                    message:
                                        "Value $value : not value : ${!value}");
                                setState(() {
                                  isActualSNGValue =
                                      Dicotomicos.fromBoolean(!value) as String;
                                  if (isActualSNGValue == 'Si') {
                                    fechaEventoSNGTextController.text =
                                        Calendarios.today(format: 'yyyy/MM/dd');
                                  } else {
                                    fechaEventoSNGTextController.text = '';
                                  }
                                });
                              },
                              isSwitched:
                                  Dicotomicos.fromString(isActualSNGValue)),
                        ),
                        Expanded(
                          child: CircleLabel(
                            radios: 20,
                            difRadios: 5,
                            fontSize: 8,
                            tittle: 'SNG',
                            // child: Text('SNG', style: Styles.textSyleGrowth(fontSize: 10)),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: EditTextArea(
                            iconData: Icons.line_style,
                            keyBoardType: TextInputType.datetime,
                            inputFormat: MaskTextInputFormatter(
                                mask: '####/##/##',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy),
                            labelEditText: 'Fecha del Evento',
                            textController: fechaEventoSNGTextController,
                            numOfLines: 1,
                            selection: true,
                            withShowOption: true,
                            onSelected: () {
                              fechaEventoSNGTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // : : ******************************
                  CircleSwitched(
                      tittle: "Agregar . . . ",
                      radios: 30,
                      difRadios: 5,
                      onChangeValue: (bool value) =>_operationMethod(),
                      isSwitched: true),
                ],
              )),
          // ####
          Expanded(
              flex: isDesktop(context) ? 4: 6,
              child: Center(
                child: TerapiasItems(),
              )),
          // ####
          Expanded(
            flex: 2,
            child: ListView(
              // controller: _pageController,
              controller: ScrollController(),
              children: [
                // 6: SOG **************************************************************
                TittleContainer(
                  tittle: "                                      SOG ",
                  color: Theming.quincuaryColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: CircleSwitched(
                            radios: 30,
                            difRadios: 5,
                            tittle: "¿Diagnóstico actual?",
                            onChangeValue: (bool value) {
                              Terminal.printExpected(
                                  message:
                                      "Value $value : not value : ${!value}");
                              setState(() {
                                isActualSOGValue =
                                    Dicotomicos.fromBoolean(!value) as String;
                                if (isActualSOGValue == 'Si') {
                                  fechaEventoSOGTextController.text =
                                      Calendarios.today(format: 'yyyy/MM/dd');
                                } else {
                                  fechaEventoSOGTextController.text = '';
                                }
                              });
                            },
                            isSwitched:
                                Dicotomicos.fromString(isActualSOGValue)),
                      ),
                      Expanded(
                        child: CircleLabel(
                          radios: 20,
                          difRadios: 5,
                          fontSize: 8,
                          tittle: 'SOG',
                          // child: Text('SOG', style: Styles.textSyleGrowth(fontSize: 10)),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: EditTextArea(
                          iconData: Icons.line_style,
                          keyBoardType: TextInputType.datetime,
                          inputFormat: MaskTextInputFormatter(
                              mask: '####/##/##',
                              filter: {"#": RegExp(r'[0-9]')},
                              type: MaskAutoCompletionType.lazy),
                          labelEditText: 'Fecha del Evento',
                          textController: fechaEventoSOGTextController,
                          numOfLines: 1,
                          selection: true,
                          withShowOption: true,
                          onSelected: () {
                            fechaEventoSOGTextController.text =
                                Calendarios.today(format: 'yyyy/MM/dd');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // 7: PEN **************************************************************
                TittleContainer(
                  tittle: "                                      PEN ",
                  color: Theming.quincuaryColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: CircleSwitched(
                            radios: 30,
                            difRadios: 5,
                            tittle: "¿Diagnóstico actual?",
                            onChangeValue: (bool value) {
                              Terminal.printExpected(
                                  message:
                                      "Value $value : not value : ${!value}");
                              setState(() {
                                isActualPENValue =
                                    Dicotomicos.fromBoolean(!value) as String;
                                if (isActualPENValue == 'Si') {
                                  fechaEventoPENTextController.text =
                                      Calendarios.today(format: 'yyyy/MM/dd');
                                } else {
                                  fechaEventoPENTextController.text = '';
                                }
                              });
                            },
                            isSwitched:
                                Dicotomicos.fromString(isActualPENValue)),
                      ),
                      Expanded(
                        child: CircleLabel(
                          radios: 20,
                          difRadios: 5,
                          fontSize: 8,
                          tittle: 'PEN',
                          // child: Text('PEN', style: Styles.textSyleGrowth(fontSize: 10)),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: EditTextArea(
                          iconData: Icons.line_style,
                          keyBoardType: TextInputType.datetime,
                          inputFormat: MaskTextInputFormatter(
                              mask: '####/##/##',
                              filter: {"#": RegExp(r'[0-9]')},
                              type: MaskAutoCompletionType.lazy),
                          labelEditText: 'Fecha del Evento',
                          textController: fechaEventoPENTextController,
                          numOfLines: 1,
                          selection: true,
                          withShowOption: true,
                          onSelected: () {
                            fechaEventoPENTextController.text =
                                Calendarios.today(format: 'yyyy/MM/dd');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // 8 : COL **************************************************************
                TittleContainer(
                  tittle: "                                      COL ",
                  color: Theming.quincuaryColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: CircleSwitched(
                            radios: 30,
                            difRadios: 5,
                            tittle: "¿Diagnóstico actual?",
                            onChangeValue: (bool value) {
                              Terminal.printExpected(
                                  message:
                                      "Value $value : not value : ${!value}");
                              setState(() {
                                isActualCOLValue =
                                    Dicotomicos.fromBoolean(!value) as String;
                                if (isActualCOLValue == 'Si') {
                                  fechaEventoCOLTextController.text =
                                      Calendarios.today(format: 'yyyy/MM/dd');
                                } else {
                                  fechaEventoCOLTextController.text = '';
                                }
                              });
                            },
                            isSwitched:
                                Dicotomicos.fromString(isActualCOLValue)),
                      ),
                      Expanded(
                        child: CircleLabel(
                          radios: 20,
                          difRadios: 5,
                          fontSize: 8,
                          tittle: 'COL',
                          // child: Text('COL', style: Styles.textSyleGrowth(fontSize: 10)),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: EditTextArea(
                          iconData: Icons.line_style,
                          keyBoardType: TextInputType.datetime,
                          inputFormat: MaskTextInputFormatter(
                              mask: '####/##/##',
                              filter: {"#": RegExp(r'[0-9]')},
                              type: MaskAutoCompletionType.lazy),
                          labelEditText: 'Fecha del Evento',
                          textController: fechaEventoCOLTextController,
                          numOfLines: 1,
                          selection: true,
                          withShowOption: true,
                          onSelected: () {
                            fechaEventoCOLTextController.text =
                                Calendarios.today(format: 'yyyy/MM/dd');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // 9 : SEP ***************************************************************
                TittleContainer(
                  tittle: "                                      SEP ",
                  color: Theming.quincuaryColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: CircleSwitched(
                            radios: 30,
                            difRadios: 5,
                            tittle: "¿Diagnóstico actual?",
                            onChangeValue: (bool value) {
                              Terminal.printExpected(
                                  message:
                                      "Value $value : not value : ${!value}");
                              setState(() {
                                isActualSEPValue =
                                    Dicotomicos.fromBoolean(!value) as String;
                                if (isActualSEPValue == 'Si') {
                                  fechaEventoSEPTextController.text =
                                      Calendarios.today(format: 'yyyy/MM/dd');
                                } else {
                                  fechaEventoSEPTextController.text = '';
                                }
                              });
                            },
                            isSwitched:
                                Dicotomicos.fromString(isActualSEPValue)),
                      ),
                      Expanded(
                        child: CircleLabel(
                          radios: 20,
                          difRadios: 5,
                          fontSize: 8,
                          tittle: 'SEP',
                          // child: Text('SEP', style: Styles.textSyleGrowth(fontSize: 10)),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: EditTextArea(
                          iconData: Icons.line_style,
                          keyBoardType: TextInputType.datetime,
                          inputFormat: MaskTextInputFormatter(
                              mask: '####/##/##',
                              filter: {"#": RegExp(r'[0-9]')},
                              type: MaskAutoCompletionType.lazy),
                          labelEditText: 'Fecha del Evento',
                          textController: fechaEventoSEPTextController,
                          numOfLines: 1,
                          selection: true,
                          withShowOption: true,
                          onSelected: () {
                            fechaEventoSEPTextController.text =
                                Calendarios.today(format: 'yyyy/MM/dd');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // 10 : GAS **************************************************************
                TittleContainer(
                  tittle: "                                      GAS ",
                  color: Theming.quincuaryColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: CircleSwitched(
                            radios: 30,
                            difRadios: 5,
                            tittle: "¿Diagnóstico actual?",
                            onChangeValue: (bool value) {
                              Terminal.printExpected(
                                  message:
                                      "Value $value : not value : ${!value}");
                              setState(() {
                                isActualGASValue =
                                    Dicotomicos.fromBoolean(!value) as String;
                                if (isActualGASValue == 'Si') {
                                  fechaEventoGASTextController.text =
                                      Calendarios.today(format: 'yyyy/MM/dd');
                                } else {
                                  fechaEventoGASTextController.text = '';
                                }
                              });
                            },
                            isSwitched:
                                Dicotomicos.fromString(isActualGASValue)),
                      ),
                      Expanded(
                        child: CircleLabel(
                          radios: 20,
                          difRadios: 5,
                          fontSize: 8,
                          tittle: 'GAS',
                          // child: Text('GAS', style: Styles.textSyleGrowth(fontSize: 10)),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: EditTextArea(
                          iconData: Icons.line_style,
                          keyBoardType: TextInputType.datetime,
                          inputFormat: MaskTextInputFormatter(
                              mask: '####/##/##',
                              filter: {"#": RegExp(r'[0-9]')},
                              type: MaskAutoCompletionType.lazy),
                          labelEditText: 'Fecha del Evento',
                          textController: fechaEventoGASTextController,
                          numOfLines: 1,
                          selection: true,
                          withShowOption: true,
                          onSelected: () {
                            fechaEventoGASTextController.text =
                                Calendarios.today(format: 'yyyy/MM/dd');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // 11: TNK **************************************************************
                TittleContainer(
                  tittle: "                                      TNK ",
                  color: Theming.quincuaryColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: CircleSwitched(
                            radios: 30,
                            difRadios: 5,
                            tittle: "¿Diagnóstico actual?",
                            onChangeValue: (bool value) {
                              Terminal.printExpected(
                                  message:
                                      "Value $value : not value : ${!value}");
                              setState(() {
                                isActualTNKValue =
                                    Dicotomicos.fromBoolean(!value) as String;
                                if (isActualTNKValue == 'Si') {
                                  fechaEventoTNKTextController.text =
                                      Calendarios.today(format: 'yyyy/MM/dd');
                                } else {
                                  fechaEventoTNKTextController.text = '';
                                }
                              });
                            },
                            isSwitched:
                                Dicotomicos.fromString(isActualTNKValue)),
                      ),
                      Expanded(
                        child: CircleLabel(
                          radios: 20,
                          difRadios: 5,
                          fontSize: 8,
                          tittle: 'TNK',
                          // child: Text('TNK', style: Styles.textSyleGrowth(fontSize: 10)),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: EditTextArea(
                          iconData: Icons.line_style,
                          keyBoardType: TextInputType.datetime,
                          inputFormat: MaskTextInputFormatter(
                              mask: '####/##/##',
                              filter: {"#": RegExp(r'[0-9]')},
                              type: MaskAutoCompletionType.lazy),
                          labelEditText: 'Fecha del Evento',
                          textController: fechaEventoTNKTextController,
                          numOfLines: 1,
                          selection: true,
                          withShowOption: true,
                          onSelected: () {
                            fechaEventoTNKTextController.text =
                                Calendarios.today(format: 'yyyy/MM/dd');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // : : ******************************
                CircleSwitched(
                    tittle: "Agregar . . . ",
                    radios: 30,
                    difRadios: 5,
                    onChangeValue: (bool value) =>_operationMethod(),
                    isSwitched: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _drawerForm(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Wrap(
        direction: Axis.vertical,
        runSpacing: 10,
        spacing: 10,
        alignment: WrapAlignment.center,
        children: List<Widget>.generate(
            Situaciones.dispositivosBasicos!.length,
            (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: () {
                      _pageController.animateToPage(index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                      _key.currentState!.closeEndDrawer();
                    },
                    child: CircleAvatar(
                      radius: 14,
                      // check if a dot is connected to the current page
                      // if true, give it a different color
                      backgroundColor:
                          _activePage == index ? Colors.amber : Colors.grey,
                      child: Text(
                          Situaciones.dispositivosBasicos![index].toString(),
                          style: Styles.textSyleGrowth(fontSize: 8)),
                    ),
                  ),
                )),
      ),
    );
  }

  _bottomNavigationBar(BuildContext context) => const BottomAppBar(
        color: Colors.black,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 25),
          ],
        ),
      );

  _floattingActionButton(BuildContext context) => FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => _operationMethod(),
        shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(100)),
        child: const Icon(
          Icons.hdr_strong,
          color: Colors.grey,
        ),
      );

  // METHODS ***************************************
  List<List<dynamic>> listOfValues() {
    return [
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualCVPValue),
        tipoIncidenciaCVPTextController.text,
        eventualidadCVPTextController.text,
        fechaEventoCVPTextController.text,
        "",
        "",
      ], // 0 : CVP
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualCVLPValue),
        tipoIncidenciaCVLPTextController.text,
        eventualidadCVLPTextController.text,
        fechaEventoCVLPTextController.text,
        "",
        "",
      ], // 1 : CVLP
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualCVCValue),
        tipoIncidenciaCVCTextController.text,
        eventualidadCVCTextController.text,
        fechaEventoCVCTextController.text,
        "",
        "",
      ], // 2 : CVC
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualMAHAValue),
        tipoIncidenciaMAHATextController.text,
        eventualidadMAHATextController.text,
        fechaEventoMAHATextController.text,
        "",
        "",
      ], // 3 : MAHA
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualFOLValue),
        tipoIncidenciaFOLTextController.text,
        eventualidadFOLTextController.text,
        fechaEventoFOLTextController.text,
        "",
        "",
      ], // 4 : FOL
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualSNGValue),
        tipoIncidenciaSNGTextController.text,
        eventualidadSNGTextController.text,
        fechaEventoSNGTextController.text,
        "",
        "",
      ], // 5 : SNG
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualSOGValue),
        tipoIncidenciaSOGTextController.text,
        eventualidadSOGTextController.text,
        fechaEventoSOGTextController.text,
        "",
        "",
      ], // 6 : SOG
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualPENValue),
        tipoIncidenciaPENTextController.text,
        eventualidadPENTextController.text,
        fechaEventoPENTextController.text,
        "",
        "",
      ], // 7 : PEN
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualCOLValue),
        tipoIncidenciaCOLTextController.text,
        eventualidadCOLTextController.text,
        fechaEventoCOLTextController.text,
        "",
        "",
      ], // 8 : COL
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualSEPValue),
        tipoIncidenciaSEPTextController.text,
        eventualidadSEPTextController.text,
        fechaEventoSEPTextController.text,
        "",
        "",
      ], // 9 : SEP
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualGASValue),
        tipoIncidenciaGASTextController.text,
        eventualidadGASTextController.text,
        fechaEventoGASTextController.text,
        "",
        "",
      ], // 10 : GAS
      [
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        Dicotomicos.fromString(isActualTNKValue),
        tipoIncidenciaTNKTextController.text,
        eventualidadTNKTextController.text,
        fechaEventoTNKTextController.text,
        "",
        "",
      ], // 11 : TNK
    ];
  }

  // VARIABLES DE LA INTERFAZ ******** ******* * * *  *
  String appBarTitile = "Revisión General del Paciente . . . ";
  String? consultIdQuery = Situaciones.situacion['consultIdQuery'];
  String consultAllIdQuery = Situaciones.situacion['consultIdQuery'];
  String? registerQuery = Situaciones.situacion['registerQuery'];
  String? updateQuery = Situaciones.situacion['updateQuery'];
  // ****************************************************
  String databaseQuery = Databases.siteground_database_reghosp;
// ****************************************************
  int idOperation = 0;

  // Variables de Operación *********************************

  // 0: CVP **************************************************************
  var isActualCVPValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaCVPTextController = TextEditingController(),
      eventualidadCVPTextController = TextEditingController(),
      fechaEventoCVPTextController = TextEditingController();
  // var observacionesEventoCVPTextController = TextEditingController(),
  //     otrosEventoCVPTextController = TextEditingController();
  // 1: CVLP **************************************************************
  var isActualCVLPValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaCVLPTextController = TextEditingController(),
      eventualidadCVLPTextController = TextEditingController(),
      fechaEventoCVLPTextController = TextEditingController();
  // var observacionesEventoCVLPTextController = TextEditingController(),
  //     otrosEventoCVLPTextController = TextEditingController();
  // 2: CVC **************************************************************
  var isActualCVCValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaCVCTextController = TextEditingController(),
      eventualidadCVCTextController = TextEditingController(),
      fechaEventoCVCTextController = TextEditingController();
  // var observacionesEventoCVCTextController = TextEditingController(),
  //     otrosEventoCVCTextController = TextEditingController();
  // 3: MAHA **************************************************************
  var isActualMAHAValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaMAHATextController = TextEditingController(),
      eventualidadMAHATextController = TextEditingController(),
      fechaEventoMAHATextController = TextEditingController();
  // var observacionesEventoMAHATextController = TextEditingController(),
  //     otrosEventoMAHATextController = TextEditingController();
  // 4: FOL **************************************************************
  var isActualFOLValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaFOLTextController = TextEditingController(),
      eventualidadFOLTextController = TextEditingController(),
      fechaEventoFOLTextController = TextEditingController();
  // var observacionesEventoFOLTextController = TextEditingController(),
  //     otrosEventoFOLTextController = TextEditingController();
  // 5: SNG **************************************************************
  var isActualSNGValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaSNGTextController = TextEditingController(),
      eventualidadSNGTextController = TextEditingController(),
      fechaEventoSNGTextController = TextEditingController();
  // var observacionesEventoSNGTextController = TextEditingController(),
  //     otrosEventoSNGTextController = TextEditingController();
  // 6: SOG **************************************************************
  var isActualSOGValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaSOGTextController = TextEditingController(),
      eventualidadSOGTextController = TextEditingController(),
      fechaEventoSOGTextController = TextEditingController();
  // var observacionesEventoSOGTextController = TextEditingController(),
  //     otrosEventoSOGTextController = TextEditingController();
  // 7: PEN **************************************************************
  var isActualPENValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaPENTextController = TextEditingController(),
      eventualidadPENTextController = TextEditingController(),
      fechaEventoPENTextController = TextEditingController();
  // var observacionesEventoPENTextController = TextEditingController(),
  //     otrosEventoPENTextController = TextEditingController();
  // 8 : COL **************************************************************
  var isActualCOLValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaCOLTextController = TextEditingController(),
      eventualidadCOLTextController = TextEditingController(),
      fechaEventoCOLTextController = TextEditingController();
  // var observacionesEventoCOLTextController = TextEditingController(),
  //     otrosEventoCOLTextController = TextEditingController();
  // 9 : SEP ***************************************************************
  var isActualSEPValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaSEPTextController = TextEditingController(),
      eventualidadSEPTextController = TextEditingController(),
      fechaEventoSEPTextController = TextEditingController();
  // var observacionesEventoSEPTextController = TextEditingController(),
  //     otrosEventoSEPTextController = TextEditingController();
  // 10 : GAS **************************************************************
  var isActualGASValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaGASTextController = TextEditingController(),
      eventualidadGASTextController = TextEditingController(),
      fechaEventoGASTextController = TextEditingController();
  // var observacionesEventoGASTextController = TextEditingController(),
  //     otrosEventoGASTextController = TextEditingController();
  // 11: TNK **************************************************************
  var isActualTNKValue = Patologicos.actualDiagno[1];
  var tipoIncidenciaTNKTextController = TextEditingController(),
      eventualidadTNKTextController = TextEditingController(),
      fechaEventoTNKTextController = TextEditingController();
  // var observacionesEventoTNKTextController = TextEditingController(),
  //     otrosEventoTNKTextController = TextEditingController();

  // Auxiliares *******************************************
  int index = 0;
  String? tipoEstudioValue;

  // OPERACIONES DE LA INTERFAZ ****************** ********
  _operationMethod() async {
    Operadores.loadingActivity(
        context: context,
        tittle: "Registrando información . . .",
        message: "Información registrada",
        onCloss: () {
          // Navigator.of(context).pop();
          // cerrar();
        });
    //
    Future.forEach(listOfValues(), (element) async {
      var aux = element as List<dynamic>;

      if (aux.isNotEmpty) {
        if (aux[2] == true) {
          await Actividades.registrar(
            Databases.siteground_database_reghosp,
            Situaciones.situacion['registerQuery'],
            element,
          );
        }
      }
    }).whenComplete(() {
      Situaciones.consultarRegistro();
        //
        Navigator.of(context).pop(); // Cierre del LoadActivity
        Operadores.alertActivity(
            context: context,
            tittle: "Registrando información . . .",
            message: "Información registrada",
            onAcept: () {
              // Se emplean 3 Navigator.of(context).pop(); para cerrar cada una de
              //    las ventanas emergentes y la interfaz inicial.
              //
              Navigator.of(context).pop(); // Cierre del AlertActivity
            });
        
    }).onError((error, stackTrace) {
      Pacientes.getParaclinicosHistorial(reload: true).whenComplete(() {
        Terminal.printAlert(message: "ERROR - $error : : : $stackTrace");
        Operadores.alertActivity(
          context: context,
          tittle: "$error . . .",
          message: "$stackTrace",
        );
      });
      //
    });
  }

  List _items() {
    return [
      // 0: CVP **************************************************************
      TittleContainer(
        tittle: "                                      CVP ",
        color: Theming.quincuaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleSwitched(
                        tittle: "¿Diagnóstico actual?",
                        onChangeValue: (bool value) {
                          Terminal.printExpected(
                              message: "Value $value : not value : ${!value}");
                          setState(() {
                            isActualCVPValue =
                                Dicotomicos.fromBoolean(!value) as String;
                            if (isActualCVPValue == 'Si') {
                              fechaEventoCVPTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            } else {
                              fechaEventoCVPTextController.text = '';
                            }
                          });
                        },
                        isSwitched: Dicotomicos.fromString(isActualCVPValue)),
                  ),
                  Expanded(
                    child: CircleLabel(
                      radios: 20,
                      difRadios: 5,
                      fontSize: 8,
                      tittle: 'CVP',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  EditTextArea(
                    iconData: Icons.line_style,
                    keyBoardType: TextInputType.datetime,
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    labelEditText: 'Fecha del Evento',
                    textController: fechaEventoCVPTextController,
                    numOfLines: 1,
                    selection: true,
                    withShowOption: true,
                    onSelected: () {
                      fechaEventoCVPTextController.text =
                          Calendarios.today(format: 'yyyy/MM/dd');
                    },
                  ),
                  CrossLine(thickness: 4, height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      // 1: CVLP **************************************************************
      TittleContainer(
        tittle: "                                      CVLP ",
        color: Theming.quincuaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleSwitched(
                        tittle: "¿Diagnóstico actual?",
                        onChangeValue: (bool value) {
                          Terminal.printExpected(
                              message: "Value $value : not value : ${!value}");
                          setState(() {
                            isActualCVLPValue =
                                Dicotomicos.fromBoolean(!value) as String;
                            if (isActualCVLPValue == 'Si') {
                              fechaEventoCVLPTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            } else {
                              fechaEventoCVLPTextController.text = '';
                            }
                          });
                        },
                        isSwitched: Dicotomicos.fromString(isActualCVLPValue)),
                  ),
                  Expanded(
                    child: CircleLabel(
                      radios: 20,
                      difRadios: 5,
                      fontSize: 8,
                      tittle: 'CVLP',
                      // child: Text('CVLP', style: Styles.textSyleGrowth(fontSize: 10)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  EditTextArea(
                    iconData: Icons.line_style,
                    keyBoardType: TextInputType.datetime,
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    labelEditText: 'Fecha del Evento',
                    textController: fechaEventoCVLPTextController,
                    numOfLines: 1,
                    selection: true,
                    withShowOption: true,
                    onSelected: () {
                      fechaEventoCVLPTextController.text =
                          Calendarios.today(format: 'yyyy/MM/dd');
                    },
                  ),
                  CrossLine(thickness: 4, height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      // 2: CVC **************************************************************
      TittleContainer(
        tittle: "                                      CVC ",
        color: Theming.quincuaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleSwitched(
                        tittle: "¿Diagnóstico actual?",
                        onChangeValue: (bool value) {
                          Terminal.printExpected(
                              message: "Value $value : not value : ${!value}");
                          setState(() {
                            isActualCVCValue =
                                Dicotomicos.fromBoolean(!value) as String;
                            if (isActualCVCValue == 'Si') {
                              fechaEventoCVCTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            } else {
                              fechaEventoCVCTextController.text = '';
                            }
                          });
                        },
                        isSwitched: Dicotomicos.fromString(isActualCVCValue)),
                  ),
                  Expanded(
                    child: CircleLabel(
                      radios: 20,
                      difRadios: 5,
                      fontSize: 8,
                      tittle: 'CVC',
                      // child: Text('CVC', style: Styles.textSyleGrowth(fontSize: 10)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  EditTextArea(
                    iconData: Icons.line_style,
                    keyBoardType: TextInputType.datetime,
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    labelEditText: 'Fecha del Evento',
                    textController: fechaEventoCVCTextController,
                    numOfLines: 1,
                    selection: true,
                    withShowOption: true,
                    onSelected: () {
                      fechaEventoCVCTextController.text =
                          Calendarios.today(format: 'yyyy/MM/dd');
                    },
                  ),
                  CrossLine(thickness: 4, height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      // 3: MAHA **************************************************************
      TittleContainer(
        tittle: "                                      MAHA ",
        color: Theming.quincuaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleSwitched(
                        tittle: "¿Diagnóstico actual?",
                        onChangeValue: (bool value) {
                          Terminal.printExpected(
                              message: "Value $value : not value : ${!value}");
                          setState(() {
                            isActualMAHAValue =
                                Dicotomicos.fromBoolean(!value) as String;
                            if (isActualMAHAValue == 'Si') {
                              fechaEventoMAHATextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            } else {
                              fechaEventoMAHATextController.text = '';
                            }
                          });
                        },
                        isSwitched: Dicotomicos.fromString(isActualMAHAValue)),
                  ),
                  Expanded(
                    child: CircleLabel(
                      radios: 20,
                      difRadios: 5,
                      fontSize: 8,
                      tittle: 'MAHA',
                      // child: Text('MAHA', style: Styles.textSyleGrowth(fontSize: 10)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  EditTextArea(
                    iconData: Icons.line_style,
                    keyBoardType: TextInputType.datetime,
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    labelEditText: 'Fecha del Evento',
                    textController: fechaEventoMAHATextController,
                    numOfLines: 1,
                    selection: true,
                    withShowOption: true,
                    onSelected: () {
                      fechaEventoMAHATextController.text =
                          Calendarios.today(format: 'yyyy/MM/dd');
                    },
                  ),
                  CrossLine(thickness: 4, height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      // 4: FOL **************************************************************
      TittleContainer(
        tittle: "                                      FOL ",
        color: Theming.quincuaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleSwitched(
                        tittle: "¿Diagnóstico actual?",
                        onChangeValue: (bool value) {
                          Terminal.printExpected(
                              message: "Value $value : not value : ${!value}");
                          setState(() {
                            isActualFOLValue =
                                Dicotomicos.fromBoolean(!value) as String;
                            if (isActualFOLValue == 'Si') {
                              fechaEventoFOLTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            } else {
                              fechaEventoFOLTextController.text = '';
                            }
                          });
                        },
                        isSwitched: Dicotomicos.fromString(isActualFOLValue)),
                  ),
                  Expanded(
                    child: CircleLabel(
                      radios: 20,
                      difRadios: 5,
                      fontSize: 8,
                      tittle: 'FOL',
                      // child: Text('FOL', style: Styles.textSyleGrowth(fontSize: 10)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  EditTextArea(
                    iconData: Icons.line_style,
                    keyBoardType: TextInputType.datetime,
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    labelEditText: 'Fecha del Evento',
                    textController: fechaEventoFOLTextController,
                    numOfLines: 1,
                    selection: true,
                    withShowOption: true,
                    onSelected: () {
                      fechaEventoFOLTextController.text =
                          Calendarios.today(format: 'yyyy/MM/dd');
                    },
                  ),
                  CrossLine(thickness: 4, height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      // 5: SNG **************************************************************
      TittleContainer(
        tittle: "                                      SNG ",
        color: Theming.quincuaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleSwitched(
                        tittle: "¿Diagnóstico actual?",
                        onChangeValue: (bool value) {
                          Terminal.printExpected(
                              message: "Value $value : not value : ${!value}");
                          setState(() {
                            isActualSNGValue =
                                Dicotomicos.fromBoolean(!value) as String;
                            if (isActualSNGValue == 'Si') {
                              fechaEventoSNGTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            } else {
                              fechaEventoSNGTextController.text = '';
                            }
                          });
                        },
                        isSwitched: Dicotomicos.fromString(isActualSNGValue)),
                  ),
                  Expanded(
                    child: CircleLabel(
                      radios: 20,
                      difRadios: 5,
                      fontSize: 8,
                      tittle: 'SNG',
                      // child: Text('SNG', style: Styles.textSyleGrowth(fontSize: 10)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  EditTextArea(
                    iconData: Icons.line_style,
                    keyBoardType: TextInputType.datetime,
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    labelEditText: 'Fecha del Evento',
                    textController: fechaEventoSNGTextController,
                    numOfLines: 1,
                    selection: true,
                    withShowOption: true,
                    onSelected: () {
                      fechaEventoSNGTextController.text =
                          Calendarios.today(format: 'yyyy/MM/dd');
                    },
                  ),
                  CrossLine(thickness: 4, height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      // 6: SOG **************************************************************
      TittleContainer(
        tittle: "                                      SOG ",
        color: Theming.quincuaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleSwitched(
                        tittle: "¿Diagnóstico actual?",
                        onChangeValue: (bool value) {
                          Terminal.printExpected(
                              message: "Value $value : not value : ${!value}");
                          setState(() {
                            isActualSOGValue =
                                Dicotomicos.fromBoolean(!value) as String;
                            if (isActualSOGValue == 'Si') {
                              fechaEventoSOGTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            } else {
                              fechaEventoSOGTextController.text = '';
                            }
                          });
                        },
                        isSwitched: Dicotomicos.fromString(isActualSOGValue)),
                  ),
                  Expanded(
                    child: CircleLabel(
                      radios: 20,
                      difRadios: 5,
                      fontSize: 8,
                      tittle: 'SOG',
                      // child: Text('SOG', style: Styles.textSyleGrowth(fontSize: 10)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  EditTextArea(
                    iconData: Icons.line_style,
                    keyBoardType: TextInputType.datetime,
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    labelEditText: 'Fecha del Evento',
                    textController: fechaEventoSOGTextController,
                    numOfLines: 1,
                    selection: true,
                    withShowOption: true,
                    onSelected: () {
                      fechaEventoSOGTextController.text =
                          Calendarios.today(format: 'yyyy/MM/dd');
                    },
                  ),
                  CrossLine(thickness: 4, height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      // 7: PEN **************************************************************
      TittleContainer(
        tittle: "                                      PEN ",
        color: Theming.quincuaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleSwitched(
                        tittle: "¿Diagnóstico actual?",
                        onChangeValue: (bool value) {
                          Terminal.printExpected(
                              message: "Value $value : not value : ${!value}");
                          setState(() {
                            isActualPENValue =
                                Dicotomicos.fromBoolean(!value) as String;
                            if (isActualPENValue == 'Si') {
                              fechaEventoPENTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            } else {
                              fechaEventoPENTextController.text = '';
                            }
                          });
                        },
                        isSwitched: Dicotomicos.fromString(isActualPENValue)),
                  ),
                  Expanded(
                    child: CircleLabel(
                      radios: 20,
                      difRadios: 5,
                      fontSize: 8,
                      tittle: 'PEN',
                      // child: Text('PEN', style: Styles.textSyleGrowth(fontSize: 10)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  EditTextArea(
                    iconData: Icons.line_style,
                    keyBoardType: TextInputType.datetime,
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    labelEditText: 'Fecha del Evento',
                    textController: fechaEventoPENTextController,
                    numOfLines: 1,
                    selection: true,
                    withShowOption: true,
                    onSelected: () {
                      fechaEventoPENTextController.text =
                          Calendarios.today(format: 'yyyy/MM/dd');
                    },
                  ),
                  CrossLine(thickness: 4, height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      // 8 : COL **************************************************************
      TittleContainer(
        tittle: "                                      COL ",
        color: Theming.quincuaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleSwitched(
                        tittle: "¿Diagnóstico actual?",
                        onChangeValue: (bool value) {
                          Terminal.printExpected(
                              message: "Value $value : not value : ${!value}");
                          setState(() {
                            isActualCOLValue =
                                Dicotomicos.fromBoolean(!value) as String;
                            if (isActualCOLValue == 'Si') {
                              fechaEventoCOLTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            } else {
                              fechaEventoCOLTextController.text = '';
                            }
                          });
                        },
                        isSwitched: Dicotomicos.fromString(isActualCOLValue)),
                  ),
                  Expanded(
                    child: CircleLabel(
                      radios: 20,
                      difRadios: 5,
                      fontSize: 8,
                      tittle: 'COL',
                      // child: Text('COL', style: Styles.textSyleGrowth(fontSize: 10)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  EditTextArea(
                    iconData: Icons.line_style,
                    keyBoardType: TextInputType.datetime,
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    labelEditText: 'Fecha del Evento',
                    textController: fechaEventoCOLTextController,
                    numOfLines: 1,
                    selection: true,
                    withShowOption: true,
                    onSelected: () {
                      fechaEventoCOLTextController.text =
                          Calendarios.today(format: 'yyyy/MM/dd');
                    },
                  ),
                  CrossLine(thickness: 4, height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      // 9 : SEP ***************************************************************
      TittleContainer(
        tittle: "                                      SEP ",
        color: Theming.quincuaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleSwitched(
                        tittle: "¿Diagnóstico actual?",
                        onChangeValue: (bool value) {
                          Terminal.printExpected(
                              message: "Value $value : not value : ${!value}");
                          setState(() {
                            isActualSEPValue =
                                Dicotomicos.fromBoolean(!value) as String;
                            if (isActualSEPValue == 'Si') {
                              fechaEventoSEPTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            } else {
                              fechaEventoSEPTextController.text = '';
                            }
                          });
                        },
                        isSwitched: Dicotomicos.fromString(isActualSEPValue)),
                  ),
                  Expanded(
                    child: CircleLabel(
                      radios: 20,
                      difRadios: 5,
                      fontSize: 8,
                      tittle: 'SEP',
                      // child: Text('SEP', style: Styles.textSyleGrowth(fontSize: 10)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  EditTextArea(
                    iconData: Icons.line_style,
                    keyBoardType: TextInputType.datetime,
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    labelEditText: 'Fecha del Evento',
                    textController: fechaEventoSEPTextController,
                    numOfLines: 1,
                    selection: true,
                    withShowOption: true,
                    onSelected: () {
                      fechaEventoSEPTextController.text =
                          Calendarios.today(format: 'yyyy/MM/dd');
                    },
                  ),
                  CrossLine(thickness: 4, height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      // 10 : GAS **************************************************************
      TittleContainer(
        tittle: "                                      GAS ",
        color: Theming.quincuaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleSwitched(
                        tittle: "¿Diagnóstico actual?",
                        onChangeValue: (bool value) {
                          Terminal.printExpected(
                              message: "Value $value : not value : ${!value}");
                          setState(() {
                            isActualGASValue =
                                Dicotomicos.fromBoolean(!value) as String;
                            if (isActualGASValue == 'Si') {
                              fechaEventoGASTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            } else {
                              fechaEventoGASTextController.text = '';
                            }
                          });
                        },
                        isSwitched: Dicotomicos.fromString(isActualGASValue)),
                  ),
                  Expanded(
                    child: CircleLabel(
                      radios: 20,
                      difRadios: 5,
                      fontSize: 8,
                      tittle: 'GAS',
                      // child: Text('GAS', style: Styles.textSyleGrowth(fontSize: 10)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  EditTextArea(
                    iconData: Icons.line_style,
                    keyBoardType: TextInputType.datetime,
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    labelEditText: 'Fecha del Evento',
                    textController: fechaEventoGASTextController,
                    numOfLines: 1,
                    selection: true,
                    withShowOption: true,
                    onSelected: () {
                      fechaEventoGASTextController.text =
                          Calendarios.today(format: 'yyyy/MM/dd');
                    },
                  ),
                  CrossLine(thickness: 4, height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      // 11: TNK **************************************************************
      TittleContainer(
        tittle: "                                      TNK ",
        color: Theming.quincuaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleSwitched(
                        tittle: "¿Diagnóstico actual?",
                        onChangeValue: (bool value) {
                          Terminal.printExpected(
                              message: "Value $value : not value : ${!value}");
                          setState(() {
                            isActualTNKValue =
                                Dicotomicos.fromBoolean(!value) as String;
                            if (isActualTNKValue == 'Si') {
                              fechaEventoTNKTextController.text =
                                  Calendarios.today(format: 'yyyy/MM/dd');
                            } else {
                              fechaEventoTNKTextController.text = '';
                            }
                          });
                        },
                        isSwitched: Dicotomicos.fromString(isActualTNKValue)),
                  ),
                  Expanded(
                    child: CircleLabel(
                      radios: 20,
                      difRadios: 5,
                      fontSize: 8,
                      tittle: 'TNK',
                      // child: Text('TNK', style: Styles.textSyleGrowth(fontSize: 10)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  EditTextArea(
                    iconData: Icons.line_style,
                    keyBoardType: TextInputType.datetime,
                    inputFormat: MaskTextInputFormatter(
                        mask: '####/##/##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    labelEditText: 'Fecha del Evento',
                    textController: fechaEventoTNKTextController,
                    numOfLines: 1,
                    selection: true,
                    withShowOption: true,
                    onSelected: () {
                      fechaEventoTNKTextController.text =
                          Calendarios.today(format: 'yyyy/MM/dd');
                    },
                  ),
                  CrossLine(thickness: 4, height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
