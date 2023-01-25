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
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/GridLayout.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:assistant/widgets/WidgetsModels.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';

// # Clase .dart para la creación predeterminada de interfaces de registro, consulta y actualización.
// Contiene un botón que enn _OperacionesVentilacionesState.build que desplega una ventana emergente,
// de la cual es posible elegir desde un catálogo de opciones.
// # # INSTRUCCIONES DE USO
// # # # Reemplazar .Ventilaciones por el valor
// # # # Reemplazar Ventilaciones. por la clase que contiene el mapa .ventilacion con las claves
// # # # # consultIdQuery
// # # # # registerQuery
// # # # # updateQuery
// # # # Reemplazar .ventilacion por el nombre del Map() correspondiente.
//
class OperacionesVentilaciones extends StatefulWidget {
  String? operationActivity;

  String _operationButton = 'Nulo';
  int actualView = 0;

  OperacionesVentilaciones({Key? key, this.operationActivity = Constantes.Nulo})
      : super(key: key);

  @override
  State<OperacionesVentilaciones> createState() =>
      _OperacionesVentilacionesState();
}

class _OperacionesVentilacionesState extends State<OperacionesVentilaciones> {
  String appBarTitile = "Gestión de Ventilaciones";
  String? consultIdQuery = Ventilaciones.ventilacion['consultIdQuery'];
  String? registerQuery = Ventilaciones.ventilacion['registerQuery'];
  String? updateQuery = Ventilaciones.ventilacion['updateQuery'];

  int idOperation = 0;

  List<dynamic>? listOfValues;

  var fechaRealizacionTextController = TextEditingController();
  String? modoVentilatorioValue = Ventilaciones.actualDiagno[0];

