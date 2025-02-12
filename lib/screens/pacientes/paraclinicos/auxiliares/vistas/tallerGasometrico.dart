import 'dart:io';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/cardiometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/gasometricos.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TallerGasometrico extends StatefulWidget {
  const TallerGasometrico({super.key});

  @override
  State<TallerGasometrico> createState() => _TallerGasometricoState();
}

class _TallerGasometricoState extends State<TallerGasometrico> {
  // static var 10 = 9 // 10 ; // TallerGasometrico (Arteriales, Venosos)
  String? filePath;

  @override
  void initState() {
    final f = DateFormat('yyyy-MM-dd HH:mm:ss');
    textDateEstudyController.text = f.format(DateTime.now());
    //
    textPVCResultController.text = Valores.presionVenosaCentral!.toString();
    textFIOResultController.text =
        Valores.fraccionInspiratoriaOxigeno!.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              mask: '####/##/## ##:##:##', // 'yyyy-MM-dd HH:mm:ss'
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
        ),
        CrossLine(height: 10),
        GrandButton(
          height: 10,
          weigth: 1000,
          labelButton: "Cargar archivo de Historial . . . ",
          onPress: () async {
            final path =
            await Directorios.choiseFromInternalDocuments(
                context);
            //
            setState(() {
              filePath = path!.files.single.path!;
            });
          },
        ),
        CrossLine(height: 10),
        CrossLine(thickness: 3, height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(7.0),
                controller: ScrollController(),
                child: Column(
                  children: [
                    EditTextArea(
                      textController: textavPHResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'aPH',
                      numOfLines: 1,
                      onChange: (String value) {
                        setState(() {
                          Valores.pHArteriales = double.parse(value);
                        });
                      },
                    ),
                    EditTextArea(
                      textController: textPaCOResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'PaCO ($unidadMedidaPaCO)',
                      numOfLines: 1,
                      onChange: (String value) {
                        setState(() {
                          Valores.pcoArteriales = double.parse(value);
                        });
                      },
                    ),
                    EditTextArea(
                      textController: textPaOResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'PaO ($unidadMedidaPaO)',
                      numOfLines: 1,
                      onChange: (String value) {
                        setState(() {
                          Valores.poArteriales = double.parse(value);
                        });
                      },
                    ),
                    EditTextArea(
                      textController: textavHCOResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'aHCO ($unidadMedidaavHCO)',
                      numOfLines: 1,
                      onChange: (String value) {
                        setState(() {
                          Valores.bicarbonatoArteriales = double.parse(value);
                        });
                      },
                    ),
                    EditTextArea(
                      textController: textSaOResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'SaO2 ($unidadMedidaSaO)',
                      numOfLines: 1,
                      onChange: (String value) {
                        setState(() {
                          Valores.soArteriales = double.parse(value);
                        });
                      },
                    ),
                    CrossLine(),
                    ValuePanel(
                      firstText: 'G.C. (Fick)',
                      secondText:
                          Cardiometrias.gastoCardiacoFick.toStringAsFixed(2),
                      thirdText: 'Lt/min',
                    ),
                    ValuePanel(
                      firstText: 'I.C.',
                      secondText:
                          Cardiometrias.indiceCardiaco.toStringAsFixed(2),
                      thirdText: 'Lt/min',
                    ),
                    CrossLine(),
                    ValuePanel(
                      firstText: 'CW',
                      secondText:
                          Cardiometrias.poderCardiaco.toStringAsFixed(2),
                      thirdText: 'Watts',
                    ),
                    ValuePanel(
                      firstText: 'iCW',
                      secondText: Cardiometrias.poderCardiacoIndexado
                          .toStringAsFixed(2),
                      thirdText: 'Watts',
                    ),
                    CrossLine(),
                    ValuePanel(
                      firstText: 'RSV', // Resistencias Venosas Sistémicas
                      secondText: Valores.RVS.toStringAsFixed(2),
                      thirdText: 'dinas/seg/cm2',
                    ),
                    CrossLine(),
                    Container(
                      decoration: ContainerDecoration.roundedDecoration(),
                      child: ValuePanel(
                          firstText: 'pBAR',
                          secondText:
                              Valores.presionBarometrica.toStringAsFixed(0),
                          thirdText: 'mmHg',
                          withEditMessage: true,
                          onEdit: (value) {
                            Operadores.editActivity(
                                context: context,
                                tittle: "Editar . . . ",
                                message: "¿Presión Barométrica? . . . ",
                                onAcept: (value) {
                                  setState(() {
                                    Valores.presionBarometrica =
                                        int.parse(value);
                                    Navigator.of(context).pop();
                                  });
                                });
                          }), // P. Barométrica
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: [
                    ValuePanel(
                      firstText: 'PiO2',
                      secondText: Gasometricos.PIO.toStringAsFixed(2),
                      thirdText: 'mmHg',
                    ),
                    ValuePanel(
                      firstText: 'PAO2',
                      secondText: Gasometricos.PAO.toStringAsFixed(2),
                      thirdText: 'mmHg',
                    ),
                    ValuePanel(
                      firstText: 'GA-a O2',
                      secondText: Gasometricos.GAA.toStringAsFixed(2),
                      thirdText: 'mmHg',
                    ),
                    // ** * * * * * * *
                    CrossLine(),
                    ValuePanel(
                      firstText: 'CaO2', // Contenido Arterial de Oxígeno
                      secondText: Gasometricos.CAO.toStringAsFixed(2),
                      thirdText: 'mL/O2%',
                    ),
                    ValuePanel(
                      firstText: 'CcO2', // Contenido Capilar de Oxígeno
                      secondText: Gasometricos.CCO.toStringAsFixed(2),
                      thirdText: 'mL/O2%',
                    ),
                    ValuePanel(
                      firstText: 'CvO2', // Contenido Arterial de Oxígeno
                      secondText: Gasometricos.CVO.toStringAsFixed(2),
                      thirdText: 'mL/O2%',
                    ),
                    CrossLine(),
                    ValuePanel(
                      firstText:
                          'Da-vO2', // Diferencia Arterio-venosa de Oxígeno
                      secondText: Gasometricos.DAV.toStringAsFixed(2),
                      thirdText: 'mL',
                    ),
                    CrossLine(),
                    ValuePanel(
                      firstText: 'VO2', // Consumo de Oxígeno
                      secondText: Gasometricos.CO.toStringAsFixed(2),
                      thirdText: 'mL/min',
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ValuePanel(
                            firstText: 'DO2',
                            secondText: Gasometricos.DO.toStringAsFixed(2),
                            thirdText: 'mL/min',
                          ),
                        ),
                        Expanded(
                          child: ValuePanel(
                            firstText: 'iDO2',
                            secondText: Gasometricos.iDO.toStringAsFixed(2),
                            thirdText: 'mL/min/m2',
                          ),
                        ),
                      ],
                    ),
                    //
                    ValuePanel(
                      firstText: 'QS/QT', // Shunt Arterio-venoso
                      secondText: Gasometricos.SF.toStringAsFixed(2),
                      thirdText: '%',
                    ),
                    ValuePanel(
                      firstText: 'PAFI', //
                      secondText: Gasometricos.PAFI.toStringAsFixed(0),
                    ),
                    ValuePanel(
                      firstText: 'IEO2%', // Indice de Extracción Oxígeno
                      secondText: Gasometricos.IEO.toStringAsFixed(2),
                      thirdText: '%',
                    ),
                    ValuePanel(
                      firstText: 'I. Resp. ',
                      secondText: Gasometricos.CI.toStringAsFixed(2),
                    ),
                    //
                    ValuePanel(
                      firstText: 'ΔCO2',
                      secondText: Gasometricos.DeltaCOS.toStringAsFixed(2),
                      thirdText: 'mmHg',
                    ),
                    ValuePanel(
                      firstText: 'ΔΔCO2',
                      secondText: Gasometricos.DavCO2.toStringAsFixed(2),
                      thirdText: 'mmHg',
                    ),
                    ValuePanel(
                      firstText: 'ΔPavCO2/\nΔPavO2',
                      secondText: Gasometricos.D_PavCO2D_PavO2.toStringAsFixed(2),
                      thirdText: "", // 'mmHg/mL',
                    ),
                    ValuePanel(
                      firstText: 'Indice \nMitocondrial',
                      secondText: Gasometricos.indiceMitocondrial.toStringAsFixed(2),
                      thirdText: "", // 'mmHg/mL',
                    ),
                    // **********************************
                    CrossLine(thickness: 3),
                    CrossLine(thickness: 2),
                    CircleIcon(
                        radios: 20,
                        difRadios: 3,
                        iconed: Icons.copy_all_sharp,
                        tittle: "Copiar en Portapapeles",
                        onChangeValue: () => Datos.portapapeles(
                            context: context,
                            text: Cardiometrias.transporteOxigeno)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(7.0),
                controller: ScrollController(),
                child: Column(
                  children: [
                    EditTextArea(
                      textController: textvPHResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'vPH',
                      numOfLines: 1,
                      onChange: (String value) {
                        setState(() {
                          Valores.pHVenosos = double.parse(value);
                        });
                      },
                    ),
                    EditTextArea(
                      textController: textPvCOResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'PvCO ($unidadMedidaPvCO)',
                      numOfLines: 1,
                      onChange: (String value) {
                        setState(() {
                          Valores.pcoVenosos = double.parse(value);
                        });
                      },
                    ),

                    EditTextArea(
                      textController: textPvOResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'PvO ($unidadMedidaPvO)',
                      numOfLines: 1,
                      onChange: (String value) {
                        setState(() {
                          Valores.poVenosos = double.parse(value);
                        });
                      },
                    ),

                    EditTextArea(
                      textController: textvHCOResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'vHCO ($unidadMedidavHCO)',
                      numOfLines: 1,
                      onChange: (String value) {
                        setState(() {
                          Valores.bicarbonatoVenosos = double.parse(value);
                        });
                      },
                    ),
                    EditTextArea(
                      textController: textSvOResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'SvO ($unidadMedidaSvO)',
                      numOfLines: 1,
                      onChange: (String value) {
                        setState(() {
                          Valores.soVenosos = double.parse(value);
                        });
                      },
                    ),
                    //
                    CrossLine(),
                    EditTextArea(
                      textController: textHbTextController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Hb (g/dL)',
                      numOfLines: 1,
                      onChange: (String value) {
                        setState(() {
                          Valores.hemoglobina = double.parse(value);
                        });
                      },
                    ),
                    CrossLine(),
                    EditTextArea(
                      textController: textPVCResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'PVC (cmH2O)',
                      numOfLines: 1,
                      onChange: (String value) {
                        setState(() {
                          Valores.presionVenosaCentral = int.parse(value);
                        });
                      },
                    ),
                    EditTextArea(
                      textController: textFIOResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'FIO ($unidadMedidaFIO)',
                      numOfLines: 1,
                      onChange: (String value) {
                        setState(() {
                          Valores.fraccionInspiratoriaOxigeno =
                              int.parse(value);
                          Valores.fioArteriales =
                              Valores.fioVenosos = double.parse(value);
                        });
                      },
                    ),
                    EditTextArea(
                      textController: textLactResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Lactato ($unidadMedidaLact)',
                      numOfLines: 1,
                    ),

                    // Botton ***** ******* ****** * ***
                    CrossLine(color: Colors.grey),
                    Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.all(5.0),
                      decoration: ContainerDecoration.roundedDecoration(),
                      child: GrandIcon(
                          labelButton: "Agregar",
                          iconData: Icons.add_circle_outline,
                          weigth: 50,
                          heigth: 50,
                          onPress: () {
                            operationMethod();
                          }),
                    ),
                    CrossLine(thickness: 2, height: 15),
                    CircleIcon(
                        radios: 30,
                        difRadios: 3,
                        iconed: Icons.copy_all_sharp,
                        tittle: "Copiar en Portapapeles",
                        onChangeValue: () => Datos.portapapeles(
                            context: context,
                            text: Cardiometrias.transporteOxigeno)),
                  ],
                ),
              ),
            ),
            filePath != null
                ? Expanded(
                flex: 3, child: Container(
                decoration: ContainerDecoration.roundedDecoration(),
                height: 550,
                child: SfPdfViewer.file(File(filePath!))))
                : Expanded(flex: 1, child: Container()),
          ],
        ),
      ],
    );
  }

  List<List<String>> listOfValues() {
    return [
      // ARTERIALES ***********************************
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[9],
        Auxiliares.Laboratorios[Auxiliares.Categorias[9]][0],
        textavPHResultController.text,
        unidadMedidaavPH!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[9],
        Auxiliares.Laboratorios[Auxiliares.Categorias[9]][1],
        textPaCOResultController.text,
        unidadMedidaPaCO!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[9],
        Auxiliares.Laboratorios[Auxiliares.Categorias[9]][2],
        textPaOResultController.text,
        unidadMedidaPaO!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[9],
        Auxiliares.Laboratorios[Auxiliares.Categorias[9]][3],
        textavHCOResultController.text,
        unidadMedidaavHCO!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[9],
        Auxiliares.Laboratorios[Auxiliares.Categorias[9]][4],
        textFIOResultController.text,
        unidadMedidaFIO!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[9],
        Auxiliares.Laboratorios[Auxiliares.Categorias[9]][5],
        textSaOResultController.text,
        unidadMedidaSaO!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[8],
        Auxiliares.Laboratorios[Auxiliares.Categorias[8]][1],
        textLactResultController.text,
        unidadMedidaLact!
        //0,
      ],
      // VENOSvOS *************************************
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[10],
        Auxiliares.Laboratorios[Auxiliares.Categorias[10]][0],
        textvPHResultController.text,
        unidadMedidavPH!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[10],
        Auxiliares.Laboratorios[Auxiliares.Categorias[10]][1],
        textPvCOResultController.text,
        unidadMedidaPvCO!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[10],
        Auxiliares.Laboratorios[Auxiliares.Categorias[10]][2],
        textPvOResultController.text,
        unidadMedidaPvO!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[10],
        Auxiliares.Laboratorios[Auxiliares.Categorias[10]][3],
        textvHCOResultController.text,
        unidadMedidavHCO!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[10],
        Auxiliares.Laboratorios[Auxiliares.Categorias[10]][4],
        textFIOResultController.text,
        unidadMedidaFIO!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[10],
        Auxiliares.Laboratorios[Auxiliares.Categorias[10]][5],
        textSvOResultController.text,
        unidadMedidaSvO!
        //0,
      ],
    ];
  }

  // VARIABLES DE LA INTERFAZ ****************** ********
  var textDateEstudyController = TextEditingController();
  //
  var textPVCResultController = TextEditingController(),
      textHbTextController = TextEditingController();
  // ********* *************** ************* *
  var textavPHResultController = TextEditingController();
  String? unidadMedidaavPH = Auxiliares.Medidas[Auxiliares.Categorias[9]][0];
  var textPaCOResultController = TextEditingController();
  String? unidadMedidaPaCO = Auxiliares.Medidas[Auxiliares.Categorias[9]][1];
  var textPaOResultController = TextEditingController();
  String? unidadMedidaPaO = Auxiliares.Medidas[Auxiliares.Categorias[9]][1];
  var textavHCOResultController = TextEditingController();
  String? unidadMedidaavHCO = Auxiliares.Medidas[Auxiliares.Categorias[9]][1];
  var textFIOResultController = TextEditingController();
  String? unidadMedidaFIO = Auxiliares.Medidas[Auxiliares.Categorias[9]][4];
  var textSaOResultController = TextEditingController();
  String? unidadMedidaSaO = Auxiliares.Medidas[Auxiliares.Categorias[9]][4];
