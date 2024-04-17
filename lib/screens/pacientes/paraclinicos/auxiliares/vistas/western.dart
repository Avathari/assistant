import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/citometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class WesternBlot extends StatefulWidget {
  const WesternBlot({Key? key}) : super(key: key);

  @override
  State<WesternBlot> createState() => _WesternBlotState();
}

class _WesternBlotState extends State<WesternBlot> {
  static var index = 29; // WesternBlot

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
                textController: textAntigenop24ResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Antigeno p24 ($unidadMedidaAntigenop24)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textAcAntip17ResultController,
                keyBoardType: TextInputType.number,
                inputFormat:
                MaskTextInputFormatter(
                    mask: '#.##',
                    filter: {"#": RegExp(r'[0-9]')},
                    type: MaskAutoCompletionType.lazy),
                labelEditText: 'Ac. Anti-p17 ($unidadMedidaAcAntip17)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textAcAntip24ResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac. Anti-p24 ($unidadMedidaAcAntip24)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textAcAntip31ResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac. Anti-p31 ($unidadMedidaAcAntip31)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textAcAntiP39ResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac. Anti-p39 ($unidadMedidaAcAntiP39)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textAcAntiGP41ResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac. Anti-GP41 ($unidadMedidaAcAntiGP41)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textAcAntip51ResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac. Anti-p51 ($unidadMedidaAcAntip51)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textAcAntip55ResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac. Anti-p55 ($unidadMedidaAcAntip55)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textAcAntip66ResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac. Anti-p66 ($unidadMedidaAcAntip66)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textAcAntiGp120ResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac. Anti-Gp120 ($unidadMedidaAcAntiGp120)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textAcAntiGp160ResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac. Anti-Gp160 ($unidadMedidaAcAntiGp160)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textAcAntiGp36ResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac. Anti-Gp36 ($unidadMedidaAcAntiGp36)',
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
        textAntigenop24ResultController.text,
        unidadMedidaAntigenop24!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][0],
        textAcAntip17ResultController.text,
        unidadMedidaAcAntip17!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][2],
        textAcAntip24ResultController.text,
        unidadMedidaAcAntip24!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][3],
        textAcAntiP39ResultController.text,
        unidadMedidaAcAntiP39!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][0],
        textAcAntiGP41ResultController.text,
        unidadMedidaAcAntiGP41!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][5],
        textAcAntip51ResultController.text,
        unidadMedidaAcAntip51!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][8],
        textAcAntip55ResultController.text,
        unidadMedidaAcAntip55!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][9],
        textAcAntip66ResultController.text,
        unidadMedidaAcAntip66!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][10],
        textAcAntiGp120ResultController.text,
        unidadMedidaAcAntiGp120!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][11],
        textAcAntiGp160ResultController.text,
        unidadMedidaAcAntiGp160!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][12],
        textAcAntiGp36ResultController.text,
        unidadMedidaAcAntiGp36!
        //0,
      ],
    ];
  }

  // VARIABLES DE LA INTERFAZ ****************** ********
  var textDateEstudyController = TextEditingController();
  // ********* *************** ************* *
  var textAcAntip17ResultController = TextEditingController();
  String? unidadMedidaAcAntip17 =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textAntigenop24ResultController = TextEditingController();
  String? unidadMedidaAntigenop24 =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textAcAntip24ResultController = TextEditingController();
  String? unidadMedidaAcAntip24 =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textAcAntiP39ResultController = TextEditingController();
  String? unidadMedidaAcAntiP39 =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textAcAntiGP41ResultController = TextEditingController();
  String? unidadMedidaAcAntiGP41 = Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textAcAntip51ResultController = TextEditingController();
  String? unidadMedidaAcAntip51 = Auxiliares.Medidas[Auxiliares.Categorias[index]][0];

  var textAcAntip31ResultController = TextEditingController();
  String? unidadMedidaAcAntip31 =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  
  var textAcAntip55ResultController = TextEditingController();
  String? unidadMedidaAcAntip55 =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];

  var textAcAntip66ResultController = TextEditingController();
  String? unidadMedidaAcAntip66 =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textAcAntiGp120ResultController = TextEditingController();
  String? unidadMedidaAcAntiGp120 =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textAcAntiGp160ResultController = TextEditingController();
  String? unidadMedidaAcAntiGp160 =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textAcAntiGp36ResultController = TextEditingController();
  String? unidadMedidaAcAntiGp36 =
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
