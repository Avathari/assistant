import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/operadores/Cie.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleSwitched.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/DialogSelector.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/SelectorArchivos.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/Switched.dart';
import 'package:assistant/widgets/WidgetsModels.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../conexiones/conexiones.dart';

class OperacionesDiagnosticos extends StatefulWidget {
  String? operationActivity;

  String _operationButton = 'Nulo';

  OperacionesDiagnosticos({Key? key, this.operationActivity = Constantes.Nulo})
      : super(key: key);

  @override
  State<OperacionesDiagnosticos> createState() =>
      _OperacionesDiagnosticosState();
}

class _OperacionesDiagnosticosState extends State<OperacionesDiagnosticos> {
  String appBarTitile = "Gestión de Diagnosticos";
  String? consultIdQuery = Diagnosticos.diagnosticos['consultIdQuery'];
  String? registerQuery = Diagnosticos.diagnosticos['registerQuery'];
  String? updateQuery = Diagnosticos.diagnosticos['updateQuery'];

  int idOperation = 0;

  List<dynamic>? listOfValues;

  var isActualDiagoValue = Diagnosticos.actualDiagno[0];
  var cieDiagnoTextController = TextEditingController();
  var comenDiagnoTextController = TextEditingController();
  var ayoDiagoTextController = TextEditingController();
  //
  var isTratamientoDiagoValue = Diagnosticos.actualTratamiento[0];
  var tratamientoTextController = TextEditingController();
  var isSuspendTratoValue = Diagnosticos.actualSuspendido[0];
  var suspensionesTextController = TextEditingController();

  //
  var diagnosticosScroller = ScrollController();

  var fileAssocieted = Diagnosticos.fileAssocieted;

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
        ayoDiagoTextController.text = Calendarios.today(format: 'yyyy-MM-dd');

