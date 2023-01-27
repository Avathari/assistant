import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/pacientes.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GridLayout.dart';
import 'package:assistant/widgets/Spinner.dart';
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
        setState(() {
          widget._operationButton = 'Actualizar';
          //
          idOperation = Pendientes.Pendiente['ID_Pace_Pen'];
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
      body: Card(
        color: const Color.fromARGB(255, 61, 57, 57),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              editFormattedText(
                  TextInputType.number,
                  MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  false,
                  'Fecha de realización',
                  fechaRealizacionTextController,
                  false),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     GrandButton(
              //         weigth: isMobile(context) ? 50 : 200,
              //         labelButton: "Ingresos",
              //         onPress: () {
              //           setState(() {
              //             carouselController.jumpToPage(0);
              //           });
              //         }),
              //     GrandButton(
              //         weigth: isMobile(context) ? 50 : 200,
              //         labelButton: "Egresos",
              //         onPress: () {
              //           setState(() {
              //             carouselController.jumpToPage(1);
              //           });
              //         })
              //   ],
              // ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CarouselSlider(
                            items: [
                              SingleChildScrollView(
                                  controller: ScrollController(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GridLayout(
                                      childAspectRatio: isMobile(context)
                                          ? 2.0
                                          : isTablet(context)
                                              ? 5.0
                                              : 7.0,
                                      columnCount: isMobile(context)
                                          ? 1
                                          : isTablet(context)
                                              ? 1
                                              : 1,
                                      children: component(context),
                                    ),
                                  )),
                              SingleChildScrollView(
                                  controller: ScrollController(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GridLayout(
                                      childAspectRatio: isMobile(context)
                                          ? 5
                                          : isTablet(context)
                                              ? 6.0
                                              : 5.0,
                                      columnCount: isMobile(context)
                                          ? 1
                                          : isTablet(context)
                                              ? 2
                                              : 2,
                                      children: secondComponent(context),
                                    ),
                                  ))
                            ],
                            carouselController: carouselController,
                            options: CarouselOptions(
                                height: 500,
                                enableInfiniteScroll: false,
                                viewportFraction: 1.0)),
                      ),
                    ],
                  ),
                ),
              ),
              grandButton(context, widget._operationButton, () {
                operationMethod(context);
              })
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> component(BuildContext context) {
    return [
      Spinner(
          width: isDesktop(context)
              ? 400
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

  List<Widget> secondComponent(BuildContext context) {
    return [
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
        pendienteValue,
        descripcionPendienteTextController.text,
        //
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

class GestionPendiente extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Pace_APP_ALE";
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
                consultQuery!, Pacientes.ID_Paciente)
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
                            "ID : ${snapshot.data[posicion]['ID_Pace_Pen'].toString()}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 12),
                          ),
                          Text(
                            "${snapshot.data[posicion]['Feca_PEN']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 14),
                          ),
                          Text(
                            "${snapshot.data[posicion]['Pace_PEN']}",
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
      Actividades.eliminar(Databases.siteground_database_reghosp,
          Pendientes.pendientes['deleteQuery'], snapshot.data[posicion]['ID_Pace_Pen']);
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
                    child: OperacionesPendiente(
                      operationActivity: Constantes.operationsActividad,
                    ),
                  ),
                ),
            transitionDuration: const Duration(seconds: 0)));
  }
}
