import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/hidrometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/ionometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class IonesUrinarios extends StatefulWidget {
  const IonesUrinarios({Key? key}) : super(key: key);

  @override
  State<IonesUrinarios> createState() => _IonesUrinariosState();
}

class _IonesUrinariosState extends State<IonesUrinarios> {
  static var index = 15; // IonesUrinarios

  @override
  void initState() {
    final f = DateFormat('yyyy-MM-dd HH:mm:ss');
    textDateEstudyController.text = f.format(DateTime.now());
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
        CrossLine(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: TittleContainer(
              padding: 2,
              child: Column(
                children: [
                  ValuePanel(
                    firstText: "Na2+",
                    secondText: Valores.sodio.toString(),
                    thirdText: "mEq/L",
                  ),
                  ValuePanel(
                    firstText: "K+",
                    secondText: Valores.potasio.toString(),
                    thirdText: "mEq/L",
                  ),
                  ValuePanel(
                    firstText: "Cl-",
                    secondText: Valores.cloro.toString(),
                    thirdText: "mg/dL",
                  ),
                  CrossLine(),
                  ValuePanel(
                    firstText: "PO3-",
                    secondText: Valores.fosforo.toString(),
                    thirdText: "mg/dL",
                  ),
                  CrossLine(),
                  ValuePanel(
                    firstText: "Cr-",
                    secondText: Valores.creatinina.toString(),
                    thirdText: "mg/dL",
                  ),
                  ValuePanel(
                    firstText: "Ure-",
                    secondText: Valores.urea.toString(),
                    thirdText: "mg/dL",
                  ),
                  CrossLine(),
                  ValuePanel(
                    firstText: "Glu-",
                    secondText: Valores.glucosa.toString(),
                    thirdText: "mg/dL",
                  ),
                  CrossLine(),
                ],
              ),
            )),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(7.0),
                controller: ScrollController(),
                child: Column(
                  children: [
                    EditTextArea(
                      textController: textDensidadUrinariaResultController,
                      keyBoardType: TextInputType.text,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Densidad U_ ($unidadMedidaDensidadUrinaria)',
                      numOfLines: 1,
                      onChange: (String value) {
                        if (textDensidadUrinariaResultController.text.isNotEmpty) {
                          setState(() {
                            Valores.densidadUrinaria = double.parse(
                                textDensidadUrinariaResultController.text);
                          });
                        }
                      },
                    ),
                    CrossLine(),
                    EditTextArea(
                      textController: textSodioUrinarioResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText:
                          'Sodio Urinario ($unidadMedidaSodioUrinario)',
                      numOfLines: 1,
                      onChange: (String value) {
                        if (textSodioUrinarioResultController.text.isNotEmpty) {
                          setState(() {
                            Ionometrias.sodioUrinario = double.parse(
                                textSodioUrinarioResultController.text);
                          });
                        }
                      },
                    ),
                    EditTextArea(
                      textController: textPotasioUrinarioResultController,
                      keyBoardType: TextInputType.text,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Potasio Urinario ($unidadMedidaPotasioUrinario)',
                      numOfLines: 1,
                      onChange: (String value) {
                        if (textPotasioUrinarioResultController.text.isNotEmpty) {
                          setState(() {
                            Ionometrias.potasioUrinario = double.parse(
                                textPotasioUrinarioResultController.text);
                          });
                        }
                      },
                    ),
                    EditTextArea(
                      textController: textCloroUrinarioResultController,
                      keyBoardType: TextInputType.text,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Cl- U_ ($unidadMedidaCloroUrinario)',
                      numOfLines: 1,
                      onChange: (String value) {
                        if (textCloroUrinarioResultController.text.isNotEmpty) {
                          setState(() {
                            Ionometrias.cloroUrinario = double.parse(
                                textCloroUrinarioResultController.text);
                          });
                        }
                      },
                    ),
                    CrossLine(),
                    EditTextArea(
                      textController: textCalcioUrinarioResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Ca2+ U_ ($unidadMedidaCalcioUrinario)',
                      numOfLines: 1,
                      onChange: (String value) {
                        if (textCalcioUrinarioResultController.text.isNotEmpty) {
                          setState(() {
                            Ionometrias.calcioUrinario = double.parse(
                                textCalcioUrinarioResultController.text);
                          });
                        }
                      },
                    ),
                    EditTextArea(
                      textController: textFosforoUrinarioResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'PO3- U_ ($unidadMedidaFosforoUrinario)',
                      numOfLines: 1,
                      onChange: (String value) {
                        if (textFosforoUrinarioResultController.text.isNotEmpty) {
                          setState(() {
                            Ionometrias.fosforoUrinario =
                                double.parse(textFosforoUrinarioResultController.text);
                          });
                        }
                      },
                    ),
                    EditTextArea(
                      textController: textMagnesioUrinarioResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText:
                          'Mg U_ ($unidadMedidaMagnesioUrinario)',
                      numOfLines: 1,
                      onChange: (String value) {
                        if (textMagnesioUrinarioResultController.text.isNotEmpty) {
                          setState(() {
                            Ionometrias.magnesioUrinario = double.parse(
                                textMagnesioUrinarioResultController.text);
                          });
                        }
                      },
                    ),
                    CrossLine(),
                    EditTextArea(
                      textController: textCreatininaUrinarioResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Cr U_ ($unidadMedidaCreatininaUrinario)',
                      numOfLines: 1,
                      onChange: (String value) {
                        if (textCreatininaUrinarioResultController.text.isNotEmpty) {
                          setState(() {
                            Ionometrias.creatininaUrinaria = double.parse(
                                textCreatininaUrinarioResultController.text);
                          });
                        }
                      },
                    ),
                    EditTextArea(
                      textController: textUreaUrinarioResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Ure- U_ ($unidadMedidaUreaUrinario)',
                      numOfLines: 1,
                      onChange: (String value) {
                        if (textUreaUrinarioResultController.text.isNotEmpty) {
                          setState(() {
                            Ionometrias.ureaUrinaria = double.parse(
                                textUreaUrinarioResultController.text);
                          });
                        }
                      },
                    ),
                    CrossLine(),
                    EditTextArea(
                      textController: textGlucosaUrinarioResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Glu U_ ($unidadMedidaGlucosaUrinario)',
                      numOfLines: 1,
                      onChange: (String value) {
                        if (textGlucosaUrinarioResultController.text.isNotEmpty) {
                          setState(() {
                            Ionometrias.glucosaUrinario = double.parse(
                                textGlucosaUrinarioResultController.text);
                          });
                        }
                      },
                    ),

                    //
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  ValuePanel(
                    firstText: "FE_Na2+-",
                    secondText:
                    Ionometrias.fraccionExcrecionSodio.toStringAsFixed(2),
                    thirdText: "%",
                  ),
                  ValuePanel(
                    firstText: "FE_K+",
                    secondText:
                    Ionometrias.fraccionExcrecionPotasio.toStringAsFixed(2),
                    thirdText: "%",
                  ),
                  CrossLine(),
                  ValuePanel(
                    firstText: "FE_PO3-",
                    secondText:
                        Ionometrias.fraccionExcrecionFosforo.toStringAsFixed(2),
                    thirdText: "%",
                  ),
                  ValuePanel(
                    firstText: "FE_Ure (%)",
                    secondText:
                        Ionometrias.fraccionExcrecionUrea.toStringAsFixed(2),
                    thirdText: "%",
                  ),
                  CrossLine(),
                  ValuePanel(
                    firstText: "Osm_U (I)",
                    secondText:
                        Ionometrias.osmolaridadUrinaria.toStringAsFixed(2),
                    thirdText: "mOsm/L",
                  ),
                  ValuePanel(
                    firstText: "Osm_U (II)",
                    secondText:
                        Ionometrias.osmolaridadUrinariaPorDensidad.toStringAsFixed(2),
                    thirdText: "mOsm/L",
                  ),
                  CrossLine(),
                  ValuePanel(
                    firstText: "Osm_S",
                    secondText:
                    Hidrometrias.osmolaridadSerica.toStringAsFixed(2),
                    thirdText: "mOsm/L",
                  ),
                  CrossLine(),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    decoration: ContainerDecoration.roundedDecoration(),
                    child: GrandIcon(
                        iconData: Icons.add,
                        size: 60,
                        labelButton: "Agregar Datos",
                        onPress: () => operationMethod()),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  List<List<String>> listOfValues() {
    return [
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[11]][3],
        textDensidadUrinariaResultController.text,
        unidadMedidaDensidadUrinaria!
        //0,
      ],
      //
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][0],
        textSodioUrinarioResultController.text,
        unidadMedidaSodioUrinario!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][1],
        textPotasioUrinarioResultController.text,
        unidadMedidaPotasioUrinario!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][2],
        textCloroUrinarioResultController.text,
        unidadMedidaCloroUrinario!
        //0,
      ],
      //
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][3],
        textCalcioUrinarioResultController.text,
        unidadMedidaCalcioUrinario!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][4],
        textFosforoUrinarioResultController.text,
        unidadMedidaFosforoUrinario!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][5],
        textMagnesioUrinarioResultController.text,
        unidadMedidaMagnesioUrinario!
        //0,
      ],
      //
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][6],
        textCreatininaUrinarioResultController.text,
        unidadMedidaCreatininaUrinario!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][7],
        textGlucosaUrinarioResultController.text,
        unidadMedidaGlucosaUrinario!
        //0,
      ],
      //
    ];
  }

  // VARIABLES DE LA INTERFAZ ****************** ********
  var textDateEstudyController = TextEditingController();
  // ********* *************** ************* *
  var textDensidadUrinariaResultController = TextEditingController();
  String? unidadMedidaDensidadUrinaria =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  //
  var textFosforoUrinarioResultController = TextEditingController();
  String? unidadMedidaFosforoUrinario =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textCalcioUrinarioResultController = TextEditingController();
  String? unidadMedidaCalcioUrinario =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textMagnesioUrinarioResultController = TextEditingController();
  String? unidadMedidaMagnesioUrinario =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  //
  var textSodioUrinarioResultController = TextEditingController();
  String? unidadMedidaSodioUrinario =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textPotasioUrinarioResultController = TextEditingController();
  String? unidadMedidaPotasioUrinario =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textCloroUrinarioResultController = TextEditingController();
  String? unidadMedidaCloroUrinario =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  //
  var textUreaUrinarioResultController = TextEditingController();
  String? unidadMedidaUreaUrinario =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textCreatininaUrinarioResultController = TextEditingController();
  String? unidadMedidaCreatininaUrinario =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textGlucosaUrinarioResultController = TextEditingController();
  String? unidadMedidaGlucosaUrinario =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  
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

      if (aux[5] != '0' && aux[5] != '' && aux[5] != null) {
        await Actividades.registrar(
          Databases.siteground_database_reggabo,
          Auxiliares.auxiliares['registerQuery'],
          element as List<String>,
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
