import 'dart:async';
import 'dart:io';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/screens/pacientes/auxiliares/detalles/menus.dart';
import 'package:assistant/screens/pacientes/auxiliares/estadisticas/estadisticas.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/CrossLine.dart';

import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/GridLayout.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/WidgetsModels.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:assistant/conexiones/conexiones.dart';

import 'package:assistant/screens/home.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:convert';

class GestionPacientes extends StatefulWidget {
  const GestionPacientes({super.key});

  @override
  State<GestionPacientes> createState() => _GestionPacientesState();
}

class _GestionPacientesState extends State<GestionPacientes> {
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
          foregroundColor: Colors.white,
          backgroundColor: Theming.primaryColor,
          leading: IconButton(
            icon: const Icon(
              color: Colors.white,
              Icons.arrow_back,
            ),
            tooltip: Sentences.regresar,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Home()));
            },
          ),
          title: AppBarText(
            Sentences.app_pacientes_tittle,
          ),
          actions: <Widget>[
            if (isMobile(context))
              GrandIcon(
                  iconData: Icons.bar_chart,
                  onPress: () {
                    Cambios.toNextActivity(context,
                        tittle: 'Estadisticas de los Pacientes',
                        chyld: const EstadisticasPacientes());
                  }),
            CrossLine(isHorizontal: false, thickness: 3, color: Colors.grey),
            IconButton(
              icon: const Icon(
                Icons.replay_outlined,
              ),
              tooltip: Sentences.reload,
              onPressed: () {
                reiniciar(); // _pullListRefresh();
              },
            ),
            Menus.accionesConPacientes(context),
            // IconButton(
            //   icon: const Icon(Icons.add_card),
            //   tooltip: Sentences.add_usuario,
            //   onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            //     builder: (BuildContext context) => OperacionesPacientes(
            //       operationActivity: Constantes.Register,
            //     ),
            //   )),
            // ),
          ]),
      body: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                flex: 2,
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
                            reiniciar(); // _pullListRefresh();
                          },
                        ),
                      )),
                ),
              ),
              CrossLine(
                thickness: 2,
              ),
              Expanded(
                flex: isTablet(context) ? 28 : 16,
                child: Row(
                  children: [
                    Expanded(
                      flex: isTablet(context) || isMobile(context) ? 9 : 18,
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
                                    shrinkWrap: false,
                                    gridDelegate: GridViewTools.gridDelegate(
                                        crossAxisCount: isDesktop(context) ||
                                                isLargeDesktop(context)
                                            ? 2
                                            : 1,
                                        mainAxisExtent:
                                            isMobile(context) ? 180 : 200),
                                    itemCount: snapshot.data == null
                                        ? 0
                                        : snapshot.data.length,
                                    itemBuilder: (context, posicion) {
                                      return Container(
                                        padding: const EdgeInsets.only(
                                            left: 2.0,
                                            top: 2.0,
                                            bottom: 2.0,
                                            right: 2.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            try {
                                              Pacientes.ID_Paciente = snapshot
                                                  .data[posicion]['ID_Pace'];
                                              Pacientes.Paciente =
                                                  snapshot.data[posicion];
                                              setState(() {
                                                Pacientes.fromJson(
                                                    snapshot.data[posicion]);
                                              });
                                              // Terminal.printNotice(message: "Nombre conformado ${Pacientes.nombreCompleto}",);
                                              // Consulta de Antecedentes No Patológicos **** ***** ******* ****
                                              Eticos.consultarRegistro();
                                              Viviendas.consultarRegistro();
                                              Higienes.consultarRegistro();
                                              Diarios.consultarRegistro();
                                              Alimenticios.consultarRegistro();
                                              Limitaciones.consultarRegistro();
                                              Sustancias.consultarRegistro();

                                              Toxicomanias.consultarRegistro();

                                              toVisual(
                                                  context, Constantes.Update);
                                            } catch (e, stacktrace) {
                                              Terminal.printAlert(
                                                  message:
                                                      "ERROR - toVisual : : $e \n\t\t: $stacktrace");
                                              Operadores.alertActivity(
                                                  context: context,
                                                  tittle:
                                                      'Error al Inicial Visual . . . ',
                                                  message:
                                                      "ERROR - toVisual : : $e \n\t\t: $stacktrace",
                                                  onClose: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  onAcept: () {
                                                    // Consulta de Antecedentes No Patológicos **** ***** ******* ****
                                                    Eticos.consultarRegistro();
                                                    Viviendas
                                                        .consultarRegistro();
                                                    Higienes
                                                        .consultarRegistro();
                                                    Diarios.consultarRegistro();
                                                    Alimenticios
                                                        .consultarRegistro();
                                                    Limitaciones
                                                        .consultarRegistro();
                                                    Sustancias
                                                        .consultarRegistro();

                                                    Toxicomanias
                                                        .consultarRegistro();

                                                    toVisual(context,
                                                        Constantes.Update);
                                                  });
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 18.0,
                                                bottom: 18.0,
                                                right: 0.0),
                                            margin: const EdgeInsets.all(5.0),
                                            decoration: ContainerDecoration
                                                .roundedDecoration(),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                    backgroundColor:
                                                        Colors.grey,
                                                    radius: 50,
                                                    child: snapshot.data[
                                                                    posicion]
                                                                ['Pace_FIAT'] !=
                                                            ''
                                                        ? const Icon(
                                                            Icons.person,
                                                            size: 75.0,
                                                            color: Colors.black,
                                                          )
                                                        : Image.memory(
                                                            base64Decode(snapshot
                                                                        .data[
                                                                    posicion][
                                                                'Pace_FIAT']))),
                                                SizedBox(
                                                  width: isMobile(context)
                                                      ? 12.0
                                                      : 15.0,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Número Paciente : ${snapshot.data[posicion]['ID_Pace'] ?? ""}",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 10),
                                                          ),
                                                          Text(
                                                            "${snapshot.data[posicion]['Pace_Ape_Pat']} ${snapshot.data[posicion]['Pace_Ape_Mat']} "
                                                            "\n${snapshot.data[posicion]['Pace_Nome_PI']} ${snapshot.data[posicion]['Pace_Nome_SE']}",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12),
                                                          ),
                                                          Text(
                                                            "${snapshot.data[posicion]['Pace_NSS']} ${snapshot.data[posicion]['Pace_AGRE']}",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 10),
                                                          ),
                                                          Text(
                                                            "Edad : ${snapshot.data[posicion]['Pace_Eda']}",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 10),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          // const SizedBox(
                                                          //   width: 1,
                                                          // ),
                                                          Expanded(
                                                            child: IconButton(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(1.0),
                                                              color:
                                                                  Colors.grey,
                                                              icon: const Icon(
                                                                  Icons.person),
                                                              onPressed: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return imageDialog(
                                                                          "${snapshot.data[posicion]['Pace_Ape_Pat']} "
                                                                          "${snapshot.data[posicion]['Pace_Ape_Mat']} "
                                                                          "\n${snapshot.data[posicion]['Pace_Nome_PI']} ${snapshot.data[posicion]['Pace_Nome_PI']}",
                                                                          snapshot.data[posicion]
                                                                              [
                                                                              'Pace_FIAT'],
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      });
                                                                    });
                                                              },
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: IconButton(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(1.0),
                                                              color:
                                                                  Colors.grey,
                                                              icon: const Icon(Icons
                                                                  .update_rounded),
                                                              onPressed: () {
                                                                Pacientes
                                                                    .ID_Paciente = snapshot
                                                                            .data[
                                                                        posicion]
                                                                    ['ID_Pace'];
                                                                Pacientes
                                                                        .Paciente =
                                                                    snapshot.data[
                                                                        posicion];
                                                                toOperaciones(
                                                                    context,
                                                                    posicion,
                                                                    snapshot,
                                                                    Constantes
                                                                        .Update);
                                                              },
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: IconButton(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(1.0),
                                                              color:
                                                                  Colors.grey,
                                                              icon: const Icon(
                                                                  Icons.delete),
                                                              onPressed: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return alertDialog(
                                                                        'Eliminar registro',
                                                                        '¿Esta seguro de querer eliminar el registro?',
                                                                        () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        () {
                                                                          deleteRegister(
                                                                              snapshot,
                                                                              posicion,
                                                                              context);
                                                                        },
                                                                      );
                                                                    });
                                                              },
                                                            ),
                                                          ),
                                                          // CrossLine(
                                                          //     isHorizontal: false,
                                                          //     // color: Colors.grey,
                                                          //     thickness: 4),
                                                          Expanded(
                                                            child: IconButton(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right:
                                                                          1.0),
                                                              color:
                                                                  Colors.grey,
                                                              icon: Icon(snapshot
                                                                              .data[posicion]
                                                                          [
                                                                          'Pace_Hosp'] ==
                                                                      'Hospitalización'
                                                                  ? Icons
                                                                      .local_hotel_sharp
                                                                  : Icons
                                                                      .desk_sharp),
                                                              onPressed: () {
                                                                String hospen =
                                                                    "";
                                                                if (snapshot.data[
                                                                            posicion]
                                                                        [
                                                                        'Pace_Hosp'] ==
                                                                    'Consulta Externa') {
                                                                  hospen =
                                                                      'Hospitalización';
                                                                } else {
                                                                  hospen =
                                                                      'Consulta Externa';
                                                                }
                                                                Actividades
                                                                        .actualizar(
                                                                            Databases
                                                                                .siteground_database_regpace,
                                                                            "UPDATE pace_iden_iden "
                                                                            "SET Pace_Hosp = ? "
                                                                            "WHERE ID_Pace = ?",
                                                                            [
                                                                              hospen,
                                                                              snapshot.data[posicion]['ID_Pace']
                                                                            ],
                                                                            snapshot.data[posicion][
                                                                                'ID_Pace'])
                                                                    .then(
                                                                        (value) =>
                                                                            null)
                                                                    .whenComplete(
                                                                        () =>
                                                                            reiniciar());
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const CircularProgressIndicator(),
                                        const SizedBox(height: 50),
                                        Text(
                                          snapshot.hasError
                                              ? snapshot.error.toString()
                                              : snapshot.error.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                        ),
                                      ],
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.only(right: 8.0),
                        decoration: ContainerDecoration.roundedDecoration(),
                        child: Column(
                          children: [
                            Expanded(
                              child: GrandIcon(
                                labelButton: 'Pacientes en Hospitalización',
                                iconData: Icons.local_hotel_sharp,
                                onPress: () {
                                  _pullListRefresh().whenComplete(() =>
                                      _runConsultaSearch(
                                          enteredKeyword:
                                              'Hospitalización')); // reiniciar(); //
                                },
                              ),
                            ),
                            Expanded(
                              child: GrandIcon(
                                labelButton:
                                    'Hospitalización en Otros Sectores',
                                iconData: Icons.local_hotel_outlined,
                                onPress: () {
                                  _pullListRefresh().whenComplete(() =>
                                      _runConsultaSearch(
                                          enteredKeyword:
                                              'Otra Hospitalización')); // reiniciar(); //
                                },
                              ),
                            ),
                            Expanded(
                              child: GrandIcon(
                                labelButton: 'Pacientes en Consulta Externa',
                                iconData: Icons.desk_sharp,
                                onPress: () {
                                  _pullListRefresh().whenComplete(() =>
                                      _runConsultaSearch()); // reiniciar(); //
                                },
                              ),
                            ),
                            Expanded(
                              child: GrandIcon(
                                labelButton: 'Pacientes en Privado',
                                iconData: Icons.private_connectivity_outlined,
                                onPress: () {
                                  _pullListRefresh().whenComplete(() =>
                                      _runConsultaSearch(
                                          enteredKeyword:
                                              'Privado')); // reiniciar(); //
                                },
                              ),
                            ),
                            Expanded(
                              child: GrandIcon(
                                labelButton: 'Pacientes de Análisis',
                                iconData: Icons.analytics_outlined,
                                onPress: () {
                                  _pullListRefresh().whenComplete(() =>
                                      _runConsultaSearch(
                                          enteredKeyword:
                                              'Análisis')); // reiniciar(); //
                                },
                              ),
                            ),
                            Expanded(
                              child: GrandIcon(
                                labelButton: 'Defunciones',
                                iconData: Icons.crop_sharp,
                                onPress: () {
                                  _pullListRefresh().whenComplete(() =>
                                      _runConsultaSearch(
                                          enteredKeyword:
                                              'Defunción')); // reiniciar(); //
                                },
                              ),
                            ),
                            Expanded(child: CrossLine()),
                            Expanded(
                              child: GrandIcon(
                                  labelButton: 'Sin Hospitalizados . . . ',
                                  iconData: Icons.bedroom_child_outlined,
                                  onPress: () {
                                    _notHospitalizedOther(
                                        query: "Hospitalización");
                                  }),
                            ),
                            Expanded(
                              child: GrandIcon(
                                  labelButton:
                                      'Sin Otras Hospitalizaciones . . . ',
                                  iconData: Icons.recent_actors_outlined,
                                  onPress: () {
                                    _notHospitalizedOther();
                                  }),
                            ),
                            Expanded(child: CrossLine()),
                            Expanded(
                              child: GrandIcon(
                                labelButton: 'Todos los Pacientes . . .',
                                iconData: Icons.clear_all,
                                onPress: () {
                                  _pullListRefresh().whenComplete(() =>
                                      _runConsultaSearch(
                                          enteredKeyword:
                                              '')); // reiniciar(); //
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        isTablet(context)
            ? const Expanded(flex: 1, child: EstadisticasPacientes())
            : isDesktop(context) || isLargeDesktop(context)
                ? const Expanded(flex: 1, child: EstadisticasPacientes())
                : isTabletAndDesktop(context)
                    ? const Expanded(flex: 1, child: EstadisticasPacientes())
                    : Container()
      ]),
    );
  }

  // OPERACIONES DE LA INTERFAZ ****************** ******** * * * *
  void iniciar() async {
    Terminal.printWarning(
        message: " . . . Iniciando Actividad - Repositorio de Pacientes");

    await Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        foundedItems = Pacientes.Pacientary = value;
      });
    }).onError((onError, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(30.0),
          padding: EdgeInsets.all(15.0),
          content: Text("ERROR - Inicio del Repositorio de Pacientes "
              "- $onError : $stackTrace"),
          action: SnackBarAction(
            label: 'Aceptar . . . ',
            onPressed: () {
              // Some code to undo the change.
            },
          )));
      reiniciar();
    });
    Terminal.printWarning(message: " . . . Actividad Iniciada");
  }

  void reiniciar() {
    Terminal.printAlert(
        message: "Iniciando actividad : : \n "
            "Consulta de pacientes hospitalizados . . .");
    Actividades.detalles(Databases.siteground_database_regpace,
            Pacientes.pacientes['pacientesStadistics'],
            emulated: true)
        .then((value) {
      Archivos.createJsonFromMap([value],
          filePath: 'assets/vault/patientsStats.json');
    }).catchError((e, stackTrace) {
      Operadores.alertActivity(
          context: context,
          tittle: "$e",
          message: "$stackTrace",
          onAcept: () {
            Navigator.of(context).pop();
          });
    });

    Actividades.consultar(Databases.siteground_database_regpace,
            Pacientes.pacientes['consultQuery']!,
            emulated: true)
        .then((value) {
      setState(() {
        Terminal.printSuccess(
            message: "Actualizando repositorio de pacientes . . . $value");
        foundedItems = Pacientes.Pacientary = value;
        Archivos.createJsonFromMap(foundedItems!, filePath: fileAssocieted);
      });
    }).catchError((e, stackTrace) {
      Operadores.alertActivity(
          context: context,
          tittle: "$e",
          message: "$stackTrace",
          onAcept: () {
            Navigator.of(context).pop();
          });
    });
    //
  }

  void deleteRegister(
      AsyncSnapshot<dynamic> snapshot, int posicion, BuildContext context) {
    try {
      Actividades.eliminar(
          Databases.siteground_database_regpace,
          Pacientes.pacientes['deleteQuery'],
          snapshot.data[posicion]['ID_Pace']);
      setState(() {
        snapshot.data.removeAt(posicion);
      });
    } finally {
      Navigator.of(context).pop();
    }
  }

  void toVisual(BuildContext context, String operationActivity) async {
    // Otras configuraciones : Inicio de Variables para Operadores
    Escalas.serviciosHospitalarios = await Archivos.listFromText(
        path: 'assets/diccionarios/Servicios.txt', splitChar: ',');
    //
    Archivos.readJsonToMap(filePath: Pacientes.localPath).then((value) {
      Pacientes.Paciente = value[0];
      setState(() {
        Pacientes.imagenPaciente = value[0]['Pace_FIAT'];
      });
      Terminal.printSuccess(message: 'Archivo ${Pacientes.localPath} Obtenido');
      Valores.fromJson(value[0]);
      //
      Terminal.printData(
          message: 'Nombre obtenido ${Pacientes.nombreCompleto}\n'
              '\t Local ${Pacientes.localPath}\n'
              '\t Repository ${Pacientes.localRepositoryPath}\n'
              '\t Reports ${Pacientes.localReportsPath}\n'
              ' . . . Directrices Asociadas a los Antecedentes Generales : : : \n'
              '\t Eticos ${Eticos.fileAssocieted}\n'
              '\t Viviendas ${Viviendas.fileAssocieted}\n'
              '\t Alimenticios ${Alimenticios.fileAssocieted}\n'
              '\t Diarios ${Diarios.fileAssocieted}\n'
              '\t Higienes ${Higienes.fileAssocieted}\n'
              '\t Limitaciones ${Limitaciones.fileAssocieted}\n'
              '\t Sustancias ${Sustancias.fileAssocieted}\n'
              '\t Toxicomanias ${Toxicomanias.fileAssocieted}\n'
              '\t Vitales ${Vitales.fileAssocieted}\n'
              '\t Patologicos ${Patologicos.fileAssocieted}\n'
              ' . . . Directrices Asociadas a la Hospitalización : : : \n'
              '\t Diagnosticos ${Diagnosticos.fileAssocieted}\n'
              '\t Pendientes ${Pendientes.fileAssocieted}\n'
              ' . . . Directrices Asociadas al Análisis General : : : \n'
              '\t Auxiliares ${Auxiliares.fileAssocieted}\n'
              '\t Imagenologias ${Imagenologias.fileAssocieted}\n'
              '\t Electrocardiogramas ${Electrocardiogramas.fileAssocieted}\n');

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => VisualPacientes(actualPage: 0),
        ),
      );
    }).onError((error, stackTrace) async {
      Operadores.loadingActivity(
        context: context,
        tittle: "Iniciando interfaz . . . ",
        message: "Iniciando Interfaz",
      );
      Terminal.printAlert(
          message: 'Archivo ${Pacientes.localPath} No Encontrado');
      Terminal.printWarning(message: 'Iniciando búsqueda en Valores . . . ');
      var response = await Valores().load().onError((error, stackTrace) {
        Operadores.alertActivity(
            context: context,
            tittle: "Error al Cargar Valores . . . ",
            message: "ERROR : : $error : $stackTrace",
            onAcept: () {
              Navigator.of(context).pop();
            });
        return false;
      }); // print("response $response");
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

  // ACTIVIDADES DE BÚSQUEDA ************ ************ ***** * ** *
  Future<Null> _pullListRefresh() async {
    Terminal.printWarning(
        message: " . . . Iniciando Actividad - Repositorio de Pacientes");

    await Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        foundedItems = originalItems=Pacientes.Pacientary = value;
      });
    }).onError((onError, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(30.0),
          padding: EdgeInsets.all(15.0),
          content: Text("ERROR - Inicio del Repositorio de Pacientes "
              "- $onError : $stackTrace"),
          action: SnackBarAction(
            label: 'Aceptar . . . ',
            onPressed: () {
              // Some code to undo the change.
            },
          )));
      reiniciar();
    });
    Terminal.printWarning(message: " . . . Actividad Iniciada");
  }

  void _runFilterSearch(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      setState(() {
        foundedItems = [];
        enteredKeyCount = 0;
      });

      // Restablecer la lista original desde la fuente de datos
      _pullListRefresh();
      return;
    }
    //
    lastEnteredKeyword = enteredKeyword;

    // Asegurarse de que foundedItems no sea null antes de filtrar
    List<dynamic> results = Listas.listFromMap(
      lista: originalItems ?? [], // Filtrar desde foundedItems en todo momento
      keySearched: 'Pace_Ape_Pat',
      elementSearched: Sentences.capitalize(enteredKeyword),
    );

    setState(() {
      //
      foundedItems = results;
      enteredKeyCount = enteredKeyword.length;
    });
  }

  void _runConsultaSearch({String enteredKeyword = 'Consulta Externa'}) {
    Terminal.printWarning(
        message: " . . . Iniciando Actividad - Repositorio de Pacientes");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
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
            exactValue: true,
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

  Future<void> _notHospitalizedOther(
      {String query = "Otra Hospitalización"}) async {
    List listOfIDs = [];
    //
    listOfIDs = await Actividades.consultar(
        Databases.siteground_database_regpace,
        "SELECT ID_Pace FROM pace_iden_iden WHERE Pace_Hosp = '$query'");
    for (var element in listOfIDs) {
      // Terminal.printExpected(message: "$element");
      Actividades.actualizar(
              Databases.siteground_database_regpace,
              "UPDATE pace_iden_iden "
              "SET Pace_Hosp = ? "
              "WHERE ID_Pace = ?",
              ["Consulta Externa", element['ID_Pace']],
              element['ID_Pace'])
          .then((value) => null)
          .whenComplete(() => reiniciar())
          .onError((error, stackTrace) {
        Terminal.printExpected(message: "ERRNO - $error : : $stackTrace");
      });
    }
  }

  // VARIABLES DE LA INTERFAZ ***************** ******* * * * *
  late List? foundedItems = [], originalItems = [];
late int enteredKeyCount = 0;
String lastEnteredKeyword = "";

  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  String searchCriteria = "Buscar por Apellido";
  var fileAssocieted = 'assets/vault/pacientesRepository.json';
}

