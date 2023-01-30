import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/pacientes.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/ThreeLabelText.dart';
import 'package:assistant/widgets/WidgetsModels.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// # Clase .dart para la creación predeterminada de interfaces de registro, consulta y actualización.
// Contiene un botón que enn _OperacionesHospitalizacionesState.build que desplega una ventana emergente,
// de la cual es posible elegir desde un catálogo de opciones.
// # # INSTRUCCIONES DE USO
// # # # Reemplazar .Hospitalizaciones por el valor
// # # # Reemplazar Hospitalizaciones. por la clase que contiene el mapa .hospitalizacion con las claves
// # # # # consultIdQuery
// # # # # registerQuery
// # # # # updateQuery
// # # # Reemplazar .hospitalizacion por el nombre del Map() correspondiente.
//
class OperacionesHospitalizaciones extends StatefulWidget {
  String? operationActivity;

  String _operationButton = 'Nulo';

  OperacionesHospitalizaciones(
      {Key? key, this.operationActivity = Constantes.Nulo})
      : super(key: key);

  @override
  State<OperacionesHospitalizaciones> createState() =>
      _OperacionesHospitalizacionesState();
}

class _OperacionesHospitalizacionesState
    extends State<OperacionesHospitalizaciones> {
  String appBarTitile = "Gestión de Hospitalizaciones";
  String? consultIdQuery = Hospitalizaciones.hospitalizacion['consultIdQuery'];
  String? registerQuery = Hospitalizaciones.hospitalizacion['registerQuery'];
  String? updateQuery = Hospitalizaciones.hospitalizacion['updateQuery'];

  int idOperation = 0;

  List<dynamic>? listOfValues;

  var fechaRealizacionTextController = TextEditingController();
  var isNumCama = Hospitalizaciones.actualDiagno[0];

  var fechaIngresoTextController = TextEditingController();
  var fechaEgresoTextController = TextEditingController();
  var diasEstanciaTextController = TextEditingController();
  var medicoTratanteTextController = TextEditingController();
  //
  var carouselController = CarouselController();

  var servicioTratanteValue;
  var servicioTratanteInicialValue;
  var motivoEgresoValue;
  //
  List<String> auxiliarServicios = [];

  @override
  void initState() {
    for (var element in Escalas.serviciosHospitalarios) {
      auxiliarServicios.add(element.toString());
    }

    servicioTratanteValue = auxiliarServicios[0];
    servicioTratanteInicialValue = auxiliarServicios[0];
    motivoEgresoValue = Escalas.motivosEgresos[0];
    //
    switch (widget.operationActivity) {
      case Constantes.Nulo:
        break;
      case Constantes.Consult:
        break;
      case Constantes.Register:
        widget._operationButton = 'Registrar';

        fechaIngresoTextController.text =
            Calendarios.today(format: 'yyyy/MM/dd');
        break;
      case Constantes.Update:
        setState(() {
          widget._operationButton = 'Actualizar';
          //
          idOperation = Hospitalizaciones
              .Hospitalizacion['ID_Hosp']; // Pacientes.ID_Hospitalizacion;
          fechaRealizacionTextController.text =
              Hospitalizaciones.Hospitalizacion['Feca_INI_Hosp'];
          isNumCama = Hospitalizaciones.Hospitalizacion['Id_Cama'].toString();

          fechaIngresoTextController.text =
              Hospitalizaciones.Hospitalizacion['Feca_INI_Hosp'].toString();
          fechaEgresoTextController.text =
              Hospitalizaciones.Hospitalizacion['Feca_EGE_Hosp'].toString();
          diasEstanciaTextController.text =
              Hospitalizaciones.Hospitalizacion['Dia_Estan'].toString();
          medicoTratanteTextController.text =
              Hospitalizaciones.Hospitalizacion['Medi_Trat'].toString();

          servicioTratanteValue =
              Hospitalizaciones.Hospitalizacion['Serve_Trat'].toString();
          servicioTratanteInicialValue =
              Hospitalizaciones.Hospitalizacion['Serve_Trat_INI'].toString();
          motivoEgresoValue =
              Hospitalizaciones.Hospitalizacion['EGE_Motivo'].toString();
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
        color: Colores.backgroundWidget,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: component(context),
                ),
              ),
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
      ThreeLabelTextAline(
          firstText: 'ID Hospitalización', secondText: idOperation.toString()),
      Spinner(
          tittle: "Número de Cama",
          onChangeValue: (String value) {
            setState(() {
              isNumCama = value;
            });
          },
          items: List<String>.generate(22, (i) => (i + 1).toString()),
          width: isTablet(context) || isMobile(context) ? 120 : 200,
          initialValue: isNumCama),
      const CrossLine(),
      Row(
        children: [
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(
                  mask: '####/##/##',
                  filter: {"#": RegExp(r'[0-9]')},
                  type: MaskAutoCompletionType.lazy),
              labelEditText: 'Fecha de Ingreso',
              textController: fechaIngresoTextController,
              withShowOption: true,
              selection: true,
              onSelected: () {
                fechaEgresoTextController.text = Calendarios.today(format: 'yyyy/MM/dd');
              },
              numOfLines: 1,
            ),
          ),
          Expanded(
            child: EditTextArea(
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(
                  mask: '####/##/##',
                  filter: {"#": RegExp(r'[0-9]')},
                  type: MaskAutoCompletionType.lazy),
              labelEditText: 'Fecha de Egreso',
              textController: fechaEgresoTextController,
              numOfLines: 1,
              withShowOption: true,
              selection: true,
              onSelected: () {
                fechaEgresoTextController.text = Calendarios.today(format: 'yyyy/MM/dd');
              },
            ),
          ),
        ],
      ),
      // const CrossLine(),
      //
      EditTextArea(
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '####',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        labelEditText: 'Días de Estancia Intrahospitalaria',
        textController: diasEstanciaTextController,
        numOfLines: 1,
      ),
      EditTextArea(
        keyBoardType: TextInputType.text,
        inputFormat: MaskTextInputFormatter(),
        labelEditText: 'Médico Tratante',
        textController: medicoTratanteTextController,
        numOfLines: 1,
      ),
      const CrossLine(),
      Spinner(
          tittle: "Servicio Tratante",
          onChangeValue: (String value) {
            setState(() {
              servicioTratanteValue = value;
            });
          },
          items: auxiliarServicios,
          width: isTablet(context) ? 200 :  isMobile(context) ? 120 : 200,
          initialValue: servicioTratanteValue),
      Spinner(
          tittle: "Servicio Que Inicia Tratamiento",
          onChangeValue: (String value) {
            setState(() {
              servicioTratanteInicialValue = value;
            });
          },
          items: auxiliarServicios,
          width: isTablet(context) ? 200 :  isMobile(context) ? 120 : 200,
          initialValue: servicioTratanteInicialValue),
      Spinner(
          tittle: "Motivo del Egreso",
          onChangeValue: (String value) {
            setState(() {
              motivoEgresoValue = value;
            });
          },
          items: Escalas.motivosEgresos,
          width: isTablet(context) ? 200 :  isMobile(context) ? 120 : 200,
          initialValue: motivoEgresoValue),
      const CrossLine(),
    ];
  }

  void operationMethod(BuildContext context) {
    try {
      listOfValues = [
        idOperation,
        Pacientes.ID_Paciente,
        fechaIngresoTextController.text,
        isNumCama,
        diasEstanciaTextController.text,
        medicoTratanteTextController.text,
        servicioTratanteValue,
        servicioTratanteInicialValue,
        fechaEgresoTextController.text,
        motivoEgresoValue,
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
                    Pacientes.Hospitalizaciones = value;
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
                    Pacientes.Hospitalizaciones = value;
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
                builder: (context) => GestionHospitalizaciones()));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
                // maintainState: false,
                builder: (context) => GestionHospitalizaciones()));
        break;
      default:
    }
  }
}