        break;
      case Constantes.Update:
        setState(() {
          widget._operationButton = 'Actualizar';
          idOperation = Diagnosticos.Diagnostico['ID_PACE_APP_DEG'];

          isActualDiagoValue =
              Dicotomicos.fromInt(Diagnosticos.Diagnostico['Pace_APP_DEG_SINO'])
                  .toString();
          if (Diagnosticos.selectedDiagnosis == "") {
            cieDiagnoTextController.text =
                Diagnosticos.Diagnostico['Pace_APP_DEG'];
          } else {
            cieDiagnoTextController.text = Diagnosticos.selectedDiagnosis;
          }
          comenDiagnoTextController.text =
              Diagnosticos.Diagnostico['Pace_APP_DEG_com'];
          ayoDiagoTextController.text =
              Diagnosticos.Diagnostico['Pace_APP_DEG_dia'].toString();
          //
          // isTratamientoDiagoValue =
          // Dicotomicos.fromBoolean(value) as String;
          //
          isTratamientoDiagoValue = Dicotomicos.fromInt(
                  Diagnosticos.Diagnostico['Pace_APP_DEG_tra_SINO'])
              .toString();
          tratamientoTextController.text =
              Diagnosticos.Diagnostico['Pace_APP_DEG_tra'];
          isSuspendTratoValue = Dicotomicos.fromInt(
                  Diagnosticos.Diagnostico['Pace_APP_DEG_sus_SINO'])
              .toString();
          suspensionesTextController.text =
              Diagnosticos.Diagnostico['Pace_APP_DEG_sus'];
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
              flex: 11,
              child: SingleChildScrollView(
                  controller: diagnosticosScroller,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: component(context),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: ContainerDecoration.roundedDecoration(),
                child: GrandButton(
                    weigth: 2000,
                    labelButton: widget._operationButton,
                    onPress: () {
                      operationMethod(context);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Actividades de Inicio *********************
  Future<void> reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");

    Pacientes.Diagnosticos!.clear();
    Actividades.consultarAllById(
            Databases.siteground_database_reghosp,
            Diagnosticos.diagnosticos['consultByIdPrimaryQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      setState(() {
        Pacientes.Diagnosticos = value;
        Terminal.printSuccess(
            message:
                "Actualizando Repositorio de Diagnósticos del Paciente . . . ${Pacientes.Diagnosticos}");

        Archivos.createJsonFromMap(Pacientes.Diagnosticos!,
            filePath: Diagnosticos.fileAssocieted);
      });
    });
  }

  // Actividades de la Intefaz *********************
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
      CrossLine(height: 20,),
      EditTextArea(
        keyBoardType: TextInputType.text,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Diagnóstico Complementario',
        textController: comenDiagnoTextController,
        numOfLines: 5,
      ),
      Row(
        children: [
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.datetime,
              inputFormat: MaskTextInputFormatter(
                  mask: '####-##-##',
                  filter: {"#": RegExp(r'[0-9]')},
                  type: MaskAutoCompletionType.lazy),
              labelEditText: 'Años de diagnóstico',
              textController: ayoDiagoTextController,
              numOfLines: 1,
              withShowOption: true,
              selection: true,
              onSelected: (){
                setState(() {
                  ayoDiagoTextController.text = Calendarios.today(format: 'yyyy-MM-dd');
                });
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: EditTextArea(
              keyBoardType: TextInputType.text,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Comentario del Diagnóstico',
              textController: suspensionesTextController,
              numOfLines: 3,
            ),
          ),
        ],
      ),
      CrossLine(),
      Row(
        children: [
          Expanded(
            flex: isMobile(context) ? 2 : 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CircleSwitched(
                  tittle: "¿Tratamiento actual?",
                  onChangeValue: (value) {
                    setState(() {
                      print("value $value");
                      isTratamientoDiagoValue =
                      Dicotomicos.fromBoolean(value) as String;
                    });
                  },
                  isSwitched: Dicotomicos.fromString(isTratamientoDiagoValue)),
            ),
          ),
          // Expanded(
          //   child: Switched(
          //       tittle: "¿Tratamiento actual?",
          //       onChangeValue: (value) {
          //         setState(() {
          //           isTratamientoDiagoValue = Dicotomicos.fromBoolean(value) as String;
          //           if (isTratamientoDiagoValue == Dicotomicos.dicotomicos()[0]) {
          //             tratamientoTextController.text = "";
          //           } else {
          //             tratamientoTextController.text = "Sin tratamiento actual";
          //           }
          //         });
          //       },
          //       isSwitched: Dicotomicos.fromString(isTratamientoDiagoValue)),
          // ),
          Expanded(
            flex: 3,
            child: EditTextArea(
              keyBoardType: TextInputType.text,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Comentario del tratamiento',
              textController: tratamientoTextController,
              numOfLines: 3,
            ),
          ),
        ],
      ),
      CrossLine(),
      //         isSuspendTratoValue = value;
    ];
  }

  void operationMethod(BuildContext context) {
    try {
      listOfValues = [
        idOperation,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
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
          Actividades.registrar(Databases.siteground_database_reghosp,
              registerQuery!, listOfValues!.removeLast());
          break;
        case Constantes.Consult:
          break;
        case Constantes.Register:
          // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(Databases.siteground_database_reghosp,
                  registerQuery!, listOfValues!)
              .then((value) {
            Archivos.deleteFile(filePath: fileAssocieted);
            reiniciar().then((value) => Operadores.alertActivity(
                context: context,
                tittle: "Anexión de registros",
                message: "Registros Agregados",
                onAcept: () {
                  onClose(context);
                }));
            // ******************************************** *** *
          });
          break;
        case Constantes.Update:
          Actividades.actualizar(Databases.siteground_database_reghosp,
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
                builder: (context) => GestionDiagnosticos()));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionDiagnosticos()));
        break;
      default:
    }
  }

}

class GestionDiagnosticos extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Pace_APP_DEG";
  // ****************** *** ****** **************

  GestionDiagnosticos({Key? key, this.actualSidePage}) : super(key: key);

  @override
  State<GestionDiagnosticos> createState() => _GestionDiagnosticosState();
}

