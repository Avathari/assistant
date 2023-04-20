import 'dart:async';
import 'dart:typed_data';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/antecesor/visuales.dart';
import 'package:assistant/screens/pacientes/auxiliares/estadisticas/estadisticas.dart';

import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/GridLayout.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/WidgetsModels.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
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
  const GestionPacientes({Key? key}) : super(key: key);

  @override
  State<GestionPacientes> createState() => _GestionPacientesState();
}

class _GestionPacientesState extends State<GestionPacientes> {
  late List? foundedItems = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  String searchCriteria = "Buscar por Apellido";

  var fileAssocieted = 'assets/vault/pacientesRepository.json';

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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const Home()));
            },
          ),
          title: const Text(Sentences.app_pacientes_tittle),
          actions: <Widget>[
            isMobile(context)
                ? GrandIcon(
                    iconData: Icons.bar_chart,
                    onPress: () {
                      Operadores.openActivity(
                          context: context,
                          chyldrim: const EstadisticasPacientes());
                    })
                : Container(),
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
              tooltip: Sentences.add_usuario,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => OperacionesPacientes(
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
                            reiniciar(); // _pullListRefresh();
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
                                return Container(
                                  padding: const EdgeInsets.all(2.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      try {
                                        Pacientes.ID_Paciente =
                                            snapshot.data[posicion]['ID_Pace'];
                                        Pacientes.Paciente =
                                            snapshot.data[posicion];
                                        setState(() {
                                          Pacientes.fromJson(
                                              snapshot.data[posicion]);
                                        });
                                        Terminal.printNotice(
                                          message:
                                              "Nombre conformado ${Pacientes.nombreCompleto}",
                                        );
                                        // Consulta de Antecedentes No Patológicos **** ***** ******* ****
                                        Eticos.consultarRegistro();
                                        Viviendas.consultarRegistro();
                                        Higienes.consultarRegistro();
                                        Diarios.consultarRegistro();
                                        Alimenticios.consultarRegistro();
                                        Limitaciones.consultarRegistro();
                                        Sustancias.consultarRegistro();

                                        Toxicomanias.consultarRegistro();

                                        toVisual(context, Constantes.Update);
                                      } on Exception catch (e) {
                                        Terminal.printAlert(
                                            message: "ERROR - toVisual : : $e");
                                        Operadores.alertActivity(
                                            message: "ERROR - toVisual : : $e",
                                            context: context,
                                            tittle: 'Error al Inicial Visual');
                                      }
                                    },
                                    child: Card(
                                      color:
                                          const Color.fromARGB(255, 54, 50, 50),
                                      child: Container(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Column(
                                                  children: const [
                                                    CircleAvatar(
                                                        backgroundColor:
                                                            Colors.grey,
                                                        radius: 50,
                                                        child: Icon(
                                                          Icons.person,
                                                          size: 75.0,
                                                          color: Colors.black,
                                                        )),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 10.0,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
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
                                                          "Número Paciente : ${snapshot.data[posicion]['ID_Pace']}",
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 12),
                                                        ),
                                                        Text(
                                                          "${snapshot.data[posicion]['Pace_Ape_Pat']} ${snapshot.data[posicion]['Pace_Ape_Mat']} "
                                                          "\n${snapshot.data[posicion]['Pace_Nome_PI']} ${snapshot.data[posicion]['Pace_Nome_SE']}",
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 14),
                                                        ),
                                                        Text(
                                                          "${snapshot.data[posicion]['Pace_NSS']} ${snapshot.data[posicion]['Pace_AGRE']}",
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 12),
                                                        ),
                                                        Text(
                                                          "Edad : ${snapshot.data[posicion]['Pace_Eda']}",
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 12),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        const SizedBox(
                                                          width: 20,
                                                        ),
                                                        IconButton(
                                                          color: Colors.grey,
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
                                                                      snapshot.data[
                                                                              posicion]
                                                                          [
                                                                          'Pace_FIAT'],
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  });
                                                                });
                                                          },
                                                        ),
                                                        IconButton(
                                                          color: Colors.grey,
                                                          icon: const Icon(Icons
                                                              .update_rounded),
                                                          onPressed: () {
                                                            Pacientes
                                                                    .ID_Paciente =
                                                                snapshot.data[
                                                                        posicion]
                                                                    ['ID_Pace'];
                                                            Pacientes.Paciente =
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
                                                        IconButton(
                                                          color: Colors.grey,
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
                                                                      Navigator.of(
                                                                              context)
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
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
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
        isTablet(context)
            ? const Expanded(flex: 1, child: EstadisticasPacientes())
            : isDesktop(context)
                ? const Expanded(flex: 1, child: EstadisticasPacientes())
                : isTabletAndDesktop(context)
                    ? const Expanded(flex: 1, child: EstadisticasPacientes())
                    : Container()
      ]),
    );
  }

  void iniciar() {
    Terminal.printWarning(
        message: " . . . Iniciando Actividad - Repositorio de Pacientes");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        foundedItems = value;
      });
    }).onError((error, stackTrace) {
      reiniciar();
    });
    Terminal.printWarning(message: " . . . Actividad Iniciada");
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
          elementSearched: enteredKeyword);

      setState(() {
        foundedItems = results;
      });
    }
  }

  void reiniciar() {
    Terminal.printAlert(
        message: "Iniciando actividad : : \n "
            "Consulta de pacientes hospitalizados . . .");
    Actividades.consultar(Databases.siteground_database_regpace,
            Pacientes.pacientes['consultQuery']!)
        .then((value) {
      setState(() {
        Terminal.printSuccess(
            message: "Actualizando repositorio de pacientes . . . ");
        foundedItems = value;
        Archivos.createJsonFromMap(foundedItems!, filePath: fileAssocieted);
      });
    }).whenComplete(() => Operadores.alertActivity(
            context: context,
            tittle: "Datos Recargados",
            message: "Registro Actualizado",
            onAcept: () {
              Navigator.of(context).pop();
            }));
  }
}

