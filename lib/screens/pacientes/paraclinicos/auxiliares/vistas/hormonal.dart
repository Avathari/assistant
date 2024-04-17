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

class Hormonales extends StatefulWidget {
  const Hormonales({Key? key}) : super(key: key);

  @override
  State<Hormonales> createState() => _HormonalesState();
}

class _HormonalesState extends State<Hormonales> {
  static var index = 23; // Hormonales

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
                textController: textCortisolResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Cortisol ($unidadMedidaCortisol)',
                numOfLines: 1,
                onChange: (String value) {
                  if (textCortisolResultController.text.isNotEmpty)
                    Valores.hemoglobina =
                        double.parse(textCortisolResultController.text);
                },
              ),
              EditTextArea(
                textController: textACTHResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(
                    mask: '#.##',
                    filter: {"#": RegExp(r'[0-9]')},
                    type: MaskAutoCompletionType.lazy),
                labelEditText: 'ACTH ($unidadMedidaACTH)',
                numOfLines: 1,
                onChange: (String value) {
                  if (textACTHResultController.text.isNotEmpty)
                    Valores.eritrocitos =
                        double.parse(textACTHResultController.text);
                },
              ),
              EditTextArea(
                textController: textFHSResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'FHS ($unidadMedidaFHS)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textADEResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'RWD / ADE ($unidadMedidaADE)',
                numOfLines: 1,
                onChange: (String value) {
                  if (textADEResultController.text.isNotEmpty) {
                    Valores.anchoDistribucionEritrocitaria =
                        double.parse(textADEResultController.text);
                  }
                },
              ),

              EditTextArea(
                textController: textProgesteronaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Progesterona ($unidadMedidaProgesterona)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textEstradiolResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Estradiol ($unidadMedidaEstradiol)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textEstronaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Estrona ($unidadMedidaEstrona)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textDihidrotestosteronaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText:
                    'Dihidrotestosterona ($unidadMedidaDihidrotestosterona)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textTestosteronaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Testosterona ($unidadMedidaTestosterona)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textProlactinaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Prolactina ($unidadMedidaProlactina)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textADHResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'ADH ($unidadMedidaADH)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textLuteinizanteResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Luteinizante ($unidadMedidaLuteinizante)',
                numOfLines: 1,
              ),
              // Botton ***** ******* ****** * ***
              CrossLine(color: Colors.grey),
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
        textCortisolResultController.text,
        unidadMedidaCortisol!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][0],
        textACTHResultController.text,
        unidadMedidaACTH!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][2],
        textFHSResultController.text,
        unidadMedidaFHS!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][3],
        textProgesteronaResultController.text,
        unidadMedidaProgesterona!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][4],
        textEstradiolResultController.text,
        unidadMedidaEstradiol!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][5],
        textEstronaResultController.text,
        unidadMedidaEstrona!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][8],
        textDihidrotestosteronaResultController.text,
        unidadMedidaDihidrotestosterona!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][9],
        textTestosteronaResultController.text,
        unidadMedidaTestosterona!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][10],
        textProlactinaResultController.text,
        unidadMedidaProlactina!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][11],
        textADHResultController.text,
        unidadMedidaADH!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][12],
        textLuteinizanteResultController.text,
        unidadMedidaLuteinizante!
        //0,
      ],
    ];
  }

  // VARIABLES DE LA INTERFAZ ****************** ********
  var textDateEstudyController = TextEditingController();
  // ********* *************** ************* *
  var textACTHResultController = TextEditingController();
  String? unidadMedidaACTH =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][4];
  var textCortisolResultController = TextEditingController();
  String? unidadMedidaCortisol =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textFHSResultController = TextEditingController();
  String? unidadMedidaFHS = Auxiliares.Medidas[Auxiliares.Categorias[index]][4];
  var textProgesteronaResultController = TextEditingController();
  String? unidadMedidaProgesterona =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textEstradiolResultController = TextEditingController();
  String? unidadMedidaEstradiol =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textEstronaResultController = TextEditingController();
  String? unidadMedidaEstrona =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][3];
  var textADEResultController = TextEditingController();
  String? unidadMedidaADE = Auxiliares.Medidas[Auxiliares.Categorias[index]][1];

  var textDihidrotestosteronaResultController = TextEditingController();
  String? unidadMedidaDihidrotestosterona =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][4];
  var textTestosteronaResultController = TextEditingController();
  String? unidadMedidaTestosterona =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][4];

  var textProlactinaResultController = TextEditingController();
  String? unidadMedidaProlactina =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textADHResultController = TextEditingController();
  String? unidadMedidaADH = Auxiliares.Medidas[Auxiliares.Categorias[index]][4];
  var textLuteinizanteResultController = TextEditingController();
  String? unidadMedidaLuteinizante =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][4];

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
