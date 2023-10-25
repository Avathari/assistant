import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Uroanalisis extends StatefulWidget {
  const Uroanalisis({Key? key}) : super(key: key);

  @override
  State<Uroanalisis> createState() => _UroanalisisState();
}

class _UroanalisisState extends State<Uroanalisis> {
  static var index = 11; // Uroanalisis


  @override
  void initState() {
    final f = DateFormat('yyyy-MM-dd');
    textDateEstudyController.text = f.format(DateTime.now());
    // ************************************************
    textColorResultController.text = "Incoloro";
    textAspectoResultController.text = "Ligeramente Turbio";
    textPhResultController.text = "7.5";

    textDensidadResultController.text = "1.025";
    textHemoglobinaResultController.text = "Negativo";
    textProteinasResultController.text = "Negativo";
    textUrobilinogenoResultController.text = "0.2";
    textBilirrubinasResultController.text = "Negativo";
    textCetonasResultController.text = "Negativo";
    textGlucosaResultController.text = "Negativo";
    textEsterasaLeucocitariaResultController.text = "Apr 15";
    textNitritosResultController.text = "Negativo";
    textFosfatosResultController.text = "Negativo";
    textCristalesResultController.text = "Negativo";
    textMucinaResultController.text = "Negativo";
    textCelulasRenalesResultController.text = "Negativo";

    textLeucocitosResultController.text = "8-10";
    textCelulasEpitelialesResultController.text = "+";
    textCilindrosResultController.text = "Negativo";
    textEritrocitosResultController.text = "0-1";
    textBacteriasResultController .text = "No se Observan";
    textLevadurasResultController.text = "No se Observan";
    textUratosResultController.text = "No se Observan";
    
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
                  Calendarios.today(format: "yyyy/MM/dd");
            });
          },
          inputFormat: MaskTextInputFormatter(
              mask: '####/##/##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.all(7.0),
          controller: ScrollController(),
          child: Column(
            children: [
              EditTextArea(
                textController: textColorResultController,
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Color ($unidadMedidaColor)',
                numOfLines: 1,
                selection: true,
                withShowOption: true,
                onSelected: () {
                  Operadores.selectOptionsActivity(
                      context: context,
                      options:
                      Auxiliares.colorLiquidos,
                      onClose: (value) {
                        setState(() {
                          textColorResultController.text = value;
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              EditTextArea(
                textController: textAspectoResultController,
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Aspecto ($unidadMedidaAspecto)',
                numOfLines: 1,
                selection: true,
                withShowOption: true,
                onSelected: () {
                  Operadores.selectOptionsActivity(
                      context: context,
                      options:
                      Auxiliares.aspectoLiquidos,
                      onClose: (value) {
                        setState(() {
                          textAspectoResultController.text = value;
                          Navigator.of(context).pop();
                        });
                      });
                },
              ),
              EditTextArea(
                textController: textPhResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ph ($unidadMedidaPh)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textDensidadResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Densidad ($unidadMedidaDensidad)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textHemoglobinaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Hemoglobina ($unidadMedidaHemoglobina)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textProteinasResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Proteinas ($unidadMedidaProteinas)',
                numOfLines: 1,
              ),
              
              EditTextArea(
                textController: textUrobilinogenoResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Urobilinogeno ($unidadMedidaUrobilinogeno)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textBilirrubinasResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Bilirrubinas ($unidadMedidaBilirrubinas)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textCetonasResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Cetonas ($unidadMedidaCetonas)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textGlucosaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Glucosa ($unidadMedidaGlucosa)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textEsterasaLeucocitariaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'EsterasaLeucocitaria ($unidadMedidaEsterasaLeucocitaria)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textNitritosResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Nitritos ($unidadMedidaNitritos)',
                numOfLines: 1,
              ),
              
              EditTextArea(
                textController: textLeucocitosResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Leucocitos ($unidadMedidaLeucocitos)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textEritrocitosResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Eritrocitos ($unidadMedidaEritrocitos)',
                numOfLines: 1,
              ),
            
            EditTextArea(
                textController: textCelulasEpitelialesResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'CelulasEpiteliales ($unidadMedidaCelulasEpiteliales)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textBacteriasResultController,
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Bacterias ($unidadMedidaBacterias)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textLevadurasResultController,
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Levaduras ($unidadMedidaLevaduras)',
                numOfLines: 1,
              ),              
              EditTextArea(
                textController: textCilindrosResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Cilindros ($unidadMedidaCilindros)',
                numOfLines: 1,
              ),
              
              EditTextArea(
                textController: textUratosResultController,
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Uratos ($unidadMedidaUratos)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textFosfatosResultController,
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Fosfatos ($unidadMedidaFosfatos)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textCristalesResultController,
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Cristales ($unidadMedidaCristales)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textMucinaResultController,
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Mucina ($unidadMedidaMucina)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textCelulasRenalesResultController,
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'CelulasRenales ($unidadMedidaCelulasRenales)',
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
      textColorResultController.text,
      unidadMedidaColor!
      //0,
    ],
    [
      "0",
      Pacientes.ID_Paciente.toString(),
      textDateEstudyController.text,
      Auxiliares.Categorias[index],
      Auxiliares.Laboratorios[Auxiliares.Categorias[index]][1],
      textAspectoResultController.text,
      unidadMedidaAspecto!
      //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][2],
    textPhResultController.text,
    unidadMedidaPh!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][3],
    textDensidadResultController.text,
    unidadMedidaDensidad!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][4],
    textHemoglobinaResultController.text,
    unidadMedidaHemoglobina!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][5],
    textProteinasResultController.text,
    unidadMedidaProteinas!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][6],
    textUrobilinogenoResultController.text,
    unidadMedidaUrobilinogeno!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][7],
    textBilirrubinasResultController.text,
    unidadMedidaBilirrubinas!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][8],
    textCetonasResultController.text,
    unidadMedidaCetonas!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][9],
    textGlucosaResultController.text,
    unidadMedidaGlucosa!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][10],
    textEsterasaLeucocitariaResultController.text,
    unidadMedidaEsterasaLeucocitaria!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][11],
    textNitritosResultController.text,
    unidadMedidaNitritos!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][12],
    textLeucocitosResultController.text,
    unidadMedidaLeucocitos!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][13],
    textEritrocitosResultController.text,
    unidadMedidaEritrocitos!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][14],
    textCelulasEpitelialesResultController.text,
    unidadMedidaCelulasEpiteliales!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][15],
    textBacteriasResultController.text,
    unidadMedidaBacterias!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][16],
    textLevadurasResultController.text,
    unidadMedidaLevaduras!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][17],
    textCilindrosResultController.text,
    unidadMedidaCilindros!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][18],
    textUratosResultController.text,
    unidadMedidaUratos!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][19],
    textFosfatosResultController.text,
    unidadMedidaFosfatos!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][20],
    textCristalesResultController.text,
    unidadMedidaCristales!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][21],
    textMucinaResultController.text,
    unidadMedidaMucina!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[index]][22],
    textCelulasRenalesResultController.text,
    unidadMedidaCelulasRenales!
    //0,
    ],
    ];
  }

  // VARIABLES DE LA INTERFAZ ****************** ********
  var textDateEstudyController = TextEditingController();
  // ********* *************** ************* *
  var textColorResultController = TextEditingController();
  String? unidadMedidaColor =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textAspectoResultController = TextEditingController();
  String? unidadMedidaAspecto =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textPhResultController = TextEditingController();
  String? unidadMedidaPh =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  // ****************************************
  var textDensidadResultController = TextEditingController();
  String? unidadMedidaDensidad =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][0];

  var textHemoglobinaResultController = TextEditingController();
  String? unidadMedidaHemoglobina =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textProteinasResultController = TextEditingController();
  String? unidadMedidaProteinas =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textUrobilinogenoResultController = TextEditingController();
  String? unidadMedidaUrobilinogeno =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textBilirrubinasResultController = TextEditingController();
  String? unidadMedidaBilirrubinas =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textCetonasResultController = TextEditingController();
  String? unidadMedidaCetonas =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textGlucosaResultController = TextEditingController();
  String? unidadMedidaGlucosa =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textEsterasaLeucocitariaResultController = TextEditingController();
  String? unidadMedidaEsterasaLeucocitaria =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][3];
  var textNitritosResultController = TextEditingController();
  String? unidadMedidaNitritos =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][0];

  var textLeucocitosResultController = TextEditingController();
  String? unidadMedidaLeucocitos =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textEritrocitosResultController = TextEditingController();
  String? unidadMedidaEritrocitos = Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textCelulasEpitelialesResultController = TextEditingController();
  String? unidadMedidaCelulasEpiteliales =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textBacteriasResultController = TextEditingController();
  String? unidadMedidaBacterias = Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textLevadurasResultController = TextEditingController();
  String? unidadMedidaLevaduras =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textCilindrosResultController = TextEditingController();
  String? unidadMedidaCilindros =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][2];

  var textUratosResultController = TextEditingController();
  String? unidadMedidaUratos =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textFosfatosResultController = TextEditingController();
  String? unidadMedidaFosfatos =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textCristalesResultController = TextEditingController();
  String? unidadMedidaCristales =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textMucinaResultController = TextEditingController();
  String? unidadMedidaMucina =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textCelulasRenalesResultController = TextEditingController();
  String? unidadMedidaCelulasRenales =
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


// selection: true,
// withShowOption: true,
// onSelected: () {
// Operadores.selectOptionsActivity(
// context: context,
// options:
// Auxiliares.aspectoLiquidos,
// onClose: (value) {
// setState(() {
// textAspectoResultController.text = value;
// Navigator.of(context).pop();
// });
// });
// },