class OperacionesPacientes extends StatefulWidget {
  //const OperacionesPacientes({super.key});
  // final Map<String, dynamic> lista;
  // final int index;
  final String operationActivity;

  String _operation_button = 'Nulo';

  OperacionesPacientes({super.key, required this.operationActivity});

  @override
  State<OperacionesPacientes> createState() => _OperacionesPacientesState();
}

class _OperacionesPacientesState extends State<OperacionesPacientes> {
  @override
  void initState() {
    // Terminal.printExpected(message: "Actividad : : ${widget.operationActivity}");

    switch (widget.operationActivity) {
      case Constantes.Nulo:
        break;
      case Constantes.Consult:
        break;
      case Constantes.Register:
        widget._operation_button = 'Registrar';
        //
        turnoValue = Pacientes.Turno[0];
        sessoValue = Pacientes.Sexo[0];
        unidadMedicaValue = Pacientes.Unidades[0];
        hemotipoValue = Items.Hemotipo[1];

        atencionValue = Pacientes.Atencion[1];
        statusValue = Pacientes.Status[0];
        estadoCivilValue = Pacientes.EstadoCivil[0];
        vivoValue = Pacientes.Vivo[0];
        escolaridadValue = Pacientes.Escolaridad[0];
        escolaridadCompletudValue = Pacientes.EscolaridadCompletud[0];
        //
        indigenaValue = Pacientes.Indigena[1];
        indigenaHablanteValue = Pacientes.lenguaIndigena[0];
        entidadFederativaValue = Pacientes.EntidadesFederativas[0];
        //
        indigenaHablanteEspecificacioTextController.text =
            "Niega hablar alguna Lengua Indigena";
        //
        toBaseImage();

        break;
      case Constantes.Update:
        widget._operation_button = 'Actualizar';
        idOperation = Pacientes.Paciente['ID_Pace'];

        numeroPacienteTextController.text = Pacientes.Paciente['Pace_NSS'];
        agregadoPacienteTextController.text = Pacientes.Paciente['Pace_AGRE'];

        firstNamePaciente.text = Pacientes.Paciente['Pace_Nome_PI'];
        secondNameTextController.text = Pacientes.Paciente['Pace_Nome_SE'];

        apellidoPaternoTextController.text = Pacientes.Paciente['Pace_Ape_Pat'];
        apellidoMaternoTextController.text = Pacientes.Paciente['Pace_Ape_Mat'];

        hemotipoValue = Pacientes.Paciente['Pace_Hemo'] ?? Items.Hemotipo[0];

        localidadResidenciaTextController.text =
            Pacientes.Paciente['Pace_Resi_Loca'];
        duracionResidenciaTextController.text =
            Pacientes.Paciente['Pace_Resi_Dur'].toString();
        domicilioTextController.text = Pacientes.Paciente['Pace_Domi'];

        religionTextController.text = Pacientes.Paciente['Pace_Reli'];

        curpTextController.text = Pacientes.Paciente['Pace_Curp'];
        rfcTextController.text = Pacientes.Paciente['Pace_RFC'];

        ocupacionTextController.text = Pacientes.Paciente['Pace_Ocupa'];

        escolaridadCompletudValue = Pacientes.Paciente['Pace_Esco_COM'];
        escolaridadEspecificacionTextController.text =
            Pacientes.Paciente['Pace_Esco_ESPE'];

        nacimientoTextController.text = Pacientes.Paciente['Pace_Nace'];
        edadTextController.text = Pacientes.Paciente['Pace_Eda'].toString();
        telefonoTextController.text = Pacientes.Paciente['Pace_Tele'];

        unidadMedicaTextController.text = Pacientes.Paciente['Pace_UMF'];
        hospitalAtencionTextController.text =
            Pacientes.Paciente['Pace_Hosp_Real'];

        municipioTextController.text = Pacientes.Paciente['Pace_Orig_Muni'];
        entidadFederativaValue = Pacientes.Paciente['Pace_Orig_EntFed'];
        turnoValue = Pacientes.Paciente['Pace_Turo'];
        sessoValue = Pacientes.Paciente['Pace_Ses'];
        atencionValue = Pacientes.Paciente['Pace_Hosp'];
        // statusValue = Pacientes.Paciente['Pace_Stat'];
        estadoCivilValue = Pacientes.Paciente['Pace_Edo_Civ'];
        vivoValue = Pacientes.Paciente['Pace_Stat'];
        escolaridadValue = Pacientes.Paciente['Pace_Esco'];

        indigenaValue = Pacientes.Paciente['Indi_Pace_SiNo'];
        indigenaHablanteValue = Pacientes.Paciente['IndiIdio_Pace_SiNo'];
        indigenaHablanteEspecificacioTextController.text =
            Pacientes.Paciente['IndiIdio_Pace_Espe'];

        img = Pacientes.imagenPaciente; // Pacientes.Paciente['Pace_FIAT'];

        super.initState();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isMobile(context) ||
              // isMobileAndTablet(context)  ||
              // isDesktop(context) ||
              isLargeDesktop(context) ||
              isTablet(
                  context) // widget.operationActivity == Constantes.Register
          ? AppBar(
              title: AppBarText('Registro del Paciente'),
              backgroundColor: Colors.black,
              leading: IconButton(
                icon: const Icon(
                  color: Colors.white,
                  Icons.arrow_back,
                ),
                tooltip: Sentences.regresar,
                onPressed: () {
                  if (widget.operationActivity == Constantes.Register) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const GestionPacientes()));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => VisualPacientes(actualPage: 0)));
                  }
                },
              ),
              actions: isMobile(context)
                  ? [
                      GrandIcon(
                          labelButton: "Datos Personales",
                          iconData: Icons.person,
                          onPress: () {
                            carouselController.jumpToPage(0);
                          }),
                      SizedBox(width: 15),
                      GrandIcon(
                          labelButton: "Datos Generales",
                          iconData: Icons.data_object,
                          onPress: () {
                            carouselController.jumpToPage(1);
                          }),
                      SizedBox(width: 15),
                    ]
                  : [],
            )
          : null,
      body: isDesktop(context) || isLargeDesktop(context)
          ? desktopView()
          : Card(
              color: const Color.fromARGB(255, 61, 57, 57),
              child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  child: isTablet(context) || isMobile(context)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // isMobile(context) || isTablet(context)
                            //     ? returnOperationUserButton(context)
                            //     : Container(),
                            Container(
                                margin: const EdgeInsets.all(8.0),
                                decoration:
                                    ContainerDecoration.roundedDecoration(),
                                child: userPresentation(context)),
                            Container(
                                margin: const EdgeInsets.all(8.0),
                                decoration:
                                    ContainerDecoration.roundedDecoration(),
                                child: userForm(context)),
                            GrandButton(
                                weigth: isMobile(context) ? 200 : 1000,
                                labelButton: widget._operation_button,
                                onPress: () {
                                  operationMethod(context);
                                })
                          ],
                        )
                      : const Column()),
            ),
    );
  }

  Container desktopView() {
    return Container(
      decoration: ContainerDecoration.roundedDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: ContainerDecoration.roundedDecoration(),
                      child: userPresentation(context)),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 8,
                        child: Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: ContainerDecoration.roundedDecoration(),
                            child: userForm(context)),
                      ),
                      Expanded(
                          child: GrandButton(
                              weigth: isMobile(context) ? 200 : 1000,
                              labelButton: widget._operation_button,
                              onPress: () {
                                operationMethod(context);
                              }))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Operaciones de Inicio ***** ******* ********** ****
    Future<void> reiniciar() async {
    Terminal.printWarning(
        message:
        " . . . Reiniciando Actividad - Repositorio de Pacientes");

    var fileAssocieted = 'assets/vault/pacientesRepository.json';

    // Verificar existencia antes de eliminar
    if (await File(Pacientes.localPath).exists()) {
      await Archivos.deleteFile(filePath: Pacientes.localPath);
    } else {
      Terminal.printWarning(message: "El archivo ${Pacientes.localPath} no existe.");
    }

    if (await File(fileAssocieted).exists()) {
      await Archivos.deleteFile(filePath: fileAssocieted);
    } else {
      Terminal.printWarning(message: "El archivo $fileAssocieted no existe.");
    }

    if (await File(Pacientes.localRepositoryPath).exists()) {
      await Archivos.deleteFile(filePath: Pacientes.localRepositoryPath);
    } else {
      Terminal.printWarning(message: "El archivo ${Pacientes.localRepositoryPath} no existe.");
    }
  }


