import 'dart:io';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/cefalorraquideos.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class LiquidoCefalorraquideo extends StatefulWidget {
  const LiquidoCefalorraquideo({super.key});

  @override
  State<LiquidoCefalorraquideo> createState() => _LiquidoCefalorraquideoState();
}

class _LiquidoCefalorraquideoState extends State<LiquidoCefalorraquideo> {
  static var index = 14; // LiquidoCefalorraquideo
  String? filePath;

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
        CrossLine(height: 10),
        Row(
          children: [
            Expanded(
              child: GrandButton(
                height: 15,
                weigth: 200,
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
            ),
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
        CrossLine(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            filePath != null
                ? Expanded(
                flex: 3, child: Container(
                decoration: ContainerDecoration.roundedDecoration(),
                height: 550,
                child: SfPdfViewer.file(File(filePath!))))
                : Expanded(flex: 2, child: Container()),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(7.0),
                controller: ScrollController(),
                child: Column(
                  children: [
                    EditTextArea(
                      textController: textPresionAperturaResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText:
                          'Presión de Apertura ($unidadMedidaPresionApertura)',
                      numOfLines: 1,
                    ),
                    CrossLine(),
                    EditTextArea(
                      textController: textAspectoResultController,
                      keyBoardType: TextInputType.text,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Aspecto ($unidadMedidaAspecto)',
                      numOfLines: 1,
                    ),
                    EditTextArea(
                      textController: textColorResultController,
                      keyBoardType: TextInputType.text,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Color ($unidadMedidaColor)',
                      numOfLines: 1,
                    ),
                    CrossLine(),
                    // CITOQUÍMICO *****************************************
                    EditTextArea(
                      textController: textGlucosaLCRResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Glucosa LCR ($unidadMedidaGlucosaLCR)',
                      numOfLines: 1,
                      onChange: (String value) {
                        if (textGlucosaLCRResultController.text.isNotEmpty) {
                          setState(() {
                            Cefalorraquideos.glucosaLCR = double.parse(
                                textGlucosaLCRResultController.text);
                          });
                        }
                      },
                    ),
                    EditTextArea(
                      textController: textDhlLCRResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'DHL LCR ($unidadMedidaDhlLCR)',
                      numOfLines: 1,
                      onChange: (String value) {
                        if (textDhlLCRResultController.text.isNotEmpty) {
                          setState(() {
                            Cefalorraquideos.lactatoDeshidrogenasaLCR =
                                double.parse(textDhlLCRResultController.text);
                          });
                        }
                      },
                    ),
                    EditTextArea(
                      textController: textProteinasLCRResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText:
                          'Proteinas LCR ($unidadMedidaProteinasLCR)',
                      numOfLines: 1,
                      onChange: (String value) {
                        if (textProteinasLCRResultController.text.isNotEmpty) {
                          setState(() {
                            Cefalorraquideos.proteinasLCR = double.parse(
                                textProteinasLCRResultController.text);
                          });
                        }
                      },
                    ),
                    EditTextArea(
                      textController: textAlbuminaLCRResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Albumina LCR ($unidadMedidaAlbuminaLCR)',
                      numOfLines: 1,
                      onChange: (String value) {
                        if (textAlbuminaLCRResultController.text.isNotEmpty) {
                          setState(() {
                            Cefalorraquideos.albuminaLCR = double.parse(
                                textAlbuminaLCRResultController.text);
                          });
                        }
                      },
                    ),
                    //
                    EditTextArea(
                      textController: textphLCRResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'ph LCR ($unidadMedidaphLCR)',
                      numOfLines: 1,
                    ),
                    //
                    EditTextArea(
                      textController: texteritrocitosLCRResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText:
                          'Eritrocitos LCR ($unidadMedidaeritrocitosLCR)',
                      numOfLines: 1,
                      onChange: (String value) {
                        if (texteritrocitosLCRResultController
                            .text.isNotEmpty) {
                          setState(() {
                            Cefalorraquideos.eritrocitosLCR = double.parse(
                                texteritrocitosLCRResultController.text);
                          });
                        }
                      },
                    ),
                    EditTextArea(
                      textController: textLeucocitosResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Leucocitos ($unidadMedidaLeucocitos)',
                      numOfLines: 1,
                      onChange: (String value) {
                        if (textLeucocitosResultController.text.isNotEmpty) {
                          setState(() {
                            Cefalorraquideos.leucocitosLCR = double.parse(
                                textLeucocitosResultController.text);
                          });
                        }
                      },
                    ),
                    EditTextArea(
                      textController: textpolimorfonuclearesLCRResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText:
                          'PMN LCR ($unidadMedidapolimorfonuclearesLCR)',
                      numOfLines: 1,
                      onChange: (String value) {
                        if (textpolimorfonuclearesLCRResultController
                            .text.isNotEmpty) {
                          setState(() {
                            Cefalorraquideos.polimorfonuclearesLCR =
                                double.parse(
                                    textpolimorfonuclearesLCRResultController
                                        .text);
                          });
                        }
                      },
                    ),
                    EditTextArea(
                      textController: textmononuclearesLCRResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText:
                          'Mononucleares LCR ($unidadMedidamononuclearesLCR)',
                      numOfLines: 1,
                      onChange: (String value) {
                        if (textmononuclearesLCRResultController
                            .text.isNotEmpty) {
                          setState(() {
                            Cefalorraquideos.mononuclearesLCR = double.parse(
                                textmononuclearesLCRResultController.text);
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
                    firstText: "Glu-",
                    secondText: Valores.glucosa.toString(),
                    thirdText: "mg/dL",
                  ),
                  CrossLine(),
                  ValuePanel(
                    firstText: "Eryt",
                    secondText: Valores.eritrocitos.toString(),
                    thirdText: "mm3/uL",
                  ),
                  ValuePanel(
                    firstText: "Hb-",
                    secondText: Valores.hemoglobina.toString(),
                    thirdText: "g/dL",
                  ),
                  ValuePanel(
                    firstText: "Leu-",
                    secondText: Valores.leucocitosTotales.toString(),
                    thirdText: "mm3/uL",
                  ),
                  CrossLine(),
                  ValuePanel(
                    firstText: "Alb-",
                    secondText: Valores.albuminaSerica.toString(),
                    thirdText: "g/dL",
                  ),
                  ValuePanel(
                    firstText: "Prot-",
                    secondText: Valores.proteinasTotales.toString(),
                    thirdText: "g/dL",
                  ),
                  CrossLine(),
                  CrossLine(),
                  ValuePanel(
                    firstText: "Relación\nGluc",
                    secondText:
                        Cefalorraquideos.relacionGlucosa.toStringAsFixed(2),
                    thirdText: "",
                  ),
                  ValuePanel(
                    firstText: "Relación\nAlbumina",
                    secondText:
                        Cefalorraquideos.relacionAlbumina.toStringAsFixed(2),
                    thirdText: "",
                  ),
                  CrossLine(),
                  ValuePanel(
                    firstText: "LEU_Real",
                    secondText:
                        Cefalorraquideos.leucocitosRealesLCR.toStringAsFixed(2),
                    thirdText: "mm3",
                  ),
                  ValuePanel(
                    firstText: "PROT_Real",
                    secondText:
                        Cefalorraquideos.proteinasRealesLCR.toStringAsFixed(2),
                    thirdText: "g/dL",
                  ),
                  CrossLine(),

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
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][0],
        textPresionAperturaResultController.text,
        unidadMedidaPresionApertura!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][1],
        textGlucosaLCRResultController.text,
        unidadMedidaGlucosaLCR!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][2],
        textDhlLCRResultController.text,
        unidadMedidaDhlLCR!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][3],
        textProteinasLCRResultController.text,
        unidadMedidaProteinasLCR!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][4],
        textAlbuminaLCRResultController.text,
        unidadMedidaAlbuminaLCR!
        //0,
      ],
      // CITOQUIMICO
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][8],
        textAspectoResultController.text,
        unidadMedidaAspecto!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][9],
        textColorResultController.text,
        unidadMedidaColor!
        //0,
      ],
      //
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][10],
        textLeucocitosResultController.text,
        unidadMedidaLeucocitos!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][11],
        textpolimorfonuclearesLCRResultController.text,
        unidadMedidapolimorfonuclearesLCR!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][12],
        textmononuclearesLCRResultController.text,
        unidadMedidamononuclearesLCR!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][13],
        texteritrocitosLCRResultController.text,
        unidadMedidaeritrocitosLCR!
        //0,
      ],
      //
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][17],
        textphLCRResultController.text,
        unidadMedidaphLCR!
        //0,
      ],
    ];
  }

  // VARIABLES DE LA INTERFAZ ****************** ********
  var textDateEstudyController = TextEditingController();
  // ********* *************** ************* *
  var textDhlLCRResultController = TextEditingController();
  String? unidadMedidaDhlLCR =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][7];
  var textGlucosaLCRResultController = TextEditingController();
  String? unidadMedidaGlucosaLCR =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textProteinasLCRResultController = TextEditingController();
  String? unidadMedidaProteinasLCR =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][5];
  var textPresionAperturaResultController = TextEditingController();
  String? unidadMedidaPresionApertura =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][4];
  var texteritrocitosLCRResultController = TextEditingController();
  String? unidadMedidaeritrocitosLCR =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textphLCRResultController = TextEditingController();
  String? unidadMedidaphLCR =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];

  var textAlbuminaLCRResultController = TextEditingController();
  String? unidadMedidaAlbuminaLCR =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][5];

  var textAspectoResultController = TextEditingController();
  String? unidadMedidaAspecto =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];

  var textLeucocitosResultController = TextEditingController();
  String? unidadMedidaLeucocitos =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][3]; // 1: mm3, 3: %
  var textpolimorfonuclearesLCRResultController = TextEditingController();
  String? unidadMedidapolimorfonuclearesLCR =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][3];
  var textmononuclearesLCRResultController = TextEditingController();
  String? unidadMedidamononuclearesLCR =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][3];
  var textColorResultController = TextEditingController();
  String? unidadMedidaColor =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];

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
