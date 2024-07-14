import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Ferricos extends StatefulWidget {
  const Ferricos({Key? key}) : super(key: key);

  @override
  State<Ferricos> createState() => _FerricosState();
}

class _FerricosState extends State<Ferricos> {
  static var index = 21; // Ferricos

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
        SingleChildScrollView(
          padding: const EdgeInsets.all(7.0),
          controller: ScrollController(),
          child: Column(
            children: [
              EditTextArea(
                textController: textHierroSericoResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Hierro Sérico ($unidadMedidaHierroSerico)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textCaptacionHierroResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Captación de Hierro ($unidadMedidaCaptacionHierro)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textFerritinaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ferritina ($unidadMedidaFerritina)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textTransferrinaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Transferrina ($unidadMedidaTransferrina)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textHIVAgAgResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Porcentaje Sat. Transferrina ($unidadMedidaHIVAgAg)',
                numOfLines: 1,
              ),
              // ***************************************
              CrossLine(),
              EditTextArea(
                textController: textFolicoEndogenoResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac. Fólico Endógeno ($unidadMedidaFolicoEndogeno)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textFolatosResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Folatos ($unidadMedidaFolatos)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textCianocobResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Cianocobalamina ($unidadMedidaCianocob)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textHaptoglobinaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Haptoglobina ($unidadMedidaHaptoglobina)',
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
        textHierroSericoResultController.text,
        unidadMedidaHierroSerico!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][0],
        textCaptacionHierroResultController.text,
        unidadMedidaCaptacionHierro!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][2],
        textFerritinaResultController.text,
        unidadMedidaFerritina!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][3],
        textTransferrinaResultController.text,
        unidadMedidaTransferrina!
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
      
      // *** * * ** * * *
        [
        "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[24]][1],
    textFolicoEndogenoResultController.text,
    unidadMedidaFolicoEndogeno!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[24]][2],
    textFolatosResultController.text,
    unidadMedidaFolatos!
    //0,
    ],
    [
    "0",
    Pacientes.ID_Paciente.toString(),
    textDateEstudyController.text,
    Auxiliares.Categorias[index],
    Auxiliares.Laboratorios[Auxiliares.Categorias[24]][0],
    textCianocobResultController.text,
    unidadMedidaCianocob!
    //0,
    ],
      // 
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][6],
        textHaptoglobinaResultController.text,
        unidadMedidaHaptoglobina!
        //0,
      ],

    ];
  }

  // VARIABLES DE LA INTERFAZ ****************** ********
  var textDateEstudyController = TextEditingController();
  // ********* *************** ************* *
  var textCaptacionHierroResultController = TextEditingController();
  String? unidadMedidaCaptacionHierro =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textHierroSericoResultController = TextEditingController();
  String? unidadMedidaHierroSerico =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textFerritinaResultController = TextEditingController();
  String? unidadMedidaFerritina =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textTransferrinaResultController = TextEditingController();
  String? unidadMedidaTransferrina =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textHIVAgAgResultController = TextEditingController();
  String? unidadMedidaHIVAgAg = Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
// ***************************************************************
  var textFolicoEndogenoResultController = TextEditingController();
  String? unidadMedidaFolicoEndogeno = Auxiliares.Medidas[Auxiliares.Categorias[24]][0];
  var textFolatosResultController = TextEditingController();
  String? unidadMedidaFolatos = Auxiliares.Medidas[Auxiliares.Categorias[24]][0];
  var textCianocobResultController = TextEditingController();
  String? unidadMedidaCianocob = Auxiliares.Medidas[Auxiliares.Categorias[24]][3];
  //
  var textHaptoglobinaResultController = TextEditingController();
  String? unidadMedidaHaptoglobina = Auxiliares.Medidas[Auxiliares.Categorias[index]][0];

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
