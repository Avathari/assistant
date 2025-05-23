import 'dart:io';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/pleurometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class LiquidoPleural extends StatefulWidget {
  const LiquidoPleural({super.key});

  @override
  State<LiquidoPleural> createState() => _LiquidoPleuralState();
}

class _LiquidoPleuralState extends State<LiquidoPleural> {
  static var index = 27; // LiquidoPleural
  String? filePath;

  @override
  void initState() {
    final f = DateFormat('yyyy-MM-dd HH:mm:ss');
    textDateEstudyController.text = f.format(DateTime.now());
    // ************************************************
    textGlucosaResultController.text = "120";
    //
    textDHLResultController.text = "";
    textProteinasTotalesResultController.text = "";
    //
    textFosfatasaAlcalinaResultController.text = "68";
    textAspectoResultController.text = "Citrino";
    textColorResultController.text = "No se Observan";
    textLeucocitosResultController .text = "No se Observan";
    textPolimorfonuclearesResultController.text = "No se Observan";
    textOtrosResultController.text = " - ";
    textPhResultController.text = "7.5";

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
        CrossLine(height: 10),
        GrandButton(
          height: 15,
          weigth: 1000,
          labelButton: "Cargar archivo de Historial . . . ",
          onPress: () async {
            final path =
            await Directorios.choiseFromInternalDocuments(
                context);
            //
            setState(() {
              filePath = path!.files.single.path!;
            });
          },
        ),
        CrossLine(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Column(children: [
              ValuePanel(
                firstText: "Prot-",
                secondText: Valores.proteinasTotales!.toStringAsFixed(2),
                thirdText: "g/dL",
              ),
              ValuePanel(
                firstText: "DHL",
                secondText: Valores.deshidrogenasaLactica!.toStringAsFixed(2),
                thirdText: "UI/L",
              ),
              CrossLine(),
              ValuePanel(
                firstText: Valores.fechaHepaticos!.toString(),
                secondText: "",
                thirdText: Valores.fechaHepaticos!.toString(),

              ),
              CrossLine(height: 15),
              ValuePanel(
                firstText: "DHL-S/DHL-LP",
                secondText: Pleurometrias.relacionDHL.toStringAsFixed(2),
                thirdText: "",
              ),
              ValuePanel(
                firstText: "PT-S/PT-LP",
                secondText: Pleurometrias.relacionProteinas.toStringAsFixed(2),
                thirdText: "",
              ),
            ],)),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(4.0),
                controller: ScrollController(),
                child: Column(
                  children: [
                    EditTextArea(
                      textController: textGlucosaResultController,
                      keyBoardType: TextInputType.text,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Glucosa ($unidadMedidaGlucosa)',
                      numOfLines: 1,
                    ),
                    EditTextArea(
                      textController: textDHLResultController,
                      keyBoardType: TextInputType.text,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'DHL ($unidadMedidaDHL)',
                      numOfLines: 1,
                      onChange: (String value) {
                        setState(() {
                          if (textDHLResultController.text.isNotEmpty){
                            Pleurometrias.dhlPleural = double.parse(textDHLResultController.text);
                          }
                        });
                      },
                    ),
                    EditTextArea(
                      textController: textProteinasTotalesResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Proteinas Totales ($unidadMedidaProteinasTotales)',
                      numOfLines: 1,
                      onChange: (String value) {
                        setState(() {
                          if (textProteinasTotalesResultController.text.isNotEmpty){
                            Pleurometrias.proteinasPleural = double.parse(textProteinasTotalesResultController.text);
                          }
                        });
                      },
                    ),
                    EditTextArea(
                      textController: textAlbuminaResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Albumina ($unidadMedidaAlbumina)',
                      numOfLines: 1,
                      onChange: (String value) {
                        setState(() {
                          if (textAlbuminaResultController.text.isNotEmpty){
                            Pleurometrias.proteinasPleural = double.parse(textAlbuminaResultController.text);
                          }
                        });
                      },
                    ),
                    //
                    EditTextArea(
                      textController: textFosfatasaAlcalinaResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Fosfatasa Alcalina ($unidadMedidaFosfatasaAlcalina)',
                      numOfLines: 1,
                    ),
                    EditTextArea(
                      textController: textColesterolResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Colesterol ($unidadMedidaColesterol)',
                      numOfLines: 1,
                    ),
                    CrossLine(thickness: 3),
                    EditTextArea(
                      textController: textAspectoResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Aspecto ($unidadMedidaAspecto)',
                      numOfLines: 1,
                    ),
                    EditTextArea(
                      textController: textColorResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Color ($unidadMedidaColor)',
                      numOfLines: 1,
                    ),
                    EditTextArea(
                      textController: textLeucocitosResultController,
                      keyBoardType: TextInputType.text,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Leucocitos ($unidadMedidaLeucocitos)',
                      numOfLines: 1,
                    ),
                    EditTextArea(
                      textController: textPolimorfonuclearesResultController,
                      keyBoardType: TextInputType.text,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Polimorfonucleares ($unidadMedidaPolimorfonucleares)',
                      numOfLines: 1,
                    ),
                    EditTextArea(
                      textController: textEritrocitosResultController,
                      keyBoardType: TextInputType.text,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Eritrocitos ($unidadMedidaEritrocitos)',
                      numOfLines: 1,
                    ),
                    EditTextArea(
                      textController: textMononuclearesResultController,
                      keyBoardType: TextInputType.text,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Mononucleares ($unidadMedidaMononucleares)',
                      numOfLines: 1,
                    ),
                    EditTextArea(
                      textController: textEritrocitosResultController,
                      keyBoardType: TextInputType.text,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Eritrocitos ($unidadMedidaEritrocitos)',
                      numOfLines: 1,
                    ),

                    EditTextArea(
                      textController: textBacteriasResultController,
                      keyBoardType: TextInputType.text,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Bacterias ($unidadMedidaBacterias)',
                      numOfLines: 1,
                    ),
                    EditTextArea(
                      textController: textLevadurasResultController,
                      keyBoardType: TextInputType.text,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Levaduras ($unidadMedidaLevaduras)',
                      numOfLines: 1,
                    ),
                    //
                    EditTextArea(
                      textController: textOtrosResultController,
                      keyBoardType: TextInputType.text,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Otros ($unidadMedidaOtros)',
                      numOfLines: 1,
                    ),
                    EditTextArea(
                      textController: textPhResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Ph ($unidadMedidaPh)',
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
            ),
            filePath != null
                ? Expanded(
                flex: 3, child: Container(
                decoration: ContainerDecoration.roundedDecoration(),
                height: 550,
                child: SfPdfViewer.file(File(filePath!))))
                : Expanded(flex: 2, child: Container()),
          ],
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
        textDHLResultController.text,
        unidadMedidaDHL!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][2],
        textProteinasTotalesResultController.text,
        unidadMedidaProteinasTotales!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][3],
        textAlbuminaResultController.text,
        unidadMedidaAlbumina!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][4],
        textFosfatasaAlcalinaResultController.text,
        unidadMedidaFosfatasaAlcalina!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][5],
        textColesterolResultController.text,
        unidadMedidaColesterol!
        //0,
      ],
      // Citológico
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][6],
        textAspectoResultController.text,
        unidadMedidaAspecto!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][7],
        textColorResultController.text,
        unidadMedidaColor!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][8],
        textLeucocitosResultController.text,
        unidadMedidaLeucocitos!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][9],
        textPolimorfonuclearesResultController.text,
        unidadMedidaPolimorfonucleares!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][10],
        textMononuclearesResultController.text,
        unidadMedidaMononucleares!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][11],
        textEritrocitosResultController.text,
        unidadMedidaEritrocitos!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][12],
        textBacteriasResultController.text,
        unidadMedidaBacterias!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][13],
        textLevadurasResultController.text,
        unidadMedidaLevaduras!
        //0,
      ],
      //
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][14],
        textOtrosResultController.text,
        unidadMedidaOtros!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][15],
        textPhResultController.text,
        unidadMedidaPh!
        //0,
      ],
    ];
  }

  // VARIABLES DE LA INTERFAZ ****************** ********
  var textDateEstudyController = TextEditingController();
  // ********* *************** ************* *
  var textGlucosaResultController = TextEditingController();
  String? unidadMedidaGlucosa =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textDHLResultController = TextEditingController();
  String? unidadMedidaDHL =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textProteinasTotalesResultController = TextEditingController();
  String? unidadMedidaProteinasTotales =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][4];
  var textAlbuminaResultController = TextEditingController();
  String? unidadMedidaAlbumina =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][4];
  var textFosfatasaAlcalinaResultController = TextEditingController();
  String? unidadMedidaFosfatasaAlcalina =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][2];
  var textColesterolResultController = TextEditingController();
  String? unidadMedidaColesterol =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  // 
  var textAspectoResultController = TextEditingController();
  String? unidadMedidaAspecto =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textColorResultController = TextEditingController();
  String? unidadMedidaColor = Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textLeucocitosResultController = TextEditingController();
  String? unidadMedidaLeucocitos = Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textPolimorfonuclearesResultController = TextEditingController();
  String? unidadMedidaPolimorfonucleares =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textMononuclearesResultController = TextEditingController();
  String? unidadMedidaMononucleares =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textEritrocitosResultController = TextEditingController();
  String? unidadMedidaEritrocitos =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textBacteriasResultController = TextEditingController();
  String? unidadMedidaBacterias =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textLevadurasResultController = TextEditingController();
  String? unidadMedidaLevaduras =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  //
  var textOtrosResultController = TextEditingController();
  String? unidadMedidaOtros =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textPhResultController = TextEditingController();
  String? unidadMedidaPh =
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


// selection: true,
// withShowOption: true,
// onSelected: () {
// Operadores.selectOptionsActivity(
// context: context,
// options:
// Auxiliares.aspectoLiquidos,
// onClose: (value) {
// setState(() {
// textGlucosaResultController.text = value;
// Navigator.of(context).pop();
// });
// });
// },

