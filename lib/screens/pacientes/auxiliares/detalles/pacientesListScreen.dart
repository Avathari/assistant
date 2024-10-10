import 'dart:async';

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

class PacientesListScreen extends StatefulWidget {
  @override
  _PacientesListScreenState createState() => _PacientesListScreenState();
}

class _PacientesListScreenState extends State<PacientesListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.grey,
        backgroundColor: Colors.black,
        title: AppBarText("Registrar Usuarios"),
      ),
      body: isMobile(context) ? _mobileView(context) : _desktopView(context)
    );
  }

  _mobileView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            flex: 7,
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Container(
                padding: const EdgeInsets.only(top: 8.0),
                decoration: ContainerDecoration.roundedDecoration(
                  colorBackground: Theming.cuaternaryColor,
                ),
                child: Column(
                  children: [
                    // Formulario
                    Row(
                      children: [
                        Expanded(
                          child: EditTextArea(
                            labelEditText: "Número de Afiliación",
                            textController: _nssController,
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
                        ),
                        Expanded(
                          child: EditTextArea(
                              labelEditText: "Agregado . . . ",
                              textController: _agregadoController,
                              keyBoardType: TextInputType.text,
                              numOfLines: 1,
                              inputFormat: MaskTextInputFormatter()),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: EditTextArea(
                              labelEditText: "Nombre",
                              textController: _nombreInicialController,
                              keyBoardType: TextInputType.text,
                              numOfLines: 1,
                              inputFormat: MaskTextInputFormatter()),
                        ),
                        Expanded(
                          child: EditTextArea(
                              labelEditText: "Nombre Segundo",
                              textController: _nombreSecundarioController,
                              keyBoardType: TextInputType.text,
                              numOfLines: 1,
                              inputFormat: MaskTextInputFormatter()),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: EditTextArea(
                              labelEditText: "Apellido Paterno",
                              textController: _apellidoPaternoController,
                              keyBoardType: TextInputType.text,
                              numOfLines: 1,
                              inputFormat: MaskTextInputFormatter()),
                        ),
                        Expanded(
                          child: EditTextArea(
                              labelEditText: "Apellido Materno",
                              textController: _apellidoMaternoController,
                              keyBoardType: TextInputType.text,
                              numOfLines: 1,
                              inputFormat: MaskTextInputFormatter()),
                        ),
                      ],
                    ),
                    EditTextArea(
                      keyBoardType: TextInputType.datetime,
                      inputFormat: MaskTextInputFormatter(
                          mask: '####-##-##',
                          filter: {"#": RegExp(r'[0-9]')},
                          type: MaskAutoCompletionType.lazy),
                      isObscure: false,
                      numOfLines: 1,
                      labelEditText: 'Fecha de Nacimiento',
                      textController: _fechaNacimiento,
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
                                      dialogBackgroundColor:
                                      Theming.cuaternaryColor),
                                  child: child!);
                            });

                        setState(() {
                          _fechaNacimiento.text =
                              DateFormat("yyyy-MM-dd").format(picked!);
                          //
                          _edad = (DateTime.now()
                              .difference(DateTime.parse(
                              _fechaNacimiento.text))
                              .inDays /
                              365)
                              .toInt();
                        });
                      },
                      onChange: (value) {
                        setState(() {
                          // _fechaNacimiento.text = value;
                          _edad = (DateTime.now()
                              .difference(DateTime.parse(value))
                              .inDays /
                              365)
                              .toInt();
                        });
                      },
                    ),
                    //
                    Row(
                      children: [
                        Expanded(
                          child: Spinner(
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
                        ),
                        Expanded(
                          child: Spinner(
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
                        ),
                        Expanded(
                          child: Spinner(
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          CrossLine(height: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: GrandButton(
                      labelButton: "Eliminar listado . . . ",
                      onPress: () => setState(() => pacientes.clear()),
                    )),
                Expanded(
                    child: GrandButton(
                      labelButton: "Agregar paciente . . . ",
                      onPress: _agregarUsuario,
                    )),
              ],
            ),
          ),
          CrossLine(height: 10),
          // Lista de pacientes
          Expanded(
            flex: 6,
            child: Container(
              decoration: ContainerDecoration.roundedDecoration(
                colorBackground: Theming.cuaternaryColor,
              ),
              child: ListView.builder(
                itemCount: pacientes.length,
                itemBuilder: (context, index) {
                  // final usuario = pacientes[index];
                  return ListTile(
                    textColor: Colors.grey,
                    leading: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    titleTextStyle: TextStyle(fontSize: 11),
                    subtitleTextStyle: TextStyle(fontSize: 9),
                    title: Text(""
                        "${pacientes[index][2]} "
                        "${pacientes[index][3]} "
                        "${pacientes[index][4]} "
                        "${pacientes[index][5]} \n"
                        ": : "
                        "NSS : ${pacientes[index][0]} ${pacientes[index][1]} "
                        ""),
                    subtitle: Text(
                      "FN: ${pacientes[index][14]} ($_edad) "
                          "Estado : ${pacientes[index][17]} "
                          "Sexo : ${pacientes[index][15]} "
                          "- ${pacientes[index][16]} "
                          "",
                    ),
                    trailing: GrandIcon(
                        labelButton: "Eliminar registro . . . ",
                        iconData: Icons.delete_forever,
                        onPress: () =>
                            setState(() => pacientes.removeAt(index))),
                  );
                },
              ),
            ),
          ),
          // Botón para enviar los datos
          Expanded(
            child: GrandButton(
              weigth: 1000,
              labelButton: "Enviar a Base de Datos",
              onPress: _enviarUsuarios,
            ),
          ),
        ],
      ),
    );
  }

  _desktopView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(children: [
              Expanded(
                flex: 6,
                child: Container(
                  decoration: ContainerDecoration.roundedDecoration(
                    colorBackground: Theming.cuaternaryColor,
                  ),
                  child: ListView.builder(
                    itemCount: pacientes.length,
                    itemBuilder: (context, index) {
                      // final usuario = pacientes[index];
                      return ListTile(
                        textColor: Colors.grey,
                        leading: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        titleTextStyle: TextStyle(fontSize: 11),
                        subtitleTextStyle: TextStyle(fontSize: 9),
                        title: Text(""
                            "${pacientes[index][2]} "
                            "${pacientes[index][3]} "
                            "${pacientes[index][4]} "
                            "${pacientes[index][5]} \n"
                            ": : "
                            "NSS : ${pacientes[index][0]} ${pacientes[index][1]} "
                            ""),
                        subtitle: Text(
                          "FN: ${pacientes[index][14]} ($_edad) "
                              "Estado : ${pacientes[index][17]} "
                              "Sexo : ${pacientes[index][15]} "
                              "- ${pacientes[index][16]} "
                              "",
                        ),
                        trailing: GrandIcon(
                            labelButton: "Eliminar registro . . . ",
                            iconData: Icons.delete_forever,
                            onPress: () =>
                                setState(() => pacientes.removeAt(index))),
                      );
                    },
                  ),
                ),
              ),
              // Botón para enviar los datos
              Expanded(
                child: GrandButton(
                  weigth: 1000,
                  labelButton: "Enviar a Base de Datos",
                  onPress: _enviarUsuarios,
                ),
              ),
            ],),
          ),
          CrossLine(height: 10, isHorizontal: false,),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Container(
                      padding: const EdgeInsets.only(top: 8.0),
                      decoration: ContainerDecoration.roundedDecoration(
                        colorBackground: Theming.cuaternaryColor,
                      ),
                      child: Column(
                        children: [
                          // Formulario
                          Row(
                            children: [
                              Expanded(
                                child: EditTextArea(
                                  labelEditText: "Número de Afiliación",
                                  textController: _nssController,
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
                              ),
                              Expanded(
                                child: EditTextArea(
                                    labelEditText: "Agregado . . . ",
                                    textController: _agregadoController,
                                    keyBoardType: TextInputType.text,
                                    numOfLines: 1,
                                    inputFormat: MaskTextInputFormatter()),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: EditTextArea(
                                    labelEditText: "Nombre",
                                    textController: _nombreInicialController,
                                    keyBoardType: TextInputType.text,
                                    numOfLines: 1,
                                    inputFormat: MaskTextInputFormatter()),
                              ),
                              Expanded(
                                child: EditTextArea(
                                    labelEditText: "Nombre Segundo",
                                    textController: _nombreSecundarioController,
                                    keyBoardType: TextInputType.text,
                                    numOfLines: 1,
                                    inputFormat: MaskTextInputFormatter()),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: EditTextArea(
                                    labelEditText: "Apellido Paterno",
                                    textController: _apellidoPaternoController,
                                    keyBoardType: TextInputType.text,
                                    numOfLines: 1,
                                    inputFormat: MaskTextInputFormatter()),
                              ),
                              Expanded(
                                child: EditTextArea(
                                    labelEditText: "Apellido Materno",
                                    textController: _apellidoMaternoController,
                                    keyBoardType: TextInputType.text,
                                    numOfLines: 1,
                                    inputFormat: MaskTextInputFormatter()),
                              ),
                            ],
                          ),
                          EditTextArea(
                            keyBoardType: TextInputType.datetime,
                            inputFormat: MaskTextInputFormatter(
                                mask: '####-##-##',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy),
                            isObscure: false,
                            numOfLines: 1,
                            labelEditText: 'Fecha de Nacimiento',
                            textController: _fechaNacimiento,
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
                                            dialogBackgroundColor:
                                            Theming.cuaternaryColor),
                                        child: child!);
                                  });

                              setState(() {
                                _fechaNacimiento.text =
                                    DateFormat("yyyy-MM-dd").format(picked!);
                                //
                                _edad = (DateTime.now()
                                    .difference(DateTime.parse(
                                    _fechaNacimiento.text))
                                    .inDays /
                                    365)
                                    .toInt();
                              });
                            },
                            onChange: (value) {
                              setState(() {
                                // _fechaNacimiento.text = value;
                                _edad = (DateTime.now()
                                    .difference(DateTime.parse(value))
                                    .inDays /
                                    365)
                                    .toInt();
                              });
                            },
                          ),
                          //
                          Row(
                            children: [
                              Expanded(
                                child: Spinner(
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
                              ),
                              Expanded(
                                child: Spinner(
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
                              ),
                              Expanded(
                                child: Spinner(
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
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                CrossLine(height: 10),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: GrandButton(
                            labelButton: "Eliminar listado . . . ",
                            onPress: () => setState(() => pacientes.clear()),
                          )),
                      Expanded(
                          child: GrandButton(
                            labelButton: "Agregar paciente . . . ",
                            onPress: _agregarUsuario,
                          )),
                    ],
                  ),
                ),
                CrossLine(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // VARIABLES ********************************************
  // Lista que contiene las listas de pacientes
  List<List<dynamic>> pacientes = [];

  // Controladores para los campos del formulario
  final _nssController = TextEditingController();
  final _agregadoController = TextEditingController();
  final _nombreInicialController = TextEditingController();
  final _nombreSecundarioController = TextEditingController();
  final _apellidoPaternoController = TextEditingController();
  final _apellidoMaternoController = TextEditingController();
  final _fechaNacimiento = TextEditingController();
  int? _edad;

  String turnoValue = Pacientes.Turno[0];
  String sessoValue = Pacientes.Sexo[0];
  String unidadMedicaValue = Pacientes.Unidades[0];
  String hemotipoValue = Items.Hemotipo[0];
  String atencionValue = Pacientes.Atencion[0];
  String statusValue = Pacientes.Status[0];
  String estadoCivilValue = Pacientes.EstadoCivil[0];
  String vivoValue = Pacientes.Vivo[0];
  String escolaridadValue = Pacientes.Escolaridad[0];
  String escolaridadCompletudValue = Pacientes.EscolaridadCompletud[0];
  //
  String indigenaValue = Pacientes.Indigena[0];
  String indigenaHablanteValue = Pacientes.lenguaIndigena[0];
  String entidadFederativaValue = Pacientes.EntidadesFederativas[0];

  @override
  void dispose() {
    _nssController.dispose();
    _agregadoController.dispose();
    _nombreInicialController.dispose();
    _nombreSecundarioController.dispose();
    _apellidoPaternoController.dispose();
    _apellidoMaternoController.dispose();
    _fechaNacimiento.dispose();
    //
    super.dispose();
  }

  // Función para agregar un usuario a la lista
  Future<void> _agregarUsuario() async {
    ByteData bytes = await rootBundle.load('assets/images/person.png');
    var buffer = bytes.buffer;

    if (_nssController.text.isNotEmpty && _fechaNacimiento.text.isNotEmpty) {
      setState(() {
        pacientes.add([
          _nssController.text.trim(),
          _agregadoController.text.trim().toUpperCase(),
          Sentences.capitalize(_nombreInicialController.text).trim(),
          Sentences.capitalize(_nombreSecundarioController.text).trim(),
          Sentences.capitalize(_apellidoPaternoController.text).trim(),
          Sentences.capitalize(_apellidoMaternoController.text).trim(),
          hemotipoValue,
          base64.encode(Uint8List.view(buffer)), // "", // img,
          //
          "", // unidadMedicaValue.text,
          "", // hospitalAtencionTextController.text,
          turnoValue,
          //
          DateTime.now().toString(),
          DateTime.now().toString(),
          //
          "", //telefonoTextController.text,
          _fechaNacimiento.text,
          sessoValue,
          atencionValue,
          //
          "", // curpTextController.text.toUpperCase(),
          "", // rfcTextController.text.toUpperCase(),
          //
          _edad,
          vivoValue,
          "", // ocupacionTextController.text,
          "", // estadoCivilValue,
          "", // religionTextController.text,
          escolaridadValue,
          escolaridadCompletudValue,
          "", // escolaridadEspecificacionTextController.text,
          "", // municipioTextController.text.trimRight(),
          entidadFederativaValue.trimRight(),
          // localidadResidenciaTextController.text.trimRight(),
          // duracionResidenciaTextController.text.trimRight(),
          // domicilioTextController.text.trimRight(),
          indigenaValue,
          indigenaHablanteValue,
          indigenaHablanteValue, // indigenaHablanteEspecificacioTextController.text,
        ]);
        //
        _dispose();
      });
    }
  }

  /// Función para enviar los pacientes a la base de datos
  void _enviarUsuarios() {
    Operadores.optionsActivity(
        context: context,
        tittle: "Listado de Pacientes preparado",
        message: "Número de registros acaparados ${pacientes.length}\n"
            "REGISTRO : \n"
            "${Listas.traduceToString(pacientes!)}",
        onClose: () => Navigator.of(context).pop(),
        textOptionA: "Agregar información a base de datos . . . ",
        optionA: () => Actividades.registrarAnidados(
                Databases.siteground_database_regpace,
                Pacientes.pacientes['registerQuery'],
                pacientes)
            .then((onValue) => Operadores.notifyActivity(
                context: context,
                tittle: "Actividad de registro de pacientes",
                message: onValue.toString(),
                onAcept: () => Navigator.of(context).pop()))
            .onError((onError, stackTrace) => Operadores.alertActivity(
                context: context,
                tittle: "Ocurrió un error al registrar el Listado . . . ",
                message: "ERROR : $onError : : $stackTrace")));
    //
  }

  void _dispose() {
    _nssController.clear();
    _agregadoController.clear();
    _nombreInicialController.clear();
    _nombreSecundarioController.clear();
    _apellidoPaternoController.clear();
    _apellidoMaternoController.clear();
    _fechaNacimiento.clear();
  }
}