class OperacionesPacientes extends StatefulWidget {
  //const OperacionesPacientes({super.key});
  // final Map<String, dynamic> lista;
  // final int index;
  final String operationActivity;

  String _operation_button = 'Nulo';

  OperacionesPacientes({Key? key, required this.operationActivity})
      : super(key: key);

  @override
  State<OperacionesPacientes> createState() => _OperacionesPacientesState();
}

class _OperacionesPacientesState extends State<OperacionesPacientes> {
  @override
  void initState() {
    Terminal.printExpected(
        message: "Actividad : : ${widget.operationActivity}");

    switch (widget.operationActivity) {
      case Constantes.Nulo:
        break;
      case Constantes.Consult:
        break;
      case Constantes.Register:
        widget._operation_button = 'Registrar';

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

        hemotipoValue = Pacientes.Paciente['Pace_Hemo'] ?? '';

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
      appBar: widget.operationActivity == Constantes.Register
          ? AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                ),
                tooltip: Sentences.regresar,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const GestionPacientes()));
                },
              ))
          : null,
      body: Card(
        color: const Color.fromARGB(255, 61, 57, 57),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isMobile(context) || isTablet(context)
                  ? returnOperationUserButton(context)
                  : Container(),
              Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: ContainerDecoration.roundedDecoration(),
                  child: userPresentation(context)),
              Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: ContainerDecoration.roundedDecoration(),
                  child: userForm(context)),
              GrandButton(
                  weigth: isMobile(context) ? 200 : 1000,
                  labelButton: widget._operation_button,
                  onPress: () {
                    operationMethod(context);
                  })
            ],
          ),
        ),
      ),
    );
  }

  // Operaciones de Inicio ***** ******* ********** ****
  Future<void> reiniciar() async {
    Archivos.deleteFile(filePath: Pacientes.localPath);
    var fileAssocieted = 'assets/vault/pacientesRepository.json';
    Terminal.printWarning(
        message: " . . . Reiniciando Actividad - Repositorio de Pacientes");
    Archivos.deleteFile(filePath: fileAssocieted);
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
      ),
      editText(false, 'Agregado médico', agregadoPacienteTextController, false),
      EditTextArea(
          labelEditText: 'Primer nombre del paciente',
          numOfLines: 1,
          textController: firstNamePaciente,
          keyBoardType: TextInputType.text,
          inputFormat: MaskTextInputFormatter()),
      editText(false, 'Segundo nombre del paciente', secondNameTextController,
          false),
      editText(false, 'Apellido Paterno', apellidoPaternoTextController, false),
      editText(false, 'Apellido Materno', apellidoMaternoTextController, false),
      Spinner(
          tittle: "Tipo Sanguíneo",
          initialValue: hemotipoValue,
          items: Items.Hemotipo,
          width: isMobile(context)
              ? 216
              : isTablet(context)
                  ? 140
                  : 200,
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
                  : 200,
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
                  : 200,
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
                  : 200,
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
                  : 200,
          onChangeValue: (String? newValue) {
            setState(() {
              atencionValue = newValue!;
            });
          }),
      editFormattedText(
          TextInputType.phone,
          MaskTextInputFormatter(
              mask: '+## (###) ###-####',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Teléfono',
          telefonoTextController,
          false),
      EditTextArea(
        keyBoardType: TextInputType.datetime,
        inputFormat: MaskTextInputFormatter(
            mask: '####-##-##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        isObscure: false,
        numOfLines: 1,
        fontSize: 16,
        labelEditText: 'Fecha de Nacimiento',
        textController: nacimientoTextController,
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
                  : 200,
          items: Pacientes.Sexo,
          onChangeValue: (String? newValue) {
            setState(() {
              sessoValue = newValue!;
            });
          }),
      editFormattedText(
          TextInputType.number,
          MaskTextInputFormatter(
              mask: '###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
          false,
          'Edad',
          edadTextController,
          false),
      editText(false, 'CURP', curpTextController, false),
      editText(false, 'RFC', rfcTextController, false),
      //

      Spinner(
          tittle: "¿Vive?",
          initialValue: vivoValue,
          width: isMobile(context)
              ? 216
              : isTablet(context)
                  ? 170
                  : 200,
          items: Pacientes.Vivo,
          onChangeValue: (String? newValue) {
            setState(() {
              vivoValue = newValue!;
            });
          }),
      editText(false, 'Ocupación', ocupacionTextController, false),
      Spinner(
          tittle: "Estado civil",
          initialValue: estadoCivilValue,
          width: isMobile(context)
              ? 216
              : isTablet(context)
                  ? 170
                  : 200,
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
                  : 200,
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
                  : 200,
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
      editText(false, 'Especificar escolaridad',
          escolaridadEspecificacionTextController, false),
      // spinner(tittle: "Estado actual", statusValue, Pacientes.Status,
      //     (String? newValue) {
      //   setState(() {
      //     statusValue = newValue!;
      //   });
      // }),
      //

      editText(false, 'Municipio residencial', municipioTextController, false),
      // spinner(tittle: "Municipio residencial", municipioValue,
      //     Pacientes.Municipios, (String? newValue) {
      //   setState(() {
      //     municipioValue = newValue!;
      //   });
      // }),
      Spinner(
          tittle: "Entidad federativa",
          initialValue: entidadFederativaValue,
          width: isMobile(context)
              ? 216
              : isTablet(context)
                  ? 170
                  : 200,
          items: Pacientes.EntidadesFederativas,
          onChangeValue: (String? newValue) {
            setState(() {
              entidadFederativaValue = newValue!;
            });
          }),

      editText(false, 'Localidad', localidadResidenciaTextController, false),
      editText(false, 'Duración', duracionResidenciaTextController, false),
      editText(false, 'Domicilio', domicilioTextController, false),
      //
      Spinner(
          tittle: "Indigena (Si/No)",
          initialValue: indigenaValue,
          width: isMobile(context)
              ? 216
              : isTablet(context)
                  ? 170
                  : 200,
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
                  : 200,
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
      editText(false, 'Especificar lenguaje',
          indigenaHablanteEspecificacioTextController, false),
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
                  primary: Colores.backgroundWidget,
                  onPrimary: Colors.grey,
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
                    primary: Colores.backgroundWidget,
                    onPrimary: Colors.grey,
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
                      primary: Colores.backgroundWidget,
                      onPrimary: Colors.grey,
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
                                      primary: Colores.backgroundWidget,
                                      onPrimary: Colors.grey,
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
                                      primary: Colores.backgroundWidget,
                                      onPrimary: Colors.grey,
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
                                      primary: Colores.backgroundWidget,
                                      onPrimary: Colors.grey,
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
                                primary: Colores.backgroundWidget,
                                onPrimary: Colors.grey,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
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
                                primary: Colores.backgroundWidget,
                                onPrimary: Colors.grey,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
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
                                primary: Colores.backgroundWidget,
                                onPrimary: Colors.grey,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
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
      Operadores.loadingActivity(context: context, tittle: "Registro de información",message: "Registrando datos . . . ");
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
          });
          // .then((value) => Actividades.consultarId(
          //             Databases.siteground_database_regpace,
          //             consultIdQuery,
          //             idOperation)
          //         .then((value) {
          //       // print("Imagen paciente ${value['Pace_FIAT']}");
          //       img = value['Pace_FIAT'];
          //       Pacientes.Paciente = value;
          //     }).then((value) => returnGestion(context)));
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
  String indigenaValue = Pacientes.Indigena[0];
  String indigenaHablanteValue = Pacientes.lenguaIndigena[0];
  //String municipioValue = Pacientes.Municipios[0];
  String entidadFederativaValue = Pacientes.EntidadesFederativas[0];

  late String img = "";

  List<dynamic>? listOfValues;

  var carouselController = CarouselController();
}
