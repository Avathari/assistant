import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CircleLabel.dart';
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

import '../../../conexiones/conexiones.dart';

class OperacionesQuirurgicos extends StatefulWidget {
  String? operationActivity;

  String _operationButton = 'Nulo';

  OperacionesQuirurgicos({Key? key, this.operationActivity = Constantes.Nulo})
      : super(key: key);

  @override
  State<OperacionesQuirurgicos> createState() => _OperacionesQuirurgicosState();
}

class _OperacionesQuirurgicosState extends State<OperacionesQuirurgicos> {
  String appBarTitile = "Gestión de Quirurgicos";
  String? consultIdQuery = Quirurgicos.cirugias['consultIdQuery'];
  String? registerQuery = Quirurgicos.cirugias['registerQuery'];
  String? updateQuery = Quirurgicos.cirugias['updateQuery'];

  int idOperation = 0;

  List<dynamic>? listOfValues;

  String typeIntervencion = Quirurgicos.intervenciones[0];
  //
  var firstItem = Quirurgicos.intervenciones[0];
  var isActualDiagoValue = Quirurgicos.actualDiagno[0];
  var cieDiagnoTextController = TextEditingController();
  var ayoDiagoTextController = TextEditingController();
  //
  var isTratamientoDiagoValue = Quirurgicos.actualDiagno[0];
  var tratamientoTextController = TextEditingController();

  //
  var fileAssocieted = Quirurgicos.fileAssocieted;

