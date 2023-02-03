import 'dart:async';
import 'dart:typed_data';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';

import 'package:assistant/screens/pacientes/auxiliares/pacientes_auxiliares.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/hospitalizacion.dart';
import 'package:assistant/screens/pacientes/intensiva/herramientas.dart';
import 'package:assistant/screens/pacientes/paraclinicos/AuxiliaresDiagnosticos.dart';
import 'package:assistant/screens/pacientes/patologicos/alergicos.dart';
import 'package:assistant/screens/pacientes/patologicos/patologicos.dart';
import 'package:assistant/screens/pacientes/patologicos/quirurgicos.dart';
import 'package:assistant/screens/pacientes/patologicos/transfusionales.dart';
import 'package:assistant/screens/pacientes/patologicos/vacunales.dart';
import 'package:assistant/screens/pacientes/reportes/reportes.dart';

import 'package:assistant/screens/pacientes/vitales/vitales.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/GridLayout.dart';
import 'package:assistant/widgets/LoadingScreen.dart';
import 'package:assistant/widgets/MenuButton.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/Tittle.dart';
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
import 'package:fl_chart/fl_chart.dart';

import 'dart:convert';

class GestionPacientes extends StatefulWidget {
  const GestionPacientes({Key? key}) : super(key: key);

  @override
  State<GestionPacientes> createState() => _GestionPacientesState();
}

class _GestionPacientesState extends State<GestionPacientes> {
  String? consultQuery = Pacientes.pacientes['consultQuery'];

  late List? foundedUsuarios = [];
  var gestionScrollController = ScrollController();
  var searchTextController = TextEditingController();

  String searchCriteria = "Buscar por Apellido";

