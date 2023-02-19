import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/Switched.dart';
import 'package:assistant/widgets/WidgetsModels.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// # Clase .dart para la creación predeterminada de interfaces de registro, consulta y actualización.
// Contiene un botón que enn _OperacionesPendienteState.build que desplega una ventana emergente,
// de la cual es posible elegir desde un catálogo de opciones.
// # # INSTRUCCIONES DE USO
// # # # Reemplazar .Pendiente por el valor
// # # # Reemplazar Pendientes. por la clase que contiene el mapa .pendiente con las claves
// # # # # consultIdQuery
// # # # # registerQuery
// # # # # updateQuery
// # # # Reemplazar .pendiente por el nombre del Map() correspondiente.
//
// ignore: must_be_immutable
class OperacionesPendiente extends StatefulWidget {
  String? operationActivity;

  String _operationButton = 'Nulo';

  OperacionesPendiente({Key? key, this.operationActivity = Constantes.Nulo})
      : super(key: key);

  @override
  State<OperacionesPendiente> createState() => _OperacionesPendienteState();
}

class _OperacionesPendienteState extends State<OperacionesPendiente> {
  String appBarTitile = "Gestión de Pendientes";
  String? consultIdQuery = Pendientes.pendientes['consultIdQuery'];
  String? registerQuery = Pendientes.pendientes['registerQuery'];
  String? updateQuery = Pendientes.pendientes['updateQuery'];

  int idOperation = 0;

  List<dynamic>? listOfValues;

  var fechaRealizacionTextController = TextEditingController();
  bool? realized = false;
  //
  var pendienteValue = Pendientes.typesPendientes[0];
  var descripcionPendienteTextController = TextEditingController();
  //
  var carouselController = CarouselController();
  //

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

        final f = DateFormat('yyyy-MM-dd');
        fechaRealizacionTextController.text = f.format(DateTime.now());

        break;
      case Constantes.Update:
        print("Pendientes.Pendiente['Pace_PEN_realized'] "
            "${Pendientes.Pendiente['Pace_PEN_realized']} "
            "${Pendientes.Pendiente['Pace_PEN_realized'].runtimeType} "
            "${Dicotomicos.fromInt(Pendientes.Pendiente['Pace_PEN_realized'], toBoolean: true) as bool} ");

