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

class Inmunologicos extends StatefulWidget {
  const Inmunologicos({super.key});

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
              // EditTextArea(
              //   textController: textAcLupicoResultController,
              //   keyBoardType: TextInputType.number,
              //   inputFormat: MaskTextInputFormatter(),
              //   labelEditText:
              //   'Ac Lúpico ($unidadMedidaAcLupico)',
              //   numOfLines: 1,
              // ),
              EditTextArea(
                textController: textProteinaCResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText:
                'Proteina C ($unidadMedidaProteinaC)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textProteinaSResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText:
                'Proteina S ($unidadMedidaProteinaS)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textAcCardiolipinaIgGResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText:
                'Ac Cardiolipina IgG ($unidadMedidaAcCardiolipinaIgG)',
                numOfLines: 1,
              ),
              // EditTextArea(
              //   textController: textAcCardiolipinaIgMResultController,
              //   keyBoardType: TextInputType.number,
              //   inputFormat: MaskTextInputFormatter(),
              //   labelEditText:
              //   'AcCardiolipinaIgM ($unidadMedidaAcCardiolipinaIgM)',
              //   numOfLines: 1,
              // ),

              //
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
              EditTextArea(
                textController: textCoombsDirectoResultController,
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Coombs Directo ($unidadMedidaCoombsDirecto)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textCoombsIndirectoResultController,
                keyBoardType: TextInputType.text,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Coombs Indirecto ($unidadMedidaCoombsIndirecto)',
                numOfLines: 1,
              ),
              // 
              EditTextArea(
                textController: textAcAntiCitoplasmaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac Anti-Citoplasma ($unidadMedidaAcAntiCitoplasma)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textAntiProteinasaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Anti Proteinasa 3 ($unidadMedidaAntiProteinasa)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textAcAntiDNAResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac Anti-DNA ($unidadMedidaAcAntiDNA)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textAcAntiB2gpIgAResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac Anti B2 gp IgA ($unidadMedidaAcAntiB2gpIgA)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textAcAntiB2gpIgGResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac Anti B2 gp IgG ($unidadMedidaAcAntiB2gpIgG)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textAcAntiB2gpIgMResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Ac Anti B2gp IgM ($unidadMedidaAcAntiB2gpIgM)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textCKligerasOrinaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'C. Kappa ligeras Orina de 24 Horas ($unidadMedidaCKligerasOrina)',
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
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][8],
        textCoombsDirectoResultController.text,
        unidadMedidaCoombsDirecto!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][9],
        textCoombsIndirectoResultController.text,
        unidadMedidaCoombsIndirecto!
        //0,
      ],
      //
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][26],
        textAcAntiCitoplasmaResultController.text,
        unidadMedidaAcAntiCitoplasma!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][27],
        textAntiProteinasaResultController.text,
        unidadMedidaAntiProteinasa!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][2],
        textAcAntiDNAResultController.text,
        unidadMedidaAcAntiDNA!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][17],
        textAcAntiB2gpIgAResultController.text,
        unidadMedidaAcAntiB2gpIgA!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][18],
        textAcAntiB2gpIgGResultController.text,
        unidadMedidaAcAntiB2gpIgG!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][19],
        textAcAntiB2gpIgMResultController.text,
        unidadMedidaAcAntiB2gpIgM!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][25],
        textCKligerasOrinaResultController.text,
        unidadMedidaCKligerasOrina!
        //0,
      ],
      // OTROS 

      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][33],
        textProteinaSResultController.text,
        unidadMedidaProteinaS!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][34],
        textProteinaCResultController.text,
        unidadMedidaProteinaC!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][5],
        textAcCardiolipinaIgGResultController.text,
        unidadMedidaAcCardiolipinaIgG!
        //0,
      ],
      // [
      //   "0",
      //   Pacientes.ID_Paciente.toString(),
      //   textDateEstudyController.text,
      //   Auxiliares.Categorias[index],
      //   Auxiliares.Laboratorios[Auxiliares.Categorias[index]][25],
      //   textAcCardiolipinaIgMResultController.text,
      //   unidadMedidaAcCardiolipinaIgM!
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
  // 
  var textAntiRoResultController = TextEditingController();
  String? unidadMedidaAntiRo =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];

  var textCoombsDirectoResultController = TextEditingController();
  String? unidadMedidaCoombsDirecto = Auxiliares.Medidas[Auxiliares.Categorias[index]][4];
  var textCoombsIndirectoResultController = TextEditingController();
  String? unidadMedidaCoombsIndirecto =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][4];
  //
  var textAcAntiCitoplasmaResultController = TextEditingController();
  String? unidadMedidaAcAntiCitoplasma =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][4];
  var textAntiProteinasaResultController = TextEditingController();
  String? unidadMedidaAntiProteinasa =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][6];
  
  var textAcAntiB2gpIgAResultController = TextEditingController();
  String? unidadMedidaAcAntiB2gpIgA =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][6];
  var textAcAntiB2gpIgGResultController = TextEditingController();
  String? unidadMedidaAcAntiB2gpIgG =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][6];
  var textAcAntiB2gpIgMResultController = TextEditingController();
  String? unidadMedidaAcAntiB2gpIgM =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][6];
  
  var textCKligerasOrinaResultController = TextEditingController();
  String? unidadMedidaCKligerasOrina =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][6];
  var textAcAntiDNAResultController = TextEditingController();
  String? unidadMedidaAcAntiDNA =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][5];
  
  //
  // var textAcLupicoResultController = TextEditingController();
  // String? unidadMedidaAcLupico =
  // Auxiliares.Medidas[Auxiliares.Categorias[index]][33];
  var textProteinaSResultController = TextEditingController();
  String? unidadMedidaProteinaS =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][5];
  var textProteinaCResultController = TextEditingController();
  String? unidadMedidaProteinaC =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][5];
  var textAcCardiolipinaIgGResultController = TextEditingController();
  String? unidadMedidaAcCardiolipinaIgG =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][5];
  // var textAcCardiolipinaIgMResultController = TextEditingController();
  // String? unidadMedidaAcCardiolipinaIgM =
  // Auxiliares.Medidas[Auxiliares.Categorias[index]][5];
  
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
