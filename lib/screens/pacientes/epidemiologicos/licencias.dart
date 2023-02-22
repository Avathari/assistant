import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
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
// Contiene un botón que enn _OperacionesLicenciaState.build que desplega una ventana emergente,
// de la cual es posible elegir desde un catálogo de opciones.
// # # INSTRUCCIONES DE USO
// # # # Reemplazar .Licencia por el valor
// # # # Reemplazar Licencias. por la clase que contiene el mapa .pendiente con las claves
// # # # # consultIdQuery
// # # # # registerQuery
// # # # # updateQuery
// # # # Reemplazar .pendiente por el nombre del Map() correspondiente.
//
// ignore: must_be_immutable
class OperacionesLicencia extends StatefulWidget {
  String? operationActivity;

  String _operationButton = 'Nulo';

  OperacionesLicencia({Key? key, this.operationActivity = Constantes.Nulo})
      : super(key: key);

  @override
  State<OperacionesLicencia> createState() => _OperacionesLicenciaState();
}

class _OperacionesLicenciaState extends State<OperacionesLicencia> {
  String appBarTitile = "Gestión de Licencias";
  String? consultIdQuery = Licencias.vicencia['consultIdQuery'];
  String? registerQuery = Licencias.vicencia['registerQuery'];
  String? updateQuery = Licencias.vicencia['updateQuery'];

  int idOperation = 0; // diasOtorgados = 0;

  List<dynamic>? listOfValues;

  var fechaRealizacionTextController = TextEditingController();
  //
  var folioLicenciaTextController = TextEditingController();
  var diasOtorgadosTextController = TextEditingController();
  var fechaInicioTextController = TextEditingController();
  var fechaTerminoTextController = TextEditingController();
  var motivoValue = Licencias.typesLicencias[0];
  var caracterValue = Licencias.caracterLicencia[0];
  var expedicionValue  = Licencias.lugarExpedicion[0];
  var diagnosticoLicenciaTextController = TextEditingController();
  // var descripcionLicenciaTextController = TextEditingController();
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
        fechaInicioTextController.text = f.format(DateTime.now());

