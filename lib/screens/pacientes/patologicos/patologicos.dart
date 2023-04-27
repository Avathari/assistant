import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/screens/pacientes/patologicos/auxiliares/antecedentes.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleSwitched.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/DialogSelector.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/Switched.dart';
import 'package:assistant/widgets/WidgetsModels.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../conexiones/conexiones.dart';

class OperacionesPatologicos extends StatefulWidget {
  String? operationActivity;

  String _operationButton = 'Nulo';

  OperacionesPatologicos({Key? key, this.operationActivity = Constantes.Nulo})
      : super(key: key);

  @override
  State<OperacionesPatologicos> createState() => _OperacionesPatologicosState();
}

class _OperacionesPatologicosState extends State<OperacionesPatologicos> {
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
        decoration: ContainerDecoration.roundedDecoration(),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                  controller: patologicosScroller,
                  child: Column(
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

  List<Widget> component(BuildContext context) {
    return [
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
            flex: 4,
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
      CrossLine(),
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
                          child: const Antecedentes()
                        ),
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

  void onClose(BuildContext context) {
    switch (isMobile(context)) {
      case true:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionPatologicos()));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionPatologicos()));
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

class GestionPatologicos extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Pace_APP_DEG";
  // ****************** *** ****** **************

  GestionPatologicos({Key? key, this.actualSidePage}) : super(key: key);

  @override
  State<GestionPatologicos> createState() => _GestionPatologicosState();
}

class _GestionPatologicosState extends State<GestionPatologicos> {
  var fileAssocieted = Patologicos.fileAssocieted;

  @override
  void initState() {
    iniciar();
    super.initState();
  }

  void iniciar() {
    Terminal.printWarning(
        message:
            " . . . Iniciando Actividad - Repositorio Patologías del Pacientes");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        foundedItems = value;
        Terminal.printSuccess(
            message: 'Repositorio Patologías del Pacientes Obtenido');
      });
    }).onError((error, stackTrace) {
      reiniciar();
    });
    Terminal.printOther(message: " . . . Actividad Iniciada");
  }

  Future<void> reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");
    Actividades.consultarAllById(
            Databases.siteground_database_regpace,
            Patologicos.patologicos['consultByIdPrimaryQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      setState(() {
        foundedItems = value;
        Archivos.createJsonFromMap(foundedItems!, filePath: fileAssocieted);
      });
    });
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
                reiniciar();
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
          padding: const EdgeInsets.only(left: 0, right: 10, bottom: 20, top: 20),
          margin: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(flex: 2, child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 40,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 30,
                      child: Text(
                        snapshot.data[posicion]['ID_PACE_APP_DEG'].toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 16),
                      ),
                    ),
                  ),),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${snapshot.data[posicion]['Pace_APP_DEG']}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 14),
                        ),
                        Text(
                          "${snapshot.data[posicion]['Pace_APP_DEG_com']}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
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
                                    Navigator.of(context).pop();
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
      ),
    );
  }

  void onSelected(AsyncSnapshot<dynamic> snapshot, int posicion,
      BuildContext context, String operaciones) {
    Patologicos.Degenerativos = snapshot.data[posicion];
    Patologicos.selectedDiagnosis = Patologicos.Degenerativos['Pace_APP_DEG'];
    Pacientes.Patologicos = snapshot.data;
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
            Patologicos.patologicos['deleteQuery'],
            snapshot.data[posicion]['ID_PACE_APP_DEG'])
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
          builder: (BuildContext context) => OperacionesPatologicos(
                operationActivity: operationActivity,
              )));
    } else {
      Constantes.operationsActividad = operationActivity;
      Constantes.reinit(value: foundedItems!);
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (a, b, c) => GestionPatologicos(
                    actualSidePage: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OperacionesPatologicos(
                        operationActivity: Constantes.operationsActividad,
                      ),
                    ),
                  ),
              transitionDuration: const Duration(seconds: 0)));
    }
  }

  void _runFilterSearch(String enteredKeyword) {
    List? results = [];

    if (enteredKeyword.isEmpty) {
      _pullListRefresh();
    } else {
      results = Listas.listFromMap(
          lista: foundedItems!,
          keySearched: widget.keySearch,
          elementSearched: enteredKeyword);

      setState(() {
        foundedItems = results;
      });
    }
  }

  Future<Null> _pullListRefresh() async {
    iniciar();
  }

  // VARIABLES DE LA INTERFAZ ********* **** ********* ******
  String appTittle = "Gestion de patologías del paciente";
  String searchCriteria = "Buscar por Fecha";
  String? consultQuery = Patologicos.patologicos['consultIdQuery'];

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();
}
