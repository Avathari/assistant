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

class Linfocitos extends StatefulWidget {
  const Linfocitos({super.key});

  @override
  State<Linfocitos> createState() => _LinfocitosState();
}

class _LinfocitosState extends State<Linfocitos> {
  static var index = 17; // Linfocitos

  @override
  void initState() {
    final f = DateFormat('yyyy-MM-dd HH:mm:ss');
    textDateEstudyController.text = f.format(DateTime.now());
    // *************************************
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
                textController: textLynTvaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Linfocitos T (VA) ($unidadMedidaLynTva)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textLynTporResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Linfocitos T ($unidadMedidaLynTpor)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textLynTcd4vaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Linfocitos T CD4 ($unidadMedidaLynTcd4va)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textLynTcd4porResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Linfocitos T CD4 ($unidadMedidaLynTcd4por)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textLynTcd8vaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Linfocitos T CD8 ($unidadMedidaLynTcd8va)',
                numOfLines: 1,
                onChange: (String value) {
                  double val = 0.0;
                  if (textLynTcd8vaResultController.text.isNotEmpty) {
                    val = double.parse(textLynTcd4vaResultController.text) /
                        double.parse(textLynTcd8vaResultController.text);
                    textRatio48ResultController.text = val.toStringAsFixed(2);
                  } else {}
                },
              ),
              EditTextArea(
                textController: textLynTcd8porResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Linfocitos T CD8 ($unidadMedidaLynTcd8por)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textRatio48ResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ratio 4/8  ($unidadMedidaRatio48)',
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
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][1],
        textLynTporResultController.text,
        unidadMedidaLynTpor!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][0],
        textLynTvaResultController.text,
        unidadMedidaLynTva!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][2],
        textLynTcd4vaResultController.text,
        unidadMedidaLynTcd4va!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][3],
        textLynTcd4porResultController.text,
        unidadMedidaLynTcd4por!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][4],
        textLynTcd8vaResultController.text,
        unidadMedidaLynTcd8va!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][5],
        textLynTcd8porResultController.text,
        unidadMedidaLynTcd8por!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][6],
        textRatio48ResultController.text,
        unidadMedidaRatio48!
        //0,
      ],
    ];
  }

  // VARIABLES DE LA INTERFAZ ****************** ********
  var textDateEstudyController = TextEditingController();
  // ********* *************** ************* *
  var textLynTvaResultController = TextEditingController();
  String? unidadMedidaLynTva =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textLynTporResultController = TextEditingController();
  String? unidadMedidaLynTpor =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textLynTcd4vaResultController = TextEditingController();
  String? unidadMedidaLynTcd4va =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textLynTcd4porResultController = TextEditingController();
  String? unidadMedidaLynTcd4por =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textLynTcd8vaResultController = TextEditingController();
  String? unidadMedidaLynTcd8va = Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textLynTcd8porResultController = TextEditingController();
  String? unidadMedidaLynTcd8por = Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  //
  var textRatio48ResultController = TextEditingController();
  String? unidadMedidaRatio48 = Auxiliares.Medidas[Auxiliares.Categorias[index]][2];

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
