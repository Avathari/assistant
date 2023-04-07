import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
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

class OperacionesTransfusionales extends StatefulWidget {
  String? operationActivity;

  String _operationButton = 'Nulo';

  OperacionesTransfusionales(
      {Key? key, this.operationActivity = Constantes.Nulo})
      : super(key: key);

  @override
  State<OperacionesTransfusionales> createState() =>
      _OperacionesTransfusionalesState();
}

class _OperacionesTransfusionalesState
    extends State<OperacionesTransfusionales> {
  String appBarTitile = "Gestión de Transfusionales";
  String? consultIdQuery = Transfusionales.transfusiones['consultIdQuery'];
  String? registerQuery = Transfusionales.transfusiones['registerQuery'];
  String? updateQuery = Transfusionales.transfusiones['updateQuery'];

  int idOperation = 0;

  List<dynamic>? listOfValues;

  var isActualDiagoValue = Transfusionales.actualDiagno[0];
  var cieDiagnoTextController = TextEditingController();
  var ayoDiagoTextController = TextEditingController();
  //
  var isTratamientoDiagoValue = Transfusionales.actualTratamiento[0];
  var tratamientoTextController = TextEditingController();

  //
  var patologicosScroller = ScrollController();

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
          idOperation = Transfusionales.Transfusiones['ID_PACE_APP_TRA'];

          isActualDiagoValue = Dicotomicos.fromInt(
              Transfusionales.Transfusiones['Pace_APP_TRA_SINO']).toString();
          if (Transfusionales.selectedDiagnosis == "") {
            cieDiagnoTextController.text =
                Transfusionales.Transfusiones['Pace_APP_TRA'];
          } else {
            cieDiagnoTextController.text = Transfusionales.selectedDiagnosis;
          }
          ayoDiagoTextController.text =
              Transfusionales.Transfusiones['Pace_APP_TRA_dia'].toString();
          //
          isTratamientoDiagoValue = Dicotomicos.fromInt(
              Transfusionales.Transfusiones['Pace_APP_TRA_com_SINO']).toString();
          tratamientoTextController.text =
              Transfusionales.Transfusiones['Pace_APP_TRA_com'];
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
      body: Card(
        color: const Color.fromARGB(255, 61, 57, 57),
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
          tittle: "¿Antecedente de transfusión?",
          onChangeValue: (String value) {
            setState(() {
              isActualDiagoValue = value;
            });
          },
          items: Dicotomicos.dicotomicos(),
          initialValue: isActualDiagoValue),
      Row(
        children: [
          Expanded(
            flex: 2,
            child: EditTextArea(
              keyBoardType: TextInputType.text,
              inputFormat: MaskTextInputFormatter(),
              numOfLines: 1,
              labelEditText: 'Elemento transfundido',
              textController: cieDiagnoTextController,
            ),
          ),
          GrandIcon(
            labelButton: "Elemento transfundido",
            weigth: 5,
            onPress: () {
              cieDialog();
            },
          ),
        ],
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Años de diagnóstico',
        textController: ayoDiagoTextController,
        numOfLines: 1,
      ),
      CrossLine(),
      Spinner(
          tittle: "¿Complicaciones?",
          onChangeValue: (String value) {
            setState(() {
              isTratamientoDiagoValue = value;
              if (value == Dicotomicos.dicotomicos()[0]) {
                tratamientoTextController.text = "";
              } else {
                tratamientoTextController.text =
                    "Sin complicaciones reportadas";
              }
            });
          },
          items: Dicotomicos.dicotomicos(),
          initialValue: isTratamientoDiagoValue),
      EditTextArea(
        keyBoardType: TextInputType.text,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Comentario de la complicación',
        textController: tratamientoTextController,
        numOfLines: 3,
      ),
    ];
  }

  Future<void> reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");

    Pacientes.Patologicos!.clear();
    Actividades.consultarAllById(
        Databases.siteground_database_regpace,
        Transfusionales.transfusiones['consultByIdPrimaryQuery'],
        Pacientes.ID_Paciente)
        .then((value) {
      setState(() {
        Pacientes.Transfusionales = value;
        Terminal.printSuccess(
            message:
            "Actualizando Repositorio de Transfusionales del Paciente . . . ${Pacientes.Transfusionales}");

        Archivos.createJsonFromMap(Pacientes.Transfusionales!,
            filePath: Transfusionales.fileAssocieted);
      });
    });
  }


  void operationMethod(BuildContext context) {
    try {
      listOfValues = [
        idOperation,
        Pacientes.ID_Paciente,
        Dicotomicos.toInt(isActualDiagoValue),
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
            Archivos.deleteFile(filePath: Transfusionales.fileAssocieted);
            reiniciar().then((value) => Operadores.alertActivity(
                context: context,
                tittle: "Anexión de registros",
                message: "Registros Agregados",
                onAcept: () {
                  onClose(context);
                }));
            // ******************************************** *** *
            // Pacientes.Transfusionales = value;
            // Constantes.reinit(value: value);
            // ******************************************** *** *
          });
          break;
        case Constantes.Update:
          Actividades.actualizar(Databases.siteground_database_regpace,
                  updateQuery!, listOfValues!, idOperation)
              .then((value) {
              Archivos.deleteFile(filePath: Transfusionales.fileAssocieted);
          reiniciar().then((value) => Operadores.alertActivity(
              context: context,
              tittle: "Actualización de registros",
              message: "Registros Actualizados",
              onAcept: () {
                onClose(context);
              }));
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
                builder: (context) => GestionTransfusionales()));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionTransfusionales()));
        break;
      default:
    }
  }

  cieDialog() {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          return Dialog(
              child: DialogSelector(
            tittle: 'Elemento de transfusión',
            searchCriteria: 'Buscar por',
            typeOfDocument: 'txt',
            pathForFileSource: 'assets/diccionarios/Transfusionales.txt',
            onSelected: ((value) {
              setState(() {
                Transfusionales.selectedDiagnosis = value;
                cieDiagnoTextController.text =
                    Transfusionales.selectedDiagnosis;
              });
            }),
          ));
        });
  }
}