  var volTidalTextController = TextEditingController();
  var peepTextController = TextEditingController();
  var respTextController = TextEditingController();
  var fioTextController = TextEditingController();
  var sensInspTextController = TextEditingController();
  var sensEspTextController = TextEditingController();
  var viaOtrosIngresosTextController = TextEditingController();
  //
  var pControlTextController = TextEditingController();
  var pMaximaTextController = TextEditingController();
  var pPlatTextController = TextEditingController();
  var volTidalEspTextController = TextEditingController();
  var viaDreneTextController = TextEditingController();
  var flujoTextController = TextEditingController();
  var pInspirattoriaTextController = TextEditingController();
  var pSoporteTextController = TextEditingController();
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
        break;
      case Constantes.Update:
        setState(() {
          widget._operationButton = 'Actualizar';
          //
          idOperation = Ventilaciones.Ventilacion['ID_Ventilacion'];
          fechaRealizacionTextController.text =
              Ventilaciones.Ventilacion['Feca_VEN'];
          modoVentilatorioValue =
              Ventilaciones.Ventilacion['VM_Mod'].toString();
          //
          volTidalTextController.text =
              Ventilaciones.Ventilacion['Pace_Vt'].toString();
          peepTextController.text =
              Ventilaciones.Ventilacion['Pace_Peep'].toString();
          respTextController.text =
              Ventilaciones.Ventilacion['Pace_Fr'].toString();
          fioTextController.text =
              Ventilaciones.Ventilacion['Pace_Fio'].toString();
          sensInspTextController.text =
              Ventilaciones.Ventilacion['Pace_Insp'].toString();
          sensEspTextController.text =
              Ventilaciones.Ventilacion['Pace_Espi'].toString();
          viaOtrosIngresosTextController.text =
              Ventilaciones.Ventilacion['Pace_bala_ING'].toString();
          //
          pControlTextController.text =
              Ventilaciones.Ventilacion['Pace_Pc'].toString();
          pMaximaTextController.text =
              Ventilaciones.Ventilacion['Pace_Pm'].toString();
          volTidalEspTextController.text =
              Ventilaciones.Ventilacion['Pace_V'].toString();
          flujoTextController.text =
              Ventilaciones.Ventilacion['Pace_F'].toString();
          pSoporteTextController.text =
              Ventilaciones.Ventilacion['Pace_Ps'].toString();
          pPlatTextController.text =
              Ventilaciones.Ventilacion['Pace_Pmet'].toString();
          pInspirattoriaTextController.text =
              Ventilaciones.Ventilacion['Pace_Pip'].toString();

          selectModal();
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
          : isTabletAndDesktop(context)
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
                  ),
                  actions: isMobile(context)
                      ? <Widget>[
                          GrandIcon(
                            iconData: Icons.candlestick_chart,
                            labelButton: 'Análisis de Parámetros',
                            onPress: () {
                              Operadores.openActivity(context: context, chyldrim: const AnalisisVentilatorio());
                            },
                          ),
                        ]
                      : isTablet(context)
                          ? <Widget>[
                              GrandIcon(
                                iconData: Icons.candlestick_chart,
                                labelButton: 'Análisis de Parámetros',
                                onPress: () {
                                   Operadores.openActivity(context: context, chyldrim: const AnalisisVentilatorio());
                                },
                              ),
                            ]
                          : null,
                ),
      body: Container(
        color: const Color.fromARGB(255, 61, 57, 57),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: isTablet(context)
                  ? 2
                  : isDesktop(context)
                      ? 2
                      : isMobile(context)
                          ? 3
                          : 2,
              child: GridLayout(
                childAspectRatio: isDesktop(context)
                    ? 5.0
                    : isTablet(context)
                        ? 8.0
                        : isMobile(context)
                            ? 4.0
                            : 6.0,
                columnCount: isDesktop(context)
                    ? 2
                    : isTablet(context)
                        ? 1
                        : isMobile(context)
                            ? 1
                            : 2,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: EditTextArea(
                      keyBoardType: TextInputType.number,
                      inputFormat: TextFormat.dateFormat,
                      numOfLines: 1,
                      labelEditText: 'Fecha de realización',
                      textController: fechaRealizacionTextController,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Spinner(
                      width: isTablet(context)
                          ? 300
                          : isTabletAndDesktop(context)
                              ? 200
                              : isDesktop(context)
                                  ? 300
                                  : isMobile(context)
                                      ? 200
                                      : 200,
                      tittle: 'M. Ventilatorio',
                      onChangeValue: (value) {
                        setState(() {
                          modoVentilatorioValue = value;
                          selectModal();
                        });
                      },
                      items: Ventilaciones.actualDiagno,
                      initialValue: modoVentilatorioValue,
                    ),
                  ),
                  // GrandButton(
                  //     weigth: isMobile(context) ? 50 : 150,
                  //     labelButton: "Parámetros Ventilatorios",
                  //     onPress: () {
                  //       setState(() {
                  //         carouselController.jumpToPage(0);
                  //       });
                  //     }),
                  // GrandButton(
                  //     weigth: isMobile(context) ? 50 : 120,
                  //     labelButton: "Otros Parámetros",
                  //     onPress: () {
                  //       setState(() {
                  //         carouselController.jumpToPage(1);
                  //       });
                  //     })
                ],
              ),
            ),
            Expanded(
              flex: isTabletAndDesktop(context)
                  ? 9
                  : isDesktop(context)
                      ? 7
                      : isTablet(context)
                          ? 6
                          : 6,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                            controller: ScrollController(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: component(context),
                            ))),
                    Expanded(
                        child: SingleChildScrollView(
                            controller: ScrollController(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: getView(widget.actualView),
                            ))),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GrandButton(
                  labelButton: widget._operationButton,
                  onPress: () {
                    operationMethod(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  DeskTopView() {
    return Container();
  }

  MobileView() {
    return Container(
      child: CarouselSlider(
          items: [
            SingleChildScrollView(
                controller: ScrollController(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridLayout(
                    childAspectRatio: isMobile(context)
                        ? 5.0
                        : isTablet(context)
                            ? 6.0
                            : 4.0,
                    columnCount: isMobile(context)
                        ? 1
                        : isTablet(context)
                            ? 2
                            : 2,
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
                    children: component(context),
                  ),
                ))
          ],
          carouselController: carouselController,
          options: CarouselOptions(
              height: 500, enableInfiniteScroll: false, viewportFraction: 1.0)),
    );
  }

  List<Widget> getView(int actualView) {
    List<List<Widget>> list = [
      [const Text('Ninguna modalidad ventilatoria')],
      presionComponent(context),
      volumenComponent(context),
      intermitenteComponent(context),
      espontaneoComponent(context),
    ];
    return list[actualView];
  }

  List<Widget> component(BuildContext context) {
    return [
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.dateFormat,
        labelEditText: 'Vol. Tidal (mL)',
        textController: volTidalTextController,
        numOfLines: 1,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.dateFormat,
        labelEditText: 'P.E.E.P. (cmH2O)',
        textController: peepTextController,
        numOfLines: 1,
      ),
      const CrossLine(),
      //
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'F. Resp (Vent/min)',
        textController: respTextController,
        numOfLines: 1,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'FiO2 (%)',
        textController: fioTextController,
        numOfLines: 1,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Sens. Insp. (Seg)',
        textController: sensInspTextController,
        numOfLines: 1,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Sens. Esp. (Seg)',
        textController: sensEspTextController,
        numOfLines: 1,
      ),

      const CrossLine(),
    ];
  }

  List<Widget> presionComponent(BuildContext context) {
    return [
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Presión Control (mmHg)',
        textController: pControlTextController,
        numOfLines: 1,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Presión Máxima (mmHg)',
        textController: pMaximaTextController,
        numOfLines: 1,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Presión Platteu (mmHg)',
        textController: pPlatTextController,
        numOfLines: 1,
      ),
      const CrossLine(),
    ];
  }

  List<Widget> volumenComponent(BuildContext context) {
    return [
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Volumen Tidal Espiratorio (mL)',
        textController: volTidalEspTextController,
        numOfLines: 1,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Flujo (L/min)',
        textController: flujoTextController,
        numOfLines: 1,
      ),
      const CrossLine(),
    ];
  }

  List<Widget> intermitenteComponent(BuildContext context) {
    return [
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Presión Inspiratoria (mmHg)',
        textController: pInspirattoriaTextController,
        numOfLines: 1,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Volumen Tidal Espiratorio (mL)',
        textController: volTidalEspTextController,
        numOfLines: 1,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Presión Máxima (mmHg)',
        textController: pMaximaTextController,
        numOfLines: 1,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Flujo (L/min)',
        textController: flujoTextController,
        numOfLines: 1,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Presión Platteu (mmHg)',
        textController: pPlatTextController,
        numOfLines: 1,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Presión Soporte (mmHg)',
        textController: pSoporteTextController,
        numOfLines: 1,
      ),
      const CrossLine(),
    ];
  }

  List<Widget> espontaneoComponent(BuildContext context) {
    return [
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Presión Soporte (mmHg)',
        textController: pSoporteTextController,
        numOfLines: 1,
      ),
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: TextFormat.numberFourFormat,
        labelEditText: 'Presión Inspiratoria Pico (mmHg)',
        textController: pInspirattoriaTextController,
        numOfLines: 1,
      ),
      const CrossLine(),
    ];
  }

  void operationMethod(BuildContext context) {
    try {
      listOfValues = [
        idOperation,
        Pacientes.ID_Paciente,
        fechaRealizacionTextController.text,
        volTidalTextController.text,
        respTextController.text,
        fioTextController.text,
        peepTextController.text,
        sensInspTextController.text,
        sensEspTextController.text,
        //
        pControlTextController.text,
        pMaximaTextController.text,
        volTidalEspTextController.text,
        flujoTextController.text,
        pSoporteTextController.text,
        pInspirattoriaTextController.text,
        pPlatTextController.text,
        //
        modoVentilatorioValue,
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

  void selectModal() {
    int index = Ventilaciones.actualDiagno.indexOf(modoVentilatorioValue!);
    // print(index);
    switch (index) {
      case 1:
        widget.actualView = 1;
        break;
      case 2:
        widget.actualView = 2;
        break;
      case 3:
        widget.actualView = 3;
        break;
      case 4:
        widget.actualView = 3;
        break;
      case 5:
        widget.actualView = 4;
        break;
      case 6:
        widget.actualView = 4;
        break;
      default:
        widget.actualView = 0;
    }
    //
  }

  void onClose(BuildContext context) {
    switch (isMobile(context)) {
      case true:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionVentilaciones()));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionVentilaciones()));
        break;
      default:
    }
  }


}

