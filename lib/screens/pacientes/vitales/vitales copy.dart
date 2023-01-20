import 'dart:convert';

import 'package:assistant/conexiones/usuarios/Pacientes.dart';
import 'package:assistant/screens/pacientes/pacientes.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/WidgetsModels.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../conexiones/conexiones.dart';

class OperacionesVitales extends StatefulWidget {
  final String operationActivity;

  String _operationButton = 'Nulo';

  OperacionesVitales({Key? key, required this.operationActivity})
      : super(key: key);

  @override
  State<OperacionesVitales> createState() => _OperacionesVitalesState();
}

class _OperacionesVitalesState extends State<OperacionesVitales> {
  String? consultIdQuery = Vitales.antropo['consultIdQuery'];
  String? registerQuery = Vitales.vitales['registerQuery'];
  String? updateQuery = Vitales.vitales['updateQuery'];

  int idOperation = 0;

  List<dynamic>? listOfValues;

  String appBarTitile = "Gestión de Vitales";

  var fechaRealizacionTextController = TextEditingController();
  var tasTextController = TextEditingController();
  var tadTextController = TextEditingController();
  var fcTextController = TextEditingController();
  var frTextController = TextEditingController();
  var tcTextController = TextEditingController();
  var spoTextController = TextEditingController();
  var estTextController = TextEditingController();
  var pctTextController = TextEditingController();
  var gluTextController = TextEditingController();
  var gluAyuTextController = TextEditingController();
  //
  var cueTextController = TextEditingController();
  var cinTextController = TextEditingController();
  var cadTextController = TextEditingController();
  var cmbTextController = TextEditingController();

  String factorActividadValue = Vitales.factorActividad[0];
  String factorEstresValue = Vitales.factorEstres[0];

  var pectTextController = TextEditingController();
  var pcbTextController = TextEditingController();
  var pseTextController = TextEditingController();
  var psiTextController = TextEditingController();
  var pstTextController = TextEditingController();

  var femIzqTextController = TextEditingController();
  var femDerTextController = TextEditingController();
  var suroIzqTextController = TextEditingController();
  var suroDerTextController = TextEditingController();

  var antropoScroller = ScrollController();
  var vitalesScroller = ScrollController();