  @override
  void initState() {
    //
    print(widget.operationActivity);
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
          idOperation = Quirurgicos.Cirugias['ID_PACE_APP_QUI'];

          isActualDiagoValue =
              Dicotomicos.fromInt(Quirurgicos.Cirugias['Pace_APP_QUI_SINO'])
                  .toString();
          //
          Quirurgicos.typeIntervencion = typeIntervencion =
              Quirurgicos.Cirugias['Pace_APP_type'].toString();
          //
          if (Quirurgicos.selectedDiagnosis == "") {
            cieDiagnoTextController.text = Quirurgicos.Cirugias['Pace_APP_QUI'];
          } else {
            cieDiagnoTextController.text = Quirurgicos.selectedDiagnosis;
          }
          ayoDiagoTextController.text =
              Quirurgicos.Cirugias['Pace_APP_QUI_dia'].toString();
          //
          // isTratamientoDiagoValue =
          //     Dicotomicos.fromInt(Quirurgicos.Cirugias['Pace_APP_QUI_com_SINO'])
          //         .toString();
          tratamientoTextController.text =
              Quirurgicos.Cirugias['Pace_APP_QUI_com'];
        });
        super.initState();
        break;
      default:
    }
  }

  // Actividades de Inicio *********************
  Future<void> reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");

    Pacientes.Quirurgicos!.clear();
    Actividades.consultarAllById(
            Databases.siteground_database_regpace,
            Quirurgicos.cirugias['consultByIdPrimaryQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      setState(() {
        Pacientes.Quirurgicos = value;
        Terminal.printSuccess(
            message:
                "Actualizando Repositorio de Quirurgicos del Paciente . . . ${Pacientes.Quirurgicos}");

        Archivos.createJsonFromMap(Pacientes.Quirurgicos!,
            filePath: Quirurgicos.fileAssocieted);
      });
    });
  }

  // Actividades de la Intefaz *********************
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: isMobile(context) || isTablet(context)
          ? AppBar(
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
              ))
          : null,
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: ContainerDecoration.roundedDecoration(),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                  controller: ScrollController(),
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
      Spinner(
          tittle: "Tipo de Intervención",
          onChangeValue: (value) =>
              setState(() => Quirurgicos.typeIntervencion = value),
          items: Quirurgicos.intervenciones,
          initialValue: Quirurgicos.typeIntervencion),
      Row(
        children: [
          CircleSwitched(
              tittle: "¿Diagnóstico actual?",
              onChangeValue: (value) => setState(() => isActualDiagoValue =
                  Dicotomicos.fromBoolean(value) as String),
              isSwitched: Dicotomicos.fromString(isActualDiagoValue)),
          Expanded(
            flex: 2,
            child: EditTextArea(
              keyBoardType: TextInputType.text,
              inputFormat: MaskTextInputFormatter(),
              numOfLines: 1,
              labelEditText: 'Intervención Realizada . . . ',
              textController: cieDiagnoTextController,
              selection: true,
              withShowOption: true,
              iconData: Icons.line_style,
              onSelected: () {
                String directionPath = "";
                //
                switch (Quirurgicos.typeIntervencion) {
                  case 'Cirugías':
                    directionPath = "assets/diccionarios/Cirugias.txt";
                    break;
                  case 'Alérgicos':
                    directionPath = "assets/diccionarios/Alergias.txt";
                    break;
                  case 'Traumáticos':
                    directionPath = "assets/diccionarios/Traumaticos.txt";
                    break;
                  case 'Tranfusiones':
                    directionPath = "assets/diccionarios/Transfusionales.txt";
                    break;
                  case 'Vacunas':
                    directionPath = "assets/diccionarios/Vacunas.txt";
                    break;
                  default:
                    directionPath = "assets/diccionarios/Cirugias.txt";
                    break;
                }
                //
                Operadores.openDialog(
                    context: context,
                    chyldrim: DialogSelector(
                      pathForFileSource: directionPath,
                      typeOfDocument: "txt",
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
      CrossLine(height: 10, thickness: 2),
      CrossLine(height: 5),
      // CircleSwitched(
      //           //     tittle: "¿Complicaciones?",
      //           //     onChangeValue: (value) {
      //           //       setState(() {
      //           //         isTratamientoDiagoValue =
      //           //         Dicotomicos.fromBoolean(value) as String;
      //           //       });
      //           //     },
      //           //     isSwitched: Dicotomicos.fromString(isTratamientoDiagoValue)),
      EditTextArea(
        keyBoardType: TextInputType.text,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Comentario de la complicación',
        textController: tratamientoTextController,
        numOfLines: 10,
      ),
    ];
  }

  void operationMethod(BuildContext context) {
    try {
      listOfValues = [
        idOperation,
        Pacientes.ID_Paciente,
        Dicotomicos.toInt(isActualDiagoValue),
        firstItem.toString(),
        cieDiagnoTextController.text,
        ayoDiagoTextController.text,
        Dicotomicos.toInt(isTratamientoDiagoValue),
        tratamientoTextController.text,
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
            Archivos.deleteFile(filePath: fileAssocieted);
            reiniciar().then((value) => Operadores.alertActivity(
                context: context,
                tittle: "Anexión de registros",
                message: "Registros agregados",
                onAcept: () {
                  onClose(context);
                }));

            // ******************************************** *** *
          });
          break;
        case Constantes.Update:
          Actividades.actualizar(Databases.siteground_database_regpace,
                  updateQuery!, listOfValues!, idOperation)
              .then((value) {
            Archivos.deleteFile(filePath: fileAssocieted);
            reiniciar().then((value) => Operadores.alertActivity(
                context: context,
                tittle: "Actualización de registros",
                message: "Registros Actualizados",
                onAcept: () {
                  onClose(context);
                }));
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

  void onClose(BuildContext context) {
    switch (isMobile(context)) {
      case true:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionQuirurgicos()));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionQuirurgicos()));
        break;
      default:
    }
  }
}

class GestionQuirurgicos extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Pace_APP_QUI";
  var idElementQuery = 'ID_PACE_APP_QUI';
  var complementElementQuery = 'Pace_APP_QUI_com';
  // ****************** *** ****** **************

  GestionQuirurgicos({Key? key, this.actualSidePage}) : super(key: key);

  @override
  State<GestionQuirurgicos> createState() => _GestionQuirurgicosState();
}

class _GestionQuirurgicosState extends State<GestionQuirurgicos> {
  var fileAssocieted = Quirurgicos.fileAssocieted;

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
              Constantes.reinit();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VisualPacientes(actualPage: 2)));
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
                            reiniciar(); // _pullListRefresh();
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
        isDesktop(context)
            ? widget.actualSidePage != null
                ? Expanded(flex: 1, child: widget.actualSidePage!)
                : Expanded(flex: 1, child: Container())
            : Container()
      ]),
    );
  }

  // Operaciones de Inicio ***** ******* ********** ****
  void iniciar() {
    Terminal.printWarning(
        message:
            " . . . Iniciando Actividad - Repositorio Quirúrgicos del Pacientes");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        foundedItems = value;
        Terminal.printSuccess(
            message: 'Repositorio Quirúrgicos del Pacientes Obtenido');
      });
    }).onError((error, stackTrace) {
      reiniciar();
    });
    Terminal.printOther(message: " . . . Actividad Iniciada");
  }

  Future<void> reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            consultQuery!, Pacientes.ID_Paciente)
        .then((value) {
      setState(() {
        foundedItems = value;
        Archivos.createJsonFromMap(foundedItems!, filePath: fileAssocieted);
      });
    });
  }

  // Operaciones de la Interfaz ***** ******* ********** ****
  Container itemListView(
      AsyncSnapshot snapshot, int posicion, BuildContext context) {
    if (snapshot.data[0].isNotEmpty) {
      return Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.all(20.0),
        decoration: ContainerDecoration.roundedDecoration(),
        child: GestureDetector(
          onTap: () {
            onSelected(snapshot, posicion, context, Constantes.Update);
          },
          child: Column(
            children: [
              Row(
                children: [
                  CircleLabel(
                    tittle: snapshot.data[posicion][widget.idElementQuery]
                        .toString(),
                  ),
                  Expanded(
                      child: CrossLine(
                          isHorizontal: false,
                          thickness: 2,
                          color: Colors.grey)),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${snapshot.data[posicion][widget.keySearch]}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 16),
                        ),
                        Text(
                          "${snapshot.data[posicion][widget.complementElementQuery]}",
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Column(
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
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  void onSelected(AsyncSnapshot<dynamic> snapshot, int posicion,
      BuildContext context, String operaciones) {
    Quirurgicos.Cirugias = snapshot.data[posicion];
    Quirurgicos.selectedDiagnosis = Quirurgicos.Cirugias[widget.keySearch];
    Pacientes.Quirurgicos = snapshot.data;
    //
    toOperaciones(context, operaciones);
  }

  void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void deleteRegister(
      AsyncSnapshot<dynamic> snapshot, int posicion, BuildContext context) {
    Actividades.eliminar(
            Databases.siteground_database_regpace,
            Quirurgicos.cirugias['deleteQuery'],
            snapshot.data[posicion][widget.idElementQuery])
        .then((value) {
      setState(() {
        snapshot.data.removeAt(posicion);
        Archivos.deleteFile(filePath: fileAssocieted).then((value) {
          Operadores.alertActivity(
              context: context,
              tittle: "Eliminación de Registros",
              message: "Registro eliminado",
              onAcept: () {
                Navigator.of(context).pop();
              });
        });
      });
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR - Hubo un error : $error");
    });
  }

  void toOperaciones(BuildContext context, String operationActivity) {
    if (isMobile(context) || isTablet(context)) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => OperacionesQuirurgicos(
                operationActivity: operationActivity,
              )));
    } else {
      Constantes.operationsActividad = operationActivity;
      Constantes.reinit(value: foundedItems!);
      _pullListRefresh();
    }
  }

  void _runFilterSearch(String enteredKeyword) {
    List? results = [];

    if (enteredKeyword.isEmpty) {
      _pullListRefresh();
    } else {
      Actividades.consultar(
              Databases.siteground_database_regpace, consultQuery!)
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
            pageBuilder: (a, b, c) => GestionQuirurgicos(
                  actualSidePage: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OperacionesQuirurgicos(
                      operationActivity: Constantes.operationsActividad,
                    ),
                  ),
                ),
            transitionDuration: const Duration(seconds: 0)));
  }

  // VARIABLES DE LA INTERFAZ ***** ******* ********** ****
  String appTittle = "Gestion de cirugias del paciente";
  String searchCriteria = "Buscar por Fecha";
  String? consultQuery = Quirurgicos.cirugias['consultIdQuery'];

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();
}