class GestionTransfusionales extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Pace_APP_TRA";
  var idElementQuery = 'ID_PACE_APP_TRA';
  var complementElementQuery = 'Pace_APP_TRA_com';
  // ****************** *** ****** **************

  GestionTransfusionales({Key? key, this.actualSidePage}) : super(key: key);

  @override
  State<GestionTransfusionales> createState() => _GestionTransfusionalesState();
}

class _GestionTransfusionalesState extends State<GestionTransfusionales> {
  var fileAssocieted = Transfusionales.fileAssocieted;

  @override
  void initState() {
    iniciar();
    // print(" . . . Iniciando array ");
    // if (Constantes.dummyArray!.isNotEmpty) {
    //   if (Constantes.dummyArray![0] == "Vacio") {
    //     Actividades.consultarAllById(Databases.siteground_database_regpace,
    //             consultQuery!, Pacientes.ID_Paciente)
    //         .then((value) {
    //       setState(() {
    //         print(" . . . Buscando items \n");
    //         foundedItems = value;
    //       });
    //     });
    //   } else {
    //     print(" . . . Dummy array iniciado");
    //     foundedItems = Constantes.dummyArray;
    //   }
    // }
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
        " . . . Iniciando Actividad - Repositorio Tranfusionales del Pacientes");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        foundedItems = value;
        Terminal.printSuccess(
            message: 'Repositorio Tranfusionales del Pacientes Obtenido');
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
    return Container(
      padding: const EdgeInsets.all(2.0),
      child: GestureDetector(
        onTap: () {
          onSelected(snapshot, posicion, context, Constantes.Update);
        },
        child: Card(
          color: const Color.fromARGB(255, 54, 50, 50),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ID : ${snapshot.data[posicion][widget.idElementQuery].toString()}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 12),
                          ),
                          Text(
                            "${snapshot.data[posicion][widget.keySearch]}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 14),
                          ),
                          Text(
                            "${snapshot.data[posicion][widget.complementElementQuery]}",
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
                                      deleteRegister(
                                          snapshot, posicion, context);
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
      ),
    );
  }

  void onSelected(AsyncSnapshot<dynamic> snapshot, int posicion,
      BuildContext context, String operaciones) {
    Transfusionales.Transfusiones = snapshot.data[posicion];
    Transfusionales.selectedDiagnosis =
        Transfusionales.Transfusiones[widget.keySearch];
    Pacientes.Transfusionales = snapshot.data;
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
          Databases.siteground_database_regpace,
          Transfusionales.transfusiones['deleteQuery'],
          snapshot.data[posicion][widget.idElementQuery]);
      setState(() {
        snapshot.data.removeAt(posicion);
      });
    } finally {
      Navigator.of(context).pop();
    }
  }

  void toOperaciones(BuildContext context, String operationActivity) {
    if (isMobile(context) || isTablet(context)) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => OperacionesTransfusionales(
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
            pageBuilder: (a, b, c) => GestionTransfusionales(
                  actualSidePage: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OperacionesTransfusionales(
                      operationActivity: Constantes.operationsActividad,
                    ),
                  ),
                ),
            transitionDuration: const Duration(seconds: 0)));
  }

  // VARIABLES DE LA INTERFAZ ***** ******* ********** ****
  String appTittle = "Gestion de transfusiones del paciente";
  String searchCriteria = "Buscar por Fecha";
  String? consultQuery = Transfusionales.transfusiones['consultIdQuery'];

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

}
