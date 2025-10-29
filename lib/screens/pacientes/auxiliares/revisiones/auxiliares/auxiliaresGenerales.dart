import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/auxiliares/revisiones/auxiliares/auxiliaresRevisiones.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AuxiliaresDispositivos extends StatefulWidget {
  const AuxiliaresDispositivos({super.key});

  @override
  State<AuxiliaresDispositivos> createState() => _AuxiliaresDispositivosState();
}

class _AuxiliaresDispositivosState extends State<AuxiliaresDispositivos> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(flex: 2, child: RevisionPrevios()),
                Expanded(child: RevisionInfusiones()),
                // Expanded(child: RevisionCultivos(listado: Pacientes.getRevisionCultivos())),
              ],
            ),
          ),
          Expanded(child: RevisionDispositivos()),
        ],
      ),
    );
  }
}

class AuxiliarVitales extends StatefulWidget {
  const AuxiliarVitales({super.key});

  @override
  State<AuxiliarVitales> createState() => _AuxiliarVitalesState();
}

class _AuxiliarVitalesState extends State<AuxiliarVitales> {
  @override
  void initState() {
    super.initState();

    // TODO: implement initState
    textDateEstudyController.text =
        Calendarios.today(format: 'yyyy-MM-dd HH:mm:ss');
    //
    if (Valores.alturaPaciente != null) {
      estTextController.text = Valores.alturaPaciente!.toString();
    } else {
      Valores.alturaPaciente = 0;
      estTextController.text = '0';
    }
    //
    if (Valores.pesoCorporalTotal != null) {
      pctTextController.text = Valores.pesoCorporalTotal!.toString();
    } else {
      Valores.pesoCorporalTotal = 0;
      pctTextController.text = '0';
    }
    //
    fraccionInspiratoriaOxigenoTextController.text = 21.toString();
    //
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 4.0,
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
                  Calendarios.today(format: "yyyy/MM/dd HH:mm:ss");
            });
          },
          inputFormat: MaskTextInputFormatter(
              mask: '####/##/##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
        ),
        CrossLine(thickness: 3, height: 15),
        Row(
          children: [
            Expanded(
              child: EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                numOfLines: 1,
                labelEditText: 'Tensión arterial sistólica',
                textController: tasTextController,
                onChange: (value) => setState(
                    () => Valores.tensionArterialSystolica = int.parse(value)),
              ),
            ),
            Expanded(
              child: EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                numOfLines: 1,
                labelEditText: 'Tensión arterial diastólica',
                textController: tadTextController,
                onChange: (value) => setState(
                    () => Valores.tensionArterialDyastolica = int.parse(value)),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                numOfLines: 1,
                labelEditText: 'Frecuencia cardiaca',
                textController: fcTextController,
                onChange: (value) => setState(
                    () => Valores.frecuenciaCardiaca = int.parse(value)),
              ),
            ),
            Expanded(
              child: EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                numOfLines: 1,
                labelEditText: 'Frecuencia respiratoria',
                textController: frTextController,
                onChange: (value) => setState(() =>
                    Valores.frecuenciaRespiratoria =
                        Valores.frecuenciaVentilatoria = int.parse(value)),
              ),
            ),
          ],
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
            onChange: (String value) {
              Valores.temperaturCorporal = double.parse(tcTextController.text);
              // viaPerdidaTextController.text =
              //     Valores.perdidasInsensibles.toStringAsFixed(0);
              // viaOtrosIngresosTextController.text =
              //     Valores.aguaMetabolica.toStringAsFixed(0);
            }),
        EditTextArea(
          keyBoardType: TextInputType.number,
          inputFormat: MaskTextInputFormatter(),
          numOfLines: 1,
          labelEditText: 'Saturación periférica de oxígeno',
          textController: spoTextController,
          onChange: (value) => setState(
              () => Valores.saturacionPerifericaOxigeno = int.parse(value)),
        ),
        Row(
          children: [
            Expanded(
              child: EditTextArea(
                  keyBoardType: TextInputType.number,
                  inputFormat: MaskTextInputFormatter(
                      mask: '###.##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  numOfLines: 1,
                  labelEditText: 'Peso corporal total',
                  textController: pctTextController,
                  onChange: (String value) {
                    final parsedValue = double.tryParse(pctTextController.text);
                    if (parsedValue != null) {
                      Valores.pesoCorporalTotal = parsedValue;
                      // Opcional: actualizar otros campos si lo necesitas
                      // viaPerdidaTextController.text =
                      //     Valores.perdidasInsensibles.toStringAsFixed(0);
                      // viaOtrosIngresosTextController.text =
                          Valores.aguaMetabolica.toStringAsFixed(0);
                    } else {
                      Valores.pesoCorporalTotal = 0.0;
                    }
                  }),
            ),
            Expanded(
              child: EditTextArea(
                  keyBoardType: TextInputType.number,
                  inputFormat: MaskTextInputFormatter(
                      mask: '#.##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  numOfLines: 1,
                  labelEditText: 'Estatura (mts)',
                  textController: estTextController,
                  onChange: (String value) {
                    Valores.alturaPaciente =
                        double.parse(estTextController.text);
                  }),
            ),
          ],
        ),
        //
        Row(
          children: [
            Expanded(
              child: EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(
                    mask: '###',
                    filter: {"#": RegExp(r'[0-9]')},
                    type: MaskAutoCompletionType.lazy),
                numOfLines: 1,
                labelEditText: 'Glucemia capilar',
                textController: gluTextController,
              ),
            ),
            Expanded(
              child: EditTextArea(
                  keyBoardType: TextInputType.number,
                  inputFormat: MaskTextInputFormatter(
                      mask: '##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  numOfLines: 1,
                  labelEditText: 'Horas de ayuno',
                  textController: gluAyuTextController),
            ),
            Expanded(
              child: EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(
                    mask: '##',
                    filter: {"#": RegExp(r'[0-9]')},
                    type: MaskAutoCompletionType.lazy),
                numOfLines: 1,
                labelEditText: 'Insulina Gastada (UI/Día)',
                textController: insulinaTextController,
                onChange: (value) => Valores.insulinaGastada = int.parse(value),
              ),
            ),
          ],
        ),

        CrossLine(thickness: 6, height: 15),
        Row(
          children: [
            Expanded(
              child: EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                numOfLines: 1,
                labelEditText: 'FiO2',
                textController: fraccionInspiratoriaOxigenoTextController,
                onChange: (value) {
                  setState(() {
                    Valores.fraccionInspiratoriaOxigeno = Valores
                        .fraccionInspiratoriaVentilatoria = int.parse(value);
                    Valores.fioArteriales = double.parse(value);
                  });
                },
              ),
            ),
            Expanded(
              child: EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                numOfLines: 1,
                labelEditText: 'C. Abd. ',
                textController: circunferenciaCinturaTextController,
                onChange: (value) {
                  setState(() {
                    Valores.circunferenciaCintura = int.parse(value);
                  });
                },
              ),
            ),
            Expanded(
              child: EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                numOfLines: 1,
                labelEditText: 'PVC',
                textController: presionVenosaCentralTextController,
                onChange: (value) {
                  setState(() {
                    Valores.presionVenosaCentral = int.parse(value);
                  });
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                numOfLines: 1,
                labelEditText: 'PIC',
                textController: presionIntraCerebralTextController,
                onChange: (value) {
                  setState(() {
                    Valores.presionIntraCerebral = int.parse(value);
                  });
                },
              ),
            ),
            Expanded(
              child: EditTextArea(
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                numOfLines: 1,
                labelEditText: 'PIA', // Presión Intraabdominal
                textController: presionIntraabdominalTextController,
                onChange: (value) {
                  setState(() {
                    Valores.presionIntraabdominal = int.parse(value);
                  });
                },
              ),
            ),
          ],
        ),
        CrossLine(thickness: 3, height: 15),
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
    );
  }

  //
  var textDateEstudyController = TextEditingController();
  //
  var tasTextController = TextEditingController();
  var tadTextController = TextEditingController();
  var fcTextController = TextEditingController();
  var frTextController = TextEditingController();
  var tcTextController = TextEditingController();
  var spoTextController = TextEditingController();
  var estTextController = TextEditingController();
  var pctTextController = TextEditingController();
  //
  var circunferenciaCinturaTextController = TextEditingController();
  //
  var gluTextController = TextEditingController();
  var gluAyuTextController = TextEditingController();
  var insulinaTextController = TextEditingController();
  // **********************************************
  var fraccionInspiratoriaOxigenoTextController = TextEditingController();
  //
  var presionVenosaCentralTextController = TextEditingController();
  var presionIntraabdominalTextController = TextEditingController();
  var presionIntraCerebralTextController = TextEditingController();
  //

  int idOperation = 0;
  List<dynamic>? listOfFirstValues, listOfSecondValues, listOfValues;
  String? registerQueryvitales = Vitales.vitales['registerQuery'];
  String? registerQueryantropo = Vitales.antropo['registerQuery'];
  //
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
        // FiO2
        estTextController.text,
        pctTextController.text,
        gluTextController.text,
        gluAyuTextController.text,
        //
        insulinaTextController.text,
        //
        fraccionInspiratoriaOxigenoTextController.text,
        presionVenosaCentralTextController.text,
        presionIntraCerebralTextController.text,
        presionIntraabdominalTextController.text,
        //
        idOperation
      ];
      listOfSecondValues = [
        idOperation,
        Pacientes.ID_Paciente,
        textDateEstudyController.text,
        '', // cueTextController.text,
        circunferenciaCinturaTextController.text,
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

      Terminal.printExpected(
          message:
              " : : . . .  listOfValues $listOfFirstValues ${listOfFirstValues!.length}");

      listOfFirstValues!.removeAt(0);
      listOfFirstValues!.removeLast();
      //
      listOfSecondValues!.removeAt(0);
      listOfSecondValues!.removeLast();
      // ******************************************** *** *
      // listOfValues!.removeAt(0);
      // listOfValues!.removeLast();
      // ******************************************** *** *
      Actividades.registrar(Databases.siteground_database_regpace,
              registerQueryvitales!, listOfFirstValues!)
          .then((value) {
        Actividades.registrar(Databases.siteground_database_regpace,
                registerQueryantropo!, listOfSecondValues!)
            .then((value) {
          // Actividades.registrar(Databases.siteground_database_reghosp,
          //         Balances.balance['registerQuery'], listOfValues!)
          //     .then((value) => Actividades.consultarAllById(
          //                 Databases.siteground_database_reghosp,
          //                 Balances.balance['consultIdQuery'],
          //                 Pacientes.ID_Paciente) // idOperation)
          //             .then((value) {
          //           // ******************************************** *** *
          //           Pacientes.Alergicos = value;
          //           Constantes.reinit(value: value);
          //           // ******************************************** *** *
          //         }).then((value) {
          //           Archivos.deleteFile(filePath: Balances.fileAssocieted);
          //           Archivos.deleteFile(filePath: Vitales.fileAssocieted);
          //
          //           reiniciar().then((value) => Operadores.alertActivity(
          //               context: context,
          //               tittle: "Anexión de registros",
          //               message: "Registros Agregados",
          //               onAcept: () {
          //                 Navigator.of(context).pop();
          //               }));
          //         }));
        });
      });
    } catch (onError, stackTrace) {
      Operadores.alertActivity(
          context: context,
          tittle: 'ERROR Encontrado . . . ',
          message:
              'Error al Operar con los Valores :  : $onError : $stackTrace',
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
    Actividades.consultarAllById(Databases.siteground_database_regpace,
            Balances.balance['consultByIdPrimaryQuery'], Pacientes.ID_Paciente)
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