// ********* *************** ************* *
  // ********* *************** ************* *
  var textvPHResultController = TextEditingController();
  String? unidadMedidavPH = Auxiliares.Medidas[Auxiliares.Categorias[10]][0];
  var textPvCOResultController = TextEditingController();
  String? unidadMedidaPvCO = Auxiliares.Medidas[Auxiliares.Categorias[10]][1];
  var textPvOResultController = TextEditingController();
  String? unidadMedidaPvO = Auxiliares.Medidas[Auxiliares.Categorias[10]][1];
  var textvHCOResultController = TextEditingController();
  String? unidadMedidavHCO = Auxiliares.Medidas[Auxiliares.Categorias[10]][1];
  var textSvOResultController = TextEditingController();
  String? unidadMedidaSvO = Auxiliares.Medidas[Auxiliares.Categorias[10]][4];
  // ********* *************** ************* *
  var textLactResultController = TextEditingController();
  String? unidadMedidaLact = Auxiliares.Medidas[Auxiliares.Categorias[9]][5];

  // OPERACIONES DE LA INTERFAZ ****************** ********
  void cerrar() {
    Navigator.of(context).pop();
  }

  operationMethod() async {
    Operadores.loadingActivity(
        context: context,
        tittle: "Registrando información . . .",
        message: "Información registrada",
        onCloss: () {
          // Navigator.of(context).pop();
          // cerrar();
        });
    //
    Future.forEach(listOfValues(), (element) async {
      var aux = element as List<String>;

      if (aux[5] != '0' && aux[5] != '') {
        await Actividades.registrar(
          Databases.siteground_database_reggabo,
          Auxiliares.auxiliares['registerQuery'],
          element,
        );
      }
    }).whenComplete(() {
      Navigator.of(context).pop(); // Cierre del LoadActivity
      Operadores.alertActivity(
          context: context,
          tittle: "Registrando información . . .",
          message: "Información registrada",
          onAcept: () {
            // Se emplean 3 Navigator.of(context).pop(); para cerrar cada una de
            //    las ventanas emergentes y la interfaz inicial.

            Navigator.of(context).pop(); // Cierre de la Interfaz Inicial
            Navigator.of(context).pop(); // Cierre del AlertActivity
          });
    }).onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR - $error : : : $stackTrace");
      Operadores.alertActivity(
        context: context,
        tittle: "Registrando información . . .",
        message: "$error",
      );
    });
  }
}
