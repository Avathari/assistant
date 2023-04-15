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

class Biometrias extends StatefulWidget {
  const Biometrias({Key? key}) : super(key: key);

  @override
  State<Biometrias> createState() => _BiometriasState();
}

class _BiometriasState extends State<Biometrias> {
  static var index = 0; // Biometrias

  @override
  void initState() {
    final f = DateFormat('yyyy-MM-dd');
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
                textController: textHemoglobinaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Hemoglobina ($unidadMedidaHemoglobina)',
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
                textController: textHematocritoResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Hematocrito ($unidadMedidaHematocrito)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textCMHCResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'CMHC ($unidadMedidaCMHC)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textVCMResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'VCM ($unidadMedidaVCM)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textHCMResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'HCM ($unidadMedidaHCM)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textPlaquetasResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Plaquetas ($unidadMedidaPlaquetas)',
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
                textController: textNeutrofilosResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Neutrofilos ($unidadMedidaNeutrofilos)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textLinfocitosResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Linfocitos ($unidadMedidaLinfocitos)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textMonocitosResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Monocitos ($unidadMedidaMonocitos)',
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
        textHemoglobinaResultController.text,
        unidadMedidaHemoglobina!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][0],
        textEritrocitosResultController.text,
        unidadMedidaEritrocitos!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][2],
        textHematocritoResultController.text,
        unidadMedidaHematocrito!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][3],
        textCMHCResultController.text,
        unidadMedidaCMHC!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][4],
        textVCMResultController.text,
        unidadMedidaVCM!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][5],
        textHCMResultController.text,
        unidadMedidaHCM!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][8],
        textPlaquetasResultController.text,
        unidadMedidaPlaquetas!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][9],
        textLeucocitosResultController.text,
        unidadMedidaLeucocitos!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][10],
        textNeutrofilosResultController.text,
        unidadMedidaNeutrofilos!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][11],
        textLinfocitosResultController.text,
        unidadMedidaLinfocitos!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][12],
        textMonocitosResultController.text,
        unidadMedidaMonocitos!
        //0,
      ],
    ];
  }

  // VARIABLES DE LA INTERFAZ ****************** ********
  var textDateEstudyController = TextEditingController();
  // ********* *************** ************* *
  var textEritrocitosResultController = TextEditingController();
  String? unidadMedidaEritrocitos =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][4];
  var textHemoglobinaResultController = TextEditingController();
  String? unidadMedidaHemoglobina =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textHematocritoResultController = TextEditingController();
  String? unidadMedidaHematocrito =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textCMHCResultController = TextEditingController();
  String? unidadMedidaCMHC =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textVCMResultController = TextEditingController();
  String? unidadMedidaVCM = Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textHCMResultController = TextEditingController();
  String? unidadMedidaHCM = Auxiliares.Medidas[Auxiliares.Categorias[index]][3];

  var textPlaquetasResultController = TextEditingController();
  String? unidadMedidaPlaquetas =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][4];

  var textLeucocitosResultController = TextEditingController();
  String? unidadMedidaLeucocitos =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][5];
  var textNeutrofilosResultController = TextEditingController();
  String? unidadMedidaNeutrofilos =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textLinfocitosResultController = TextEditingController();
  String? unidadMedidaLinfocitos =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textMonocitosResultController = TextEditingController();
  String? unidadMedidaMonocitos =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][1];

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
