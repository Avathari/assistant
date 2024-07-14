import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/hepatometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Hepaticos extends StatefulWidget {
  const Hepaticos({Key? key}) : super(key: key);

  @override
  State<Hepaticos> createState() => _HepaticosState();
}

class _HepaticosState extends State<Hepaticos> {
  static var index = 3; // Hepaticos

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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  ValuePanel(
                    firstText: "Factor R",
                    secondText: Hepatometrias.factorR.toStringAsFixed(2),
                  ),
                  CrossLine(thickness: 2),
                  ValuePanel(
                    firstText: "ALT/FA",
                    secondText: Hepatometrias.relacionALTFA.toStringAsFixed(2),
                  ),
                  ValuePanel(
                    firstText: "ALT/AST",
                    secondText: Hepatometrias.relacionALTAST.toStringAsFixed(2),
                  ),
                  ValuePanel(
                    firstText: "ALT/DHL",
                    secondText: Hepatometrias.relacionALTDHL.toStringAsFixed(2),
                  ),
                  ValuePanel(
                    firstText: "GGT/FA",
                    secondText: Hepatometrias.relacionGGTFA.toStringAsFixed(2),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(7.0),
                controller: ScrollController(),
                child: Column(
                  children: [
                    EditTextArea(
                      textController: textBTResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Bilirrubinas Totales ($unidadMedidaBT)',
                      numOfLines: 1,
                      onChange: (String value) {
                        double val = 0.0;
                        if (textBDResultController.text.isNotEmpty) {
                          val = double.parse(textBTResultController.text) -
                              double.parse(textBDResultController.text);
                          textBIResultController.text = val.toStringAsFixed(2);
                        } else {}
                      },
                    ),
                    EditTextArea(
                      textController: textBDResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Bilirrubina Directa ($unidadMedidaBD)',
                      numOfLines: 1,
                      onChange: (String value) {
                        double val = 0.0;

                        if (textBTResultController.text.isNotEmpty) {
                          val = double.parse(textBTResultController.text) -
                              double.parse(textBDResultController.text);
                          textBIResultController.text = val.toStringAsFixed(2);
                        } else {}
                      },
                    ),
                    EditTextArea(
                        textController: textBIResultController,
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText:
                            'Bilirrubina Indirecta ($unidadMedidaBI)',
                        numOfLines: 1,
                        onChange: (String value) =>
                            Valores.bilirrubinaIndirecta =
                                double.parse(textBIResultController.text)),
                    EditTextArea(
                        textController: textAlaninoResultController,
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText:
                            'Alaninoaminotrasferasa ($unidadMedidaAlanino)',
                        numOfLines: 1,
                        onChange: (String value) => setState(() => Valores
                                .alaninoaminotrasferasa =
                            double.parse(textAlaninoResultController.text))),
                    EditTextArea(
                        textController: textAspartatoResultController,
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText:
                            'Aspartatoaminotransferasa ($unidadMedidaAspartato)',
                        numOfLines: 1,
                        onChange: (String value) => setState(() => Valores
                                .aspartatoaminotransferasa =
                            double.parse(textAspartatoResultController.text))),
                    EditTextArea(
                        textController: textDHLResultController,
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText:
                            'Deshidrogenasa Láctica ($unidadMedidaDHL)',
                        numOfLines: 1,
                        onChange: (String value) => setState(() =>
                            Valores.deshidrogenasaLactica =
                                double.parse(textDHLResultController.text))),

                    EditTextArea(
                        textController: textGlutarilResultController,
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText:
                            'Glutaril transpeptidasa ($unidadMedidaGlutaril)',
                        numOfLines: 1,
                        onChange: (String value) => setState(() => Valores
                                .glutrailtranspeptidasa =
                            double.parse(textGlutarilResultController.text))),
                    EditTextArea(
                        textController: textFosfatasaResultController,
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText:
                            'Fosfatasa Alcalina ($unidadMedidaFosfatasa)',
                        numOfLines: 1,
                        onChange: (String value) => setState(() => Valores
                                .fosfatasaAlcalina =
                            double.parse(textFosfatasaResultController.text))),

                    EditTextArea(
                        textController: textAlbuminaResultController,
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText:
                            'Albumina Sérica ($unidadMedidaAlbumina)',
                        numOfLines: 1,
                        onChange: (String value) => setState(() => Valores
                                .albuminaSerica =
                            double.parse(textAlbuminaResultController.text))),
                    EditTextArea(
                        textController: textProteinasResultController,
                        keyBoardType: TextInputType.number,
                        inputFormat: MaskTextInputFormatter(),
                        labelEditText:
                            'Proteinas Totales ($unidadMedidaProteinas)',
                        numOfLines: 1,
                        onChange: (String value) {
                          Valores.proteinasTotales =
                              double.parse(textProteinasResultController.text);
                          textGlobulinasResultController.text =
                              Hepatometrias.globulinas.toStringAsFixed(2);
                        }),
                    EditTextArea(
                      textController: textGlobulinasResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Globulinas ($unidadMedidaGlobulinas)',
                      numOfLines: 1,
                    ),
                    // Botton ***** ******* ****** * ***
                    CrossLine(
                      color: Colors.grey,
                    ),
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      decoration: ContainerDecoration.roundedDecoration(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GrandButton(
                                labelButton: "Agregar Datos",
                                weigth: 2000,
                                onPress: () {
                                  operationMethod();
                                }),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Column(
              children: [
                ValuePanel(
                  firstText: "I-APRI",
                  secondText: Hepatometrias.APRI.toStringAsFixed(2),
                ),
                ValuePanel(
                  firstText: "FIB-4",
                  secondText: Hepatometrias.Fib4.toStringAsFixed(2),
                ),
                ValuePanel(
                  firstText: "",
                  secondText: "",
                ),
              ],
            ))
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
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][2],
        textBTResultController.text,
        unidadMedidaBT!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][3],
        textBDResultController.text,
        unidadMedidaBD!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][4],
        textBIResultController.text,
        unidadMedidaBI!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][0],
        textAlaninoResultController.text,
        unidadMedidaAlanino!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][1],
        textAspartatoResultController.text,
        unidadMedidaAspartato!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][5],
        textDHLResultController.text,
        unidadMedidaDHL!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][6],
        textGlutarilResultController.text,
        unidadMedidaGlutaril!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][7],
        textFosfatasaResultController.text,
        unidadMedidaFosfatasa!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][8],
        textAlbuminaResultController.text,
        unidadMedidaAlbumina!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][9],
        textProteinasResultController.text,
        unidadMedidaProteinas!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][10],
        textGlobulinasResultController.text,
        unidadMedidaGlobulinas!
        //0,
      ],
    ];
  }

  // VARIABLES DE LA INTERFAZ ****************** ********
  var textDateEstudyController = TextEditingController();
  // ********* *************** ************* *
  var textBDResultController = TextEditingController();
  String? unidadMedidaBD = Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textBTResultController = TextEditingController();
  String? unidadMedidaBT = Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textBIResultController = TextEditingController();
  String? unidadMedidaBI = Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textAlaninoResultController = TextEditingController();
  String? unidadMedidaAlanino =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textAspartatoResultController = TextEditingController();
  String? unidadMedidaAspartato =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textDHLResultController = TextEditingController();
  String? unidadMedidaDHL = Auxiliares.Medidas[Auxiliares.Categorias[index]][0];

  var textGlutarilResultController = TextEditingController();
  String? unidadMedidaGlutaril =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];

  var textFosfatasaResultController = TextEditingController();
  String? unidadMedidaFosfatasa =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textAlbuminaResultController = TextEditingController();
  String? unidadMedidaAlbumina =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textProteinasResultController = TextEditingController();
  String? unidadMedidaProteinas =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textGlobulinasResultController = TextEditingController();
  String? unidadMedidaGlobulinas =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][2];

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
