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

class Virales extends StatefulWidget {
  const Virales({super.key});

  @override
  State<Virales> createState() => _ViralesState();
}

class _ViralesState extends State<Virales> {
  static var index = 20; // Virales

  @override
  void initState() {
    final f = DateFormat('yyyy-MM-dd HH:mm:ss');
    textDateEstudyController.text = f.format(DateTime.now());
    // *************************************
    textAcAntiHCVResultController.text = "0.03";
    textHIVabResultController.text = "0.3";
    textHbsAgResultController.text = "<0.030";
    textHIVaGResultController.text = "0.22";
    textHIVAgAgResultController.text = "No Reactivo";
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
                textController: textAcAntiHCVResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'AcAntiHCV ($unidadMedidaAcAntiHCV)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textHIVabResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'HIVab ($unidadMedidaHIVab)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textHbsAgResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'HbsAg ($unidadMedidaHbsAg)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textHIVaGResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'HIVaG ($unidadMedidaHIVaG)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textHIVAgAgResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'HIVAg-Ag ($unidadMedidaHIVAgAg)',
                numOfLines: 1,
              ),
              // Perfil TORCH * *********** * ***
              EditTextArea(
                textController: textIgMCytoResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac IgM Cyto ($unidadMedidaIgMCyto)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textIgGCytoResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac IgG Cyto ($unidadMedidaIgGCyto)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textIgMRubeResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac IgM Rube ($unidadMedidaIgMRube)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textIgGRubeResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac IgG Rube ($unidadMedidaIgGRube)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textIgMToxoResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac IgM Toxo ($unidadMedidaIgMToxo)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textIgGToxoResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac IgG Toxo ($unidadMedidaIgGToxo)',
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
        textAcAntiHCVResultController.text,
        unidadMedidaAcAntiHCV!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][0],
        textHIVabResultController.text,
        unidadMedidaHIVab!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][2],
        textHbsAgResultController.text,
        unidadMedidaHbsAg!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][3],
        textHIVaGResultController.text,
        unidadMedidaHIVaG!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][4],
        textHIVAgAgResultController.text,
        unidadMedidaHIVAgAg!
        //0,
      ],
      // TORCH *************************
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][5],
        textIgMCytoResultController.text,
        unidadMedidaIgMCyto!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][6],
        textIgGCytoResultController.text,
        unidadMedidaIgGCyto!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][5],
        textIgMRubeResultController.text,
        unidadMedidaIgMRube!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][6],
        textIgGRubeResultController.text,
        unidadMedidaIgGRube!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][5],
        textIgMToxoResultController.text,
        unidadMedidaIgMToxo!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][6],
        textIgGToxoResultController.text,
        unidadMedidaIgGToxo!
        //0,
      ],
    ];
  }

  // VARIABLES DE LA INTERFAZ ****************** ********
  var textDateEstudyController = TextEditingController();
  // ********* *************** ************* *
  var textHIVabResultController = TextEditingController();
  String? unidadMedidaHIVab =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textAcAntiHCVResultController = TextEditingController();
  String? unidadMedidaAcAntiHCV =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textHbsAgResultController = TextEditingController();
  String? unidadMedidaHbsAg =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textHIVaGResultController = TextEditingController();
  String? unidadMedidaHIVaG =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textHIVAgAgResultController = TextEditingController();
  String? unidadMedidaHIVAgAg = Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
// TORCH
  var textIgMCytoResultController = TextEditingController();
  String? unidadMedidaIgMCyto = Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textIgGCytoResultController = TextEditingController();
  String? unidadMedidaIgGCyto = Auxiliares.Medidas[Auxiliares.Categorias[index]][1];

  var textIgMRubeResultController = TextEditingController();
  String? unidadMedidaIgMRube = Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textIgGRubeResultController = TextEditingController();
  String? unidadMedidaIgGRube = Auxiliares.Medidas[Auxiliares.Categorias[index]][1];

  var textIgMToxoResultController = TextEditingController();
  String? unidadMedidaIgMToxo = Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textIgGToxoResultController = TextEditingController();
  String? unidadMedidaIgGToxo = Auxiliares.Medidas[Auxiliares.Categorias[index]][1];

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