class GestionVentilaciones extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Pace_APP_ALE";
  // ****************** *** ****** **************

  GestionVentilaciones({Key? key, this.actualSidePage}) : super(key: key);

  @override
  State<GestionVentilaciones> createState() => _GestionVentilacionesState();
}

class _GestionVentilacionesState extends State<GestionVentilaciones> {
  String appTittle =
      "Gestion de registros de parámetros ventilatorios del paciente";
  String searchCriteria = "Buscar por Fecha";
  String? consultQuery = Ventilaciones.ventilacion['consultIdQuery'];

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
        print(" . . . Ventilaciones array iniciado");
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
                  builder: (context) => VisualPacientes(actualPage: 6)));
            },
          ),
          title: Text(appTittle),
          actions: <Widget>[
            isTabletAndDesktop(context) ? GrandIcon(
              iconData: Icons.candlestick_chart,
              labelButton: 'Análisis de Parámetros',
              onPress: () {
                openActivity(AnalisisVentilatorio());
              },
            ) : isDesktop(context) ? GrandIcon(
              iconData: Icons.candlestick_chart,
              labelButton: 'Análisis de Parámetros',
              onPress: () {
                openActivity(AnalisisVentilatorio());
              },
            ) : Container(),
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
        isTabletAndDesktop(context)
            ? widget.actualSidePage != null
                ? Expanded(flex: 2, child: widget.actualSidePage!)
                : Expanded(flex: 1, child: Container())
            : isDesktop(context)
                ? widget.actualSidePage != null
                    ? Expanded(flex: 2, child: widget.actualSidePage!)
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
                            "ID : ${snapshot.data[posicion]['ID_Ventilacion'].toString()}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 12),
                          ),
                          Text(
                            "${snapshot.data[posicion]['Feca_VEN']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 14),
                          ),
                          Text(
                            "${snapshot.data[posicion]['VM_Mod']}",
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
    Ventilaciones.Ventilacion = snapshot.data[posicion];
    // Ventilaciones.selectedDiagnosis = Ventilaciones.ventilacion['Pace_APP_ALE'];
    Pacientes.Ventilaciones = snapshot.data;
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
          Ventilaciones.ventilacion['deleteQuery'],
          snapshot.data[posicion]['ID_Ventilacion']);
      setState(() {
        snapshot.data.removeAt(posicion);
      });
    } finally {
      Navigator.of(context).pop();
    }
  }

  void toOperaciones(BuildContext context, String operationActivity) {
    if (isTabletAndDesktop(context) || isDesktop(context)) {
      Constantes.operationsActividad = operationActivity;
      Constantes.reinit(value: foundedItems!);
      _pullListRefresh();
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => OperacionesVentilaciones(
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
            pageBuilder: (a, b, c) => GestionVentilaciones(
                  actualSidePage: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OperacionesVentilaciones(
                      operationActivity: Constantes.operationsActividad,
                    ),
                  ),
                ),
            transitionDuration: const Duration(seconds: 0)));
  }

  void openActivity(chyldrim) {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          return Dialog(
              backgroundColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: chyldrim),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: Colors.grey,
                          )),
                      child: GrandButton(
                        labelButton: 'Cerrar',
                        onPress: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}

class AnalisisVentilatorio extends StatefulWidget {
  const AnalisisVentilatorio({Key? key}) : super(key: key);

  @override
  State<AnalisisVentilatorio> createState() => _AnalisisVentilatorioState();
}

class _AnalisisVentilatorioState extends State<AnalisisVentilatorio> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TittlePanel(textPanel: 'Análisis Ventilatorio')
    ],);
  }
}