  @override
  void initState() {
    Actividades.consultar(Databases.siteground_database_regpace, consultQuery!)
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
            .where((user) => user["Pace_Ape_Pat"].contains(enteredKeyword))
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
                _pullListRefresh();
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
                                return Container(
                                  padding: const EdgeInsets.all(2.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Pacientes.ID_Paciente =
                                          snapshot.data[posicion]['ID_Pace'];
                                      Pacientes.Paciente =
                                          snapshot.data[posicion];
                                      // Cambio de la Variable de imagen al actualizar.
                                      Pacientes.imagenPaciente =
                                          snapshot.data[posicion]['Pace_FIAT'];
                                      Pacientes.Paciente['Pace_FIAT'] =
                                          snapshot.data[posicion]['Pace_FIAT'];

                                      toVisual(context, Constantes.Update);
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
                                                  children: [
                                                    CircleAvatar(
                                                        backgroundColor:
                                                            Colors.grey,
                                                        radius: 50,
                                                        child: ClipOval(
                                                            child: Image.memory(
                                                          base64Decode(snapshot
                                                                      .data[
                                                                  posicion]
                                                              ['Pace_FIAT']),
                                                          width: 100,
                                                          height: 100,
                                                          fit: BoxFit.cover,
                                                        ))),
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
                                                                      closeDialog(
                                                                          context);
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

  void closeDialog(BuildContext context) {
    Navigator.of(context).pop();
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
    //
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: const Text(
              'Iniciado interfaz',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            content: LoadingScreen(
              error: 'Iniciando Interfaz . . . ',
            ),
          );
        });
    // Despues de la selección se espera  5 segundos
    var response = await Valores().load(); // print("response $response");
    //
    if (response == true) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => VisualPacientes(actualPage: 0),
        ),
      );
    }
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
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (a, b, c) => const GestionPacientes(),
            transitionDuration: const Duration(seconds: 0)));
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

        img = Pacientes.Paciente['Pace_FIAT'];

        super.initState();
        break;
      default:
    }
  }

  List<Widget> component(BuildContext context) {
    return [
      editText(
          false, "Número de Afiliación", numeroPacienteTextController, false),
      editText(false, 'Agregado médico', agregadoPacienteTextController, false),
      editText(false, 'Primer nombre del paciente', firstNamePaciente, false),
      editText(false, 'Segundo nombre del paciente', secondNameTextController,
          false),
      editText(false, 'Apellido Paterno', apellidoPaternoTextController, false),
      editText(false, 'Apellido Materno', apellidoMaternoTextController, false),
    ];
  }

  List<Widget> secondComponent(BuildContext context) {
    return [
      Spinner(
          tittle: "Unidad de Atención",
          initialValue: unidadMedicaValue,
          items: Pacientes.Unidades,
          onChangeValue: (String? newValue) {
            setState(() {
              unidadMedicaValue = newValue!;
            });
          }),
      Spinner(
          tittle: "Hospital de Atención",
          initialValue: unidadMedicaValue,
          items: Pacientes.Unidades,
          onChangeValue: (String? newValue) {
            setState(() {
              unidadMedicaValue = newValue!;
            });
          }),
      Spinner(
          tittle: "Turno de atención",
          initialValue: turnoValue,
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
        keyBoardType: TextInputType.number,
        inputFormat: MaskTextInputFormatter(
            mask: '####/##/##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy),
        isObscure: false,
        numOfLines: 1,
        fontSize: 16,
        labelEditText: 'Fecha de nacimiento',
        textController: nacimientoTextController,
        prefixIcon: false,
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
          items: Pacientes.EstadoCivil,
          onChangeValue: (String? newValue) {
            setState(() {
              estadoCivilValue = newValue!;
            });
          }),
      editText(false, 'Religión', religionTextController, false),
      //
      Spinner(
          tittle: "Escolaridad",
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
          items: Pacientes.Indigena,
          onChangeValue: (String? newValue) {
            setState(() {
              indigenaValue = newValue!;
            });
          }),
      Spinner(
          tittle: "Hablante Indígena",
          initialValue: indigenaHablanteValue,
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

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 61, 57, 57),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isMobile(context) || isTablet(context)
                  ? returnOperationUserButton(context)
                  : Container(),
              userPresentation(context),
              userForm(context),
              GrandButton(
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

  void returnGestion(BuildContext context) {
    switch (widget.operationActivity) {
      case Constantes.Nulo:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const GestionPacientes()));
        break;
      case Constantes.Consult:
        break;
      case Constantes.Register:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const GestionPacientes()));
        break;
      case Constantes.Update:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VisualPacientes(actualPage: 0)));
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
        // Pacientes.imagenPaciente = img;
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
            : Column(
                children: [
                  GridLayout(
                      childAspectRatio: isMobile(context)
                          ? 4.0
                          : isTablet(context)
                              ? 4.0
                              : isDesktop(context)
                                  ? 8.0
                                  : 7.0,
                      columnCount: 2,
                      children: secondComponent(context)),
                  const SizedBox(height: 10),
                  // grandButton(context, widget._operation_button, () {
                  //   operationMethod(context);
                  // }),
                ],
              ));
  }

  void operationMethod(BuildContext context) {
  try {
  listOfValues = [
  idOperation,
  numeroPacienteTextController.text,
  agregadoPacienteTextController.text,
  firstNamePaciente.text,
  secondNameTextController.text,
  apellidoPaternoTextController.text,
  apellidoMaternoTextController.text,
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
  curpTextController.text,
  rfcTextController.text,
  //
  edadTextController.text,
  vivoValue,
  ocupacionTextController.text,
  estadoCivilValue,
  religionTextController.text,
  escolaridadValue,
  escolaridadCompletudValue,
  escolaridadEspecificacionTextController.text,
  municipioTextController.text,
  entidadFederativaValue,
  localidadResidenciaTextController.text,
  duracionResidenciaTextController.text,
  domicilioTextController.text,
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
  registerQuery, listOfValues!.removeLast());
  break;
  case Constantes.Consult:
  break;
  case Constantes.Register:
  listOfValues!.removeAt(0);
  listOfValues!.removeLast();

  Actividades.registrar(Databases.siteground_database_regpace,
  registerQuery, listOfValues!)
      .then((value) => returnGestion(context));
  break;
  case Constantes.Update:
  Actividades.actualizar(Databases.siteground_database_regpace,
  updateQuery, listOfValues!, idOperation)
      .then((value) => Actividades.consultarId(
  Databases.siteground_database_regpace,
  consultIdQuery,
  idOperation)
      .then((value) {
  // print("Imagen paciente ${value['Pace_FIAT']}");
  img = value['Pace_FIAT'];
  Pacientes.Paciente = value;
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
  // returnGestion(context);
  }
  }

  // VARIABLES
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

class VisualPacientes extends StatefulWidget {
  int actualPage = 6;

  VisualPacientes({Key? key, required this.actualPage}) : super(key: key);

  @override
  State<VisualPacientes> createState() => _VisualPacientesState();
}

class _VisualPacientesState extends State<VisualPacientes> {
  @override
  void initState() {
    //
    // Valores();
    //
    setState(() {
      numeroPaciente = Pacientes.Paciente['Pace_NSS'];
      agregadoPaciente = Pacientes.Paciente['Pace_AGRE'];

      primerNombrePaciente = Pacientes.Paciente['Pace_Nome_PI'];
      segundoNombrePaciente = Pacientes.Paciente['Pace_Nome_SE'];
      apellidoPaternoPaciente = Pacientes.Paciente['Pace_Ape_Pat'];
      apellidoMaternoPaciente = Pacientes.Paciente['Pace_Ape_Mat'];

      edadPaciente = Pacientes.Paciente['Pace_Eda'].toString();
      numeroPaciente =
          "${Pacientes.Paciente['Pace_NSS']} ${Pacientes.Paciente['Pace_AGRE']}";
      // print("Pacientes.Paciente['Pace_FIAT'] ${Pacientes.Paciente['Pace_FIAT'].runtimeType}");
      imgPaciente = Pacientes.Paciente['Pace_FIAT'];

      statusPaciente = Pacientes.Paciente['Pace_Stat'];
      turnoPaciente = Pacientes.Paciente['Pace_Turo'];

      Pacientes(
          numeroPaciente,
          agregadoPaciente,
          primerNombrePaciente,
          segundoNombrePaciente,
          apellidoPaternoPaciente,
          apellidoMaternoPaciente,
          imgPaciente);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer:
          isMobile(context) || isTablet(context) ? drawerHome(context) : null,
      appBar: AppBar(
          leading: isTabletAndDesktop(context)
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                  tooltip: 'Regresar',
                  onPressed: () {
                    cerrarUsuario();
                  },
                )
              : null,
          backgroundColor: Colors.black,
          title: const Text(
            Sentences.app_bar_usuarios,
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.question_answer,
              ),
              tooltip: 'Mensajería',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return alertDialog("Manejo de registro",
                          "El registro ha sido actualizado / creado", () {
                        Navigator.of(context).pop();
                      }, () {});
                    });
              },
            ),
            IconButton(
                icon: const Icon(
                  Icons.safety_check,
                ),
                tooltip: '',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return emergentDialog(
                            context, Phrases.demoTittle, Phrases.demoPhrase,
                            () {
                          Navigator.of(context).pop();
                        });
                      }));
                }),
            IconButton(
                icon: const Icon(Icons.person),
                tooltip: '',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return imageDialog(
                            Pacientes.nombreCompleto, Pacientes.imagenPaciente,
                            () {
                          Navigator.of(context).pop();
                        });
                      });
                }),
          ]),
      body:
          isMobile(context) || isTablet(context) ? mobileView() : desktopView(),
      // Row(children: [
      //   Expanded(
      //     flex: isTabletAndDesktop(context)
      //         ? 2
      //         : isDesktop(context)
      //             ? 1
      //             : 0,
      //     child: isTabletAndDesktop(context) ? sideBar() : Container(),
      //   ),
      //   Expanded(
      //       flex: isTabletAndDesktop(context) ? 7 : 4,
      //       child: pantallasAuxiliares(widget.actualPage)),
      // ]),
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: Colors.black,
      //     tooltip: "",
      //     onPressed: () {
      //       // Navigator.push(context, MaterialPageRoute(builder: (_) {
      //       // return const Home();
      //       // return Create();
      //       //}));
      //     },
      //     child: const Icon(Icons.add)),
    );
  }

  Row mobileView() {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        flex: 0,
        child: Container(),
      ),
      Expanded(flex: 4, child: pantallasAuxiliares(widget.actualPage)),
    ]);
  }

  Row desktopView() {
    return Row(children: [
      Expanded(
        flex: 2,
        child: isTablet(context) ? sideBarTablet() : sideBarDesktop(),
      ),
      Expanded(flex: 7, child: pantallasAuxiliares(widget.actualPage)),
    ]);
  }

  void toNextScreen({context, int? index, screen}) {
    if (isMobile(context) || isTablet(context)) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
    } else {
      setState(() {
        widget.actualPage = index!;
      });
    }
  }

  void cerrarUsuario() {
    Pacientes.close();

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const GestionPacientes()));
  }
  //
  // Widget presentationUser() {
  //   if (isTablet(context)) {
  //     return Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: <Widget>[
  //         CircleAvatar(
  //             backgroundColor: Colors.grey,
  //             radius: 60,
  //             child: imgPaciente != ""
  //                 ? ClipOval(
  //                     child: Image.memory(
  //                     base64Decode(imgPaciente),
  //                     width: 250,
  //                     height: 250,
  //                     fit: BoxFit.cover,
  //                   ))
  //                 : const ClipOval(child: Icon(Icons.person))),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Text(
  //               "$apellidoPaternoPaciente $apellidoMaternoPaciente \n$primerNombrePaciente $segundoNombrePaciente",
  //               style: const TextStyle(fontSize: 14, color: Colors.white),
  //             ),
  //             Text(
  //               "$numeroPaciente",
  //               style: const TextStyle(fontSize: 12, color: Colors.white),
  //             ),
  //             Text(
  //               "Edad: ${edadPaciente.toString()} Años",
  //               style: const TextStyle(fontSize: 10, color: Colors.white),
  //             ),
  //             const SizedBox(
  //               height: 20,
  //             ),
  //             Text(
  //               "Estado actual: $statusPaciente",
  //               style: const TextStyle(fontSize: 10, color: Colors.white),
  //             ),
  //             Text(
  //               "Turno de Atención: $turnoPaciente",
  //               style: const TextStyle(fontSize: 10, color: Colors.white),
  //             ),
  //           ],
  //         ),
  //       ],
  //     );
  //   } else {
  //     return Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: <Widget>[
  //         const SizedBox(
  //           width: 10,
  //         ),
  //         CircleAvatar(
  //             backgroundColor: Colors.grey,
  //             radius: 60,
  //             child: imgPaciente != ""
  //                 ? ClipOval(
  //                     child: Image.memory(
  //                     base64Decode(imgPaciente),
  //                     width: 250,
  //                     height: 250,
  //                     fit: BoxFit.cover,
  //                   ))
  //                 : const ClipOval(child: Icon(Icons.person))),
  //         const SizedBox(
  //           width: 10,
  //         ),
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             Text(
  //               "$apellidoPaternoPaciente $apellidoMaternoPaciente \n$primerNombrePaciente $segundoNombrePaciente",
  //               style: const TextStyle(fontSize: 14, color: Colors.white),
  //             ),
  //             Text(
  //               "$numeroPaciente",
  //               style: const TextStyle(fontSize: 12, color: Colors.white),
  //             ),
  //             Text(
  //               "Edad: ${edadPaciente.toString()} Años",
  //               style: const TextStyle(fontSize: 10, color: Colors.white),
  //             ),
  //             const SizedBox(
  //               height: 20,
  //             ),
  //             Text(
  //               "Estado actual: $statusPaciente",
  //               style: const TextStyle(fontSize: 10, color: Colors.white),
  //             ),
  //             Text(
  //               "Turno de Atención: $turnoPaciente",
  //               style: const TextStyle(fontSize: 10, color: Colors.white),
  //             ),
  //           ],
  //         ),
  //       ],
  //     );
  //   }
  // }

  Drawer drawerHome(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
      backgroundColor: Colores.backgroundWidget,
      child: ListView(
        controller: scrollListController,
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: PresentacionPacientes()),
          Container(
            decoration: const BoxDecoration(color: Theming.terciaryColor),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: userActivities(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column sideBarDesktop() {
    return Column(
      children: [
        Container(color: Colors.black, child: const PresentacionPacientes()),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(color: Theming.terciaryColor),
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: userActivities(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container sideBarTablet() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: ListView(
        controller: scrollListController,
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(color: Colors.black),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  isTabletAndDesktop(context)
                      ? const PresentacionPacientes()
                      : Container(),
                ]),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(color: Theming.terciaryColor),
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: userActivities(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pantallasAuxiliares(int actualPage) {
    var list = [
      Dashboard(),
      OperacionesPacientes(operationActivity: Constantes.Update),
      const MenuPersonales(),
      const GestionVitales(),
      const Center(
        child: Text('Body 3'),
      ),
      const AuxiliaresDiagnosticos(),
      Intensiva(), // Analisis(),
      ReportesMedicos(),
      // GestionBalances(),
      const Center(
        child: Text('Body 7'),
      ),
      GestionHospitalizaciones(),
      const Center(
        child: Text('Body 9'),
      ),
      const Center(
        child: Text('Body 10'),
      )
    ];
    return list[actualPage];
  }

  List<Widget> userActivities(BuildContext context) {
    return [
      ListTile(
        leading: const Icon(
          Icons.dashboard,
          color: Colors.grey,
        ),
        title: const Text('Dashboard',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          // Update the state of the app
          setState(() {
            widget.actualPage = 0;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.person,
          color: Colors.grey,
        ),
        title: const Text(
          'Datos Generales',
          style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey),
        ),
        onTap: () {
          if (isMobile(context) || isTablet(context)) {
            Navigator.of(context).pop();
          }
          // Update the state of the app
          toNextScreen(
              context: context,
              index: 1,
              screen: OperacionesPacientes(
                operationActivity: Constantes.Update,
              ));
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.family_restroom,
          color: Colors.grey,
        ),
        title: const Text('Antecedentes Personales',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          // Update the state of the app
          if (isMobile(context) || isTablet(context)) {
            Navigator.of(context).pop();
          }
          setState(() {
            widget.actualPage = 2;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.medical_information,
          color: Colors.grey,
        ),
        title: const Text('Registro de Signos Vitales',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          if (isMobile(context) || isTablet(context)) {
            Navigator.of(context).pop();
          }
          // Update the state of the app
          toNextScreen(
              context: context, index: 3, screen: const GestionVitales());
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.medical_services,
          color: Colors.grey,
        ),
        title: const Text('Registro de Consultas',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          if (isMobile(context) || isTablet(context)) {
            Navigator.of(context).pop();
          }
          // Update the state of the app
          setState(() {
            widget.actualPage = 4;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.settings,
          color: Colors.grey,
        ),
        title: const Text('Auxiliares Diagnósticos',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          if (isMobile(context) || isTablet(context)) {
            Navigator.of(context).pop();
          }
          // Update the state of the app
          toNextScreen(
              context: context,
              index: 5,
              screen: const AuxiliaresDiagnosticos());
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.settings,
          color: Colors.grey,
        ),
        title: const Text('Herramientas de Terapia Intensiva',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          if (isMobile(context) || isTablet(context)) {
            Navigator.of(context).pop();
          }
          // Update the state of the app
          setState(() {
            widget.actualPage = 6;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.settings,
          color: Colors.grey,
        ),
        title: const Text('Reportes y Notas Médicas',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ReportesMedicos()));
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.settings,
          color: Colors.grey,
        ),
        title: const Text('Archivos y Documentos',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          if (isMobile(context) || isTablet(context)) {
            Navigator.of(context).pop();
          }
          // Update the state of the app
          setState(() {
            widget.actualPage = 8;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.medical_services_outlined,
          color: Colors.grey,
        ),
        title: const Text('Registro de Hospitalización',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          if (isMobile(context) || isTablet(context)) {
            Navigator.of(context).pop();
          }
          // Update the state of the app
          toNextScreen(
              context: context, index: 9, screen: GestionHospitalizaciones());
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.settings,
          color: Colors.grey,
        ),
        title: const Text('Licencias Médicas',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          if (isMobile(context) || isTablet(context)) {
            Navigator.of(context).pop();
          }
          // Update the state of the app
          setState(() {
            widget.actualPage = 10;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.settings,
          color: Colors.grey,
        ),
        title: const Text('Registro de Embarazos',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          if (isMobile(context) || isTablet(context)) {
            Navigator.of(context).pop();
          }
          // Update the state of the app
          setState(() {
            widget.actualPage = 11;
          });
        },
      ),
      ListTile(
        leading: const Icon(
          Icons.exit_to_app,
          color: Colors.grey,
        ),
        title: const Text('Regresar',
            style: TextStyle(fontSize: Font.fontTileSize, color: Colors.grey)),
        onTap: () {
          cerrarUsuario();
        },
      ),
    ];
  }

  // Variables
  var scrollController = ScrollController();
  var scrollListController = ScrollController();

  String? turnoPaciente,
      statusPaciente,
      numeroPaciente,
      agregadoPaciente,
      primerNombrePaciente,
      segundoNombrePaciente,
      apellidoPaternoPaciente,
      apellidoMaternoPaciente,
      edadPaciente;
  late String imgPaciente = "";
}

class EstadisticasPacientes extends StatefulWidget {
  const EstadisticasPacientes({Key? key}) : super(key: key);

  @override
  State<EstadisticasPacientes> createState() => _EstadisticasPacientesState();
}

class _EstadisticasPacientesState extends State<EstadisticasPacientes> {
  Map<String, dynamic> data = {
    // "Total_Pacientes": 0,
    "Total_Mujeres": 0,
    "Total_Hombres": 0,
    //
    "Total_Hospitalizacion": 0,
    "Total_Consulta": 0,
    "Total_Matutino": 0,
    "Total_Vespertino": 0,
    "Total_Vivos": 0,
    "Total_Fallecidos": 0,
    "Total_Indigenas": 0,
    "Total_No_Indigenas": 0,
    "Total_Hablantes": 0,
    "Total_No_Hablantes": 0,
    "Total_Pacientes": 0,
  };
  var statScrollController = ScrollController();

  @override
  void initState() {
    Actividades.detalles(Databases.siteground_database_regpace,
            Pacientes.pacientes['pacientesStadistics'])
        .then((value) {
      setState(() {
        data = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 58, 55, 55)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(),
              child: const Text(
                'Estadisticas de Pacientes',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: isMobile(context) ? 2 : 1,
              child: isTablet(context) || isMobile(context)
                  ? Column(
                      children: [
                        Flexible(
                            flex: 2,
                            child: data['Total_Pacientes'] != 0
                                ? PieChart(PieChartData(
                                    sections: listChartSections(
                                        data['Total_Pacientes'])))
                                : Container()),
                        Flexible(
                            flex: 3,
                            child: SingleChildScrollView(
                              controller: ScrollController(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  tileStat(Icons.person, "Total de Pacientes",
                                      data['Total_Pacientes']),
                                  tileStat(Icons.person_add_outlined,
                                      "Total de Activos", data['Total_Vivos']),
                                  tileStat(
                                      Icons.person_off_outlined,
                                      "Total de Fallecidos",
                                      data['Total_Fallecidos'])
                                ],
                              ),
                            ))
                      ],
                    )
                  : Row(
                      children: [
                        Flexible(
                            flex: 2,
                            child: data['Total_Pacientes'] != 0
                                ? PieChart(PieChartData(
                                    sections: listChartSections(
                                        data['Total_Pacientes'])))
                                : Container()),
                        Flexible(
                            flex: 3,
                            child: SingleChildScrollView(
                              controller: ScrollController(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  tileStat(Icons.person, "Total de Pacientes",
                                      data['Total_Pacientes']),
                                  tileStat(Icons.person_add_outlined,
                                      "Total de Activos", data['Total_Vivos']),
                                  tileStat(
                                      Icons.person_off_outlined,
                                      "Total de Fallecidos",
                                      data['Total_Fallecidos'])
                                ],
                              ),
                            ))
                      ],
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
                flex: 2,
                //fit: FlexFit.tight,
                child: ListView.builder(
                    //shrinkWrap: true,
                    controller: statScrollController,
                    itemCount: Pacientes.Categorias.length,
                    itemBuilder: (BuildContext context, index) {
                      //print("INDEX BUILDER $index ${Pacientes.Categorias[index]} ${data!.values.toList().elementAt(index).runtimeType}");
                      //print("data data $data");
                      if (index <= data.length) {
                        return tileStat(Icons.list, Pacientes.Categorias[index],
                            data.values.toList().elementAt(index));
                      } else {
                        return Container();
                      }
                    }))
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> listChartSections(int total) {
    List<PieChartSectionData> list = [];
    Indices.indice = 0;

    data.forEach((key, value) {
      // # . . . # # # . . . #
      //print("total ${value!} $total ${total / value!}");
      double val = ((value! * 100) / total);
      // # . . . # # # . . . #
      list.add(PieChartSectionData(
        color: Colores.locales[Indices.indice],
        value: (val),
        title: "${val.toStringAsFixed(1)} %",
        radius: 20,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ));
      Indices.indice++;
    });
    return list;
  }

  Padding tileStat(IconData? icon, String tittle, int stat) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 0, top: 0),
      child: ListTile(
        leading: Icon(icon!, color: Colors.white),
        title: Text(
          tittle,
          style: const TextStyle(
              fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          "$stat Pacientes",
          style: const TextStyle(fontSize: 10, color: Colors.white),
        ),
      ),
    );
  }
}

class MenuPersonales extends StatelessWidget {
  const MenuPersonales({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Tittle(
              tittle: "Antecedentes Personales del Paciente",
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridLayout(
                  childAspectRatio: isMobile(context)
                      ? 1.0
                      : isTablet(context)
                          ? 2.0
                          : 4.0,
                  columnCount: 2,
                  children: [
                    MenuButton(
                        iconData: Icons.family_restroom,
                        labelButton: "Antecedentes Heredofamiliares",
                        onPress: () {}),
                    MenuButton(
                        iconData: Icons.medication,
                        labelButton: "Antecedentes Personales Patológicos",
                        onPress: () {
                          toNextPage(context, GestionPatologicos());
                        }),
                    MenuButton(
                        iconData: Icons.person_pin,
                        labelButton: "Antecedentes Personales No Patológicos",
                        onPress: () {}),
                    MenuButton(
                        iconData: Icons.bloodtype,
                        labelButton: "Antecedentes Transfusionales",
                        onPress: () {
                          toNextPage(context, GestionTransfusionales());
                        }),
                    MenuButton(
                        iconData: Icons.medical_information_rounded,
                        labelButton: "Antecedentes Quirúrgicos",
                        onPress: () {
                          toNextPage(context, GestionQuirurgicos());
                        }),
                    MenuButton(
                        iconData: Icons.vaccines,
                        labelButton: "Antecedentes Vacunales",
                        onPress: () {
                          toNextPage(context, GestionVacunales());
                        }),
                    MenuButton(
                        iconData: Icons.medication_liquid,
                        labelButton: "Antecedentes Alérgicos",
                        onPress: () {
                          toNextPage(context, GestionAlergicos());
                        }),
                    MenuButton(
                        iconData: Icons.quiz,
                        labelButton: "Cuestionarios",
                        onPress: () {})
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  void toNextPage(BuildContext context, screen) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => screen)));
  }
}
