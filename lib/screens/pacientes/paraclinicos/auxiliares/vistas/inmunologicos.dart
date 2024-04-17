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

class Inmunologicos extends StatefulWidget {
  const Inmunologicos({Key? key}) : super(key: key);

  @override
  State<Inmunologicos> createState() => _InmunologicosState();
}

class _InmunologicosState extends State<Inmunologicos> {
  static var index = 22; // Inmunologicos

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
                textController: textAcMusculoLisoResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText:
                    'Ac. Anti Musculo Liso ($unidadMedidaAcMusculoLiso)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textAcAntinuclearesResultController,
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText:
                    'Ac. Antinucleares ($unidadMedidaAcAntinucleares)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textAntiLaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac. Anti-SSB (La/SSB) ($unidadMedidaAntiLa)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textAntiRoResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac. Anti-SSA (Ro/SSA) ($unidadMedidaAntiRo)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textPANCAResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'pANCA ($unidadMedidaPANCA)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textCANCAResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'cANCA ($unidadMedidaCANCA)',
                numOfLines: 1,
              ),
              //
              // EditTextArea(
              //   textController: textHCMResultController,
              //   keyBoardType: TextInputType.number,
              //   inputFormat: MaskTextInputFormatter(),
              //   labelEditText: 'HCM ($unidadMedidaHCM)',
              //   numOfLines: 1,
              // ),
              // EditTextArea(
              //   textController: textPlaquetasResultController,
              //   keyBoardType: TextInputType.number,
              //   inputFormat: MaskTextInputFormatter(),
              //   labelEditText: 'Plaquetas ($unidadMedidaPlaquetas)',
              //   numOfLines: 1,
              // ),
              // EditTextArea(
              //   textController: textLeucocitosResultController,
              //   keyBoardType: TextInputType.number,
              //   inputFormat: MaskTextInputFormatter(),
              //   labelEditText: 'Leucocitos ($unidadMedidaLeucocitos)',
              //   numOfLines: 1,
              // ),
              // EditTextArea(
              //   textController: textNeutrofilosResultController,
              //   keyBoardType: TextInputType.number,
              //   inputFormat: MaskTextInputFormatter(),
              //   labelEditText: 'Neutrofilos ($unidadMedidaNeutrofilos)',
              //   numOfLines: 1,
              // ),
              // EditTextArea(
              //   textController: textLinfocitosResultController,
              //   keyBoardType: TextInputType.number,
              //   inputFormat: MaskTextInputFormatter(),
              //   labelEditText: 'Linfocitos ($unidadMedidaLinfocitos)',
              //   numOfLines: 1,
              // ),
              // EditTextArea(
              //   textController: textMonocitosResultController,
              //   keyBoardType: TextInputType.number,
              //   inputFormat: MaskTextInputFormatter(),
              //   labelEditText: 'Monocitos ($unidadMedidaMonocitos)',
              //   numOfLines: 1,
              // ),
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
        textAcMusculoLisoResultController.text,
        unidadMedidaAcMusculoLiso!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][0],
        textAcAntinuclearesResultController.text,
        unidadMedidaAcAntinucleares!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][2],
        textAntiLaResultController.text,
        unidadMedidaAntiLa!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][3],
        textPANCAResultController.text,
        unidadMedidaPANCA!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][4],
        textCANCAResultController.text,
        unidadMedidaCANCA!
        //0,
      ],
      // [
      //   "0",
      //   Pacientes.ID_Paciente.toString(),
      //   textDateEstudyController.text,
      //   Auxiliares.Categorias[index],
      //   Auxiliares.Laboratorios[Auxiliares.Categorias[index]][5],
      //   textHCMResultController.text,
      //   unidadMedidaHCM!
      //   //0,
      // ],
      // [
      //   "0",
      //   Pacientes.ID_Paciente.toString(),
      //   textDateEstudyController.text,
      //   Auxiliares.Categorias[index],
      //   Auxiliares.Laboratorios[Auxiliares.Categorias[index]][8],
      //   textPlaquetasResultController.text,
      //   unidadMedidaPlaquetas!
      //   //0,
      // ],
      // [
      //   "0",
      //   Pacientes.ID_Paciente.toString(),
      //   textDateEstudyController.text,
      //   Auxiliares.Categorias[index],
      //   Auxiliares.Laboratorios[Auxiliares.Categorias[index]][9],
      //   textLeucocitosResultController.text,
      //   unidadMedidaLeucocitos!
      //   //0,
      // ],
      // [
      //   "0",
      //   Pacientes.ID_Paciente.toString(),
      //   textDateEstudyController.text,
      //   Auxiliares.Categorias[index],
      //   Auxiliares.Laboratorios[Auxiliares.Categorias[index]][10],
      //   textNeutrofilosResultController.text,
      //   unidadMedidaNeutrofilos!
      //   //0,
      // ],
      // [
      //   "0",
      //   Pacientes.ID_Paciente.toString(),
      //   textDateEstudyController.text,
      //   Auxiliares.Categorias[index],
      //   Auxiliares.Laboratorios[Auxiliares.Categorias[index]][11],
      //   textLinfocitosResultController.text,
      //   unidadMedidaLinfocitos!
      //   //0,
      // ],
      // [
      //   "0",
      //   Pacientes.ID_Paciente.toString(),
      //   textDateEstudyController.text,
      //   Auxiliares.Categorias[index],
      //   Auxiliares.Laboratorios[Auxiliares.Categorias[index]][12],
      //   textMonocitosResultController.text,
      //   unidadMedidaMonocitos!
      //   //0,
      // ],
    ];
  }

  // VARIABLES DE LA INTERFAZ ****************** ********
  var textDateEstudyController = TextEditingController();
  // ********* *************** ************* *
  var textAcAntinuclearesResultController = TextEditingController();
  String? unidadMedidaAcAntinucleares =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][4];
  var textAcMusculoLisoResultController = TextEditingController();
  String? unidadMedidaAcMusculoLiso =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textAntiLaResultController = TextEditingController();
  String? unidadMedidaAntiLa =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textPANCAResultController = TextEditingController();
  String? unidadMedidaPANCA =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textCANCAResultController = TextEditingController();
  String? unidadMedidaCANCA =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  // var textHCMResultController = TextEditingController();
  // String? unidadMedidaHCM = Auxiliares.Medidas[Auxiliares.Categorias[index]][3];
  //
  var textAntiRoResultController = TextEditingController();
  String? unidadMedidaAntiRo =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];

  // var textPlaquetasResultController = TextEditingController();
  // String? unidadMedidaPlaquetas =
  //     Auxiliares.Medidas[Auxiliares.Categorias[index]][4];
  //
  // var textLeucocitosResultController = TextEditingController();
  // String? unidadMedidaLeucocitos =
  //     Auxiliares.Medidas[Auxiliares.Categorias[index]][6];
  // var textNeutrofilosResultController = TextEditingController();
  // String? unidadMedidaNeutrofilos =
  //     Auxiliares.Medidas[Auxiliares.Categorias[index]][6];
  // var textLinfocitosResultController = TextEditingController();
  // String? unidadMedidaLinfocitos =
  //     Auxiliares.Medidas[Auxiliares.Categorias[index]][6];
  // var textMonocitosResultController = TextEditingController();
  // String? unidadMedidaMonocitos =
  //     Auxiliares.Medidas[Auxiliares.Categorias[index]][6];

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
