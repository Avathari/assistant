import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/operativity/pacientes/valores/semiologia/semiotica.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleSwitched.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/DialogSelector.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/Switched.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SituacionesHospitalizacion extends StatefulWidget {
  const SituacionesHospitalizacion({Key? key}) : super(key: key);

  @override
  State<SituacionesHospitalizacion> createState() =>
      _SituacionesHospitalizacionState();
}

class _SituacionesHospitalizacionState
    extends State<SituacionesHospitalizacion> {
  var disposValue;
  List<dynamic> ? listOfValues = [];

  @override
  void initState() {
    // *********** ********* *********
    Actividades.consultarId(Databases.siteground_database_reghosp,
            Situaciones.situacion['consultQuery'], Pacientes.ID_Hospitalizacion)
        .then((response) {
      print("RESPUESTA $response");
      if (response['Error'] == 'Hubo un error') {
      } else {
        // setState(() {
        //   Situaciones.ID_Situaciones = response['ID_Siti'];
        //   dispositivoOxigenoValue =
        //       response['Disp_Oxigen'] ?? 'Sin Dispositivo';
        //   Valores.dispositivoOxigeno =
        //       response['Disp_Oxigen'] ?? Items.dispositivosOxigeno[0];
        //   // *********** ********* *********
        //   Valores.isCateterPeriferico =
        //       Dicotomicos.fromInt(response['CVP'], toBoolean: true) as bool?;
        //   Valores.isCateterLargoPeriferico =
        //       Dicotomicos.fromInt(response['CVLP'], toBoolean: true) as bool?;
        //   Valores.isCateterVenosoCentral =
        //       Dicotomicos.fromInt(response['CVC'], toBoolean: true) as bool?;
        //   Valores.isCateterHemodialisis =
        //       Dicotomicos.fromInt(response['MAH'], toBoolean: true) as bool?;
        //   Valores.isSondaFoley =
        //       Dicotomicos.fromInt(response['S_Foley'], toBoolean: true)
        //           as bool?;
        //   Valores.isSondaNasogastrica =
        //       Dicotomicos.fromInt(response['SNG'], toBoolean: true) as bool?;
        //   Valores.isSondaOrogastrica =
        //       Dicotomicos.fromInt(response['SOG'], toBoolean: true) as bool?;
        //   Valores.isDrenajePenrose =
        //       Dicotomicos.fromInt(response['Drenaje'], toBoolean: true)
        //           as bool?;
        //   Valores.isPleuroVac =
        //       Dicotomicos.fromInt(response['Pleuro_Vac'], toBoolean: true)
        //           as bool?;
        //   Valores.isColostomia =
        //       Dicotomicos.fromInt(response['Colostomia'], toBoolean: true)
        //           as bool?;
        //   Valores.isGastrostomia =
        //       Dicotomicos.fromInt(response['Gastrostomia'], toBoolean: true)
        //           as bool?;
        //   Valores.isDialisisPeritoneal = Dicotomicos.fromInt(
        //       response['Dialisis_Peritoneal'],
        //       toBoolean: true) as bool?;
        // });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isMobile(context) ? mobileView() : otherView();
  }

  // *****************************************************************
  otherView() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
              child: TittlePanel(
                  textPanel: 'Situación General en la Hospitalización')),
          Expanded(
            child: Spinner(
              items: Items.dispositivosOxigeno,
              initialValue: disposValue,
              width: isDesktop(context)
                  ? 600
                  : SpinnersValues.maximumWidth(context: context),
              tittle: 'Dispositivo / Evento',
              onChangeValue: (value) {
                setState(() {
                  disposValue = value;
                });
              },
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              decoration: ContainerDecoration.roundedDecoration(),
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        EditTextArea(
                          labelEditText: 'Dispositivo empleado',
                          keyBoardType: TextInputType.multiline,
                          numOfLines: 3,
                          inputFormat: MaskTextInputFormatter(
                          ),
                          textController: disposValueTextController,
                          iconColor: Colors.white,
                          withShowOption: true,
                          selection: true,
                          onSelected: () {
                            //
                            Operadores.openDialog(
                                context: context,
                                chyldrim: DialogSelector(
                                  typeOfDocument: 'txt',
                                  pathForFileSource: 'assets/diccionarios/Oxigenoterapia.txt',
                                  onSelected: ((value) {
                                    setState(() {
                                      Diagnosticos.selectedDiagnosis = value;
                                      disposValueTextController.text =
                                          Diagnosticos.selectedDiagnosis;
                                    });
                                  }),
                                ));
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  EditTextArea(
                                    labelEditText: 'Fecha de colocación',
                                    keyBoardType: TextInputType.number,
                                    numOfLines: 1,
                                    inputFormat: MaskTextInputFormatter(
                                        mask: '####/##/##',
                                        filter: {"#": RegExp(r'[0-9]')},
                                        type: MaskAutoCompletionType.lazy),
                                    textController: fechaDispTextController,
                                    iconColor: Colors.white,
                                    withShowOption: true,
                                    selection: true,
                                    onSelected: () {
                                      fechaDispTextController.text =
                                          Calendarios.today(format: 'yyyy-MM-dd');
                                    },
                                  ),
                                  EditTextArea(
                                    labelEditText: 'Observaciones . . . ',
                                    keyBoardType: TextInputType.text,
                                    numOfLines: 1,
                                    inputFormat: MaskTextInputFormatter(),
                                    textController: observacionesTextController,
                                  ),
                                  EditTextArea(
                                    labelEditText: 'Otros comentarios . . . ',
                                    keyBoardType: TextInputType.multiline,
                                    numOfLines: 4,
                                    inputFormat: MaskTextInputFormatter(),
                                    textController: otrosTextController,
                                    iconColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  CircleSwitched(
                                      tittle: "Agregar / Actualizar",
                                      isSwitched: true,
                                      onChangeValue: (onChangeValue) {
                                        print(listOfValues);
                                        operatorButton();
                                      }),
                                  CircleSwitched(
                                    radios: 20,
                                      tittle: "Agregar / Actualizar",
                                      isSwitched: true,
                                      onChangeValue: (onChangeValue) {
                                        listOfValues!.clear();
                                        print(listOfValues);
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // **************************************
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: ContainerDecoration.roundedDecoration(),
                      child: FutureBuilder<List>(
                        initialData: listOfValues!,
                        future: Future.value(listOfValues!),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
                          return snapshot.hasData
                              ? ListView.builder(
                            controller: ScrollController(),
                            shrinkWrap: true,
                            itemCount: snapshot.data == null
                                ? 0
                                : snapshot.data.length,
                            itemBuilder: (context, posicion) {
                              print(snapshot.data);
                              return Container(
                                decoration: ContainerDecoration.roundedDecoration(),
                                margin: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  TittlePanel(textPanel: snapshot.data[posicion]['dispositivo']),
                                  Row(
                                    children: [
                                      TittlePanel(textPanel: snapshot.data[posicion]['fecha']),
                                      Column(
                                        children: [
                                          TittlePanel(textPanel: snapshot.data[posicion]['observaciones']),
                                          TittlePanel(textPanel: snapshot.data[posicion]['comentarios']),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],),
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
                ],
              ),
            ),
          ),
          GrandButton(
            weigth: 2000,
            labelButton: "Actualizar",
            onPress: () {
              operatorButton();
            },
          ),
        ],
      ),
    );
  }

  mobileView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      controller: ScrollController(),
      child: Column(
        children: [
          TittlePanel(textPanel: 'Situación General en la Hospitalización'),
          Spinner(
              tittle: 'Dispositivo de Oxígeno',
              width: isDesktop(context)
                  ? 600
                  : isTablet(context)
                      ? 200
                      : 100,
              onChangeValue: (value) {
                setState(() {
                  dispositivoOxigenoValue = value;
                  Exploracion.dispositivoOxigeno = value;
                });
              },
              items: Items.dispositivosOxigeno,
              initialValue: dispositivoOxigenoValue),
          CrossLine(),
          Row(
            children: [
              Expanded(
                child: Switched(
                    tittle: 'Cáteter Venoso Periférico',
                    onChangeValue: (value) {
                      setState(() {
                        Exploracion.isCateterPeriferico = value;
                      });
                    },
                    isSwitched: Exploracion.isCateterPeriferico),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                  tittle: 'Cáteter Largo Periférico',
                  onChangeValue: (value) {
                    setState(() {
                      Exploracion.isCateterLargoPeriferico = value;
                    });
                  },
                  isSwitched: Exploracion.isCateterLargoPeriferico,
                ),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                    tittle: 'Cáteter Venoso Central',
                    onChangeValue: (value) {
                      setState(() {
                        Exploracion.isCateterVenosoCentral = value;
                        Exploracion.isCateterVenosoCentral = value;
                      });
                    },
                    isSwitched: Exploracion.isCateterVenosoCentral),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                    tittle: 'Sonda Orogástrica',
                    onChangeValue: (value) {
                      setState(() {
                        Exploracion.isSondaOrogastrica = value;
                        Exploracion.isSondaOrogastrica = value;
                      });
                    },
                    isSwitched: Exploracion.isSondaOrogastrica),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                  tittle: 'Sonda Nasogástrica',
                  onChangeValue: (value) {
                    setState(() {
                      Exploracion.isSondaNasogastrica = value;
                      Exploracion.isSondaNasogastrica = value;
                    });
                  },
                  isSwitched: Exploracion.isSondaNasogastrica,
                ),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                    tittle: 'Cáteter Hemodiálisis',
                    onChangeValue: (value) {
                      setState(() {
                        Exploracion.isCateterHemodialisis = value;
                        Exploracion.isCateterHemodialisis = value;
                      });
                    },
                    isSwitched: Exploracion.isCateterHemodialisis),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                    tittle: 'Sonda Foley',
                    onChangeValue: (value) {
                      setState(() {
                        Exploracion.isSondaFoley = value;
                        Exploracion.isSondaFoley = value;
                      });
                    },
                    isSwitched: Exploracion.isSondaFoley),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                    tittle: 'Drenaje Penrose',
                    onChangeValue: (value) {
                      setState(() {
                        Exploracion.isDrenajePenrose = value;
                        Exploracion.isDrenajePenros = value;
                      });
                    },
                    isSwitched: Exploracion.isDrenajePenrose),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                  tittle: 'Sello Pleural',
                  onChangeValue: (value) {
                    setState(() {
                      Exploracion.isPleuroVac = value;
                      Exploracion.isPleuroVac = value;
                    });
                  },
                  isSwitched: Exploracion.isPleuroVac,
                ),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                    tittle: 'Colostomía',
                    onChangeValue: (value) {
                      setState(() {
                        Exploracion.isColostomia = value;
                        Exploracion.isColostomia = value;
                      });
                    },
                    isSwitched: Exploracion.isColostomia),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                  tittle: 'Gaastrostomia',
                  onChangeValue: (value) {
                    setState(() {
                      Exploracion.isGastrostomia = value;
                    });
                  },
                  isSwitched: Exploracion.isGastrostomia,
                ),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                    tittle: 'Diálisis Peritoneal',
                    onChangeValue: (value) {
                      setState(() {
                        Exploracion.isDialisisPeritoneal = value;
                      });
                    },
                    isSwitched: Exploracion.isDialisisPeritoneal),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                  tittle: 'Cáteter Largo Periférico',
                  onChangeValue: (value) {
                    setState(() {
                      Exploracion.isCateterLargoPeriferico = value;
                    });
                  },
                  isSwitched: Exploracion.isCateterLargoPeriferico,
                ),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                  tittle: 'Cáteter Largo Periférico',
                  onChangeValue: (value) {
                    setState(() {
                      Exploracion.isCateterLargoPeriferico = value;
                    });
                  },
                  isSwitched: Exploracion.isCateterLargoPeriferico,
                ),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                  tittle: 'Cáteter Largo Periférico',
                  onChangeValue: (value) {
                    setState(() {
                      Exploracion.isCateterLargoPeriferico = value;
                    });
                  },
                  isSwitched: Exploracion.isCateterLargoPeriferico,
                ),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                  tittle: 'Cáteter Largo Periférico',
                  onChangeValue: (value) {
                    setState(() {
                      Exploracion.isCateterLargoPeriferico = value;
                    });
                  },
                  isSwitched: Exploracion.isCateterLargoPeriferico,
                ),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // OPERADORES ********************************************************
  void operatorButton() {
    setState(() {
      listOfValues!.add({
        "dispositivo": disposValueTextController.text,
        "fecha": fechaDispTextController.text,
        "observaciones": observacionesTextController.text,
        "comentarios": otrosTextController.text,
      });
    });
  }

  // VARIABLES ********************************************************
  var dispositivoOxigenoValue = Items.dispositivosOxigeno[0];
  var fechaCVPTextController = TextEditingController();
  //
  var disposValueTextController = TextEditingController();
  var fechaDispTextController = TextEditingController();
  var observacionesTextController = TextEditingController();
  var otrosTextController = TextEditingController();
}
