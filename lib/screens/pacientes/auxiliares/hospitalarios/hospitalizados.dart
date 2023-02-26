import 'dart:io';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/actividades/pdfGenerete/PdfApi.dart';
import 'package:assistant/conexiones/actividades/pdfGenerete/pdfGenereteFormats/formatosReportes.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/home.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/screens/pacientes/pacientes.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';

class Hospitalizados extends StatefulWidget {
  Widget? actualSidePage = Container();
  // ****************** *** ****** **************
  var keySearch = "Pace_APP_ALE";
  // ****************** *** ****** **************

  Hospitalizados({Key? key, this.actualSidePage}) : super(key: key);

  @override
  State<Hospitalizados> createState() => _HospitalizadosState();
}

class _HospitalizadosState extends State<Hospitalizados> {
  String appTittle = "Gestion de pacientes hospitalizados";
  String searchCriteria = "Buscar por Fecha";
  String? consultQuery = Pacientes.pacientes['consultHospitalized'];

  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  var fileAssocieted = 'assets/vault/hospitalized.json';

  @override
  void initState() {
    Terminal.printWarning(message: " . . . Iniciando Actividad ");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        foundedItems = value;
      });
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "Error : $error");
      _pullListRefresh();
    });
    Terminal.printWarning(message: " . . . Actividad Iniciada");
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Home(),
                ),
              );
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
                _pullListRefresh();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.list,
              ),
              tooltip: "Imprimir cennso hospitalario",
              onPressed: () async {
                final pdfFile = await PdfParagraphsApi.generateFromList(
                  rightMargin: 10,
                  leftMargin: 10,
                  withIndicationReport: false,
                  indexOfTypeReport: TypeReportes.censoHospitalario,
                  paraph: foundedItems!,
                  name: "(CEN) - (${Calendarios.today()}).pdf",
                );

                PdfApi.openFile(pdfFile);
              },
            ),
          ]),
      body: Column(
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
                        borderSide: BorderSide(color: Colors.white, width: 0.5),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
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
                          padding: const EdgeInsets.all(10.0),
                          gridDelegate: GridViewTools.gridDelegate(),
                          controller: gestionScrollController,
                          shrinkWrap: true,
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
    );
  }

  Container itemListView(
      AsyncSnapshot snapshot, int posicion, BuildContext context) {
    return Container(
      decoration: ContainerDecoration.roundedDecoration(),
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Terminal.printExpected(message: "${snapshot.data[posicion]['Pendientes']}");
        },
        onDoubleTap: () {
          Pacientes.ID_Paciente = snapshot.data[posicion]['ID_Pace'];
          Pacientes.Paciente = snapshot.data[posicion];

          Pacientes.fromJson(snapshot.data[posicion]);

          toVisual(context, Constantes.Update);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 1,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 50,
                        child: Text(
                            snapshot.data[posicion]['Id_Cama'].toString(),
                            style: Styles.textSyleGrowth(fontSize: 18)),
                      )),
                  IconButton(
                    color: Colors.grey,
                    icon: const Icon(Icons.update_rounded),
                    onPressed: () {
                      Pacientes.ID_Paciente = snapshot.data[posicion]['ID_Pace'];
                      Pacientes.Paciente = snapshot.data[posicion];

                      Pacientes.fromJson(snapshot.data[posicion]);

                      toVisual(context, Constantes.Update);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                margin: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "${snapshot.data[posicion]['Pace_Ape_Pat']} "
                        "${snapshot.data[posicion]['Pace_Ape_Mat']} "
                        "${snapshot.data[posicion]['Pace_Nome_PI']} "
                        "${snapshot.data[posicion]['Pace_Nome_SE']}",
                        maxLines: 2,
                        style: Styles.textSyleGrowth(fontSize: 16)),
                    Text(
                      "Servicio: ${snapshot.data[posicion]['Serve_Trat']}",
                      maxLines: 2,
                      style: Styles.textSyleGrowth(fontSize: 12),
                    ),
                    Text(
                      "${snapshot.data[posicion]['Medi_Trat']}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.textSyleGrowth(fontSize: 12),
                    ),
                    Text(
                      "Egreso: ${snapshot.data[posicion]['Feca_EGE_Hosp']}",
                      style: Styles.textSyleGrowth(fontSize: 12),
                    ),
                    Text("D.E.H.: ${snapshot.data[posicion]['Dia_Estan']}",
                        style: Styles.textSyleGrowth(fontSize: 14)),
                    Text(
                      "${snapshot.data[posicion]['EGE_Motivo']}",
                      style: Styles.textSyleGrowth(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toVisual(BuildContext context, String operationActivity) async {
    //
    Terminal.printData(message: 'Nombre obtenido ${Pacientes.nombreCompleto}\n'
        '${Pacientes.localPath}');
    Archivos.readJsonToMap(
            filePath: Pacientes.localPath)
        .then((value) {
      Pacientes.Paciente = value[0];
      setState(() {
        Pacientes.imagenPaciente = value[0]['Pace_FIAT'];
      });
      Terminal.printSuccess(
          message:
              'Archivo ${Pacientes.localPath} Obtenido');
      Valores.fromJson(value[0]);

      Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => VisualPacientes(actualPage: 0),
          ),);
    }).onError((error, stackTrace) async {
      Operadores.loadingActivity(
        context: context,
        tittle: "Iniciando interfaz . . . ",
        message: "Iniciando Interfaz",
      );
      Terminal.printAlert(
          message:
              'Archivo ${Pacientes.localPath} No Encontrado');
      Terminal.printWarning(message: 'Iniciando busqueda en Valores . . . ');
      var response = await Valores().load(); // print("response $response");
      //
      if (response == true) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => VisualPacientes(actualPage: 0),
          ),
        );
      }
    });
  }

  void toOperaciones(BuildContext context, int posicion,
      AsyncSnapshot<dynamic> snapshot, String operationActivity) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => OperacionesPacientes(
        operationActivity: operationActivity,
      ),
    ));
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
    Terminal.printAlert(
        message: "Iniciando actividad : : \n "
            "Consulta de pacientes hospitalizados . . .");
    List hospitalizaed = [];

    Actividades.consultar(
      Databases.siteground_database_regpace,
      Pacientes.pacientes['consultHospitalized'],
    ).then((response) async {
      var ids = Listas.listFromMapWithOneKey(response, keySearched: 'ID_Pace');
      for (var item in ids) {
        hospitalizaed.add(await Actividades.consultarId(
          Databases.siteground_database_reghosp,
          "SELECT * FROM pace_hosp WHERE ID_Pace = ? "
          "ORDER BY ID_Hosp ASC",
          item,
        ));
      }
      // ********** ************** ***********
      for (var v = 0; v < response.length; v++) {
        if (hospitalizaed[v].keys.contains('Error')) {
          response[v].addAll({
            "ID_Hosp": 0,
            "Feca_INI_Hosp": '0000-00-00',
            "Id_Cama": 'NA',
            "Dia_Estan": 0,
            "Medi_Trat": 'N/A',
            "Serve_Trat": 'N/A',
            "Serve_Trat_INI": 'N/A',
            "Feca_EGE_Hosp": '0000-00-00',
            "EGE_Motivo": ""
          });
          response[v].addAll({
            "Cronicos": [],
          });
          response[v].addAll({
            "Diagnosticos": [],
          });
          response[v].addAll({
            "Pendientes": [],
          });
        } else {
          response[v].addAll(hospitalizaed[v]);
          response[v].addAll({
            "Cronicos": await Actividades.consultarAllById(
              Databases.siteground_database_regpace,
              "SELECT * FROM pace_app_deg WHERE ID_Pace = ? ",
              response[v]['ID_Pace'],
            ),
          });
          response[v].addAll({
            "Diagnosticos": await Actividades.consultarAllById(
              Databases.siteground_database_reghosp,
              "SELECT * FROM pace_dia WHERE ID_Pace = ? "
              "AND ID_Hosp = '${hospitalizaed[v]['ID_Hosp']}'",
              response[v]['ID_Pace'],
            ),
          });
          response[v].addAll({
            "Pendientes": await Actividades.consultarAllById(
              Databases.siteground_database_reghosp,
              "SELECT * FROM pace_pen WHERE ID_Pace = ? "
              "AND ID_Hosp = '${hospitalizaed[v]['ID_Hosp']}' "
              "AND Pace_PEN_realized = '1'",
              response[v]['ID_Pace'],
            )
          });
        }
      }
      // ********** ************** ***********
      foundedItems = response;
      setState(() {
        Terminal.printSuccess(
            message: "Actualizando pacientes hospitalizados . . . ");
        // foundedItems!.sort((a, b) => a["Id_Cama"].compareTo(b["Id_Cama"]));
        foundedItems!.sort((a, b) {
          return Items.orderOfCamas.indexOf(a['Id_Cama'].toString()) -
              Items.orderOfCamas.indexOf(b['Id_Cama'].toString());
        });
        Archivos.createJsonFromMap(foundedItems!, filePath: fileAssocieted);
      });
      // ********** ************** ***********
    });
  }
}
