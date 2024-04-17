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

class LiquidoDialisis extends StatefulWidget {
  const LiquidoDialisis({Key? key}) : super(key: key);

  @override
  State<LiquidoDialisis> createState() => _LiquidoDialisisState();
}

class _LiquidoDialisisState extends State<LiquidoDialisis> {
  static var index = 13; // LiquidoDialisis

  @override
  void initState() {
    final f = DateFormat('yyyy-MM-dd HH:mm:ss');
    textDateEstudyController.text = f.format(DateTime.now());
    // ************************************************
    textAspectoResultController.text = "Ligeramente Turbio";
    textColorResultController.text = "Incoloro";
    textLeucocitosResultController.text = "1690";
    textPolimorfonuclaresResultController.text = "68";
    textMononuclearesResultController.text = "32";
    textEritrocitosResultController.text = "No se Observan";
    textBacteriasResultController .text = "No se Observan";
    textLevadurasResultController.text = "No se Observan";
    textOtrosResultController.text = " - ";
    textPhResultController.text = "7.5";

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
        SingleChildScrollView(
          padding: const EdgeInsets.all(7.0),
          controller: ScrollController(),
          child: Column(
            children: [
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
                textController: textLeucocitosResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Leucocitos ($unidadMedidaLeucocitos)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textPolimorfonuclaresResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Polimorfonuclares ($unidadMedidaPolimorfonuclares)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textMononuclearesResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Mononucleares ($unidadMedidaMononucleares)',
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
                textController: textOtrosResultController,
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Otros ($unidadMedidaOtros)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textPhResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ph ($unidadMedidaPh)',
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
        textAspectoResultController.text,
        unidadMedidaAspecto!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][1],
        textColorResultController.text,
        unidadMedidaColor!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][2],
        textLeucocitosResultController.text,
        unidadMedidaLeucocitos!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][3],
        textPolimorfonuclaresResultController.text,
        unidadMedidaPolimorfonuclares!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][4],
        textMononuclearesResultController.text,
        unidadMedidaMononucleares!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][5],
        textEritrocitosResultController.text,
        unidadMedidaEritrocitos!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][6],
        textBacteriasResultController.text,
        unidadMedidaBacterias!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][7],
        textLevadurasResultController.text,
        unidadMedidaLevaduras!
        //0,
      ],

      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][8],
        textOtrosResultController.text,
        unidadMedidaOtros!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][9],
        textPhResultController.text,
        unidadMedidaPh!
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
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textPolimorfonuclaresResultController = TextEditingController();
  String? unidadMedidaPolimorfonuclares =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textMononuclearesResultController = TextEditingController();
  String? unidadMedidaMononucleares =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textEritrocitosResultController = TextEditingController();
  String? unidadMedidaEritrocitos = Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textBacteriasResultController = TextEditingController();
  String? unidadMedidaBacterias = Auxiliares.Medidas[Auxiliares.Categorias[index]][0];

  var textLevadurasResultController = TextEditingController();
  String? unidadMedidaLevaduras =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];

  var textLeucocitosResultController = TextEditingController();
  String? unidadMedidaLeucocitos =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textOtrosResultController = TextEditingController();
  String? unidadMedidaOtros =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textPhResultController = TextEditingController();
  String? unidadMedidaPh =
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

