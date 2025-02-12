import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/screens/pacientes/auxiliares/hospitalarios/hospitalizados.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CircleSwitched.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
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
// ignore: must_be_immutable
class OperacionesPendiente extends StatefulWidget {
  String? operationActivity;

  bool? withReturn;
  String _operationButton = 'Nulo';

  OperacionesPendiente(
      {super.key,
      this.withReturn = false,
      this.operationActivity = Constantes.Nulo});

  @override
  State<OperacionesPendiente> createState() => _OperacionesPendienteState();
}

class _OperacionesPendienteState extends State<OperacionesPendiente> {
  int index = 0, secondIndex = 0;
  late List _pendientesList = [];

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
          //
          pendienteValue = Pendientes.Pendiente['Pace_PEN'].toString();
          //
          index = Pendientes.typesPendientes.indexOf(pendienteValue);
          subPendienteValue = Pendientes.subTypesPendientes[index][0];
          //
          subPendienteValue = Pendientes.Pendiente['Pace_Desc_PEN'].toString();

          descripcionPendienteTextController.text =
              Pendientes.Pendiente['Pace_Commen_PEN'].toString();
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
      appBar: !isDesktop(context) && !isLargeDesktop(context)
          ? AppBar(
              foregroundColor: Colors.white,
              backgroundColor: Theming.primaryColor,
              title: AppBarText(appBarTitile),
              leading: IconButton(
                color: Colors.white,
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
              withShowOption: true,
              selection: true,
              onSelected: () async {
                  //
                    final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2055),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                              data: ThemeData.dark().copyWith(
                                  dialogBackgroundColor: Theming.cuaternaryColor),
                              child: child!);
                        });
                    if (picked != null) {
                      setState(() {
                        fechaRealizacionTextController.text = DateFormat("yyyy/MM/dd").format(picked);
                      });
                    }

                },
              // onSelected: () => setState(() => fechaRealizacionTextController
              //     .text = Calendarios.today(format: "yyyy/MM/dd"),
              // ),
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

  // Actividades de Inicio *********************
  Future<void> reiniciar() async {
    Terminal.printExpected(message: "Reinicio de los valores . . .");

    Pacientes.Pendiente!.clear();
    Actividades.consultarAllById(
            Databases.siteground_database_reghosp,
            Pendientes.pendientes['consultByIdPrimaryQuery'],
            Pacientes.ID_Paciente)
        .then((value) {
      setState(() {
        Pacientes.Pendiente = value;
        Terminal.printSuccess(
            message:
                "Actualizando Repositorio de Pendientes de la Hospitalización . . . ${Pacientes.Pendiente}");

        Archivos.createJsonFromMap(Pacientes.Pendiente!,
            filePath: Pendientes.fileAssocieted);
      });
    });
  }

  // Actividades de la Intefaz *********************
  List<Widget> component(BuildContext context) {
    return [
      Row(
        children: [
          Expanded(
            flex: isTabletAndDesktop(context) ? 2 : 1,
            child: CircleSwitched(
              tittle: "¿Realizado?",
              isSwitched: realized,
              onChangeValue: (value) {
                setState(() {
                  realized = !value;

                  if (realized!) {
                    fechaRealizacionTextController.text =
                        DateFormat('yyyy-MM-dd').format(DateTime.now());
                  } else {
                    fechaRealizacionTextController.text = "0000-00-00";
                  }
                });
              },
            ),
          ),
          Expanded(
            flex: isTabletAndDesktop(context) ? 3 : 2,
            child: Spinner(
                width: isDesktop(context)
                    ? 150
                    : isTabletAndDesktop(context)
                        ? 130
                        : isTablet(context)
                            ? 200
                            : isMobile(context)
                                ? 100
                                : 200,
                tittle: "Tipo de Pendiente",
                onChangeValue: (String newValue) {
                  setState(() {
                    pendienteValue = newValue;
                    //
                    index = Pendientes.typesPendientes.indexOf(newValue);
                    subPendienteValue = Pendientes.subTypesPendientes[index][0];
                    //
                    descripcionPendienteTextController.text = "";
                  });
                },
                items: Pendientes.typesPendientes,
                initialValue: pendienteValue),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Spinner(
          tittle: " . . . Incidencias",
          onChangeValue: (String newValue) {
            setState(() {
              subPendienteValue = newValue;
              //
              _pendientesList.add(newValue);
              //
              descripcionPendienteTextController.text =
                  Listas.stringFromList(listValues: _pendientesList);
            });
          },
          items: Pendientes.subTypesPendientes[index],
          initialValue: subPendienteValue),
      CrossLine(
        height: 10,
      ),
      EditTextArea(
        keyBoardType: TextInputType.multiline,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Descripción del Pendiente',
        textController: descripcionPendienteTextController,
        numOfLines: 7,
        iconData: Icons.list_outlined,
        selection: true,
        withShowOption: true,
        onSelected: () {
          Operadores.selectOptionsActivity(
              context: context,
              options: Pendientes.subTypesPendientes[
                  Pendientes.typesPendientes.indexOf(pendienteValue)],
              onClose: (String value) {
                if (descripcionPendienteTextController.text.isEmpty) {
                  descripcionPendienteTextController.text = value;
                } else {
                  descripcionPendienteTextController.text =
                      "${descripcionPendienteTextController.text}, \n$value";
                }
                Navigator.pop(context);
              });
        },
        onChange: (value) {
          setState(() {
            _pendientesList = Listas.traslateFromString(value);
          });
        },
      ),
      CrossLine(),
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
        subPendienteValue,
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
          listOfValues!.removeLast();
          // ******************************************** *** *
          Actividades.registrar(Databases.siteground_database_reghosp,
                  registerQuery!, listOfValues!)
              .then((value) {
            Archivos.deleteFile(filePath: Pendientes.fileAssocieted);
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
            Archivos.deleteFile(filePath: Pendientes.fileAssocieted);
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
    Constantes.reinit();

    switch (isMobile(context)) {
      case true:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionPendiente(
                      withReturn: widget.withReturn,
                    )));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) =>
                    GestionPendiente(withReturn: widget.withReturn)));
        break;
      default:
    }
  }

  // VARIABLES ******************************************7
  String appBarTitile = "Gestión de Pendientes";
  String? consultIdQuery = Pendientes.pendientes['consultIdQuery'];
  String? registerQuery = Pendientes.pendientes['registerQuery'];
  String? updateQuery = Pendientes.pendientes['updateQuery'];

  int idOperation = 0;

  List<dynamic>? listOfValues;

  var fechaRealizacionTextController = TextEditingController();
  bool? realized = false;
  //
  var pendienteValue = Pendientes.typesPendientes[0], subPendienteValue;
  var descripcionPendienteTextController = TextEditingController();
  //
  var carouselController = CarouselSliderController();
//
}

