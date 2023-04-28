import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Generales extends StatefulWidget {
  const Generales({Key? key}) : super(key: key);

  @override
  State<Generales> createState() => _GeneralesState();
}

class _GeneralesState extends State<Generales> {
  @override
  void initState() {
    final f = DateFormat('yyyy-MM-dd');
    textDateEstudyController.text = f.format(DateTime.now());
    estTextController.text = Valores.alturaPaciente!.toString();
    pctTextController.text = Valores.pesoCorporalTotal!.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: [
          isMobile(context)
              ? SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      EditTextArea(
                        labelEditText: "Fecha de realización",
                        numOfLines: 1,
                        textController: textDateEstudyController,
                        keyBoardType: TextInputType.datetime,
                        withShowOption: true,
                        selection: true,
                        iconData: Icons.calculate_outlined,
                        onSelected: () {
                          setState(() {
                            textDateEstudyController.text =
                                Calendarios.today(format: "yyyy/MM/dd");
                          });
                        },
                        inputFormat: MaskTextInputFormatter(
                            mask: '####/##/##',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy),
                      ),
                      CrossLine(),
                      EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          numOfLines: 1,
                          labelEditText: 'Tensión arterial sistólica',
                          textController: tasTextController),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        numOfLines: 1,
                        labelEditText: 'Tensión arterial diastólica',
                        textController: tadTextController,
                      ),
                      EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          numOfLines: 1,
                          labelEditText: 'Frecuencia cardiaca',
                          textController: fcTextController),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        numOfLines: 1,
                        labelEditText: 'Frecuencia respiratoria',
                        textController: frTextController,
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(
                            mask: '##.#',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy),
                        numOfLines: 1,
                        labelEditText: 'Temperatura corporal',
                        textController: tcTextController,
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        numOfLines: 1,
                        labelEditText: 'Saturación periférica de oxígeno',
                        textController: spoTextController,
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(
                            mask: '##.##',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy),
                        numOfLines: 1,
                        labelEditText: 'Peso corporal total',
                        textController: pctTextController,
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(
                            mask: '#.##',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy),
                        numOfLines: 1,
                        labelEditText: 'Estatura (mts)',
                        textController: estTextController,
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(
                            mask: '###',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy),
                        numOfLines: 1,
                        labelEditText: 'Glucemia capilar',
                        textController: gluTextController,
                      ),
                      EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(
                              mask: '##',
                              filter: {"#": RegExp(r'[0-9]')},
                              type: MaskAutoCompletionType.lazy),
                          numOfLines: 1,
                          labelEditText: 'Horas de ayuno',
                          textController: gluAyuTextController),
                      // Botton ***** ******* ****** * ***
                      CrossLine(
                        color: Colors.grey,
                      ),
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        decoration: ContainerDecoration.roundedDecoration(),
                        child: GrandButton(
                            labelButton: "Agregar Datos",
                            weigth: 2000,
                            onPress: () {
                              operationMethod(context);
                            }),
                      )
                    ],
                  ),
                )
              : SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      EditTextArea(
                        labelEditText: "Fecha de realización",
                        numOfLines: 1,
                        textController: textDateEstudyController,
                        keyBoardType: TextInputType.datetime,
                        withShowOption: true,
                        selection: true,
                        iconData: Icons.calculate_outlined,
                        onSelected: () {
                          setState(() {
                            textDateEstudyController.text =
                                Calendarios.today(format: "yyyy/MM/dd");
                          });
                        },
                        inputFormat: MaskTextInputFormatter(
                            mask: '####/##/##',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy),
                      ),
                      CrossLine(),
                      EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(
                              mask: '###',
                              filter: {"#": RegExp(r'[0-9]')},
                              type: MaskAutoCompletionType.lazy),
                          labelEditText: 'Tensión arterial sistólica',
                          textController: tasTextController),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(
                            mask: '###',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy),
                        labelEditText: 'Tensión arterial diastólica',
                        textController: tadTextController,
                      ),
                      EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(
                              mask: '###',
                              filter: {"#": RegExp(r'[0-9]')},
                              type: MaskAutoCompletionType.lazy),
                          labelEditText: 'Frecuencia cardiaca',
                          textController: fcTextController),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(
                            mask: '##',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy),
                        labelEditText: 'Frecuencia respiratoria',
                        textController: frTextController,
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(
                            mask: '##.#',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy),
                        labelEditText: 'Temperatura corporal',
                        textController: tcTextController,
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(
                            mask: '##',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy),
                        labelEditText: 'Saturación periférica de oxígeno',
                        textController: spoTextController,
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(
                            mask: '##.##',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy),
                        labelEditText: 'Peso corporal total',
                        textController: pctTextController,
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(
                            mask: '#.##',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy),
                        labelEditText: 'Estatura (mts)',
                        textController: estTextController,
                      ),
                      EditTextArea(
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(
                            mask: '###',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy),
                        labelEditText: 'Glucemia capilar',
                        textController: gluTextController,
                      ),
                      EditTextArea(
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(
                              mask: '##',
                              filter: {"#": RegExp(r'[0-9]')},
                              type: MaskAutoCompletionType.lazy),
                          labelEditText: 'Horas de ayuno',
                          textController: gluAyuTextController),
                      // Botton ***** ******* ****** * ***
                      CrossLine(
                        color: Colors.grey,
                      ),
                      Container(
                        margin: const EdgeInsets.all(5.0),
                        decoration: ContainerDecoration.roundedDecoration(),
                        child: GrandButton(
                            labelButton: "Agregar Datos",
                            weigth: 2000,
                            onPress: () {
                              operationMethod(context);
                            }),
                      )
                    ],
                  ),
                ),
          SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                Spinner(
                    isRow: false,
                    tittle: "Intervalo de Horario",
                    onChangeValue: (String value) {
                      setState(() {
                        isHorarioValue = value;
                        Valores.horario = int.parse(value);
                      });
                    },
                    items: Opciones.horarios(),
                    width: isTablet(context) ? 40 : 60,
                    initialValue: isHorarioValue),
                EditTextArea(
                  keyBoardType: TextInputType.number,
                  inputFormat: MaskTextInputFormatter(),
                  labelEditText: 'Via Oral (mL)',
                  textController: viaOralTextController,
                  numOfLines: 1,
                  onChange: (value) {
                    setState(() {
                      Valores.viaOralBalances = double.parse(value);
                    });
                  },
                ),
                EditTextArea(
                  keyBoardType: TextInputType.number,
                  inputFormat: MaskTextInputFormatter(),
                  labelEditText: 'Vía Sonda Orogástrica (mL)',
                  textController: viaOrogasTextController,
                  numOfLines: 1,
                  onChange: (value) {
                    setState(() {
                      Valores.sondaOrogastricaBalances = double.parse(value);
                    });
                  },
                ),
                // CrossLine(),
                //
                EditTextArea(
                  keyBoardType: TextInputType.number,
                  inputFormat: MaskTextInputFormatter(),
                  labelEditText: 'Vía Hemoderivados (mL)',
                  textController: viaHemosTextController,
                  numOfLines: 1,
                  onChange: (value) {
                    setState(() {
                      Valores.hemoderivadosBalances = double.parse(value);
                    });
                  },
                ),
                EditTextArea(
                  keyBoardType: TextInputType.number,
                  inputFormat: MaskTextInputFormatter(),
                  labelEditText: 'Vía N.P.T. (mL)',
                  textController: viaNutrianTextController,
                  numOfLines: 1,
                  onChange: (value) {
                    setState(() {
                      Valores.nutricionParenteralBalances = double.parse(value);
                    });
                  },
                ),
                EditTextArea(
                  keyBoardType: TextInputType.number,
                  inputFormat: MaskTextInputFormatter(),
                  labelEditText: 'Vía Sol. Parenterales (mL)',
                  textController: viaParesTextController,
                  numOfLines: 1,
                  onChange: (value) {
                    setState(() {
                      Valores.parenteralesBalances = double.parse(value);
                    });
                  },
                ),
                EditTextArea(
                  keyBoardType: TextInputType.number,
                  inputFormat: MaskTextInputFormatter(),
                  labelEditText: 'Vía Diluciones (mL)',
                  textController: viaDilucionesTextController,
                  numOfLines: 1,
                  onChange: (value) {
                    setState(() {
                      Valores.dilucionesBalances = double.parse(value);
                    });
                  },
                ),
                EditTextArea(
                  keyBoardType: TextInputType.number,
                  inputFormat: MaskTextInputFormatter(),
                  labelEditText: 'Otros Ingresos (mL)',
                  textController: viaOtrosIngresosTextController,
                  numOfLines: 1,
                  onChange: (value) {
                    setState(() {
                      Valores.otrosIngresosBalances = double.parse(value);
                    });
                  },
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            controller: ScrollController(),
            child: Column(children: [
              EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Vía Uresis (mL)',
                textController: viaUresisTextController,
                numOfLines: 1,
                onChange: (value) {
                  Valores.uresisBalances = double.parse(value);
                  setState(() {});
                },
              ),
              EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Vía Evacuacionees. (mL)',
                textController: viaEvacTextController,
                numOfLines: 1,
                onChange: (value) {
                  setState(() {
                    Valores.evacuacionesBalances = double.parse(value);
                  });
                },
              ),
              EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Vía Sangrados (mL)',
                textController: viaSangTextController,
                numOfLines: 1,
                onChange: (value) {
                  setState(() {
                    Valores.sangradosBalances = double.parse(value);
                  });
                },
              ),
              EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Vía Succión (mL)',
                textController: viaSucciTextController,
                numOfLines: 1,
                onChange: (value) {
                  setState(() {
                    Valores.succcionBalances = double.parse(value);
                  });
                },
              ),
              EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Perdidas Insensibles (mL)',
                textController: viaPerdidaTextController,
                numOfLines: 1,
              ),
              EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Otros Egresos (mL)',
                textController: viaOtrosEgresosTextController,
                numOfLines: 1,
                onChange: (value) {
                  setState(() {
                    Valores.otrosEgresosBalances = double.parse(value);
                  });
                },
              ),
            ]),
          )
        ],
        carouselController: carouselController,
        options: Carousel.carouselOptions(context: context));
  }

  // VARIABLES DE LA INTERFAZ ****************** ********
  var textDateEstudyController = TextEditingController();
  var carouselController = CarouselController();
  // **********************************************
  int idOperation = 0;
  List<dynamic>? listOfFirstValues, listOfSecondValues, listOfValues;
  // **********************************************
  String? registerQueryvitales = Vitales.vitales['registerQuery'];
  String? registerQueryantropo = Vitales.antropo['registerQuery'];
  // **********************************************
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
// **********************************************
  var isHorarioValue = Balances.actualDiagno[6];