class GestionHospitalizaciones extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Pace_APP_ALE";
  // ****************** *** ****** **************

  GestionHospitalizaciones({Key? key, this.actualSidePage}) : super(key: key);

  @override
  State<GestionHospitalizaciones> createState() =>
      _GestionHospitalizacionesState();
}

class _GestionHospitalizacionesState extends State<GestionHospitalizaciones> {
  String appTittle = "Gestion de hospitalizaciones del paciente";
  String searchCriteria = "Buscar por Fecha";
  String? consultQuery = Hospitalizaciones.hospitalizacion['consultIdQuery'];

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
        print(" . . . Hospitalizaciones array iniciado");
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
                            "ID : ${snapshot.data[posicion]['ID_Hosp'].toString()}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 12),
                          ),
                          Text(
                            "${snapshot.data[posicion]['Feca_INI_Hosp']}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 14),
                          ),
                          Text(
                            "${snapshot.data[posicion]['Serve_Trat']}",
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
    Hospitalizaciones.Hospitalizacion = snapshot.data[posicion];
    // Hospitalizaciones.selectedDiagnosis = Hospitalizaciones.hospitalizacion['Pace_APP_ALE'];
    Pacientes.Hospitalizaciones = snapshot.data;
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
          Hospitalizaciones.hospitalizacion['deleteQuery'],
          snapshot.data[posicion]['ID_Hosp']);
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
          builder: (BuildContext context) => OperacionesHospitalizaciones(
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
            pageBuilder: (a, b, c) => GestionHospitalizaciones(
                  actualSidePage: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OperacionesHospitalizaciones(
                      operationActivity: Constantes.operationsActividad,
                    ),
                  ),
                ),
            transitionDuration: const Duration(seconds: 0)));
  }
}