        break;
      case Constantes.Update:
        setState(() {
          widget._operationButton = 'Actualizar';
          //
          idOperation = Licencias.Licencia['ID_Licen_Med'];
          fechaRealizacionTextController.text = Licencias.Licencia['Fecha_Realizacion'];
          //
          folioLicenciaTextController.text = Licencias.Licencia['Folio'];
          diasOtorgadosTextController.text = Licencias.Licencia['Dias_Otorgados'].toString();
          fechaInicioTextController.text = Licencias.Licencia['Fecha_Inicio'];
          fechaTerminoTextController.text = Licencias.Licencia['Fecha_Termino'];
          motivoValue = Licencias.Licencia['Motivo_Incapacidad'];
          caracterValue = Licencias.Licencia['Caracter'];
          expedicionValue = Licencias.Licencia['Lugar_Expedicion'];
          diagnosticoLicenciaTextController.text = Licencias.Licencia['Diagnos_Expedicion'];

          // descripcionLicenciaTextController.text =
          //     Licencias.Licencia['Pace_Desc_PEN'].toString();
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
      appBar: isDesktop(context) || isTabletAndDesktop(context)
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
            child: EditTextArea(
              keyBoardType: TextInputType.text,
              inputFormat: MaskTextInputFormatter(
                  // mask: '####',
                  // filter: {"#": RegExp(r'[0-9]')},
                  // type: MaskAutoCompletionType.lazy
                  ),
              labelEditText: 'Folio del Licencia',
              textController: folioLicenciaTextController,
              numOfLines: 1,
            ),
          ),
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(
                  mask: '##',
                  filter: {"#": RegExp(r'[0-9]')},
                  type: MaskAutoCompletionType.lazy),
              labelEditText: 'Dias Otorgados',
              textController: diasOtorgadosTextController,
              numOfLines: 1,
              onChange: (value) {
                setState(() {
                  try {
                    DateFormat dateFormat = DateFormat("yyyy-MM-dd"); // how you want it to be formatted
                    fechaTerminoTextController
                        .text = dateFormat.format(DateTime.parse(fechaInicioTextController.text)
                        .add(Duration(
                        days:
                        int.parse(value) - 1)));
                  } on Exception {
                    // TODO
                  }
                });
              },
            ),
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(
                  mask: '####/##/##',
                  filter: {"#": RegExp(r'[0-9]')},
                  type: MaskAutoCompletionType.lazy),
              labelEditText: 'Fecha de Inicio de la Licencia',
              textController: fechaInicioTextController,
              numOfLines: 1,
              onChange: (value) {
                setState(() {
                  diasOtorgadosTextController.text =
                      DateTime.parse(fechaTerminoTextController.text)
                          .difference(
                              DateTime.parse(fechaInicioTextController.text))
                          .inDays.toString();
                });
              },
            ),
          ),
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.text,
              inputFormat: MaskTextInputFormatter(
                  mask: '####/##/##',
                  filter: {"#": RegExp(r'[0-9]')},
                  type: MaskAutoCompletionType.lazy),
              labelEditText: 'Fecha de Termino de la Licencia',
              textController: fechaTerminoTextController,
              numOfLines: 1,
              onChange: (value) {
                setState(() {
                  diasOtorgadosTextController.text =
                      DateTime.parse(fechaTerminoTextController.text)
                          .difference(
                              DateTime.parse(fechaInicioTextController.text))
                          .inDays.toString();
                });
              },
            ),
          ),
        ],
      ),
      Spinner(
          width: isDesktop(context)
              ? 200
              : isTabletAndDesktop(context)
                  ? 130
                  : isTablet(context)
                      ? 200
                      : isMobile(context)
                          ? 100
                          : 200,
          tittle: "Tipo de Licencia",
          onChangeValue: (String value) {
            setState(() {
              motivoValue = value;
            });
          },
          items: Licencias.typesLicencias,
          initialValue: motivoValue),
      Spinner(
          width: isDesktop(context)
              ? 200
              : isTabletAndDesktop(context)
                  ? 130
                  : isTablet(context)
                      ? 200
                      : isMobile(context)
                          ? 100
                          : 200,
          tittle: "Carácter de Licencia",
          onChangeValue: (String value) {
            setState(() {
              caracterValue = value;
            });
          },
          items: Licencias.caracterLicencia,
          initialValue: caracterValue),
      const CrossLine(),
      Spinner(
          width: isDesktop(context)
              ? 200
              : isTabletAndDesktop(context)
              ? 130
              : isTablet(context)
              ? 200
              : isMobile(context)
              ? 100
              : 200,
          tittle: "Lugar de Expedición",
          onChangeValue: (String value) {
            setState(() {
              expedicionValue = value;
            });
          },
          items: Licencias.lugarExpedicion,
          initialValue: expedicionValue),
      const CrossLine(),
      EditTextArea(
          textController: diagnosticoLicenciaTextController,
          labelEditText: "Diagnóstico",
          keyBoardType: TextInputType.text,
          numOfLines: 1,
          withShowOption: true,
          selection: true,
          onSelected: () {
            Operadores.selectOptionsActivity(
                context: context,
                tittle: 'Seleccione un diagnóstico . . . ',
                options: Pacientes.diagnosticos().split("\n"),
                onClose: (value) {
                  setState(() {
                    Valores.diagnosticoLicencia = value;
                    diagnosticoLicenciaTextController.text = value;
                  });
                  Navigator.of(context).pop();
                });
          },
          onChange: (value) {
            setState(() {
              Valores.motivoCirugia = value;
              Reportes.reportes['Motivo_Prequirurgico'] = Pacientes.motivoPrequirurgico();
            });
          },
          inputFormat: MaskTextInputFormatter()),
    ];
  }

  void operationMethod(BuildContext context) {
    try {
      listOfValues = [
        idOperation,
        Pacientes.ID_Paciente,
        folioLicenciaTextController.text,
        diasOtorgadosTextController.text,
        fechaRealizacionTextController.text,
        fechaInicioTextController.text,
        fechaTerminoTextController.text,
        //
        motivoValue,
        caracterValue,
        expedicionValue,
        //
        diagnosticoLicenciaTextController.text,
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
                builder: (context) => GestionLicencia()));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionLicencia()));
        break;
      default:
    }
  }
}

