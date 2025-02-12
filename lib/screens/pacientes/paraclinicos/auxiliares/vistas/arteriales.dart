import 'dart:io';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/gasometricos.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/GridLayout.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Arteriales extends StatefulWidget {
  const Arteriales({super.key});

  @override
  State<Arteriales> createState() => _ArterialesState();
}

class _ArterialesState extends State<Arteriales> {
  static var index = 9; // Arteriales

  String? filePath;

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
            // Expanded(
            //   flex: 2,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       ValuePanel(
            //         firstText: "Na+",
            //         secondText: Valores.sodio!.toString(),
            //         thirdText: "mmol/L",
            //       ),
            //       ValuePanel(
            //         firstText: "K+",
            //         secondText: Valores.potasio!.toString(),
            //         thirdText: "mmol/L",
            //       ),
            //       ValuePanel(
            //         firstText: "Cl-",
            //         secondText: Valores.cloro!.toString(),
            //         thirdText: "mg/dL",
            //         withEditMessage: true,
            //         onEdit: (String value) {
            //           Operadores.editActivity(
            //               context: context,
            //               onAcept: (value) {
            //                 setState(() {
            //                   Valores.cloro = double.parse(value);
            //                   Navigator.of(context).pop();
            //                 });
            //               });
            //         },
            //       ),
            //       CrossLine(),
            //       ValuePanel(
            //         firstText: "Mg-",
            //         secondText: Valores.magnesio!.toString(),
            //         thirdText: "mEq/L",
            //       ),
            //       ValuePanel(
            //         firstText: "Ca2+",
            //         secondText: Valores.calcio!.toString(),
            //         thirdText: "mg/dL",
            //       ),
            //       ValuePanel(
            //         firstText: "PO3-",
            //         secondText: Valores.fosforo!.toString(),
            //         thirdText: "mg/dL",
            //       ),
            //       CrossLine(),
            //       ValuePanel(
            //         firstText: "Alb-",
            //         secondText: Valores.albuminaSerica!.toString(),
            //         thirdText: "g/dL",
            //       ),
            //       CrossLine(),
            //       ValuePanel(
            //         firstText: "Hb",
            //         secondText: Valores.hemoglobina!.toString(),
            //         thirdText: "g/dL",
            //       ),
            //       ValuePanel(
            //         firstText: "Hto",
            //         secondText: Valores.hematocrito!.toString(),
            //         thirdText: "%",
            //       ),
            //       CrossLine(),
            //       ValuePanel(
            //         firstText: "Fecha Biometrias",
            //         secondText: Valores.fechaBiometria!.toString(),
            //         thirdText: "",
            //       ),
            //       ValuePanel(
            //         firstText: "Fecha Químicas",
            //         secondText: Valores.fechaQuimicas!.toString(),
            //         thirdText: "",
            //       ),
            //       CrossLine(),
            //       ValuePanel(
            //         firstText: "pBARR",
            //         secondText: Valores.presionBarometrica!.toString(),
            //         thirdText: "mmGh",
            //         onEdit: (onVal) {
            //           Operadores.editActivity(context: context, tittle: "¡Presión barométrica?", onAcept: (onValue) {
            //             setState(() {
            //               Navigator.of(context).pop();
            //               Valores.presionBarometrica = int.parse(onValue);
            //             });
            //           });
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(
                    1.0), // padding: const EdgeInsets.all(7.0),
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
                      onChange: (value) => setState(() =>
                          Valores.potasioArteriales = double.parse(value)),
                    ),

                    EditTextArea(
                      textController: textCloroArterialResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'A_Cl- ($unidadMedidaACl)',
                      numOfLines: 1,
                      onChange: (value) => setState(() =>
                      Valores.cloroArteriales = double.parse(value)),
                    ),

                    EditTextArea(
                      textController: textCalcioIonicoArterialResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'iCa++ ($unidadMedidaCai)',
                      numOfLines: 1,
                      onChange: (value) => setState(() =>
                          Valores.calcioIonicoArteriales = double.parse(value)),
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
                      color: Colors.grey
                    ),
                    EditTextArea(
                      textController: textHematocritoArterialResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'HtcA ($unidadMedidaHematocritoArterial)',
                      numOfLines: 1,
                      onChange: (value) => setState(() =>
                      Valores.hematocritoArteriales = double.parse(value)),
                    ),
                    EditTextArea(
                      textController: textHemoglobinaArterialResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'HbArt ($unidadMedidaHemoglobinaArterial)',
                      numOfLines: 1,
                      onChange: (value) => setState(() =>
                      Valores.hemoglobinaArteriales = double.parse(value)),
                    ),
                    // Botton ***** ******* ****** * ***
                    CrossLine(
                        color: Colors.grey
                    ),
                    EditTextArea(
                      textController: textOxiHemoglobinaArterialResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'OxiHb ($unidadMedidaOxiHemoglobinaArterial)',
                      numOfLines: 1,
                      onChange: (value) => setState(() =>
                      Valores.oxiHemoglobinaArteriales = double.parse(value)),
                    ),
                    EditTextArea(
                      textController: textCarboxiHemoArterialResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'COHb ($unidadMedidaCarboxiHemoArterial)',
                      numOfLines: 1,
                      onChange: (value) => setState(() =>
                      Valores.carboxiHemoglobinaArteriales = double.parse(value)),
                    ),
                    EditTextArea(
                      textController: textMetaHemoArterialResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'Met_Hb ($unidadMedidaMetaHemoArterial)',
                      numOfLines: 1,
                      onChange: (value) => setState(() =>
                      Valores.metaHemoglobinaArteriales = double.parse(value)),
                    ),
                    EditTextArea(
                      textController: textHemoReducidaArterialResultController,
                      keyBoardType: TextInputType.number,
                      inputFormat: MaskTextInputFormatter(),
                      labelEditText: 'HHb ($unidadMedidaHemoReducidaArterial)',
                      numOfLines: 1,
                      onChange: (value) => setState(() =>
                      Valores.hemoglobinaReducidaArteriales = double.parse(value)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(
                    1.0), // padding: const EdgeInsets.all(7.0),
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
            filePath != null
                ? Expanded(
                flex: 5, child: Container(
              decoration: ContainerDecoration.roundedDecoration(),
              height: 550,
                child: SfPdfViewer.file(File(filePath!))))
                : Expanded(flex: 2, child: Container()),
          ],
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
        Row(children: [
          Expanded(
            child: ValuePanel(
              firstText: "Fecha Biometrias",
              secondText: Valores.fechaBiometria!.toString(),
              thirdText: "",
            ),
          ),
          Expanded(
            child: ValuePanel(
              firstText: "Fecha Químicas",
              secondText: Valores.fechaQuimicas!.toString(),
              thirdText: "",
            ),
          ),
        ],),
        GridLayout(
          columnCount: !isMobile(context) ? 15: 5,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
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
                Operadores.editActivity(
                    context: context,
                    onAcept: (value) {
                      setState(() {
                        Valores.cloro = double.parse(value);
                        Navigator.of(context).pop();
                      });
                    });
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
            CrossLine(),
            ValuePanel(
              firstText: "pBARR",
              secondText: Valores.presionBarometrica!.toString(),
              thirdText: "mmGh",
              onEdit: (onVal) {
                Operadores.editActivity(context: context, tittle: "¡Presión barométrica?", onAcept: (onValue) {
                  setState(() {
                    Navigator.of(context).pop();
                    Valores.presionBarometrica = int.parse(onValue);
                  });
                });
              },
            ),
          ],),
        CrossLine(height: 10),
        GridLayout(
          columnCount: !isMobile(context) ? 14: 5,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
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
          ValuePanel(
            firstText: "PAFI",
            secondText: Gasometricos.PAFI.toStringAsFixed(0),
            thirdText: "mmHg/%",
          ),
          ValuePanel(
            firstText: "SAFI",
            secondText: Gasometricos.SAFI.toStringAsFixed(0),
            thirdText: "%",
          ),
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
        ],)
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
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][8],
        textCloroArterialResultController.text,
        unidadMedidaACl!
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
      //
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][18],
        textHematocritoArterialResultController.text,
        unidadMedidaHematocritoArterial!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][13],
        textHemoglobinaArterialResultController.text,
        unidadMedidaHemoglobinaArterial!
        //0,
      ],
      //
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][14],
        textOxiHemoglobinaArterialResultController.text,
        unidadMedidaOxiHemoglobinaArterial!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][15],
        textCarboxiHemoArterialResultController.text,
        unidadMedidaCarboxiHemoArterial!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][16],
        textMetaHemoArterialResultController.text,
        unidadMedidaMetaHemoArterial!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[index],
        Auxiliares.Laboratorios[Auxiliares.Categorias[index]][17],
        textHemoReducidaArterialResultController.text,
        unidadMedidaHemoReducidaArterial!
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
  String? unidadMedidaANA = Auxiliares.Medidas[Auxiliares.Categorias[index]][5];
  var textPotasioArterialResultController = TextEditingController();
  String? unidadMedidaAK = Auxiliares.Medidas[Auxiliares.Categorias[index]][5];
  var textCloroArterialResultController = TextEditingController();
  String? unidadMedidaACl = Auxiliares.Medidas[Auxiliares.Categorias[index]][3];
  //
  var textCalcioIonicoArterialResultController = TextEditingController();
  String? unidadMedidaCai = Auxiliares.Medidas[Auxiliares.Categorias[index]][5];
  var textGluAResultController = TextEditingController();
  String? unidadMedidaGluA =
      Auxiliares.Medidas[Auxiliares.Categorias[index]][6];