// ignore: must_be_immutable
class GestionPendiente extends StatefulWidget {
  Widget? actualSidePage = Container();
  bool? withReturn;
  // ****************** *** ****** **************
  var keySearch = "Feca_PEN";

  String? tipePendiente = Pendientes.typesPendientes[0];
  // ****************** *** ****** **************

  GestionPendiente({super.key, this.actualSidePage, this.withReturn = false});

  @override
  State<GestionPendiente> createState() => _GestionPendienteState();
}

class _GestionPendienteState extends State<GestionPendiente> {
  var fileAssocieted = Pendientes.fileAssocieted;

  @override
  void initState() {
    if (widget.withReturn!) {
      reiniciar();
    } else {
      iniciar();
    }

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
              if (widget.withReturn == true) {
                Constantes.reinit();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Hospitalizados()));
              } else {
                Constantes.reinit();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VisualPacientes(actualPage: 0)));
              }
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Expanded(child: Spinner(
                  tittle: "Tipo de Procedimiento . . . ",
                  onChangeValue: (String value) {
                    setState(() {
                      widget.tipePendiente = value;
                      //
                      foundedItems = _previos;
                      //
                      foundedItems = Listas.listFromMap(lista: foundedItems!, keySearched: 'Pace_PEN', elementSearched: value);
                    });
                }, items: Pendientes.typesPendientes, initialValue: widget.tipePendiente!,)),
                Expanded(
                  flex: 8,
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
                                    mainAxisExtent: isMobile(context) ? 200 : 250),
                                controller: gestionScrollController,
                                shrinkWrap: isMobile(context) ? false : true,
                                itemCount:
                                    snapshot.data == null ? 0 : snapshot.data.length,
                                itemBuilder: (context, posicion) {
                                  return itemListView(snapshot, posicion, context);
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
          isDesktop(context) || isLargeDesktop(context) // || isTablet(context)
              ? widget.actualSidePage != null
                  ? Expanded(flex: 5, child: widget.actualSidePage!)
                  : Expanded(flex: 1, child: Container())
              : Container()
        ]),
      ),
    );
  }

  // Operaciones de Inicio ***** ******* ********** ****
  void iniciar() {
    Terminal.printWarning(
        message:
            " . . . Iniciando Actividad - Repositorio de Pendientes de la Hospitalización");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        foundedItems = _previos = value;
        Terminal.printSuccess(
            message: "Repositorio de Pendientes de la Hospitalización");
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
        foundedItems = _previos = value;
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
        padding: const EdgeInsets.all(12.0),
        decoration: ContainerDecoration.roundedDecoration(),
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
                  Expanded(
                    child: Text(
                      snapshot.data[posicion]['Feca_PEN'].toString(),
                      style: Styles.textSyleGrowth(fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      snapshot.data[posicion]['Pace_PEN'].toString(),
                      style: Styles.textSyleGrowth(fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(child: CrossLine()),
                  Expanded(
                    flex: 4,
                    child: Text(
                      snapshot.data[posicion]['Pace_Desc_PEN'].toString(),
                      maxLines: 7,
                      style: Styles.textSyle,
                      textAlign: TextAlign.start,
                    ),
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
    Actividades.eliminar(
            Databases.siteground_database_reghosp,
            Pendientes.pendientes['deleteQuery'],
            snapshot.data[posicion]['ID_Pace_Pen'])
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
    if (isDesktop(context) || isLargeDesktop(context)) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => GestionPendiente(
              withReturn: widget.withReturn,
              actualSidePage: OperacionesPendiente(
                withReturn: widget.withReturn ?? false,
                operationActivity: operationActivity,
              ))));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => OperacionesPendiente(
                withReturn: widget.withReturn ?? false,
                operationActivity: operationActivity,
              )));
    }
  }

// Operaciones de Búsqueda ***** ******* ********** ****
  Future<Null> _pullListRefresh() async {
    iniciar();
  }

  // VARIABLES DE LA INTERFAZ ***** ******* ********** ****
  String appTittle = "Gestion de pendientes del paciente";
  String searchCriteria = "Buscar por Fecha";
  String? consultQuery = Pendientes.pendientes['consultIdQuery'];

  late List? foundedItems = [], _previos = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  //  void _runFilterSearch(String enteredKeyword) {
//     List? results = [];
//
//     if (enteredKeyword.isEmpty) {
//       _pullListRefresh();
//     } else {
//       results = Listas.listFromMap(
//           lista: foundedItems!,
//           keySearched: widget.keySearch,
//           elementSearched: enteredKeyword);
//
//       setState(() {
//         foundedItems = results;
//       });
//     }
//   }
}