        setState(() {
          widget._operationButton = 'Actualizar';
          //
          idOperation = Pendientes.Pendiente['ID_Pace_Pen'];
          realized = Dicotomicos.fromInt(
              Pendientes.Pendiente['Pace_PEN_realized'],
              toBoolean: true) as bool;
          fechaRealizacionTextController.text =
              Pendientes.Pendiente['Feca_PEN'];
          pendienteValue = Pendientes.Pendiente['Pace_PEN'].toString();

          descripcionPendienteTextController.text =
              Pendientes.Pendiente['Pace_Desc_PEN'].toString();
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
      appBar: isDesktop(context)
          ? null
          : AppBar(
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
              )),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: ContainerDecoration.roundedDecoration(),
        child: Column(
          children: [
            EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(
                  mask: '####/##/##',
                  filter: {"#": RegExp(r'[0-9]')},
                  type: MaskAutoCompletionType.lazy),
              labelEditText: 'Fecha de realización',
              textController: fechaRealizacionTextController,
              numOfLines: 1,
            ),
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10.0),
                controller: ScrollController(),
                child: Column(
                  children: component(context),
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
      ),
    );
  }

  List<Widget> component(BuildContext context) {
    return [
      Row(
        children: [
          Expanded(
            child: Switched(
              tittle: "¿Realizado?",
              isSwitched: realized,
              onChangeValue: (value) {
                setState(() {
                  realized = value;
                });
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Spinner(
                width: isDesktop(context)
                    ? 200
                    : isTablet(context)
                        ? 200
                        : isMobile(context)
                            ? 100
                            : 200,
                tittle: "Tipo de Pendiente",
                onChangeValue: (String value) {
                  setState(() {
                    pendienteValue = value;
                  });
                },
                items: Pendientes.typesPendientes,
                initialValue: pendienteValue),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      EditTextArea(
        keyBoardType: TextInputType.text,
        inputFormat: MaskTextInputFormatter(
            mask: '####',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Descripción del Pendiente',
        textController: descripcionPendienteTextController,
        numOfLines: 7,
      ),
      const CrossLine(),
    ];
  }

  void operationMethod(BuildContext context) {
    try {
      listOfValues = [
        idOperation,
        Pacientes.ID_Paciente,
        Pacientes.ID_Hospitalizacion,
        fechaRealizacionTextController.text,
        // hora
        Dicotomicos.fromBoolean(realized!, toInt: true),
        pendienteValue,
        descripcionPendienteTextController.text,
        //
        idOperation
      ];

      print(
          "${widget.operationActivity} listOfValues $listOfValues ${listOfValues!.length}");
      // print("realized! ${realized!} ${realized!.runtimeType} "
      //     "${ Dicotomicos.fromBoolean(realized!, toInt: true)} "
      //     "${ Dicotomicos.fromBoolean(realized!, toInt: true).runtimeType} ");

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
              .then((value) => Actividades.consultarAllById(
                          Databases.siteground_database_reghosp,
                          consultIdQuery!,
                          Pacientes.ID_Paciente) // idOperation)
                      .then((value) {
                    // ******************************************** *** *
                    Pacientes.Alergicos = value;
                    Constantes.reinit(value: value);
                    // ******************************************** *** *
                  }).then((value) => onClose(context)));
          break;
        case Constantes.Update:
          Actividades.actualizar(Databases.siteground_database_reghosp,
                  updateQuery!, listOfValues!, idOperation)
              .then((value) => Actividades.consultarAllById(
                          Databases.siteground_database_reghosp,
                          consultIdQuery!,
                          Pacientes.ID_Paciente) // idOperation)
                      .then((value) {
                    // ******************************************** *** *
                    Pacientes.Alergicos = value;
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
    Constantes.reinit();

    switch (isMobile(context)) {
      case true:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionPendiente()));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionPendiente()));
        break;
      default:
    }
  }
}

// ignore: must_be_immutable
class GestionPendiente extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Feca_PEN";
  // ****************** *** ****** **************

  GestionPendiente({Key? key, this.actualSidePage}) : super(key: key);

  @override
  State<GestionPendiente> createState() => _GestionPendienteState();
}

class _GestionPendienteState extends State<GestionPendiente> {
  String appTittle = "Gestion de pendientes del paciente";
  String searchCriteria = "Buscar por Fecha";
  String? consultQuery = Pendientes.pendientes['consultIdQuery'];

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  @override
  void initState() {
    print(" . . . Iniciando array ");
    if (Constantes.dummyArray!.isNotEmpty) {
      if (Constantes.dummyArray![0] == "Vacio") {
        Actividades.consultarAllById(Databases.siteground_database_reghosp,
                consultQuery!, Pacientes.ID_Hospitalizacion)
            .then((value) {
          setState(() {
            print(" . . . Buscando items \n $value");
            foundedItems = value;
          });
        });
      } else {
        print(" . . . Pendiente array iniciado");
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
                              gridDelegate:
                                  GridViewTools.gridDelegate(crossAxisCount: 3),
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
      padding: const EdgeInsets.all(12.0),
      decoration: ContainerDecoration.roundedDecoration(),
      child: GestureDetector(
        onTap: () {
          onSelected(snapshot, posicion, context, Constantes.Update);
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
                      snapshot.data[posicion]['ID_Pace_Pen'].toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 24),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  snapshot.data[posicion]['Pace_PEN_realized'] == 0
                      ? IconButton(
                          icon: const Icon(Icons.not_interested,
                              color: Colors.redAccent),
                          onPressed: () {
                            Actividades.actualizar(
                                    Databases.siteground_database_reghosp,
                                    Pendientes.pendientes['updateDoQuery'],
                                    [
                                      Dicotomicos.fromBoolean(true,
                                          toInt: true),
                                      snapshot.data[posicion]['ID_Pace_Pen']
                                    ],
                                    snapshot.data[posicion]['ID_Pace_Pen'])
                                .then((value) => _pullListRefresh());
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () {
                            Actividades.actualizar(
                                    Databases.siteground_database_reghosp,
                                    Pendientes.pendientes['updateDoQuery'],
                                    [
                                      Dicotomicos.fromBoolean(false,
                                          toInt: true),
                                      snapshot.data[posicion]['ID_Pace_Pen']
                                    ],
                                    snapshot.data[posicion]['ID_Pace_Pen'])
                                .then((value) => _pullListRefresh());
                          },
                        ),
                  // const SizedBox(
                  //   height: 30,
                  // ),
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
                  Text(
                    snapshot.data[posicion]['Feca_PEN'].toString(),
                    style: Styles.textSyleGrowth(fontSize: 18),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    snapshot.data[posicion]['Pace_PEN'].toString(),
                    style: Styles.textSyleGrowth(fontSize: 16),
                    textAlign: TextAlign.start,
                  ),
                  const CrossLine(),
                  Text(
                    snapshot.data[posicion]['Pace_Desc_PEN'].toString(),
                    maxLines: 7,
                    style: Styles.textSyle,
                    textAlign: TextAlign.start,
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
      BuildContext context, String operaciones) {
    Pendientes.Pendiente = snapshot.data[posicion];
    // Pendientes.selectedDiagnosis = Pendientes.pendientes['Pace_APP_ALE'];
    Pacientes.Pendiente = snapshot.data;
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
          Databases.siteground_database_reghosp,
          Pendientes.pendientes['deleteQuery'],
          snapshot.data[posicion]['ID_Pace_Pen']);
      setState(() {
        snapshot.data.removeAt(posicion);
      });
    } finally {
      Navigator.of(context).pop();
    }
  }

  void toOperaciones(BuildContext context, String operationActivity) {
    if (isDesktop(context)) {
      Constantes.operationsActividad = operationActivity;
      Constantes.reinit(value: foundedItems!);
      _pullListRefresh();
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => OperacionesPendiente(
                operationActivity: operationActivity,
              )));
    }
  }

  void _runFilterSearch(String enteredKeyword) {
    List? results = [];

    if (enteredKeyword.isEmpty) {
      _pullListRefresh();
    } else {
      Actividades.consultar(
              Databases.siteground_database_reghosp, consultQuery!)
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
            pageBuilder: (a, b, c) => GestionPendiente(
                  actualSidePage: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(),
                    // OperacionesPendiente(
                    //   operationActivity: Constantes.operationsActividad,
                    // ),
                  ),
                ),
            transitionDuration: const Duration(seconds: 0)));
  }
}