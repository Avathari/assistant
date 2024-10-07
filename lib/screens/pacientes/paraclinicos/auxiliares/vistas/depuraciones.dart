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

class Depuraciones extends StatefulWidget {
  const Depuraciones({super.key});

  @override
  State<Depuraciones> createState() => _DepuracionesState();
}

class _DepuracionesState extends State<Depuraciones> {
  static var index = 12; // Depuraciones

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
                textController: textVolMuestraResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Vol de la Muestra ($unidadMedidaVolMuestra)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textCreat24ResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Creatinina en Orina de 24 Horas ($unidadMedidaCreat24)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textProt24ResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Proteínas en Orina de 24 Horas ($unidadMedidaProt24)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textAlbuOriResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Albúmina en Orina ($unidadMedidaAlbuOri)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textProtTotOriResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Proteinas Totales en Orina ($unidadMedidaProtTotOri)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textCreatOrinResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Creatinina en Orina ($unidadMedidaCreatOrin)',
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
        textVolMuestraResultController.text,
        unidadMedidaVolMuestra!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][1],
        textCreat24ResultController.text,
        unidadMedidaCreat24!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][2],
        textProt24ResultController.text,
        unidadMedidaProt24!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][3],
        textAlbuOriResultController.text,
        unidadMedidaAlbuOri!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][4],
        textProtTotOriResultController.text,
        unidadMedidaProtTotOri!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][5],
        textCreatOrinResultController.text,
        unidadMedidaCreatOrin!
        //0,
      ],
    ];
  }

  // VARIABLES DE LA INTERFAZ ****************** ********
  var textDateEstudyController = TextEditingController();
  // ********* *************** ************* *
  var textCreat24ResultController = TextEditingController();
  String? unidadMedidaCreat24 =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textVolMuestraResultController = TextEditingController();
  String? unidadMedidaVolMuestra =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textProt24ResultController = TextEditingController();
  String? unidadMedidaProt24 =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][3];
  var textAlbuOriResultController = TextEditingController();
  String? unidadMedidaAlbuOri =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][3];
  var textProtTotOriResultController = TextEditingController();
  String? unidadMedidaProtTotOri = Auxiliares.Medidas[Auxiliares.Categorias[index]][5];
  var textCreatOrinResultController = TextEditingController();
  String? unidadMedidaCreatOrin = Auxiliares.Medidas[Auxiliares.Categorias[index]][1];

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