// Componentes Base de Interfaz ** *********** ********* ****
  List<Widget> component(BuildContext context) {
    return [
      EditTextArea(
        labelEditText: "Número de Afiliación",
        textController: numeroPacienteTextController,
        keyBoardType: TextInputType.number,
        numOfLines: 1,
        limitOfChars: 14,
        inputFormat: MaskTextInputFormatter(
            mask: '#### ## #### #',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        onChange: (String search) {
          var match = Listas.listFromMap(
            lista: Pacientes.Pacientary!,
            keySearched: "Pace_NSS",
            elementSearched: search.toString(),
            exactValue: true,
          );

          if (match.isNotEmpty) {
            Operadores.notifyActivity(
                context: context,
                tittle: "Registro repetido !! ",
                message:
                    "El NSS/ID del paciente recién inscrito, ya ha sido registrado . . . \n\n"
                    "${Pacientes.pacienteSeleccionado(match.last)}",
                onAcept: () {
                  Navigator.of(context).pop();
                });
          }
        },
      ),
      EditTextArea(
        labelEditText: "Agregado médico",
        textController: agregadoPacienteTextController,
        keyBoardType: TextInputType.text,
        numOfLines: 1,
        limitOfChars: 8,
        inputFormat: MaskTextInputFormatter(),
      ),
      EditTextArea(
          labelEditText: 'Primer nombre del paciente',
          numOfLines: 1,
          textController: firstNamePaciente,
          keyBoardType: TextInputType.text,
          inputFormat: MaskTextInputFormatter()),
      EditTextArea(
          labelEditText: 'Segundo nombre del paciente',
          numOfLines: 1,
          textController: secondNameTextController,
          keyBoardType: TextInputType.text,
          inputFormat: MaskTextInputFormatter()),
      EditTextArea(
          labelEditText: 'Apellido Paterno',
          numOfLines: 1,
          textController: apellidoPaternoTextController,
          keyBoardType: TextInputType.text,
          inputFormat: MaskTextInputFormatter()),
      EditTextArea(
          labelEditText: 'Apellido Materno',
          numOfLines: 1,
          textController: apellidoMaternoTextController,
          keyBoardType: TextInputType.text,
          inputFormat: MaskTextInputFormatter()),
      Spinner(
          tittle: "Tipo Sanguíneo",
          initialValue: hemotipoValue,
          items: Items.Hemotipo,
          width: isMobile(context)
              ? 216
              : isTablet(context)
                  ? 140
                  : 180,
          onChangeValue: (String? newValue) {
            setState(() {
              hemotipoValue = newValue!;
            });
          }),
    ];
  }

  List<Widget> secondComponent(BuildContext context) {
    return [
      Spinner(
          tittle: "Unidad de Atención",
          initialValue: unidadMedicaValue,
          width: isMobile(context)
              ? 216
              : isTablet(context)
                  ? 170
                  : 180,
          items: Pacientes.Unidades,
          onChangeValue: (String? newValue) {
            setState(() {
              unidadMedicaValue = newValue!;
            });
          }),
      Spinner(
          tittle: "Hospital de Atención",
          initialValue: unidadMedicaValue,
          width: isMobile(context)
              ? 216
              : isTablet(context)
                  ? 170
                  : 180,
          items: Pacientes.Unidades,
          onChangeValue: (String? newValue) {
            setState(() {
              unidadMedicaValue = newValue!;
            });
          }),
      Spinner(
          tittle: "Turno de atención",
          initialValue: turnoValue,
          width: isMobile(context)
              ? 216
              : isTablet(context)
                  ? 170
                  : 180,
          items: Pacientes.Turno,
          onChangeValue: (String? newValue) {
            setState(() {
              turnoValue = newValue!;
            });
          }),
      Spinner(
          tittle: "Modo de atención",
          initialValue: atencionValue,
          items: Pacientes.Atencion,
          width: isMobile(context)
              ? 216
              : isTablet(context)
                  ? 170
                  : 180,
          onChangeValue: (String? newValue) {
            setState(() {
              atencionValue = newValue!;
            });
          }),
      EditTextArea(
          keyBoardType: TextInputType.phone,
          inputFormat: MaskTextInputFormatter(
              mask: '+## (###) ###-####',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          labelEditText: 'Teléfono',
          numOfLines: 1,
          textController: telefonoTextController),
      EditTextArea(
        keyBoardType: TextInputType.datetime,
        inputFormat: MaskTextInputFormatter(
            mask: '####-##-##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.eager),
        isObscure: false,
        numOfLines: 1,
        labelEditText: 'Fecha de Nacimiento',
        textController: nacimientoTextController,
        selection: true,
        withShowOption: true,
        iconData: Icons.calendar_today_outlined,
        onSelected: () async {
          final DateTime? picked = await showDatePicker(
              context: context,
              // initialEntryMode: DatePickerEntryMode.calendar,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2055),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                    data: ThemeData.dark().copyWith(
                        dialogBackgroundColor: Theming.cuaternaryColor),
                    child: child!);
              });

          setState(() {
            nacimientoTextController.text =
                DateFormat("yyyy-MM-dd").format(picked!);
            //
            edadTextController.text = (DateTime.now()
                        .difference(
                            DateTime.parse(nacimientoTextController.text))
                        .inDays /
                    365)
                .toStringAsFixed(0);
          });
        },
        onChange: (value) {
          setState(() {
            edadTextController.text =
                (DateTime.now().difference(DateTime.parse(value)).inDays / 365)
                    .toStringAsFixed(0);
          });
        },
      ),
      Spinner(
          tittle: "Sexo",
          initialValue: sessoValue,
          width: isMobile(context)
              ? 216
              : isTablet(context)
                  ? 170
                  : 180,
          items: Pacientes.Sexo,
          onChangeValue: (String? newValue) {
            setState(() {
              sessoValue = newValue!;
            });
          }),
      EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          numOfLines: 1,
          labelEditText: 'Edad',
          textController: edadTextController),
      EditTextArea(
        labelEditText: 'CURP',
        numOfLines: 1,
        textController: curpTextController,
        keyBoardType: TextInputType.text,
        inputFormat: MaskTextInputFormatter(),
      ),
      EditTextArea(
        labelEditText: 'RFC',
        numOfLines: 1,
        textController: rfcTextController,
        keyBoardType: TextInputType.text,
        inputFormat: MaskTextInputFormatter(),
      ),
      //
      Spinner(
          tittle: "¿Vive?",
          initialValue: vivoValue,
          width: isMobile(context)
              ? 216
              : isTablet(context)
                  ? 170
                  : 180,
          items: Pacientes.Vivo,
          onChangeValue: (String? newValue) {
            setState(() {
              vivoValue = newValue!;
            });
          }),
      EditTextArea(
        labelEditText: 'Ocupación',
        numOfLines: 1,
        textController: ocupacionTextController,
        keyBoardType: TextInputType.text,
        inputFormat: MaskTextInputFormatter(),
      ),
      Spinner(
          tittle: "Estado civil",
          initialValue: estadoCivilValue,
          width: isMobile(context)
              ? 216
              : isTablet(context)
                  ? 170
                  : 180,
          items: Pacientes.EstadoCivil,
          onChangeValue: (String? newValue) {
            setState(() {
              estadoCivilValue = newValue!;
            });
          }),
      EditTextArea(
        labelEditText: 'Religión',
        textController: religionTextController,
        keyBoardType: TextInputType.text,
        numOfLines: 1,
        inputFormat: MaskTextInputFormatter(),
        selection: true,
        withShowOption: true,
        onSelected: () {
          Operadores.selectOptionsActivity(
              context: context,
              tittle: '¿Religión?',
              options: Items.religiones,
              onClose: (value) {
                setState(() {
                  religionTextController.text = value;
                  Navigator.pop(context);
                });
              });
        },
      ),
      //
      Spinner(
          tittle: "Escolaridad",
          width: isMobile(context)
              ? 216
              : isTablet(context)
                  ? 170
                  : 180,
          initialValue: escolaridadValue,
          items: Pacientes.Escolaridad,
          onChangeValue: (String? newValue) {
            setState(() {
              escolaridadValue = newValue!;
            });
          }),
      Spinner(
          tittle: "Escolaridad completud",
          initialValue: escolaridadCompletudValue,
          width: isMobile(context)
              ? 216
              : isTablet(context)
                  ? 160
                  : 180,
          items: Pacientes.EscolaridadCompletud,
          onChangeValue: (String? newValue) {
            setState(() {
              escolaridadCompletudValue = newValue!;

              if (newValue == Pacientes.EscolaridadCompletud[1]) {
                escolaridadEspecificacionTextController.text =
                    Pacientes.EscolaridadCompletud[1];
              } else {
                escolaridadEspecificacionTextController.text = "";
              }
            });
          }),
      EditTextArea(
        numOfLines: 1,
        labelEditText: 'Especificar escolaridad',
        textController: escolaridadEspecificacionTextController,
        keyBoardType: TextInputType.text,
        inputFormat: MaskTextInputFormatter(),
      ),
      // spinner(tittle: "Estado actual", statusValue, Pacientes.Status,
      //     (String? newValue) {
      //   setState(() {
      //     statusValue = newValue!;
      //   });
      // }),
      //
      EditTextArea(
        numOfLines: 1,
        labelEditText: 'Municipio residencial de Origen',
        textController: municipioTextController,
        keyBoardType: TextInputType.text,
        inputFormat: MaskTextInputFormatter(),
      ),
      // spinner(tittle: "Municipio residencial", municipioValue,
      //     Pacientes.Municipios, (String? newValue) {
      //   setState(() {
      //     municipioValue = newValue!;
      //   });
      // }),
      Spinner(
          tittle: "Entidad federativa de Origen",
          initialValue: entidadFederativaValue,
          width: isMobile(context)
              ? 216
              : isTablet(context)
                  ? 170
                  : 140,
          items: Pacientes.EntidadesFederativas,
          onChangeValue: (String? newValue) {
            setState(() {
              entidadFederativaValue = newValue!;
            });
          }),

      EditTextArea(
        numOfLines: 1,
        labelEditText: 'Localidad',
        textController: localidadResidenciaTextController,
        keyBoardType: TextInputType.text,
        inputFormat: MaskTextInputFormatter(),
      ),
      EditTextArea(
        numOfLines: 1,
        labelEditText: 'Duración',
        textController: duracionResidenciaTextController,
        keyBoardType: TextInputType.text,
        inputFormat: MaskTextInputFormatter(),
      ),
      EditTextArea(
        numOfLines: 1,
        labelEditText: 'Domicilio',
        textController: domicilioTextController,
        keyBoardType: TextInputType.text,
        inputFormat: MaskTextInputFormatter(),
      ),
      //
      Spinner(
          tittle: "Indigena (Si/No)",
          initialValue: indigenaValue,
          width: isMobile(context)
              ? 216
              : isTablet(context)
                  ? 170
                  : 180,
          items: Pacientes.Indigena,
          onChangeValue: (String? newValue) {
            setState(() {
              indigenaValue = newValue!;
            });
          }),
      Spinner(
          tittle: "Hablante Indígena",
          initialValue: indigenaHablanteValue,
          width: isMobile(context)
              ? 216
              : isTablet(context)
                  ? 170
                  : 180,
          items: Pacientes.lenguaIndigena,
          onChangeValue: (String? newValue) {
            setState(() {
              indigenaHablanteValue = newValue!;

              if (newValue == Pacientes.lenguaIndigena[0]) {
                indigenaHablanteEspecificacioTextController.text =
                    "Niega hablar alguna Lengua Indigena";
              } else {
                indigenaHablanteEspecificacioTextController.text = "";
              }
            });
          }),
      EditTextArea(
        numOfLines: 1,
        labelEditText: 'Especificar lenguaje',
        textController: indigenaHablanteEspecificacioTextController,
        keyBoardType: TextInputType.text,
        inputFormat: MaskTextInputFormatter(),
      ),
    ];
  }

  // Visuales de la Interfaz ** *********** ********* ****

  Padding returnOperationUserButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.grey,
                  backgroundColor: Colores.backgroundWidget,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  minimumSize: const Size(50, 50)),
              onPressed: () {
                returnGestion(context);
              },
              child: const Icon(Icons.arrow_back)),
          SizedBox(
            width: isMobile(context) ? 120 : 150,
          ),
          Tooltip(
            message: "Datos Personales",
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.grey,
                    backgroundColor: Colores.backgroundWidget,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    minimumSize: const Size(50, 50)),
                onPressed: () {
                  carouselController.jumpToPage(0);
                },
                child: const Icon(Icons.person)),
          ),
          const SizedBox(
            width: 10,
          ),
          Tooltip(
              message: "Datos Generales",
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.grey,
                      backgroundColor: Colores.backgroundWidget,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      minimumSize: const Size(50, 50)),
                  onPressed: () {
                    carouselController.jumpToPage(1);
                  },
                  child: const Icon(
                    Icons.data_object,
                  ))),
        ],
      ),
    );
  }

  Padding userPresentation(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: isMobile(context)
            ? CarouselSlider(
                items: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 27, 32, 30),
                            radius: 150,
                            // ignore: unnecessary_null_comparison
                            child: img != ""
                                ? ClipOval(
                                    child: Image.memory(
                                    base64Decode(img),
                                    width: 250,
                                    height: 250,
                                    fit: BoxFit.cover,
                                  ))
                                : const ClipOval(child: Icon(Icons.person)),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.grey,
                                      backgroundColor: Colores.backgroundWidget,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      minimumSize: const Size(75, 75)),
                                  onPressed: () {
                                    choiseFromCamara();
                                  },
                                  child: const Icon(Icons.camera)),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.grey,
                                      backgroundColor: Colores.backgroundWidget,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      minimumSize: const Size(50, 50)),
                                  onPressed: () {
                                    toBaseImage();
                                  },
                                  child: const Icon(Icons.person)),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.grey,
                                      backgroundColor: Colores.backgroundWidget,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      minimumSize: const Size(75, 75)),
                                  onPressed: () {
                                    choiseFromDirectory();
                                  },
                                  child: const Icon(Icons.file_open))
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: component(context),
                          )
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                        child: Column(children: secondComponent(context))),
                    GrandButton(
                        labelButton: widget._operation_button,
                        onPress: () {
                          operationMethod(context);
                        })
                  ],
                carouselController: carouselController,
                options: CarouselOptions(
                    height: isMobile(context) ? 600 : 500,
                    enableInfiniteScroll: false,
                    viewportFraction: 1.0))
            : isDesktop(context) || isLargeDesktop(context)
                ? Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: CircleAvatar(
                                backgroundColor:
                                    const Color.fromARGB(255, 27, 32, 30),
                                radius: 150,
                                // ignore: unnecessary_null_comparison
                                child: img != ""
                                    ? ClipOval(
                                        child: Image.memory(
                                        base64Decode(img),
                                        width: 250,
                                        height: 250,
                                        fit: BoxFit.cover,
                                      ))
                                    : const ClipOval(child: Icon(Icons.person)),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SingleChildScrollView(
                                controller: ScrollController(),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 2.0,
                                          left: 2.0,
                                          top: 2.0,
                                          bottom: 2.0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.grey,
                                              backgroundColor:
                                                  Colores.backgroundWidget,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              minimumSize: const Size(75, 75)),
                                          onPressed: () {
                                            choiseFromCamara();
                                          },
                                          child: const Icon(Icons.camera)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.grey,
                                              backgroundColor:
                                                  Colores.backgroundWidget,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              minimumSize: const Size(50, 50)),
                                          onPressed: () {
                                            toBaseImage();
                                          },
                                          child: const Icon(Icons.person)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              foregroundColor: Colors.grey,
                                              backgroundColor:
                                                  Colores.backgroundWidget,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              minimumSize: const Size(75, 75)),
                                          onPressed: () {
                                            choiseFromDirectory();
                                          },
                                          child: const Icon(Icons.file_open)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(child: CrossLine()),
                      Expanded(
                        flex: 7,
                        child: SingleChildScrollView(
                          controller: ScrollController(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: component(context),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 27, 32, 30),
                        radius: 150,
                        // ignore: unnecessary_null_comparison
                        child: img != ""
                            ? ClipOval(
                                child: Image.memory(
                                base64Decode(img),
                                width: 250,
                                height: 250,
                                fit: BoxFit.cover,
                              ))
                            : const ClipOval(child: Icon(Icons.person)),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.grey,
                                    backgroundColor: Colores.backgroundWidget,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    minimumSize: const Size(75, 75)),
                                onPressed: () {
                                  choiseFromCamara();
                                },
                                child: const Icon(Icons.camera)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.grey,
                                    backgroundColor: Colores.backgroundWidget,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    minimumSize: const Size(50, 50)),
                                onPressed: () {
                                  toBaseImage();
                                },
                                child: const Icon(Icons.person)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.grey,
                                    backgroundColor: Colores.backgroundWidget,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    minimumSize: const Size(75, 75)),
                                onPressed: () {
                                  choiseFromDirectory();
                                },
                                child: const Icon(Icons.file_open)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: Column(
                          children: component(context),
                        ),
                      )
                    ],
                  ));
  }

  userForm(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: isMobile(context)
            ? Container()
            : GridLayout(
                childAspectRatio: isMobile(context)
                    ? 4.0
                    : isTablet(context)
                        ? 5.0
                        : isDesktop(context)
                            ? 6.0
                            : 7.0,
                columnCount: 2,
                children: secondComponent(context)));
  }

  // Operaciones de la Interfaz ** *********** ********* ****
  void returnGestion(BuildContext context) {
    switch (widget.operationActivity) {
      case Constantes.Nulo:
        break;
      case Constantes.Consult:
        break;
      case Constantes.Register:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const GestionPacientes()));
        break;
      case Constantes.Update:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const GestionPacientes()));
        break;
      default:
    }
  }

  choiseFromCamara() async {
    XFile? xFileImage = await picker.pickImage(source: ImageSource.camera);
    if (xFileImage != null) {
      Uint8List bytes = await xFileImage.readAsBytes();
      setState(() {
        img = base64.encode(bytes);
        Pacientes.imagenPaciente = img;
      });
    }
  }

  choiseFromDirectory() async {
    XFile? xFileImage = await picker.pickImage(source: ImageSource.gallery);
    if (xFileImage != null) {
      Uint8List bytes = await xFileImage.readAsBytes();
      setState(() {
        img = base64.encode(bytes);
        Pacientes.imagenPaciente = img;
      });
    }
  }

  toBaseImage() async {
    ByteData bytes = await rootBundle.load('assets/images/person.png');
    var buffer = bytes.buffer;

    setState(() {
      img = base64.encode(Uint8List.view(buffer));
    });
  }

  void operationMethod(BuildContext context) {
    try {
      Operadores.loadingActivity(
          context: context,
          tittle: "Registro de información",
          message: "Registrando datos . . . ");
      listOfValues = [
        idOperation,
        numeroPacienteTextController.text.trim(),
        agregadoPacienteTextController.text.trim().toUpperCase(),
        Sentences.capitalize(firstNamePaciente.text).trim(),
        Sentences.capitalize(secondNameTextController.text).trim(),
        Sentences.capitalize(apellidoPaternoTextController.text).trim(),
        Sentences.capitalize(apellidoMaternoTextController.text).trim(),
        hemotipoValue,
        img,
        //
        unidadMedicaTextController.text,
        hospitalAtencionTextController.text,
        turnoValue,
        //
        DateTime.now().toString(),
        DateTime.now().toString(),
        //
        telefonoTextController.text,
        nacimientoTextController.text,
        sessoValue,
        atencionValue,
        //
        curpTextController.text.toUpperCase(),
        rfcTextController.text.toUpperCase(),
        //
        edadTextController.text,
        vivoValue,
        ocupacionTextController.text,
        estadoCivilValue,
        religionTextController.text,
        escolaridadValue,
        escolaridadCompletudValue,
        escolaridadEspecificacionTextController.text,
        municipioTextController.text.trimRight(),
        entidadFederativaValue.trimRight(),
        localidadResidenciaTextController.text.trimRight(),
        duracionResidenciaTextController.text.trimRight(),
        domicilioTextController.text.trimRight(),
        indigenaValue,
        indigenaHablanteValue,
        indigenaHablanteEspecificacioTextController.text,
        idOperation
      ];

      //print("${widget.operationActivity} listOfValues $listOfValues ${listOfValues!.length}");

      switch (widget.operationActivity) {
        case Constantes.Nulo:
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();

          Actividades.registrar(Databases.siteground_database_regpace,
                  registerQuery, listOfValues!)
              .then((value) {
            // Registro de Antecedentes No Patológicos ******** ******** ********
            Eticos.registrarRegistro(); // Si
            Viviendas.registrarRegistro(); // Si
            Higienes.registrarRegistro(); // Si
            Diarios.registrarRegistro(); // Si
            Alimenticios.registrarRegistro(); // Si
            Limitaciones.registrarRegistro(); // Si
            Sustancias.registrarRegistro(); // Si
            //
            // Toxicomanias.consultarRegistro();
            // ******** ******** ********
            reiniciar().then((value) {
              Operadores.alertActivity(
                  context: context,
                  tittle: "Registro de los Valores",
                  message: 'El registro del paciente fue agregado',
                  onAcept: () {
                    returnGestion(context);
                    // Navigator.of(context).pop();
                  });
            });
          });
          break;
        case Constantes.Consult:
          break;
        case Constantes.Register:
          listOfValues!.removeAt(0);
          listOfValues!.removeLast();

          Actividades.registrar(Databases.siteground_database_regpace,
                  registerQuery, listOfValues!)
              .then((value) {
            // Registro de Antecedentes No Patológicos ******** ******** ********
            Eticos.registrarRegistro(); // Si
            Viviendas.registrarRegistro(); // Si
            Higienes.registrarRegistro(); // Si
            Diarios.registrarRegistro(); // Si
            Alimenticios.registrarRegistro(); // Si
            Limitaciones.registrarRegistro(); // Si
            Sustancias.registrarRegistro(); // Si
            //
            // Toxicomanias.consultarRegistro();
            // ******** ******** ********
            reiniciar().then((value) {
              Operadores.alertActivity(
                  context: context,
                  tittle: "Registro de los Valores",
                  message: 'El registro del paciente fue agregado',
                  onAcept: () {
                    returnGestion(context);
                    // Navigator.of(context).pop();
                  });
            });
          }).onError((error, stackTrace) {
            Operadores.alertActivity(
                context: context,
                tittle: 'Error al Registrar paciente',
                message: "ERROR - $error : : $stackTrace",
                onAcept: () => Navigator.of(context).pop());
          });
          break;
        case Constantes.Update:
          Actividades.actualizar(Databases.siteground_database_regpace,
                  updateQuery, listOfValues!, idOperation)
              .then((value) {
            reiniciar().then((value) {
              Operadores.alertActivity(
                  context: context,
                  tittle: "Actualización de los Valores",
                  message: 'El registro del paciente fue Actualizado',
                  onAcept: () {
                    returnGestion(context);
                    // Navigator.of(context).pop();
                  });
            });
          }).onError((error, stackTrace) {
            Operadores.alertActivity(
                context: context,
                tittle: 'Error al Actualizar paciente',
                message: "ERROR - $error : : $stackTrace",
                onAcept: () => Navigator.of(context).pop());
          });
          break;
        default:
      }
    } on Exception catch (ex) {
      Terminal.printAlert(
          message: "Error al operar con los valores : : : $ex ");
      showDialog(
          context: context,
          builder: (context) {
            return alertDialog("Error al operar con los valores", "$ex", () {
              Navigator.of(context).pop();
            }, () {
              Navigator.of(context).pop();
            });
          });
    } finally {
      // returnGestion(context);
    }
  }

  // VARIABLES DE LA INTERFAZ ************ ************** *
  final picker = ImagePicker();

  String consultIdQuery = Pacientes.pacientes['consultIdQuery'];
  String registerQuery = Pacientes.pacientes['registerQuery'];
  String updateQuery = Pacientes.pacientes['updateQuery'];

  int idOperation = 0;

  final numeroPacienteTextController = TextEditingController();
  final agregadoPacienteTextController = TextEditingController();

  final firstNamePaciente = TextEditingController();
  final secondNameTextController = TextEditingController();

  final apellidoPaternoTextController = TextEditingController();
  final apellidoMaternoTextController = TextEditingController();

  final unidadMedicaTextController = TextEditingController();
  final hospitalAtencionTextController = TextEditingController();

  final domicilioTextController = TextEditingController();
  final duracionResidenciaTextController = TextEditingController();
  final localidadResidenciaTextController = TextEditingController();

  final escolaridadEspecificacionTextController = TextEditingController();
  final religionTextController = TextEditingController();
  final ocupacionTextController = TextEditingController();
  final edadTextController = TextEditingController();

  final rfcTextController = TextEditingController();
  final curpTextController = TextEditingController();
  final nacimientoTextController = TextEditingController();

  final telefonoTextController = TextEditingController();
  final municipioTextController = TextEditingController();

  final indigenaHablanteEspecificacioTextController = TextEditingController();

  // *************************************************************************
  String turnoValue = Pacientes.Turno[0];
  String sessoValue = Pacientes.Sexo[0];
  String unidadMedicaValue = Pacientes.Unidades[0];
  String hemotipoValue = Items.Hemotipo[0];
  String atencionValue = Pacientes.Atencion[1];
  String statusValue = Pacientes.Status[0];
  String estadoCivilValue = Pacientes.EstadoCivil[0];
  String vivoValue = Pacientes.Vivo[0];
  String escolaridadValue = Pacientes.Escolaridad[0];
  String escolaridadCompletudValue = Pacientes.EscolaridadCompletud[0];
  //
  String indigenaValue = Pacientes.Indigena[0];
  String indigenaHablanteValue = Pacientes.lenguaIndigena[0];
  //String municipioValue = Pacientes.Municipios[0];
  String entidadFederativaValue = Pacientes.EntidadesFederativas[0];

  late String img = "";
//
  List<dynamic>? listOfValues;

  var carouselController = CarouselSliderController();
}