  @override
  void initState() {
    switch (widget.operationActivity) {
      case Constantes.Nulo:
        break;
      case Constantes.Consult:
        break;
      case Constantes.Register:
        widget._operationButton = 'Registrar';

        break;
      case Constantes.Update:
        Actividades.consultarId(Databases.siteground_database_regpace,
                consultIdQuery!, Vitales.ID_Vitales)
            .then((value) {
          setState(() {
            Pacientes.Vital.addAll(value);

            widget._operationButton = 'Actualizar';
            idOperation = Pacientes.Vital['ID_Pace_SV'];

            fechaRealizacionTextController.text =
                Pacientes.Vital['Pace_Feca_SV'].toString();
            tasTextController.text = Pacientes.Vital['Pace_SV_tas'].toString();
            tadTextController.text = Pacientes.Vital['Pace_SV_tad'].toString();
            fcTextController.text = Pacientes.Vital['Pace_SV_fc'].toString();
            frTextController.text = Pacientes.Vital['Pace_SV_fr'].toString();
            tcTextController.text = Pacientes.Vital['Pace_SV_tc'].toString();
            spoTextController.text = Pacientes.Vital['Pace_SV_spo'].toString();
            estTextController.text = Pacientes.Vital['Pace_SV_est'].toString();
            pctTextController.text = Pacientes.Vital['Pace_SV_pct'].toString();
            gluTextController.text = Pacientes.Vital['Pace_SV_glu'].toString();
            gluAyuTextController.text =
                Pacientes.Vital['Pace_SV_glu_ayu'].toString();
            //
            cueTextController.text = Pacientes.Vital['Pace_SV_cue'].toString();
            cinTextController.text = Pacientes.Vital['Pace_SV_cin'].toString();
            cadTextController.text = Pacientes.Vital['Pace_SV_cad'].toString();
            cmbTextController.text = Pacientes.Vital['Pace_SV_cmb'].toString();

            factorActividadValue = Pacientes.Vital['Pace_SV_fa'].toString();
            factorEstresValue = Pacientes.Vital['Pace_SV_fe'].toString();

            pectTextController.text =
                Pacientes.Vital['Pace_SV_c_pect'].toString();
            pcbTextController.text = Pacientes.Vital['Pace_SV_pcb'].toString();
            pseTextController.text = Pacientes.Vital['Pace_SV_pse'].toString();
            psiTextController.text = Pacientes.Vital['Pace_SV_psi'].toString();
            pstTextController.text = Pacientes.Vital['Pace_SV_pst'].toString();

            femIzqTextController.text =
                Pacientes.Vital['Pace_SV_c_fem_izq'].toString();
            femDerTextController.text =
                Pacientes.Vital['Pace_SV_c_fem_der'].toString();
            suroIzqTextController.text =
                Pacientes.Vital['Pace_SV_c_suro_izq'].toString();
            suroDerTextController.text =
                Pacientes.Vital['Pace_SV_c_suro_der'].toString();
          });
        });

        super.initState();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theming.primaryColor,
          title: Text(appBarTitile),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            tooltip: Sentences.regresar,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => isMobile(context)
                      ? const GestionVitales()
                      : VisualPacientes(actualPage: 0)));
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                            controller: vitalesScroller,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: component(context),
                                  )),
                            )),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                            controller: antropoScroller,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: secondComponent(context),
                                  )),
                            )),
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

  void returnGestion(BuildContext context) {
    switch (isMobile(context)) {
      case true:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const GestionVitales()));
        break;
      case false:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VisualPacientes(actualPage: 0)));
        break;
      default:
    }
  }

  List<Widget> component(BuildContext context) {
    return [
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Tensión arterial sistólica',
          tasTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Tensión arterial diastólica',
          tadTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Frecuencia cardiaca',
          fcTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Frecuencia respiratoria',
          frTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Temperatura corporal',
          tcTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Saturación periférica de oxígeno',
          spoTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Peso corporal total',
          pctTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Estatura (mts)',
          estTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Glucemia capilar',
          gluTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Horas de ayuno',
          gluAyuTextController,
          false),
    ];
  }

  List<Widget> secondComponent(BuildContext context) {
    return [
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Circunferencia cervical',
          cueTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Circunferencia cintura',
          cinTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Circunferencia cadera',
          cadTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Circunferencia medio braquial',
          cmbTextController,
          false),
      spinner(context, "Factor de actividad", factorActividadValue,
          Vitales.factorActividad, (String? newValue) {
        setState(() {
          factorActividadValue = newValue!;
        });
      }),
      spinner(
          context, "Factor de estrés", factorEstresValue, Vitales.factorEstres,
          (String? newValue) {
        setState(() {
          factorEstresValue = newValue!;
        });
      }),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Pliegue subcutáneo escapular',
          pseTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Pliegue subcutáneo iliaco',
          psiTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Pliegue subcutáneo tricipital',
          pstTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Circunferencia pectoral',
          pectTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Circunferencia femoral izquierdo',
          femIzqTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Circunferencia femoral derecho',
          femDerTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Circunferencia sural izquierda',
          suroIzqTextController,
          false),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Circunferencia sural derecho',
          suroDerTextController,
          false),
    ];
  }

  void operationMethod(BuildContext context) {
    try {
      listOfValues = [
        idOperation,
        fechaRealizacionTextController.text,
        tasTextController.text,
        tadTextController.text,
        fcTextController.text,
        frTextController.text,
        tcTextController.text,
        spoTextController.text,
        estTextController.text,
        pctTextController.text,
        gluTextController.text,
        gluAyuTextController.text,
        cueTextController.text,
        cinTextController.text,
        cadTextController.text,
        cmbTextController.text,
        pctTextController.text,
        factorActividadValue,
        factorEstresValue,
        pectTextController.text,
        pcbTextController.text,
        pseTextController.text,
        psiTextController.text,
        pstTextController.text,
        femIzqTextController.text,
        femDerTextController.text,
        suroIzqTextController.text,
        suroDerTextController.text,
        idOperation
      ];

      //print("${widget.operationActivity} listOfValues $listOfValues ${listOfValues!.length}");

      switch (widget.operationActivity) {
        case Constantes.Nulo:
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();

          Actividades.registrar(Databases.siteground_database_regpace,
              registerQuery!, listOfValues!.removeLast());
          break;
        case Constantes.Consult:
          break;
        case Constantes.Register:
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();

          Actividades.registrar(Databases.siteground_database_regpace,
                  registerQuery!, listOfValues!)
              .then((value) => returnGestion(context));
          break;
        case Constantes.Update:
          Actividades.actualizar(Databases.siteground_database_regpace,
                  updateQuery!, listOfValues!, idOperation)
              .then((value) => Actividades.consultarId(
                          Databases.siteground_database_regpace,
                          consultIdQuery!,
                          idOperation)
                      .then((value) {
                    Pacientes.Vital = value;
                  }).then((value) => returnGestion(context)));
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
    } finally {
      returnGestion(context);
    }
  }
}

