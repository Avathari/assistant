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

class Quimicas extends StatefulWidget {
  const Quimicas({Key? key}) : super(key: key);

  @override
  State<Quimicas> createState() => _QuimicasState();
}

class _QuimicasState extends State<Quimicas> {
  static var index = 1; // Quimicas

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
                textController: textGlucosaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Glucosa ($unidadMedidaGlucosa)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textUreaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Urea ($unidadMedidaUrea)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textCreatininaResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Creatinina ($unidadMedidaCreatinina)',
                numOfLines: 1,
              ),

              EditTextArea(
                textController: textAcidoUricoResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText: 'Acido Urico ($unidadMedidaAcidoUrico)',
                numOfLines: 1,
              ),
              EditTextArea(
                textController: textNitrogenoUreicoResultController,
                keyBoardType: TextInputType.number,
                inputFormat: MaskTextInputFormatter(),
                labelEditText:
                    'Nitrógeno Ureico ($unidadMedidaNitrogenoUreico)',
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
                            operationMethod().then(
                              (value) => Operadores.loadingActivity(
                                  context: context,
                                  tittle: "Registrando información . . .",
                                  message: "Información registrada",
                                  onCloss: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    cerrar();
                                  }),
                            );
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
        textGlucosaResultController.text,
        unidadMedidaGlucosa!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][1],
        textUreaResultController.text,
        unidadMedidaUrea!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][2],
        textCreatininaResultController.text,
        unidadMedidaCreatinina!
        //0,
      ],
      // [
      //   "0",
      //   Pacientes.ID_Paciente.toString(),
      //   textDateEstudyController.text,
      //   Auxiliares.Categorias[index],
      // Auxiliares.Laboratorios[Auxiliares.Categorias[index]][4],
      //   textAcidoUricoResultController.text,
      //   unidadMedidaAcidoUrico!
      //   //0,
      // ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][3],
        textNitrogenoUreicoResultController.text,
        unidadMedidaNitrogenoUreico!
        //0,
      ],
    ];
  }

  // VARIABLES DE LA INTERFAZ ****************** ********
  var textDateEstudyController = TextEditingController();
  // ********* *************** ************* *
  var textUreaResultController = TextEditingController();
  String? unidadMedidaUrea =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textGlucosaResultController = TextEditingController();
  String? unidadMedidaGlucosa =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textCreatininaResultController = TextEditingController();
  String? unidadMedidaCreatinina =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textAcidoUricoResultController = TextEditingController();
  String? unidadMedidaAcidoUrico =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textNitrogenoUreicoResultController = TextEditingController();
  String? unidadMedidaNitrogenoUreico =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];

  // OPERACIONES DE LA INTERFAZ ****************** ********
  void cerrar() {
    Navigator.of(context).pop();
  }

  operationMethod() async {
    //
    Future.forEach(listOfValues(), (element) {
      var aux = element as List<String>;

      if (aux[5] != '0' && aux[5] != '' && aux[5] != null) {
        Actividades.registrar(
          Databases.siteground_database_reggabo,
          Auxiliares.auxiliares['registerQuery'],
          element as List<String>,
        );
      }
    })
        .then(
      (value) => Operadores.alertActivity(
          context: context,
          tittle: "Registrando información . . .",
          message: "Información registrada",
          onAcept: () {
            // Se emplean 3 Navigator.of(context).pop(); para cerrar cada una de
            //    las ventanas emergentes y la interfaz inicial.
            Navigator.of(context).pop(); // Cierre del AlertActivity
            Navigator.of(context).pop(); // Cierre del LoadActivity
            Navigator.of(context).pop(); // Cierre de la Interfaz Inicial
          }),
    )
        .onError((error, stackTrace) {
      Terminal.printAlert(message: "ERROR - $error : : : $stackTrace");
      Operadores.alertActivity(
        context: context,
        tittle: "Registrando información . . .",
        message: "$error",
      );
    });
  }
}
