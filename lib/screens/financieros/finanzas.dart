import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Financieros.dart';
import 'package:assistant/screens/financieros/estadisticas.dart';
import 'package:assistant/screens/home.dart';
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
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:assistant/widgets/WidgetsModels.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// # Clase .dart para la creación predeterminada de interfaces de registro, consulta y actualización.
// Contiene un botón que enn _OperacionesActivosState.build que desplega una ventana emergente,
// de la cual es posible elegir desde un catálogo de opciones.
// # # INSTRUCCIONES DE USO
// # # # Reemplazar .Activos por el valor
// # # # Reemplazar Activos. por la clase que contiene el mapa .activos con las claves
// # # # # consultIdQuery
// # # # # registerQuery
// # # # # updateQuery
// # # # Reemplazar .activos por el nombre del Map() correspondiente.
//
class OperacionesActivos extends StatefulWidget {
  String? operationActivity;

  String _operationButton = 'Nulo';

  OperacionesActivos({Key? key, this.operationActivity = Constantes.Nulo})
      : super(key: key);

  @override
  State<OperacionesActivos> createState() => _OperacionesActivosState();
}

class _OperacionesActivosState extends State<OperacionesActivos> {
  String appBarTitile = "Gestión de Activos";
  String? consultIdQuery = Activos.activos['consultIdQuery'];
  String? registerQuery = Activos.activos['registerQuery'];
  String? updateQuery = Activos.activos['updateQuery'];

  int idOperation = 0;

  List<dynamic>? listOfValues;

  var isActualDiagoValue = Activos.actualDiagno[0];
  var cieDiagnoTextController = TextEditingController();
  var comenDiagnoTextController = TextEditingController();
  var ayoDiagoTextController = TextEditingController();
  //
  var isTratamientoDiagoValue = Activos.actualDiagno[0];
  var tratamientoTextController = TextEditingController();

  //
  var activosScroller = ScrollController();

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
          idOperation = Activos.activos['ID_Registro'];

          isActualDiagoValue =
              Dicotomicos.fromInt(Activos.activos['Concepto_Recurso_SINO'])
                  .toString();
          if (Activos.selectedDiagnosis == "") {
            cieDiagnoTextController.text = Activos.activos['Concepto_Recurso'];
          } else {
            cieDiagnoTextController.text = Activos.selectedDiagnosis;
          }
          comenDiagnoTextController.text = Activos.activos['Tipo_Recurso'];
          ayoDiagoTextController.text =
              Activos.activos['Concepto_Recurso_dia'].toString();
          //
          isTratamientoDiagoValue =
              Dicotomicos.fromInt(Activos.activos['Concepto_Recurso_tra_SINO'])
                  .toString();
          tratamientoTextController.text =
              Activos.activos['Concepto_Recurso_tra'];
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
                  controller: activosScroller,
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
          tittle: "¿Diagnóstico actual?",
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
              labelEditText: 'Antecedente alérgico',
              textController: cieDiagnoTextController,
            ),
          ),
          GrandIcon(
            labelButton: "Antecedente alérgico",
            weigth: 5,
            onPress: () {
              cieDialog();
            },
          ),
        ],
      ),
      EditTextArea(
        keyBoardType: TextInputType.text,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Comentario de antecedente alérgico',
        textController: comenDiagnoTextController,
        numOfLines: 1,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Años de antecedente alérgico',
        textController: ayoDiagoTextController,
        numOfLines: 1,
      ),
      CrossLine(),
      Spinner(
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
      EditTextArea(
        keyBoardType: TextInputType.text,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Comentario del tratamiento',
        textController: tratamientoTextController,
        numOfLines: 3,
      ),
      CrossLine(),
    ];
  }

  void operationMethod(BuildContext context) {
    try {
      listOfValues = [
        idOperation,
        Financieros.ID_Financieros,
        Dicotomicos.toInt(isActualDiagoValue),
        cieDiagnoTextController.text,
        comenDiagnoTextController.text,
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
          Actividades.registrar(Databases.siteground_database_regfine,
              registerQuery!, listOfValues!.removeLast());
          break;
        case Constantes.Consult:
          break;
        case Constantes.Register:
          // ******************************************** *** *
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(Databases.siteground_database_regfine,
                  registerQuery!, listOfValues!)
              .then((value) => Actividades.consultarAllById(
                          Databases.siteground_database_regfine,
                          consultIdQuery!,
                          Financieros.ID_Financieros) // idOperation)
                      .then((value) {
                    // ******************************************** *** *
                    Financieros.Activos = value;
                    Constantes.reinit(value: value);
                    // ******************************************** *** *
                  }).then((value) => onClose(context)));
          break;
        case Constantes.Update:
          Actividades.actualizar(Databases.siteground_database_regfine,
                  updateQuery!, listOfValues!, idOperation)
              .then((value) => Actividades.consultarAllById(
                          Databases.siteground_database_regfine,
                          consultIdQuery!,
                          Financieros.ID_Financieros) // idOperation)
                      .then((value) {
                    // ******************************************** *** *
                    Financieros.Activos = value;
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
    }
  }

  void onClose(BuildContext context) {
    switch (isMobile(context)) {
      case true:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionActivos()));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionActivos()));
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
            tittle: 'Elemento de Activos',
            searchCriteria: 'Buscar por',
            typeOfDocument: 'txt',
            pathForFileSource: 'assets/diccionarios/activos.txt',
            onSelected: ((value) {
              setState(() {
                Activos.selectedDiagnosis = value;
                cieDiagnoTextController.text = Activos.selectedDiagnosis;
              });
            }),
          ));
        });
  }
}