class GestionVitales extends StatefulWidget {
  const GestionVitales({Key? key}) : super(key: key);

  @override
  State<GestionVitales> createState() => _GestionVitalesState();
}

class _GestionVitalesState extends State<GestionVitales> {
  String? consultQuery = Vitales.vitales['consultIdQuery'].toString();

  late List? foundedUsuarios = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  String searchCriteria = "Buscar por Fecha";

  @override
  void initState() {
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            consultQuery!, Pacientes.ID_Paciente)
        .then((value) {
      setState(() {
        foundedUsuarios = value;
      });
    });

    super.initState();
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
            .where((user) => user["Pace_Feca_SV"].contains(enteredKeyword))
            .toList();

        setState(() {
          foundedUsuarios = results;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Theming.primaryColor,
          leading: isTabletAndDesktop(context)
              ? null
              : IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  tooltip: Sentences.regresar,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            VisualPacientes(actualPage: 0)));
                  },
                ),
          title: const Text(Sentences.app_pacientes_tittle),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.replay_outlined,
              ),
              tooltip: Sentences.reload,
              onPressed: () {
                _pullListRefresh();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.add_card,
              ),
              tooltip: Sentences.add_vitales,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => OperacionesVitales(
                    operationActivity: Constantes.Register,
                  ),
                ));
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
                    initialData: foundedUsuarios!,
                    future: Future.value(foundedUsuarios!),
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
            ? const Expanded(flex: 1, child: EstadisticasPacientes())
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
          Vitales.ID_Vitales = snapshot.data[posicion]['ID_Pace_SV'];
          Pacientes.Vital = snapshot.data[posicion];
          toOperaciones(context, Constantes.Update);
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
                            "ID : ${snapshot.data[posicion]['ID_Pace_SV'].toString()}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 12),
                          ),
                          Text(
                            "Fecha de Realización: ${snapshot.data[posicion]['Pace_Feca_SV'].toString()}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 14),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GridView.count(
                            childAspectRatio: 14.0,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            shrinkWrap: true,
                            children: [
                              Text(
                                "TA: ${snapshot.data[posicion]['Pace_SV_tas'].toString()}/${snapshot.data[posicion]['Pace_SV_tad'].toString()} mmHg",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 12),
                              ),
                              Text(
                                "Fc ${snapshot.data[posicion]['Pace_SV_fc'].toString()} L/min",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 12),
                              ),
                              Text(
                                "Fr: ${snapshot.data[posicion]['Pace_SV_fr'].toString()} Resp/min",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 12),
                              ),
                              Text(
                                "TC ${snapshot.data[posicion]['Pace_SV_tc'].toString()}°C",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 12),
                              ),
                              Text(
                                "PCT: ${snapshot.data[posicion]['Pace_SV_pct'].toString()} Kg",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 12),
                              ),
                              Text(
                                "Est ${snapshot.data[posicion]['Pace_SV_est'].toString()} mts",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                    fontSize: 12),
                              ),
                            ],
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
                            Pacientes.ID_Paciente =
                                snapshot.data[posicion]['ID_Pace_SV'];
                            Pacientes.Paciente = snapshot.data[posicion];
                            toOperaciones(context, Constantes.Update);
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

  void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  void deleteRegister(
      AsyncSnapshot<dynamic> snapshot, int posicion, BuildContext context) {
    try {
      Actividades.eliminar(
          Databases.siteground_database_regpace,
          Vitales.vitales['deleteQuery'].toString(),
          snapshot.data[posicion]['ID_Pace_SV']);
      setState(() {
        snapshot.data.removeAt(posicion);
      });
    } finally {
      Navigator.of(context).pop();
    }
  }

  void toOperaciones(BuildContext context, String operationActivity) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => OperacionesVitales(
        operationActivity: operationActivity,
      ),
    ));
  }

  Future<Null> _pullListRefresh() async {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (a, b, c) => const GestionVitales(),
            transitionDuration: const Duration(seconds: 0)));
  }
}