//
  var textHematocritoArterialResultController = TextEditingController();
  String? unidadMedidaHematocritoArterial =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][4];
  var textHemoglobinaArterialResultController = TextEditingController();
  String? unidadMedidaHemoglobinaArterial =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][7];
  //
  var textOxiHemoglobinaArterialResultController = TextEditingController();
  String? unidadMedidaOxiHemoglobinaArterial =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][4];
  var textCarboxiHemoArterialResultController = TextEditingController();
  String? unidadMedidaCarboxiHemoArterial =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][4];
  var textMetaHemoArterialResultController = TextEditingController();
  String? unidadMedidaMetaHemoArterial =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][4];
  var textHemoReducidaArterialResultController = TextEditingController();
  String? unidadMedidaHemoReducidaArterial =
  Auxiliares.Medidas[Auxiliares.Categorias[index]][4];

  // OPERACIONES DE LA INTERFAZ ****************** ********
  void cerrar() {
    Navigator.of(context).pop();
  }

  operationMethod() async {
    //
    Operadores.loadingActivity(
        context: context,
        tittle: "Registrando información . . .",
        message: "Información registrada",
        onCloss: () => null
        // Navigator.of(context).pop();
        // cerrar();
        );
    //

    List<List<String>> listAux = [];

    Future.forEach(listOfValues(), (element) async {
      var aux = element as List<String>;
      if (aux[5] != '0' && aux[5] != '') listAux.add(element);
      // Representa el valor del Estudio realizado, comprueba si esta vacío o es nulo
    }).whenComplete(() {
      // Terminal.printAlert(message: listAux.toString()); //
      Actividades.registrarAnidados(
        Databases.siteground_database_reggabo,
        Auxiliares.auxiliares['registerQuery'],
        listAux,
      )
          .then((onValue) => Operadores.notifyActivity(
              context: context,
              tittle: "Respuesta de Consulta a Base de Datos . . . ",
              message: onValue.toString()))
          .whenComplete(() {
        Navigator.of(context).pop(); // Cierre del LoadActivity
        Operadores.alertActivity(
            context: context,
            tittle: "Registrando información . . .",
            message: "Información registrada",
            onAcept: () {
              // Se emplean 3 Navigator.of(context).pop(); para cerrar cada una de
              //    las ventanas emergentes y la interfaz inicial.

              if (filePath !=null) File(filePath!).delete();
              //
              Navigator.of(context).pop(); // Cierre de la Interfaz Inicial
              Navigator.of(context).pop(); // Cierre del AlertActivity
            });
      }).onError((onError, stackTrace) => Operadores.alertActivity(
                context: context,
                tittle: "Error al Consultar Base de Datos . . . ",
                message: "$onError : $stackTrace",
                onAcept: () {
                  Navigator.of(context).pop();
                },
                onClose: () => Navigator.of(context).pop(),
              ));
    });
  }
}