class _GestionDiagnosticosState extends State<GestionDiagnosticos> {
  var fileAssocieted = Diagnosticos.fileAssocieted;

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
                  builder: (context) => VisualPacientes(actualPage: 0)));
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
                            reiniciar();
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
                              gridDelegate: GridViewTools.gridDelegate(
                                  crossAxisCount: isMobile(context) ? 1 : 3,
                                  mainAxisExtent:
                                      isMobile(context) ? 150 : 250),
                              controller: gestionScrollController,
                              shrinkWrap: isMobile(context) ? false : true,
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
        isDesktop(context) || isTabletAndDesktop(context)
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
            " . . . Iniciando Actividad - Repositorio Diagnósticos del Pacientes");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        foundedItems = value;
        Terminal.printSuccess(
            message: 'Repositorio Diagnósticos del Pacientes Obtenido');
      });
    }).onError((error, stackTrace) {
      reiniciar();
    });
    Terminal.printOther(message: " . . . Actividad Iniciada");
  }

  Future<void> reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");
    Actividades.consultarAllById(Databases.siteground_database_reghosp,
            consultQuery!, Pacientes.ID_Hospitalizacion)
        .then((value) {
      setState(() {
        foundedItems = value;
        Archivos.createJsonFromMap(foundedItems!, filePath: fileAssocieted);
      });
    });
  }

  // Operaciones de la Interfaz ***** ******* ********** ****
  GestureDetector itemListView(
      AsyncSnapshot snapshot, int posicion, BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected(snapshot, posicion, context, Constantes.Update);
      },
      child: Container(
        padding: const EdgeInsets.only(left: 8.0, right: 2.0, top: 8, bottom: 8),
        decoration: ContainerDecoration.roundedDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CircleAvatar(
                      radius: 300,
                      backgroundColor: Colors.grey,
                      child: Text(
                        snapshot.data[posicion]['ID_PACE_APP_DEG'].toString(),
                        style: Styles.textSyleGrowth(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 4.0, top: 6, bottom: 2.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.data[posicion]['Pace_APP_DEG']}",
                            style: Styles.textSyleGrowth(fontSize: 18),
                            maxLines: 3,
                          ),
                          CrossLine(),
                          Text("${snapshot.data[posicion]['Pace_APP_DEG_com']}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                              style: Styles.textSyleGrowth(fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
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
                      Operadores.alertActivity(context: context, tittle: 'Eliminar registro',
                        message: '¿Esta seguro de querer eliminar el registro?', onAcept: () {
                          Navigator.of(context).pop();
                          deleteRegister(snapshot, posicion, context);
                        },);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onSelected(AsyncSnapshot<dynamic> snapshot, int posicion,
      BuildContext context, String operaciones) {
    Diagnosticos.Diagnostico = snapshot.data[posicion];
    Diagnosticos.selectedDiagnosis = Diagnosticos.Diagnostico['Pace_APP_DEG'];
    Pacientes.Diagnosticos = snapshot.data;
    //
    toOperaciones(context, operaciones);
  }

  void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void deleteRegister(
      AsyncSnapshot<dynamic> snapshot, int posicion, BuildContext context) {
    Actividades.eliminar(
            Databases.siteground_database_reghosp,
            Diagnosticos.diagnosticos['deleteQuery'],
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
          builder: (BuildContext context) => OperacionesDiagnosticos(
                operationActivity: operationActivity,
              )));
    } else {
      Constantes.operationsActividad = operationActivity;
      Constantes.reinit(value: foundedItems!);
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (a, b, c) => GestionDiagnosticos(
                    actualSidePage: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OperacionesDiagnosticos(
                        operationActivity: Constantes.operationsActividad,
                      ),
                    ),
                  ),
              transitionDuration: const Duration(seconds: 0)));
    }
  }

  // Operaciones de Búsqueda ***** ******* ********** ****
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

  // VARIABLES DE LA INTERFAZ ***** ******* ********** ****
  String appTittle =
      "Gestion de diagnósiticos de la Hospitalización del paciente";
  String searchCriteria = "Buscar por diagnóstico";
  String? consultQuery = Diagnosticos.diagnosticos['consultIdQuery'];

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();
}