// ignore: must_be_immutable
class GestionLicencia extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Feca_PEN";
  // ****************** *** ****** **************

  GestionLicencia({Key? key, this.actualSidePage}) : super(key: key);

  @override
  State<GestionLicencia> createState() => _GestionLicenciaState();
}

class _GestionLicenciaState extends State<GestionLicencia> {
  String appTittle = "Gestion de vicencia del paciente";
  String searchCriteria = "Buscar por Fecha";
  String? consultQuery = Licencias.vicencia['consultIdQuery'];

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
        print(" . . . Licencia array iniciado");
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
        isDesktop(context) || isTabletAndDesktop(context)
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
                      snapshot.data[posicion]['ID_Licen_Med'].toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 24),
                    ),
                  ),
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
                      snapshot.data[posicion]['Fecha_Realizacion'].toString(),
                      style: Styles.textSyleGrowth(fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      snapshot.data[posicion]['Folio'].toString(),
                      style: Styles.textSyleGrowth(fontSize: 16),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const Expanded(child: CrossLine()),
                  Expanded(
                    child: Text(
                      snapshot.data[posicion]['Fecha_Inicio'].toString(),
                      maxLines: 1,
                      style: Styles.textSyle,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      snapshot.data[posicion]['Fecha_Termino'].toString(),
                      maxLines: 1,
                      style: Styles.textSyle,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      snapshot.data[posicion]['Motivo_Incapacidad'].toString(),
                      maxLines: 1,
                      style: Styles.textSyle,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${snapshot.data[posicion]['Dias_Otorgados'].toString()} Días Otorgados",
                      maxLines: 1,
                      style: Styles.textSyleGrowth(fontSize: 10),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Carácter ${snapshot.data[posicion]['Caracter'].toString()}",
                      maxLines: 1,
                      style: Styles.textSyleGrowth(fontSize: 10),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      snapshot.data[posicion]['Lugar_Expedicion'].toString(),
                      maxLines: 1,
                      style: Styles.textSyleGrowth(fontSize: 10),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      snapshot.data[posicion]['Diagnos_Expedicion'].toString(),
                      maxLines: 1,
                      style: Styles.textSyleGrowth(fontSize: 10),
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
    Licencias.Licencia = snapshot.data[posicion];
    // Licencias.selectedDiagnosis = Licencias.vicencia['Pace_APP_ALE'];
    Pacientes.Licencias = snapshot.data;
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
          Licencias.vicencia['deleteQuery'],
          snapshot.data[posicion]['ID_Licen_Med']);
      setState(() {
        snapshot.data.removeAt(posicion);
      });
    } finally {
      Navigator.of(context).pop();
    }
  }

  void toOperaciones(BuildContext context, String operationActivity) {
    if (isDesktop(context) || isTabletAndDesktop(context)) {
      Constantes.operationsActividad = operationActivity;
      Constantes.reinit(value: foundedItems!);
      _pullListRefresh();
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => OperacionesLicencia(
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
            pageBuilder: (a, b, c) => GestionLicencia(
                  actualSidePage: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OperacionesLicencia(
                      operationActivity: Constantes.operationsActividad,
                    ),
                  ),
                ),
            transitionDuration: const Duration(seconds: 0)));
  }
}