class GestionActivos extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Concepto_Recurso";
  // ****************** *** ****** **************

  GestionActivos({Key? key, this.actualSidePage}) : super(key: key);

  @override
  State<GestionActivos> createState() => _GestionActivosState();
}

class _GestionActivosState extends State<GestionActivos> {
  String appTittle = "Gestion de Activos del Usuario";
  String searchCriteria = "Buscar por Fecha";
  String? consultQuery = Activos.activos['consultIdQuery'];

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
              Constantes.reinit();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const Home()));
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
        ),
        isTablet(context)
            ? const Expanded(flex: 1, child: EstadisticasActivos())
            : isDesktop(context)
            ? const Expanded(flex: 1, child: EstadisticasActivos())
            : isTabletAndDesktop(context)
            ? const Expanded(flex: 1, child: EstadisticasActivos())
            : Container()
      ]),
    );
  }

  // OPERACIONES DE LA INTERFAZ ****************** ******** * * * *
  void iniciar() {
    Terminal.printWarning(
        message: " . . . Iniciando Actividad - Repositorio de Pacientes");
    Archivos.readJsonToMap(filePath:  Activos.fileAssocieted).then((value) {
      setState(() {
        foundedItems = value;
      });
    }).onError((error, stackTrace) {
      reiniciar();
    });
    Terminal.printWarning(message: " . . . Actividad Iniciada");
  }

  void reiniciar() {
    Terminal.printAlert(
        message: "Iniciando actividad : : \n "
            "Consulta de Activos del Usuario . . .");
    Actividades.detalles(Databases.siteground_database_regfine,
        Activos.activos['activosStadistics'])
        .then((value) {
      Archivos.createJsonFromMap([value],
          filePath: Activos.fileStadistics);
    });
    Actividades.consultarAllById(Databases.siteground_database_regfine,
        consultQuery!, Financieros.ID_Financieros)
        .then((value) {
      setState(() {
        Terminal.printSuccess(
            message: "Actualizando repositorio de pacientes . . . ");
        foundedItems = value;
        Archivos.createJsonFromMap(foundedItems!, filePath: Activos.fileAssocieted);
      });
    }).whenComplete(() => Operadores.alertActivity(
        context: context,
        tittle: "Datos Recargados",
        message: "Registro Actualizado",
        onAcept: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => GestionActivos(),
            ),
          );
        }));
  }

  void deleteRegister(
      AsyncSnapshot<dynamic> snapshot, int posicion, BuildContext context) {
    try {
      Actividades.eliminar(
          Databases.siteground_database_regfine,
          Activos.activos['deleteQuery'],
          snapshot.data[posicion]['ID_Registro']);
      setState(() {
        snapshot.data.removeAt(posicion);
      });
    } finally {
      Navigator.of(context).pop();
    }
  }

  void toOperaciones(BuildContext context, String operationActivity) {
    if (isMobile(context)) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => OperacionesActivos(
            operationActivity: operationActivity,
          )));
    } else {
      Constantes.operationsActividad = operationActivity;
      Constantes.reinit(value: foundedItems!);
      _pullListRefresh();
    }
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
              CircleLabel(
                radios: 30,
                tittle: snapshot.data[posicion]['ID_Registro'].toString(),
              ),
              CircleIcon(iconed: snapshot.data[posicion]['Tipo_Recurso'] == 'Ingresos' ?  Icons.insights : Icons.leaderboard_sharp,),
              Column(
                children: [
                  Text(
                    "${snapshot.data[posicion]['Tipo_Recurso']}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 14),
                  ),
                  Text(
                    "${snapshot.data[posicion]['Monto_Pagado']}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 14),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "${snapshot.data[posicion]['Fecha_Pago_Programado']}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 14),
                  ),
                  Text(
                    "${snapshot.data[posicion]['Estado_Actual']}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 14),
                  ),
                ],
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
        ),
      ),
    );
  }

  void onSelected(AsyncSnapshot<dynamic> snapshot, int posicion,
      BuildContext context, String operaciones) {
    Activos.Degenerativo = snapshot.data[posicion];
    Activos.selectedDiagnosis = Activos.activos['Concepto_Recurso'];
    Financieros.Activos = snapshot.data;
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
          keySearched: 'Pace_Ape_Pat',
          elementSearched: Sentences.capitalize(enteredKeyword));

      setState(() {
        foundedItems = results;
      });
    }
  }

  void _runHospitalizedSearch({String enteredKeyword = 'Hospitalización'}) {
    Terminal.printWarning(
        message: " . . . Iniciando Actividad - Repositorio de Pacientes");
    Archivos.readJsonToMap(filePath: Activos.fileAssocieted).then((value) {
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
            keySearched: 'Pace_Hosp',
            elementSearched: Sentences.capitalize(enteredKeyword));

        // Terminal.printNotice(message: " . . . ${results.length} Pacientes Encontrados".toUpperCase());
        setState(() {
          foundedItems = results;
        });
      }
    });
  }

  void _runConsultaSearch({String enteredKeyword = 'Consulta Externa'}) {
    Terminal.printWarning(
        message: " . . . Iniciando Actividad - Repositorio de Pacientes");
    Archivos.readJsonToMap(filePath: Activos.fileAssocieted).then((value) {
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
            keySearched: 'Pace_Hosp',
            elementSearched: Sentences.capitalize(enteredKeyword));

        // Terminal.printNotice(message: " . . . ${results.length} Pacientes Encontrados".toUpperCase());
        setState(() {
          foundedItems = results;
        });
      }
    });
  }

}