// **********************************************
  var viaOralTextController = TextEditingController();
  var viaOrogasTextController = TextEditingController();
  var viaHemosTextController = TextEditingController();
  var viaNutrianTextController = TextEditingController();
  var viaParesTextController = TextEditingController();
  var viaDilucionesTextController = TextEditingController();
  var viaOtrosIngresosTextController = TextEditingController();
  // **********************************************
  var viaUresisTextController = TextEditingController();
  var viaEvacTextController = TextEditingController();
  var viaSangTextController = TextEditingController();
  var viaSucciTextController = TextEditingController();
  var viaDreneTextController = TextEditingController();
  var viaPerdidaTextController = TextEditingController();
  var viaOtrosEgresosTextController = TextEditingController();
  // **********************************************
  void operationMethod(BuildContext context) {
    try {
      listOfFirstValues = [
        idOperation,
        Pacientes.ID_Paciente,
        textDateEstudyController.text,
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
        idOperation
      ];
      listOfSecondValues = [
        idOperation,
        Pacientes.ID_Paciente,
        textDateEstudyController.text,
        '', // cueTextController.text,
        '', // cinTextController.text,
        '', // cadTextController.text,
        '', // cmbTextController.text,
        pctTextController.text,
        '0.9', // factorActividadValue,
        '0.9', // factorEstresValue,
        '', // pectTextController.text,
        '', // pcbTextController.text,
        '', // pseTextController.text,
        '', // psiTextController.text,
        '', // pstTextController.text,
        '', // femIzqTextController.text,
        '', // femDerTextController.text,
        '', // suroIzqTextController.text,
        '', // suroDerTextController.text,
        idOperation
      ];
      listOfValues = [
        idOperation,
        Pacientes.ID_Paciente,
        textDateEstudyController.text,
        DateTime.now().toString(),
        // hora
        viaOralTextController.text,
        viaOrogasTextController.text,
        viaHemosTextController.text,
        viaNutrianTextController.text,
        viaParesTextController.text,
        viaDilucionesTextController.text,
        viaOtrosIngresosTextController.text,
        //
        viaUresisTextController.text,
        viaEvacTextController.text,
        viaSangTextController.text,
        viaSucciTextController.text,
        viaDreneTextController.text,
        viaPerdidaTextController.text,
        viaOtrosEgresosTextController.text,
        //
        isHorarioValue,
        //
        idOperation
      ];

      Terminal.printExpected(
          message:
              " : : . . .  listOfValues $listOfFirstValues ${listOfFirstValues!.length}");

      listOfFirstValues!.removeAt(0);
      listOfFirstValues!.removeLast();
      //
      listOfSecondValues!.removeAt(0);
      listOfSecondValues!.removeLast();
      // ******************************************** *** *
      listOfValues!.removeAt(0);
      listOfValues!.removeLast();
      // ******************************************** *** *
      Actividades.registrar(Databases.siteground_database_regpace,
              registerQueryvitales!, listOfFirstValues!)
          .then((value) {
        Actividades.registrar(Databases.siteground_database_regpace,
                registerQueryantropo!, listOfSecondValues!)
            .then((value) {
          Actividades.registrar(Databases.siteground_database_reghosp,
                  Balances.balance['registerQuery'], listOfValues!)
              .then((value) => Actividades.consultarAllById(
                          Databases.siteground_database_reghosp,
                          Balances.balance['consultIdQuery'],
                          Pacientes.ID_Paciente) // idOperation)
                      .then((value) {
                    // ******************************************** *** *
                    Pacientes.Alergicos = value;
                    Constantes.reinit(value: value);
                    // ******************************************** *** *
                  }).then((value) {
                    Archivos.deleteFile(filePath: Balances.fileAssocieted);
                    Archivos.deleteFile(filePath: Vitales.fileAssocieted);

                    reiniciar().then((value) => Operadores.alertActivity(
                        context: context,
                        tittle: "Anexión de registros",
                        message: "Registros Agregados",
                        onAcept: () {
                          Navigator.of(context).pop();
                        }));
                  }));
        });
      });
    } catch (ex) {
      Operadores.alertActivity(
          context: context,
          tittle: 'ERROR Encontrado . . . ',
          message: 'Error al Operar con los Valores :  : $ex',
          onAcept: () {
            Navigator.of(context).pop();
          });
    }
  }

  Future<void> reiniciar() async {
    // ******************************** * * * *
    // Terminal.printExpected(message: "Reinicio de los valores . . .");
    List result = [];
    Pacientes.Vitales!.clear();
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            Vitales.vitales['consultByIdPrimaryQuery'], Pacientes.ID_Paciente)
        .then((value) {
      result.addAll(value);
      Actividades.consultarAllById(Databases.siteground_database_regpace,
              Vitales.antropo['consultByIdPrimaryQuery'], Pacientes.ID_Paciente)
          .then((value) {
        int index = 0;
        for (var item in result) {
          if (index <= result.length) {
            var thirdMap = {};
            // print("${value.length} ${result.length}");
            // print("${value[index]['ID_Pace_SV']} ${item['ID_Pace_SV']}");
            thirdMap.addAll(item);
            thirdMap.addAll(value[index]);
            // Adición a Vitales ********** ************ ************** ********
            Pacientes.Vitales!.add(thirdMap);
            index++;
          }
        }
        setState(() {
          Terminal.printSuccess(
              message:
                  "Actualizando Repositorio de Signos Vitales del Paciente . . . ${Pacientes.Vitales}");
          Pacientes.Vitales!;
          Archivos.createJsonFromMap(Pacientes.Vitales!,
              filePath: Vitales.fileAssocieted);
        });
      });
    });

    // ******************************** * * * *
    Terminal.printExpected(message: "Reinicio de los valores . . .");
    Pacientes.Balances!.clear();
    Actividades.consultarAllById(
        Databases.siteground_database_regpace,
        Balances.balance['consultByIdPrimaryQuery'],
        Pacientes.ID_Paciente)
        .then((value) {
      setState(() {
        Pacientes.Balances = value;
        Terminal.printSuccess(
            message:
            "Actualizando Repositorio de Patologías del Paciente . . . ${Pacientes.Balances}");

        Archivos.createJsonFromMap(Pacientes.Balances!,
            filePath: Balances.fileAssocieted);
      });
    });
  }

}
