import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/gasometricos.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Arteriales extends StatefulWidget {
  const Arteriales({super.key});

  @override
  State<Arteriales> createState() => _ArterialesState();
}

class _ArterialesState extends State<Arteriales> {
  static var index = 9; // Arteriales

  @override
  void initState() {
    final f = DateFormat('yyyy-MM-dd HH:mm:ss');
    textDateEstudyController.text = f.format(DateTime.now());
    //
    textFIOResultController.text =
        Valores.fraccionInspiratoriaOxigeno!.toString();
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
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ValuePanel(
                    firstText: "Na+",
                    secondText: Valores.sodio!.toString(),
                    thirdText: "mmol/L",
                  ),
                  ValuePanel(
                    firstText: "K+",
                    secondText: Valores.potasio!.toString(),
                    thirdText: "mmol/L",
                  ),
                  ValuePanel(
                    firstText: "Cl-",
                    secondText: Valores.cloro!.toString(),
                    thirdText: "mg/dL",
                    withEditMessage: true,
                    onEdit: (String value) {
                      Operadores.editActivity(context: context,
                        onAcept: (value) {
                        setState(() {
                          Valores.cloro = double.parse(value);
                          Navigator.of(context).pop();
                        });
                        }
                      );

                    },
                  ),
                  CrossLine(),
                  ValuePanel(
                    firstText: "Mg-",
                    secondText: Valores.magnesio!.toString(),
                    thirdText: "mEq/L",
                  ),
                  ValuePanel(
                    firstText: "Ca2+",
                    secondText: Valores.calcio!.toString(),
                    thirdText: "mg/dL",
                  ),
                  ValuePanel(
                    firstText: "PO3-",
                    secondText: Valores.fosforo!.toString(),
                    thirdText: "mg/dL",
                  ),
                  CrossLine(),
                  ValuePanel(
                    firstText: "Alb-",
                    secondText: Valores.albuminaSerica!.toString(),
                    thirdText: "g/dL",
                  ),
                  CrossLine(),
                  ValuePanel(
                    firstText: "Hb",
                    secondText: Valores.hemoglobina!.toString(),
                    thirdText: "g/dL",
                  ),
                  ValuePanel(
                    firstText: "Hto",
                    secondText: Valores.hematocrito!.toString(),
                    thirdText: "%",
                  ),
                  CrossLine(),
                  ValuePanel(
                    firstText: "Fecha Biometrias",
                    secondText: Valores.fechaBiometria!.toString(),
                    thirdText: "",
                  ),
                  ValuePanel(
                    firstText: "Fecha Químicas",
                    secondText: Valores.fechaQuimicas!.toString(),
                    thirdText: "",
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(2.0), // padding: const EdgeInsets.all(7.0),
                controller: ScrollController(),
                child: Column(
                  children: [
                    EditTextArea(
                      textController: textSodioArterialResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'A_Na+ ($unidadMedidaANA)',
                      numOfLines: 1,
                      onChange: (value) => setState(
                              () => Valores.sodioArteriales = double.parse(value)),
                    ),
                    EditTextArea(
                      textController: textPotasioArterialResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'A_K+ ($unidadMedidaAK)',
                      numOfLines: 1,
                      onChange: (value) => setState(
                              () => Valores.potasioArteriales = double.parse(value)),
                    ),

                    EditTextArea(
                      textController: textCalcioIonicoArterialResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'iCa++ ($unidadMedidaCai)',
                      numOfLines: 1,
                      onChange: (value) => setState(
                              () => Valores.calcioIonicoArteriales = double.parse(value)),
                    ),

                    EditTextArea(
                      textController: textGluAResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'A_Glu ($unidadMedidaGluA)',
                      numOfLines: 1,
                      onChange: (value) => setState(() =>
                      Valores.glucosaArteriales = double.parse(value)),
                    ),
                    // Botton ***** ******* ****** * ***
                    CrossLine(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(2.0), // padding: const EdgeInsets.all(7.0),
                controller: ScrollController(),
                child: Column(
                  children: [
                    EditTextArea(
                      textController: textPHResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'PH',
                      numOfLines: 1,
                      onChange: (value) => setState(
                          () => Valores.pHArteriales = double.parse(value)),
                    ),
                    EditTextArea(
                      textController: textPCOResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'PCO ($unidadMedidaPCO)',
                      numOfLines: 1,
                      onChange: (value) => setState(
                          () => Valores.pcoArteriales = double.parse(value)),
                    ),

                    EditTextArea(
                      textController: textPOResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'PO ($unidadMedidaPO)',
                      numOfLines: 1,
                      onChange: (value) => setState(
                          () => Valores.poArteriales = double.parse(value)),
                    ),

                    EditTextArea(
                      textController: textHCOResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'HCO ($unidadMedidaHCO)',
                      numOfLines: 1,
                      onChange: (value) => setState(() =>
                          Valores.bicarbonatoArteriales = double.parse(value)),
                    ),
                    EditTextArea(
                      textController: textFIOResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'FIO ($unidadMedidaFIO)',
                      numOfLines: 1,
                      onChange: (value) => setState(
                          () => Valores.fioArteriales = double.parse(value)),
                    ),
                    EditTextArea(
                      textController: textSOResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'SO ($unidadMedidaSO)',
                      numOfLines: 1,
                      onChange: (value) => setState(
                          () => Valores.soArteriales = double.parse(value)),
                    ),
                    EditTextArea(
                      textController: textLactResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Lactato ($unidadMedidaLact)',
                      numOfLines: 1,
                      onChange: (value) => setState(
                          () => Valores.lactatoArterial = double.parse(value)),
                    ),

                    // Botton ***** ******* ****** * ***
                    CrossLine(
                      color: Colors.grey,
                    ),
                    CircleIcon(
                        tittle: "Agregar Datos . . . ",
                        iconed: Icons.move_up_rounded,
                        onChangeValue: () => operationMethod()),
                    // GrandButton(
                    //     labelButton: "Agregar Datos",
                    //     weigth: 2000,
                    //     onPress: () {
                    //       operationMethod();
                    //     })
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ValuePanel(
                    firstText: "PAO2",
                    secondText: Gasometricos.PAO.toStringAsFixed(0),
                    thirdText: "mmHg",
                  ),
                  ValuePanel(
                    firstText: "PIO2",
                    secondText: Gasometricos.PIO.toStringAsFixed(0),
                    thirdText: "mmHg",
                  ),
                  ValuePanel(
                    firstText: "AaO2",
                    secondText: Gasometricos.GAA.toStringAsFixed(0),
                    thirdText: "mmHg",
                  ),
                  CrossLine(),
                  CrossLine(),
                  ValuePanel(
                    firstText: "CaO2",
                    secondText: Gasometricos.CAO.toStringAsFixed(0),
                    thirdText: "mL/dL",
                  ),
                  ValuePanel(
                    firstText: "CcO2",
                    secondText: Gasometricos.CCO.toStringAsFixed(0),
                    thirdText: "mL/dL",
                  ),
                  CrossLine(),
                  ValuePanel(
                    firstText: "PCO2e",
                    secondText: Gasometricos.PCO2esperado.toStringAsFixed(2),
                    thirdText: "mmHg",
                  ),
                  ValuePanel(
                    firstText: "EBe",
                    secondText:
                    Gasometricos.excesoBaseEsperado.toStringAsFixed(2),
                    thirdText: "",
                  ),
                  CrossLine(),
                  ValuePanel(
                    firstText: "DIFa",
                    secondText: Gasometricos.diferenciaIonesFuertesAparente
                        .toStringAsFixed(0),
                    thirdText: "",
                  ),
                  ValuePanel(
                    firstText: "DIFe",
                    secondText: Gasometricos.diferenciaIonesFuertesEfectiva
                        .toStringAsFixed(2),
                    thirdText: "",
                  ),
                  ValuePanel(
                    firstText: "Atot",
                    secondText: Gasometricos.aTOT.toStringAsFixed(2),
                    thirdText: "",
                  ),
                  ValuePanel(
                    firstText: "GIF",
                    secondText: Gasometricos.GIF.toStringAsFixed(2),
                    thirdText: "",
                  ),
                  CrossLine(),

                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  ValuePanel(
                    firstText: "aGAP",
                    secondText: Gasometricos.GAP.toStringAsFixed(2),
                    thirdText: "",
                  ),
                  ValuePanel(
                    firstText: "GAPA",
                    secondText: Gasometricos.GAPA.toStringAsFixed(2),
                    thirdText: "",
                  ),
                  ValuePanel(
                    firstText: "aGAP/Alb",
                    secondText: Gasometricos.aGapAlb.toStringAsFixed(2),
                    thirdText: "",
                  ),
                  ValuePanel(
                    firstText: "Δ-aGAP/Alb",
                    secondText: Gasometricos.aGapAlbArterial.toStringAsFixed(2),
                    thirdText: "",
                  ), // aGap Ionico, ES arteriales
                  CrossLine(),
                  ValuePanel(
                    firstText: "dGAP",
                    secondText: Gasometricos.d_GAP.toStringAsFixed(2),
                    thirdText: "mmol/L",
                  ),
                  ValuePanel(
                    firstText: "dHCO3-",
                    secondText: Gasometricos.d_HCO.toStringAsFixed(2),
                    thirdText: "mmol/L",
                  ),
                  CrossLine(),
                  CrossLine(),
                  ValuePanel(
                    firstText: "ΔΔ",
                    secondText: Gasometricos.D_d_GAP.toStringAsFixed(2),
                    thirdText: "",
                  ),
                  ValuePanel(
                    firstText: "Δr",
                    secondText: Gasometricos.D_d_ratio.toStringAsFixed(2),
                    thirdText: "",
                  ),
                  CrossLine(),
                  ValuePanel(
                    firstText: "i Cl/Na",
                    secondText:
                        Gasometricos.indiceCloroSodiio.toStringAsFixed(2),
                    thirdText: "",
                  ),
                  ValuePanel(
                    firstText: "dif Na/Cl",
                    secondText:
                        Gasometricos.diferenciaSodioCloro.toStringAsFixed(2),
                    thirdText: "",
                  ),
                  CrossLine(),
                  ValuePanel(
                    firstText: "I. Lact",
                    secondText:
                    Gasometricos.influenciaLactato.toStringAsFixed(2),
                    thirdText: "",
                  ),
                  ValuePanel(
                    firstText: "I. IMedi",
                    secondText:
                    Gasometricos.influenciaIonesMedibles.toStringAsFixed(2),
                    thirdText: "",
                  ),
                  ValuePanel(
                    firstText: "I. Alb",
                    secondText:
                    Gasometricos.influenciaAlbumina.toStringAsFixed(2),
                    thirdText: "",
                  ),
                  ValuePanel(
                    firstText: "I. O-Iones",
                    secondText:
                    Gasometricos.influenciaOtrosIones.toStringAsFixed(2),
                    thirdText: "",
                  ),
                ],
              ),
            ),
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
        textPHResultController.text,
        unidadMedidaPH!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][1],
        textPCOResultController.text,
        unidadMedidaPCO!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][2],
        textPOResultController.text,
        unidadMedidaPO!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][3],
        textHCOResultController.text,
        unidadMedidaHCO!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][4],
        textFIOResultController.text,
        unidadMedidaFIO!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][5],
        textSOResultController.text,
        unidadMedidaSO!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[8],
        Auxiliares.Laboratorios[Auxiliares.Categorias[8]][1],
        textLactResultController.text,
        unidadMedidaLact!
        //0,
      ],
      // 
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][6],
        textSodioArterialResultController.text,
        unidadMedidaANA!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][7],
        textPotasioArterialResultController.text,
        unidadMedidaAK!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][9],
        textCalcioIonicoArterialResultController.text,
        unidadMedidaCai!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][11],
        textGluAResultController.text,
        unidadMedidaGluA!
        //0,
      ],
    ];
  }

  // VARIABLES DE LA INTERFAZ ****************** ********
  var textDateEstudyController = TextEditingController();
  // ********* *************** ************* *
  var textPHResultController = TextEditingController();
  String? unidadMedidaPH = Auxiliares.Medidas[Auxiliares.Categorias[index]][0];
  var textPCOResultController = TextEditingController();
  String? unidadMedidaPCO = Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textPOResultController = TextEditingController();
  String? unidadMedidaPO = Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textHCOResultController = TextEditingController();
  String? unidadMedidaHCO = Auxiliares.Medidas[Auxiliares.Categorias[index]][1];
  var textFIOResultController = TextEditingController();
  String? unidadMedidaFIO = Auxiliares.Medidas[Auxiliares.Categorias[index]][4];
  var textSOResultController = TextEditingController();
  String? unidadMedidaSO = Auxiliares.Medidas[Auxiliares.Categorias[index]][4];

  var textLactResultController = TextEditingController();
  String? unidadMedidaLact =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][5];

  var textSodioArterialResultController = TextEditingController();
  String? unidadMedidaANA =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][5];
  var textPotasioArterialResultController = TextEditingController();
  String? unidadMedidaAK =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][5];
  var textCalcioIonicoArterialResultController = TextEditingController();
  String? unidadMedidaCai =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][5];
  var textGluAResultController = TextEditingController();
  String? unidadMedidaGluA =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][6];
  

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
