import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/citometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Rutinas extends StatefulWidget {
  const Rutinas({Key? key}) : super(key: key);

  @override
  State<Rutinas> createState() => _RutinasState();
}

class _RutinasState extends State<Rutinas> {

  var carouselController = CarouselController();

  @override
  void initState() {
    final f = DateFormat('yyyy-MM-dd');
    textDateEstudyController.text = f.format(DateTime.now());
    // *************************************
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: !isMobile(context) ? 5 : 1,
              child: EditTextArea(
                labelEditText: "Fecha de realización",
                numOfLines: 1,
                textController: textDateEstudyController,
                keyBoardType: TextInputType.datetime,
                selection: true,
                iconData: Icons.calculate_outlined,
                withDeleteOption: !isMobile(context),
                onSelected: () {
                  setState(() {
                    textDateEstudyController.text =
                        Calendarios.today(format: "yyyy/MM/dd");
                  });
                },
                onChange: (value) {
                  textDateEstudyController.text = value;
                },
                inputFormat: MaskTextInputFormatter(
                    mask: '####/##/##',
                    filter: {"#": RegExp(r'[0-9]')},
                    type: MaskAutoCompletionType.lazy),
              ),
            ),
            if (!isMobile(context)) Expanded(
              child: GrandButton(
                labelButton: 'Agregar Información',
                onPress: () {
                  operationMethod();
                },
              ),
            )
          ],
        ),
        CrossLine(height: 20, thickness: 4,),
        isMobile(context)
            ? mobileView()
            : desktopView()
            // : SingleChildScrollView(
            //     padding: const EdgeInsets.all(7.0),
            //     controller: ScrollController(),
            //     child: Column(
            //       children: [
            //         Row(
            //           children: [
            //             Expanded(
            //               child: EditTextArea(
            //                 textController: textHemoglobinaResultController,
            //                 keyBoardType: TextInputType.number,
            //                 inputFormat: MaskTextInputFormatter(),
            //                 labelEditText:
            //                     'Hemoglobina ($unidadMedidaHemoglobina)',
            //                 numOfLines: 1,
            //               ),
            //             ),
            //             Expanded(
            //               child: EditTextArea(
            //                 textController: textEritrocitosResultController,
            //                 keyBoardType: TextInputType.number,
            //                 inputFormat: MaskTextInputFormatter(),
            //                 labelEditText:
            //                     'Eritrocitos ($unidadMedidaEritrocitos)',
            //                 numOfLines: 1,
            //               ),
            //             ),
            //             Expanded(
            //               child: EditTextArea(
            //                 textController: textHematocritoResultController,
            //                 keyBoardType: TextInputType.number,
            //                 inputFormat: MaskTextInputFormatter(),
            //                 labelEditText:
            //                     'Hematocrito ($unidadMedidaHematocrito)',
            //                 numOfLines: 1,
            //               ),
            //             ),
            //           ],
            //         ),
            //         Row(
            //           children: [
            //             Expanded(
            //               child: EditTextArea(
            //                 textController: textCMHCResultController,
            //                 keyBoardType: TextInputType.number,
            //                 inputFormat: MaskTextInputFormatter(),
            //                 labelEditText: 'CMHC ($unidadMedidaCMHC)',
            //                 numOfLines: 1,
            //               ),
            //             ),
            //             Expanded(
            //               child: EditTextArea(
            //                 textController: textVCMResultController,
            //                 keyBoardType: TextInputType.number,
            //                 inputFormat: MaskTextInputFormatter(),
            //                 labelEditText: 'VCM ($unidadMedidaVCM)',
            //                 numOfLines: 1,
            //               ),
            //             ),
            //             Expanded(
            //               child: EditTextArea(
            //                 textController: textHCMResultController,
            //                 keyBoardType: TextInputType.number,
            //                 inputFormat: MaskTextInputFormatter(),
            //                 labelEditText: 'HCM ($unidadMedidaHCM)',
            //                 numOfLines: 1,
            //               ),
            //             ),
            //           ],
            //         ),
            //         EditTextArea(
            //           textController: textPlaquetasResultController,
            //           keyBoardType: TextInputType.number,
            //           inputFormat: MaskTextInputFormatter(),
            //           labelEditText: 'Plaquetas ($unidadMedidaPlaquetas)',
            //           numOfLines: 1,
            //         ),
            //         EditTextArea(
            //           textController: textLeucocitosResultController,
            //           keyBoardType: TextInputType.number,
            //           inputFormat: MaskTextInputFormatter(),
            //           labelEditText: 'Leucocitos ($unidadMedidaLeucocitos)',
            //           numOfLines: 1,
            //         ),
            //         Row(
            //           children: [
            //             Expanded(
            //               child: EditTextArea(
            //                 textController: textNeutrofilosResultController,
            //                 keyBoardType: TextInputType.number,
            //                 inputFormat: MaskTextInputFormatter(),
            //                 labelEditText:
            //                     'Neutrofilos ($unidadMedidaNeutrofilos)',
            //                 numOfLines: 1,
            //               ),
            //             ),
            //             Expanded(
            //               child: EditTextArea(
            //                 textController: textLinfocitosResultController,
            //                 keyBoardType: TextInputType.number,
            //                 inputFormat: MaskTextInputFormatter(),
            //                 labelEditText:
            //                     'Linfocitos ($unidadMedidaLinfocitos)',
            //                 numOfLines: 1,
            //               ),
            //             ),
            //             Expanded(
            //               child: EditTextArea(
            //                 textController: textMonocitosResultController,
            //                 keyBoardType: TextInputType.number,
            //                 inputFormat: MaskTextInputFormatter(),
            //                 labelEditText: 'Monocitos ($unidadMedidaMonocitos)',
            //                 numOfLines: 1,
            //               ),
            //             ),
            //           ],
            //         ),
            //         // Quimica Sanguinea ***** ******* ****** * ***
            //         CrossLine(
            //           color: Colors.grey,
            //         ),
            //         Row(
            //           children: [
            //             Expanded(
            //               child: EditTextArea(
            //                 textController: textGlucosaResultController,
            //                 keyBoardType: TextInputType.number,
            //                 inputFormat: MaskTextInputFormatter(),
            //                 labelEditText: 'Glucosa ($unidadMedidaGlucosa)',
            //                 numOfLines: 1,
            //               ),
            //             ),
            //             Expanded(
            //               child: EditTextArea(
            //                 textController: textUreaResultController,
            //                 keyBoardType: TextInputType.number,
            //                 inputFormat: MaskTextInputFormatter(),
            //                 labelEditText: 'Urea ($unidadMedidaUrea)',
            //                 numOfLines: 1,
            //               ),
            //             ),
            //             Expanded(
            //               child: EditTextArea(
            //                 textController: textCreatininaResultController,
            //                 keyBoardType: TextInputType.number,
            //                 inputFormat: MaskTextInputFormatter(),
            //                 labelEditText:
            //                     'Creatinina ($unidadMedidaCreatinina)',
            //                 numOfLines: 1,
            //               ),
            //             ),
            //           ],
            //         ),
            //         Row(
            //           children: [
            //             Expanded(
            //               child: EditTextArea(
            //                 textController: textAcidoUricoResultController,
            //                 keyBoardType: TextInputType.number,
            //                 inputFormat: MaskTextInputFormatter(),
            //                 labelEditText:
            //                     'Acido Urico ($unidadMedidaAcidoUrico)',
            //                 numOfLines: 1,
            //               ),
            //             ),
            //             Expanded(
            //               child: EditTextArea(
            //                 textController: textNitrogenoUreicoResultController,
            //                 keyBoardType: TextInputType.number,
            //                 inputFormat: MaskTextInputFormatter(),
            //                 labelEditText:
            //                     'Nitrógeno Ureico ($unidadMedidaNitrogenoUreico)',
            //                 numOfLines: 1,
            //               ),
            //             ),
            //           ],
            //         ),
            //         // Electrolitos Séricos ***** ******* ****** * ***
            //         CrossLine(),
            //         Row(
            //           children: [
            //             Expanded(
            //               child: EditTextArea(
            //                 textController: textPotasioResultController,
            //                 keyBoardType: TextInputType.number,
            //                 inputFormat: MaskTextInputFormatter(),
            //                 labelEditText: 'Potasio ($unidadMedidaPotasio)',
            //                 numOfLines: 1,
            //               ),
            //             ),
            //             Expanded(
            //               child: EditTextArea(
            //                 textController: textSodioResultController,
            //                 keyBoardType: TextInputType.number,
            //                 inputFormat: MaskTextInputFormatter(),
            //                 labelEditText: 'Sodio ($unidadMedidaSodio)',
            //                 numOfLines: 1,
            //               ),
            //             ),
            //             Expanded(
            //               child: EditTextArea(
            //                 textController: textCloroResultController,
            //                 keyBoardType: TextInputType.number,
            //                 inputFormat: MaskTextInputFormatter(),
            //                 labelEditText: 'Cloro ($unidadMedidaCloro)',
            //                 numOfLines: 1,
            //               ),
            //             ),
            //           ],
            //         ),
            //
            //         Row(
            //           children: [
            //             Expanded(
            //               child: EditTextArea(
            //                 textController: textFosforoResultController,
            //                 keyBoardType: TextInputType.number,
            //                 inputFormat: MaskTextInputFormatter(),
            //                 labelEditText: 'Fosforo ($unidadMedidaFosforo)',
            //                 numOfLines: 1,
            //               ),
            //             ),
            //             Expanded(
            //               child: EditTextArea(
            //                 textController: textCalcioResultController,
            //                 keyBoardType: TextInputType.number,
            //                 inputFormat: MaskTextInputFormatter(),
            //                 labelEditText: 'Calcio ($unidadMedidaCalcio)',
            //                 numOfLines: 1,
            //               ),
            //             ),
            //             Expanded(
            //               child: EditTextArea(
            //                 textController: textMagnesioResultController,
            //                 keyBoardType: TextInputType.number,
            //                 inputFormat: MaskTextInputFormatter(),
            //                 labelEditText: 'Magnesio ($unidadMedidaMagnesio)',
            //                 numOfLines: 1,
            //               ),
            //             ),
            //           ],
            //         ),
            //         // Botton ***** ******* ****** * ***
            //         CrossLine(
            //           color: Colors.grey,
            //         ),
            //         Container(
            //           margin: const EdgeInsets.all(5.0),
            //           decoration: ContainerDecoration.roundedDecoration(),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Expanded(
            //                 child: GrandButton(
            //                     labelButton: "Agregar Datos",
            //                     weigth: 2000,
            //                     onPress: () {
            //                       operationMethod();
            //                     }),
            //               )
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
      ],
    );
  }

  List<List<String>> listOfValues() {
    return [
      // BIOMETRIAS
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[0],
        Auxiliares.Laboratorios[Auxiliares.Categorias[0]][1],
        textHemoglobinaResultController.text,
        unidadMedidaHemoglobina!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[0],
        Auxiliares.Laboratorios[Auxiliares.Categorias[0]][0],
        textEritrocitosResultController.text,
        unidadMedidaEritrocitos!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[0],
        Auxiliares.Laboratorios[Auxiliares.Categorias[0]][7],
        textADEResultController.text,
        unidadMedidaADE!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[0],
        Auxiliares.Laboratorios[Auxiliares.Categorias[0]][2],
        textHematocritoResultController.text,
        unidadMedidaHematocrito!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[0],
        Auxiliares.Laboratorios[Auxiliares.Categorias[0]][3],
        textCMHCResultController.text,
        unidadMedidaCMHC!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[0],
        Auxiliares.Laboratorios[Auxiliares.Categorias[0]][4],
        textVCMResultController.text,
        unidadMedidaVCM!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[0],
        Auxiliares.Laboratorios[Auxiliares.Categorias[0]][5],
        textHCMResultController.text,
        unidadMedidaHCM!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[0],
        Auxiliares.Laboratorios[Auxiliares.Categorias[0]][8],
        textPlaquetasResultController.text,
        unidadMedidaPlaquetas!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[0],
        Auxiliares.Laboratorios[Auxiliares.Categorias[0]][9],
        textLeucocitosResultController.text,
        unidadMedidaLeucocitos!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[0],
        Auxiliares.Laboratorios[Auxiliares.Categorias[0]][10],
        textNeutrofilosResultController.text,
        unidadMedidaNeutrofilos!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[0],
        Auxiliares.Laboratorios[Auxiliares.Categorias[0]][11],
        textLinfocitosResultController.text,
        unidadMedidaLinfocitos!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[0],
        Auxiliares.Laboratorios[Auxiliares.Categorias[0]][12],
        textMonocitosResultController.text,
        unidadMedidaMonocitos!
        //0,
      ],
      // QUIMICA SANGUINEA
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[1],
        Auxiliares.Laboratorios[Auxiliares.Categorias[1]][0],
        textGlucosaResultController.text,
        unidadMedidaGlucosa!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[1],
        Auxiliares.Laboratorios[Auxiliares.Categorias[1]][1],
        textUreaResultController.text,
        unidadMedidaUrea!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[1],
        Auxiliares.Laboratorios[Auxiliares.Categorias[1]][2],
        textCreatininaResultController.text,
        unidadMedidaCreatinina!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[1],
      Auxiliares.Laboratorios[Auxiliares.Categorias[1]][4],
        textAcidoUricoResultController.text,
        unidadMedidaAcidoUrico!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[1],
        Auxiliares.Laboratorios[Auxiliares.Categorias[1]][3],
        textNitrogenoUreicoResultController.text,
        unidadMedidaNitrogenoUreico!
        //0,
      ],
      // ELECTROLITOS SÉRICOS
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[2],
        "Potasio",
        textPotasioResultController.text,
        unidadMedidaPotasio!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[2],
        "Sodio",
        textSodioResultController.text,
        unidadMedidaSodio!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[2],
        "Cloro",
        textCloroResultController.text,
        unidadMedidaCloro!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[2],
        "Fósforo",
        textFosforoResultController.text,
        unidadMedidaFosforo!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[2],
        "Calcio",
        textCalcioResultController.text,
        unidadMedidaCalcio!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[2],
        "Magnesio",
        textMagnesioResultController.text,
        unidadMedidaMagnesio!
        //0,
      ],
      // LIPIDICOS
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[6],
        "Colesterol Total",
        textColesterolResultController.text,
        unidadMedidaColesterol!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[6],
        "Triglicéridos",
        textTrigliceridosResultController.text,
        unidadMedidaTrigliceridos!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[6],
        "c-HDL",
        textHDLResultController.text,
        unidadMedidaHDL!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[6],
        "c-LDL",
        textLDLResultController.text,
        unidadMedidaLDL!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[6],
        "c-VLDL",
        textVLDLResultController.text,
        unidadMedidaVLDL!
        //0,
      ],
      // HEPATICOS
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[3],
        Auxiliares.Laboratorios[Auxiliares.Categorias[3]][2],
        textBTResultController.text,
        unidadMedidaBT!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[3],
        Auxiliares.Laboratorios[Auxiliares.Categorias[3]][3],
        textBDResultController.text,
        unidadMedidaBD!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[3],
        Auxiliares.Laboratorios[Auxiliares.Categorias[3]][4],
        textBIResultController.text,
        unidadMedidaBI!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[3],
        Auxiliares.Laboratorios[Auxiliares.Categorias[3]][0],
        textAlaninoResultController.text,
        unidadMedidaAlanino!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[3],
        Auxiliares.Laboratorios[Auxiliares.Categorias[3]][1],
        textAspartatoResultController.text,
        unidadMedidaAspartato!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[3],
        Auxiliares.Laboratorios[Auxiliares.Categorias[3]][5],
        textDHLResultController.text,
        unidadMedidaDHL!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[3],
        Auxiliares.Laboratorios[Auxiliares.Categorias[3]][6],
        textGlutarilResultController.text,
        unidadMedidaGlutaril!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[3],
        Auxiliares.Laboratorios[Auxiliares.Categorias[3]][7],
        textFosfatasaResultController.text,
        unidadMedidaFosfatasa!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[3],
        Auxiliares.Laboratorios[Auxiliares.Categorias[3]][8],
        textAlbuminaResultController.text,
        unidadMedidaAlbumina!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[3],
        Auxiliares.Laboratorios[Auxiliares.Categorias[3]][9],
        textProteinasResultController.text,
        unidadMedidaProteinas!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[3],
        Auxiliares.Laboratorios[Auxiliares.Categorias[3]][10],
        textGlobulinasResultController.text,
        unidadMedidaGlobulinas!
        //0,
      ],
      // COAGULACIONES
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[7],
        Auxiliares.Laboratorios[Auxiliares.Categorias[7]][0],
        textProtrombinaResultController.text,
        unidadMedidaProtrombina!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[7],
        Auxiliares.Laboratorios[Auxiliares.Categorias[7]][1],
        textTromboplastinaResultController.text,
        unidadMedidaTromboplastina!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[7],
        Auxiliares.Laboratorios[Auxiliares.Categorias[7]][2],
        textInrResultController.text,
        unidadMedidaInr!
        //0,
      ],
      // PANCREATICOS
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[5],
        Auxiliares.Laboratorios[Auxiliares.Categorias[5]][0],
        textAmilasaResultController.text,
        unidadMedidaAmilasa!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[5],
        Auxiliares.Laboratorios[Auxiliares.Categorias[5]][0],
        textLipasaResultController.text,
        unidadMedidaLipasa!
        //0,
      ],
      // REACTANTES
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[8],
        Auxiliares.Laboratorios[Auxiliares.Categorias[8]][3],
        textPCRResultController.text,
        unidadMedidaPCR!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[8],
        Auxiliares.Laboratorios[Auxiliares.Categorias[8]][2],
        textVSGResultController.text,
        unidadMedidaVSG!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[8],
        Auxiliares.Laboratorios[Auxiliares.Categorias[8]][0],
        textProcalcitoninaResultController.text,
        unidadMedidaProcalcitonina!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[8],
        Auxiliares.Laboratorios[Auxiliares.Categorias[8]][1],
        textLactatoResultController.text,
        unidadMedidaLactato!
        //0,
      ],
      // CARDIACOS
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[18],
        Auxiliares.Laboratorios[Auxiliares.Categorias[18]][0],
        textCKResultController.text,
        unidadMedidaCK!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[18],
        Auxiliares.Laboratorios[Auxiliares.Categorias[18]][1],
        textCKMBResultController.text,
        unidadMedidaCKMB!
        //0,
      ],
      // ARTERIALES
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[9],
        Auxiliares.Laboratorios[Auxiliares.Categorias[9]][0],
        textPHResultController.text,
        unidadMedidaPH!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[9],
        Auxiliares.Laboratorios[Auxiliares.Categorias[9]][1],
        textPCOResultController.text,
        unidadMedidaPCO!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[9],
        Auxiliares.Laboratorios[Auxiliares.Categorias[9]][2],
        textPOResultController.text,
        unidadMedidaPO!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[9],
        Auxiliares.Laboratorios[Auxiliares.Categorias[9]][3],
        textHCOResultController.text,
        unidadMedidaHCO!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[9],
        Auxiliares.Laboratorios[Auxiliares.Categorias[9]][4],
        textFIOResultController.text,
        unidadMedidaFIO!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[9],
        Auxiliares.Laboratorios[Auxiliares.Categorias[9]][5],
        textSOResultController.text,
        unidadMedidaSO!
        //0,
      ],
      // OTROS
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[25],
        Auxiliares.Laboratorios[Auxiliares.Categorias[25]][0],
        textHbAcResultController.text,
        unidadMedidaHbAc!
        //0,
      ],
      // VIRALES
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[20],
        Auxiliares.Laboratorios[Auxiliares.Categorias[20]][1],
        textAcAntiHCVResultController.text,
        unidadMedidaAcAntiHCV!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[20],
        Auxiliares.Laboratorios[Auxiliares.Categorias[20]][0],
        textHIVabResultController.text,
        unidadMedidaHIVab!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[20],
        Auxiliares.Laboratorios[Auxiliares.Categorias[20]][2],
        textHbsAgResultController.text,
        unidadMedidaHbsAg!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[20],
        Auxiliares.Laboratorios[Auxiliares.Categorias[20]][3],
        textHIVaGResultController.text,
        unidadMedidaHIVaG!
        //0,
      ],
      [
        "0",
        Pacientes.ID_Paciente.toString(),
        textDateEstudyController.text,
        Auxiliares.Categorias[20],
        Auxiliares.Laboratorios[Auxiliares.Categorias[20]][4],
        textHIVAgAgResultController.text,
        unidadMedidaHIVAgAg!
        //0,
      ],
    ];
  }

  // VARIABLES DE LA INTERFAZ ****************** ********
  var textDateEstudyController = TextEditingController();
  // ********* *************** ************* *
  var textEritrocitosResultController = TextEditingController();
  String? unidadMedidaEritrocitos =
      Auxiliares.Medidas[Auxiliares.Categorias[0]][4];
  var textADEResultController = TextEditingController();
  String? unidadMedidaADE =
  Auxiliares.Medidas[Auxiliares.Categorias[0]][1];
  //
  var textHemoglobinaResultController = TextEditingController();
  String? unidadMedidaHemoglobina =
      Auxiliares.Medidas[Auxiliares.Categorias[0]][0];
  var textHematocritoResultController = TextEditingController();
  String? unidadMedidaHematocrito =
      Auxiliares.Medidas[Auxiliares.Categorias[0]][1];
  var textCMHCResultController = TextEditingController();
  String? unidadMedidaCMHC = Auxiliares.Medidas[Auxiliares.Categorias[0]][1];
  var textVCMResultController = TextEditingController();
  String? unidadMedidaVCM = Auxiliares.Medidas[Auxiliares.Categorias[0]][2];
  var textHCMResultController = TextEditingController();
  String? unidadMedidaHCM = Auxiliares.Medidas[Auxiliares.Categorias[0]][3];

  var textPlaquetasResultController = TextEditingController();
  String? unidadMedidaPlaquetas =
      Auxiliares.Medidas[Auxiliares.Categorias[0]][4];

  var textLeucocitosResultController = TextEditingController();
  String? unidadMedidaLeucocitos =
      Auxiliares.Medidas[Auxiliares.Categorias[0]][6];
  var textNeutrofilosResultController = TextEditingController();
  String? unidadMedidaNeutrofilos =
      Auxiliares.Medidas[Auxiliares.Categorias[0]][6];
  var textLinfocitosResultController = TextEditingController();
  String? unidadMedidaLinfocitos =
      Auxiliares.Medidas[Auxiliares.Categorias[0]][6];
  var textMonocitosResultController = TextEditingController();
  String? unidadMedidaMonocitos =
      Auxiliares.Medidas[Auxiliares.Categorias[0]][6];
  // QUIMICA SANGUINEA  ********* *************** ************* *
  var textUreaResultController = TextEditingController();
  String? unidadMedidaUrea = Auxiliares.Medidas[Auxiliares.Categorias[1]][0];
  var textGlucosaResultController = TextEditingController();
  String? unidadMedidaGlucosa = Auxiliares.Medidas[Auxiliares.Categorias[1]][0];
  var textCreatininaResultController = TextEditingController();
  String? unidadMedidaCreatinina =
      Auxiliares.Medidas[Auxiliares.Categorias[1]][0];
  var textAcidoUricoResultController = TextEditingController();
  String? unidadMedidaAcidoUrico =
      Auxiliares.Medidas[Auxiliares.Categorias[1]][0];
  var textNitrogenoUreicoResultController = TextEditingController();
  String? unidadMedidaNitrogenoUreico =
      Auxiliares.Medidas[Auxiliares.Categorias[1]][0];
  // ELECTROLITOS SÉRICOS  ********* *************** ************* *
  var textSodioResultController = TextEditingController();
  String? unidadMedidaSodio = Auxiliares.Medidas[Auxiliares.Categorias[2]][0];
  var textPotasioResultController = TextEditingController();
  String? unidadMedidaPotasio = Auxiliares.Medidas[Auxiliares.Categorias[2]][0];
  var textCloroResultController = TextEditingController();
  String? unidadMedidaCloro = Auxiliares.Medidas[Auxiliares.Categorias[2]][0];
  var textFosforoResultController = TextEditingController();
  String? unidadMedidaFosforo = Auxiliares.Medidas[Auxiliares.Categorias[2]][2];
  var textCalcioResultController = TextEditingController();
  String? unidadMedidaCalcio = Auxiliares.Medidas[Auxiliares.Categorias[2]][2];
  var textMagnesioResultController = TextEditingController();
  String? unidadMedidaMagnesio =
      Auxiliares.Medidas[Auxiliares.Categorias[2]][2];
  // LIPIDICOS ********* *************** ************* *
  var textTrigliceridosResultController = TextEditingController();
  String? unidadMedidaTrigliceridos =
  Auxiliares.Medidas[Auxiliares.Categorias[6]][0];
  var textColesterolResultController = TextEditingController();
  String? unidadMedidaColesterol =
  Auxiliares.Medidas[Auxiliares.Categorias[6]][0];
  var textHDLResultController = TextEditingController();
  String? unidadMedidaHDL =
  Auxiliares.Medidas[Auxiliares.Categorias[6]][0];
  var textLDLResultController = TextEditingController();
  String? unidadMedidaLDL =
  Auxiliares.Medidas[Auxiliares.Categorias[6]][0];
  var textVLDLResultController = TextEditingController();
  String? unidadMedidaVLDL = Auxiliares.Medidas[Auxiliares.Categorias[6]][0];
// HEPATICOS ********* *************** ************* *
  var textBDResultController = TextEditingController();
  String? unidadMedidaBD = Auxiliares.Medidas[Auxiliares.Categorias[3]][2];
  var textBTResultController = TextEditingController();
  String? unidadMedidaBT = Auxiliares.Medidas[Auxiliares.Categorias[3]][2];
  var textBIResultController = TextEditingController();
  String? unidadMedidaBI = Auxiliares.Medidas[Auxiliares.Categorias[3]][2];
  var textAlaninoResultController = TextEditingController();
  String? unidadMedidaAlanino =
  Auxiliares.Medidas[Auxiliares.Categorias[3]][0];
  var textAspartatoResultController = TextEditingController();
  String? unidadMedidaAspartato =
  Auxiliares.Medidas[Auxiliares.Categorias[3]][0];
  var textDHLResultController = TextEditingController();
  String? unidadMedidaDHL = Auxiliares.Medidas[Auxiliares.Categorias[3]][0];

  var textGlutarilResultController = TextEditingController();
  String? unidadMedidaGlutaril =
  Auxiliares.Medidas[Auxiliares.Categorias[3]][0];

  var textFosfatasaResultController = TextEditingController();
  String? unidadMedidaFosfatasa =
  Auxiliares.Medidas[Auxiliares.Categorias[3]][0];
  var textAlbuminaResultController = TextEditingController();
  String? unidadMedidaAlbumina =
  Auxiliares.Medidas[Auxiliares.Categorias[3]][2];
  var textProteinasResultController = TextEditingController();
  String? unidadMedidaProteinas =
  Auxiliares.Medidas[Auxiliares.Categorias[3]][2];
  var textGlobulinasResultController = TextEditingController();
  String? unidadMedidaGlobulinas =
  Auxiliares.Medidas[Auxiliares.Categorias[3]][2];

  // COAGULACIONES  ********* *************** ************* *
  var textTromboplastinaResultController = TextEditingController();
  String? unidadMedidaTromboplastina =
  Auxiliares.Medidas[Auxiliares.Categorias[7]][1];
  var textProtrombinaResultController = TextEditingController();
  String? unidadMedidaProtrombina =
  Auxiliares.Medidas[Auxiliares.Categorias[7]][1];
  var textInrResultController = TextEditingController();
  String? unidadMedidaInr =
  Auxiliares.Medidas[Auxiliares.Categorias[7]][0];
  // PANCREATICOS  ********* *************** ************* *
  var textLipasaResultController = TextEditingController();
  String? unidadMedidaLipasa =
  Auxiliares.Medidas[Auxiliares.Categorias[5]][0];
  var textAmilasaResultController = TextEditingController();
  String? unidadMedidaAmilasa =
  Auxiliares.Medidas[Auxiliares.Categorias[5]][0];
  // VIRALES  ********* *************** ************* *
  var textHIVabResultController = TextEditingController();
  String? unidadMedidaHIVab =
  Auxiliares.Medidas[Auxiliares.Categorias[20]][2];
  var textAcAntiHCVResultController = TextEditingController();
  String? unidadMedidaAcAntiHCV =
  Auxiliares.Medidas[Auxiliares.Categorias[20]][0];
  var textHbsAgResultController = TextEditingController();
  String? unidadMedidaHbsAg =
  Auxiliares.Medidas[Auxiliares.Categorias[20]][1];
  var textHIVaGResultController = TextEditingController();
  String? unidadMedidaHIVaG =
  Auxiliares.Medidas[Auxiliares.Categorias[20]][2];
  var textHIVAgAgResultController = TextEditingController();
  String? unidadMedidaHIVAgAg = Auxiliares.Medidas[Auxiliares.Categorias[20]][0];
// ARTERIALES
  var textPHResultController = TextEditingController();
  String? unidadMedidaPH =
  Auxiliares.Medidas[Auxiliares.Categorias[9]][0];
  var textPCOResultController = TextEditingController();
  String? unidadMedidaPCO =
  Auxiliares.Medidas[Auxiliares.Categorias[9]][1];
  var textPOResultController = TextEditingController();
  String? unidadMedidaPO =
  Auxiliares.Medidas[Auxiliares.Categorias[9]][1];
  var textHCOResultController = TextEditingController();
  String? unidadMedidaHCO =
  Auxiliares.Medidas[Auxiliares.Categorias[9]][1];
  var textFIOResultController = TextEditingController();
  String? unidadMedidaFIO = Auxiliares.Medidas[Auxiliares.Categorias[9]][4];
  var textSOResultController = TextEditingController();
  String? unidadMedidaSO = Auxiliares.Medidas[Auxiliares.Categorias[9]][4];
  // REACTANTES ********* *************** ************* *
  var textVSGResultController = TextEditingController();
  String? unidadMedidaVSG =
  Auxiliares.Medidas[Auxiliares.Categorias[8]][1];
  var textPCRResultController = TextEditingController();
  String? unidadMedidaPCR =
  Auxiliares.Medidas[Auxiliares.Categorias[8]][0];
  var textProcalcitoninaResultController = TextEditingController();
  String? unidadMedidaProcalcitonina =
  Auxiliares.Medidas[Auxiliares.Categorias[8]][3];
  var textLactatoResultController = TextEditingController();
  String? unidadMedidaLactato =
  Auxiliares.Medidas[Auxiliares.Categorias[8]][2];
// CARDIACOS ********* *************** ************* *
  var textCKResultController = TextEditingController();
  String? unidadMedidaCK =
  Auxiliares.Medidas[Auxiliares.Categorias[18]][0];
  var textCKMBResultController = TextEditingController();
  String? unidadMedidaCKMB =
  Auxiliares.Medidas[Auxiliares.Categorias[18]][0];
  // OTROS  ********* *************** ************* *
  var textHbAcResultController = TextEditingController();
  String? unidadMedidaHbAc =
  Auxiliares.Medidas[Auxiliares.Categorias[25]][0];

  // OPERACIONES DE LA INTERFAZ ****************** ********
  void cerrar() {

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
      Pacientes.getParaclinicosHistorial(reload: true).whenComplete(() {
        //
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
      });
      //
    }).onError((error, stackTrace) {
      Pacientes.getParaclinicosHistorial(reload: true).whenComplete(() {
        Terminal.printAlert(message: "ERROR - $error : : : $stackTrace");
        Operadores.alertActivity(
          context: context,
          tittle: "$error . . .",
          message: "$stackTrace",
        );
      });
      //
    });
  }

  // VISTAS DE LA INTERFAZ *********************************
  mobileView() {
    return CarouselSlider(
      carouselController: carouselController,
      options: Carousel.carouselOptions(context: context), items: [
      SingleChildScrollView(
        // padding: const EdgeInsets.all(7.0),
        controller: ScrollController(),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: EditTextArea(
                    textController: textHemoglobinaResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText:
                    'Hemoglobina ($unidadMedidaHemoglobina)',
                    numOfLines: 1,
                    onChange: (String value) {
                      if (textHemoglobinaResultController.text.isNotEmpty)
                        Valores.hemoglobina =
                            double.parse(textHemoglobinaResultController.text);
                    },
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    textController: textEritrocitosResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat:
                    MaskTextInputFormatter(
                        mask: '#.##',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy),
                    labelEditText:
                    'Eritrocitos ($unidadMedidaEritrocitos)',
                    numOfLines: 1,

                    onChange: (String value) {
                      if (textEritrocitosResultController.text.isNotEmpty)
                        Valores.eritrocitos =
                            double.parse(textEritrocitosResultController.text);
                    },
                  ),
                ),

              ],
            ),
            Row(
              children: [
                Expanded(
                  child: EditTextArea(
                    textController: textHematocritoResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText:
                    'Hematocrito ($unidadMedidaHematocrito)',
                    numOfLines: 1,
                    onChange: (String value) {
                      if (textHematocritoResultController.text.isNotEmpty) {
                        Valores.hematocrito =
                            double.parse(textHematocritoResultController.text);
                        //
                        setState(() {
                          textCMHCResultController.text =
                              Citometrias.CMHC.toStringAsFixed(2);
                          textVCMResultController.text = Citometrias.VCM.toStringAsFixed(2);
                          textHCMResultController.text = Citometrias.HCM.toStringAsFixed(2);
                        });
                      }
                    },
                  ),
                ),
                Expanded(
                  child: EditTextArea(
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
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: EditTextArea(
                    textController: textVCMResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'VCM ($unidadMedidaVCM)',
                    numOfLines: 1,
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    textController: textCMHCResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'CMHC ($unidadMedidaCMHC)',
                    numOfLines: 1,
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    textController: textHCMResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'HCM ($unidadMedidaHCM)',
                    numOfLines: 1,
                  ),
                ),
              ],
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
            Row(
              children: [
                Expanded(
                  child: EditTextArea(
                    textController: textNeutrofilosResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText:
                    'Neutrofilos ($unidadMedidaNeutrofilos)',
                    numOfLines: 1,
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    textController: textLinfocitosResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText:
                    'Linfocitos ($unidadMedidaLinfocitos)',
                    numOfLines: 1,
                  ),
                ),
              ],
            ),
            EditTextArea(
              textController: textMonocitosResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Monocitos ($unidadMedidaMonocitos)',
              numOfLines: 1,
            ),
            // Quimica Sanguinea ***** ******* ****** * ***
            CrossLine(
              color: Colors.grey,
            ),
            EditTextArea(
              textController: textGlucosaResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Glucosa ($unidadMedidaGlucosa)',
              numOfLines: 1,
            ),
            Row(
              children: [
                Expanded(
                  child: EditTextArea(
                    textController: textUreaResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Urea ($unidadMedidaUrea)',
                    numOfLines: 1,
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    textController: textCreatininaResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText:
                    'Creatinina ($unidadMedidaCreatinina)',
                    numOfLines: 1,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: EditTextArea(
                    textController: textAcidoUricoResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText:
                    'Acido Urico ($unidadMedidaAcidoUrico)',
                    numOfLines: 1,
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    textController: textNitrogenoUreicoResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText:
                    'Nitrógeno Ureico ($unidadMedidaNitrogenoUreico)',
                    numOfLines: 1,
                  ),
                ),
              ],
            ),
            // Electrolitos Séricos ***** ******* ****** * ***
            CrossLine(
              color: Colors.grey,
            ),
            Row(
              children: [
                Expanded(
                  child: EditTextArea(
                    textController: textPotasioResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Potasio ($unidadMedidaPotasio)',
                    numOfLines: 1,
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    textController: textSodioResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Sodio ($unidadMedidaSodio)',
                    numOfLines: 1,
                  ),
                ),

              ],
            ),
            Row(
              children: [
                Expanded(
                  child: EditTextArea(
                    textController: textCloroResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Cloro ($unidadMedidaCloro)',
                    numOfLines: 1,
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    textController: textFosforoResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Fosforo ($unidadMedidaFosforo)',
                    numOfLines: 1,
                  ),
                ),
              ],
            ),
            Row(
              children: [

                Expanded(
                  child: EditTextArea(
                    textController: textCalcioResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Calcio ($unidadMedidaCalcio)',
                    numOfLines: 1,
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    textController: textMagnesioResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Magnesio ($unidadMedidaMagnesio)',
                    numOfLines: 1,
                  ),
                ),
              ],
            ),
            // Botton ***** ******* ****** * ***
            CrossLine(
              color: Colors.grey,
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              decoration: ContainerDecoration.roundedDecoration(),
              child: GrandButton(
                  labelButton: "Agregar Datos",
                  weigth: 2000,
                  onPress: () {
                    operationMethod();
                  }),
            )
          ],
        ),
      ), // Biometrías // Químicas // Electrolitos
      SingleChildScrollView(
        padding: const EdgeInsets.all(7.0),
        controller: ScrollController(),
        child: Column(
          children: [
            EditTextArea(
              textController: textColesterolResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Colesterol ($unidadMedidaColesterol)',
              numOfLines: 1,
            ),
            EditTextArea(
              textController: textTrigliceridosResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Trigliceridos ($unidadMedidaTrigliceridos)',
              numOfLines: 1,
            ),
            Row(
              children: [
                Expanded(
                  child: EditTextArea(
                    textController: textHDLResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'HDL ($unidadMedidaHDL)',
                    numOfLines: 1,
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    textController: textLDLResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'LDL ($unidadMedidaLDL)',
                    numOfLines: 1,
                  ),
                ),
              ],
            ),
            EditTextArea(
              textController: textVLDLResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'VLDL ($unidadMedidaVLDL)',
              numOfLines: 1,
            ),

            // Botton ***** ******* ****** * ***
            CrossLine(
              color: Colors.grey,
            ),
            EditTextArea(
              textController: textBTResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Bilirrubinas Totales ($unidadMedidaBT)',
              numOfLines: 1,
              onChange: (String value) {
                double val = 0.0;
                if (textBDResultController.text.isNotEmpty) {
                  val = double.parse(textBTResultController.text) -
                      double.parse(textBDResultController.text);
                  textBIResultController.text = val.toStringAsFixed(2);
                } else {}
              },
            ),
            EditTextArea(
              textController: textBDResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Bilirrubina Directa ($unidadMedidaBD)',
              numOfLines: 1,
              onChange: (String value) {
                double val = 0.0;

                if (textBTResultController.text.isNotEmpty) {
                  val = double.parse(textBTResultController.text) -
                      double.parse(textBDResultController.text);
                  textBIResultController.text = val.toStringAsFixed(2);
                } else {}
              },
            ),
            EditTextArea(
              textController: textBIResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Bilirrubina Indirecta ($unidadMedidaBI)',
              numOfLines: 1,
            ),

            EditTextArea(
              textController: textAlaninoResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Alaninoaminotrasferasa ($unidadMedidaAlanino)',
              numOfLines: 1,
            ),
            EditTextArea(
              textController: textAspartatoResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText:
              'Aspartatoaminotransferasa ($unidadMedidaAspartato)',
              numOfLines: 1,
            ),
            EditTextArea(
              textController: textDHLResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Deshidrogenasa Láctica ($unidadMedidaDHL)',
              numOfLines: 1,
            ),

            EditTextArea(
              textController: textGlutarilResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText:
              'Glutaril transpeptidasa ($unidadMedidaGlutaril)',
              numOfLines: 1,
            ),
            EditTextArea(
              textController: textFosfatasaResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Fosfatasa Alcalina ($unidadMedidaFosfatasa)',
              numOfLines: 1,
            ),

            EditTextArea(
              textController: textAlbuminaResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Albumina Sérica ($unidadMedidaAlbumina)',
              numOfLines: 1,
            ),
            EditTextArea(
              textController: textProteinasResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Proteinas Totales ($unidadMedidaProteinas)',
              numOfLines: 1,
            ),
            EditTextArea(
              textController: textGlobulinasResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Globulinas ($unidadMedidaGlobulinas)',
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
      ), // Hepaticos
      // Tiroideos
      SingleChildScrollView(
        padding: const EdgeInsets.all(7.0),
        controller: ScrollController(),
        child: Column(
          children: [
            EditTextArea(
              textController: textProtrombinaResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Tiempo de Protrombina ($unidadMedidaProtrombina)',
              numOfLines: 1,
            ),
            EditTextArea(
              textController: textTromboplastinaResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Tiempo Parcial de Tromboplastina ($unidadMedidaTromboplastina)',
              numOfLines: 1,
            ),
            EditTextArea(
              textController: textInrResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'I.N.R. ', // ($unidadMedidaInr)
              numOfLines: 1,
            ),
            CrossLine(
              color: Colors.grey,
            ),
            Row(
              children: [
                Expanded(
                  child: EditTextArea(
                    textController: textAmilasaResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Amilasa Sérica ($unidadMedidaAmilasa)',
                    numOfLines: 1,
                  ),
                ),
                Expanded(
                  child: EditTextArea(
                    textController: textLipasaResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Lipasa Sérica ($unidadMedidaLipasa)',
                    numOfLines: 1,
                  ),
                ),
              ],
            ),
            CrossLine(
              color: Colors.grey,
            ),
            EditTextArea(
              textController: textVSGResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Eritrosedimentación ($unidadMedidaVSG)',
              numOfLines: 1,
            ),
            EditTextArea(
              textController: textPCRResultController,
              keyBoardType: TextInputType.numberWithOptions(),
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Proteína C Reactiva ($unidadMedidaPCR)',
              numOfLines: 1,
            ),
            EditTextArea(
              textController: textProcalcitoninaResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Procalcitonina ($unidadMedidaProcalcitonina)',
              numOfLines: 1,
            ),
            EditTextArea(
              textController: textLactatoResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'Ácido Láctico ($unidadMedidaLactato)',
              numOfLines: 1,
            ),
            CrossLine(
              color: Colors.grey,
            ),
            EditTextArea(
              textController: textCKResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'CK ($unidadMedidaCK)',
              numOfLines: 1,
            ),
            EditTextArea(
              textController: textCKMBResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'CK-Mb ($unidadMedidaCKMB)',
              numOfLines: 1,
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
      ), // Coagulaciones
      SingleChildScrollView(
        padding: const EdgeInsets.all(7.0),
        controller: ScrollController(),
        child: Column(
          children: [
            EditTextArea(
              textController: textAcAntiHCVResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'AcAntiHCV ($unidadMedidaAcAntiHCV)',
              numOfLines: 1,
              selection: true,
              withShowOption: true,
              onSelected: () {
                setState(() {
                  // *************************************
                  textAcAntiHCVResultController.text = "0.03";
                  textHIVabResultController.text = "0.3";
                  textHbsAgResultController.text = "<0.030";
                  textHIVaGResultController.text = "0.22";
                  textHIVAgAgResultController.text = "No Reactivo";
                });
              },
            ),
            EditTextArea(
              textController: textHIVabResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'HIVab ($unidadMedidaHIVab)',
              numOfLines: 1,
            ),
            EditTextArea(
              textController: textHbsAgResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'HbsAg ($unidadMedidaHbsAg)',
              numOfLines: 1,
            ),

            EditTextArea(
              textController: textHIVaGResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'HIVaG ($unidadMedidaHIVaG)',
              numOfLines: 1,
            ),
            EditTextArea(
              textController: textHIVAgAgResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'HIVAg-Ag ($unidadMedidaHIVAgAg)',
              numOfLines: 1,
            ),
            // Botton ***** ******* ****** * ***
            CrossLine(
              color: Colors.grey,
            ),
            EditTextArea(
              textController: textPHResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'PH',
              numOfLines: 1,
            ),
            EditTextArea(
              textController: textPCOResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'PCO ($unidadMedidaPCO)',
              numOfLines: 1,
            ),

            EditTextArea(
              textController: textPOResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'PO ($unidadMedidaPO)',
              numOfLines: 1,
            ),

            EditTextArea(
              textController: textHCOResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'HCO ($unidadMedidaHCO)',
              numOfLines: 1,
            ),
            EditTextArea(
              textController: textFIOResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'FIO ($unidadMedidaFIO)',
              numOfLines: 1,
            ),
            EditTextArea(
              textController: textSOResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'SO ($unidadMedidaSO)',
              numOfLines: 1,
            ),
            CrossLine(
              color: Colors.grey,
            ),
            EditTextArea(
              textController: textHbAcResultController,
              keyBoardType: TextInputType.number,
              inputFormat: MaskTextInputFormatter(),
              labelEditText: 'HbAc ($unidadMedidaHbAc)',
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
      ), // Virales
    ],);
  }

  desktopView() {
    return CarouselSlider(
      carouselController: carouselController,
      options: Carousel.carouselOptions(context: context), items: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start ,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              // padding: const EdgeInsets.all(7.0),
              controller: ScrollController(),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          textController: textHemoglobinaResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText:
                          'Hemoglobina ($unidadMedidaHemoglobina)',
                          numOfLines: 1,
                          onChange: (String value) {
                            if (textHemoglobinaResultController.text.isNotEmpty)
                              Valores.hemoglobina =
                                  double.parse(textHemoglobinaResultController.text);
                          },
                        ),
                      ),
                      Expanded(
                        child: EditTextArea(
                          textController: textEritrocitosResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat:
                          MaskTextInputFormatter(
                              mask: '#.##',
                              filter: {"#": RegExp(r'[0-9]')},
                              type: MaskAutoCompletionType.lazy),
                          labelEditText:
                          'Eritrocitos ($unidadMedidaEritrocitos)',
                          numOfLines: 1,
                          onChange: (String value) {
                            if (textEritrocitosResultController.text.isNotEmpty)
                              Valores.eritrocitos =
                                  double.parse(textEritrocitosResultController.text);
                          },
                        ),
                      ),

                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          textController: textHematocritoResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText:
                          'Hematocrito ($unidadMedidaHematocrito)',
                          numOfLines: 1,
                          onChange: (String value) {
                            if (textHematocritoResultController.text.isNotEmpty) {
                              Valores.hematocrito =
                                  double.parse(textHematocritoResultController.text);
                              //
                              setState(() {
                                textCMHCResultController.text =
                                    Citometrias.CMHC.toStringAsFixed(2);
                                textVCMResultController.text = Citometrias.VCM.toStringAsFixed(2);
                                textHCMResultController.text = Citometrias.HCM.toStringAsFixed(2);
                              });
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: EditTextArea(
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
                      ),
                      
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          textController: textVCMResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'VCM ($unidadMedidaVCM)',
                          numOfLines: 1,
                        ),
                      ),
                      Expanded(
                        child: EditTextArea(
                          textController: textCMHCResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'CMHC ($unidadMedidaCMHC)',
                          numOfLines: 1,
                        ),
                      ),
                      Expanded(
                        child: EditTextArea(
                          textController: textHCMResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'HCM ($unidadMedidaHCM)',
                          numOfLines: 1,
                        ),
                      ),
                    ],
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
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          textController: textNeutrofilosResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText:
                          'Neutrofilos ($unidadMedidaNeutrofilos)',
                          numOfLines: 1,
                        ),
                      ),
                      Expanded(
                        child: EditTextArea(
                          textController: textLinfocitosResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText:
                          'Linfocitos ($unidadMedidaLinfocitos)',
                          numOfLines: 1,
                        ),
                      ),
                    ],
                  ),
                  EditTextArea(
                    textController: textMonocitosResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Monocitos ($unidadMedidaMonocitos)',
                    numOfLines: 1,
                  ),
                  // Quimica Sanguinea ***** ******* ****** * ***
                  CrossLine(
                    color: Colors.grey,
                  ),
                  EditTextArea(
                    textController: textGlucosaResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Glucosa ($unidadMedidaGlucosa)',
                    numOfLines: 1,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          textController: textUreaResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Urea ($unidadMedidaUrea)',
                          numOfLines: 1,
                        ),
                      ),
                      Expanded(
                        child: EditTextArea(
                          textController: textCreatininaResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText:
                          'Creatinina ($unidadMedidaCreatinina)',
                          numOfLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          textController: textAcidoUricoResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText:
                          'Acido Urico ($unidadMedidaAcidoUrico)',
                          numOfLines: 1,
                        ),
                      ),
                      Expanded(
                        child: EditTextArea(
                          textController: textNitrogenoUreicoResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText:
                          'Nitrógeno Ureico ($unidadMedidaNitrogenoUreico)',
                          numOfLines: 1,
                        ),
                      ),
                    ],
                  ),
                  // Electrolitos Séricos ***** ******* ****** * ***
                  CrossLine(
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          textController: textPotasioResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Potasio ($unidadMedidaPotasio)',
                          numOfLines: 1,
                        ),
                      ),
                      Expanded(
                        child: EditTextArea(
                          textController: textSodioResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Sodio ($unidadMedidaSodio)',
                          numOfLines: 1,
                        ),
                      ),

                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          textController: textCloroResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Cloro ($unidadMedidaCloro)',
                          numOfLines: 1,
                        ),
                      ),
                      Expanded(
                        child: EditTextArea(
                          textController: textFosforoResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Fosforo ($unidadMedidaFosforo)',
                          numOfLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [

                      Expanded(
                        child: EditTextArea(
                          textController: textCalcioResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Calcio ($unidadMedidaCalcio)',
                          numOfLines: 1,
                        ),
                      ),
                      Expanded(
                        child: EditTextArea(
                          textController: textMagnesioResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Magnesio ($unidadMedidaMagnesio)',
                          numOfLines: 1,
                        ),
                      ),
                    ],
                  ),
                  // Botton ***** ******* ****** * ***
                  CrossLine(
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ), // Biometrías // Químicas // Electrolitos
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(7.0),
              controller: ScrollController(),
              child: Column(
                children: [
                  EditTextArea(
                    textController: textColesterolResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Colesterol ($unidadMedidaColesterol)',
                    numOfLines: 1,
                  ),
                  EditTextArea(
                    textController: textTrigliceridosResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Trigliceridos ($unidadMedidaTrigliceridos)',
                    numOfLines: 1,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          textController: textHDLResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'HDL ($unidadMedidaHDL)',
                          numOfLines: 1,
                        ),
                      ),
                      Expanded(
                        child: EditTextArea(
                          textController: textLDLResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'LDL ($unidadMedidaLDL)',
                          numOfLines: 1,
                        ),
                      ),
                    ],
                  ),
                  EditTextArea(
                    textController: textVLDLResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'VLDL ($unidadMedidaVLDL)',
                    numOfLines: 1,
                  ),

                  // Botton ***** ******* ****** * ***
                  CrossLine(
                    color: Colors.grey,
                  ),
                  EditTextArea(
                    textController: textBTResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Bilirrubinas Totales ($unidadMedidaBT)',
                    numOfLines: 1,
                    onChange: (String value) {
                      double val = 0.0;
                      if (textBDResultController.text.isNotEmpty) {
                        val = double.parse(textBTResultController.text) -
                            double.parse(textBDResultController.text);
                        textBIResultController.text = val.toStringAsFixed(2);
                      } else {}
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          textController: textBDResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Bilirrubina Directa ($unidadMedidaBD)',
                          numOfLines: 1,
                          onChange: (String value) {
                            double val = 0.0;

                            if (textBTResultController.text.isNotEmpty) {
                              val = double.parse(textBTResultController.text) -
                                  double.parse(textBDResultController.text);
                              textBIResultController.text = val.toStringAsFixed(2);
                            } else {}
                          },
                        ),
                      ),
                      Expanded(
                        child: EditTextArea(
                          textController: textBIResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Bilirrubina Indirecta ($unidadMedidaBI)',
                          numOfLines: 1,
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          textController: textAlaninoResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Alaninoaminotrasferasa ($unidadMedidaAlanino)',
                          numOfLines: 1,
                        ),
                      ),
                      Expanded(
                        child: EditTextArea(
                          textController: textAspartatoResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText:
                          'Aspartatoaminotransferasa ($unidadMedidaAspartato)',
                          numOfLines: 1,
                        ),
                      ),
                    ],
                  ),
                  EditTextArea(
                    textController: textDHLResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Deshidrogenasa Láctica ($unidadMedidaDHL)',
                    numOfLines: 1,
                  ),

                  EditTextArea(
                    textController: textGlutarilResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText:
                    'Glutaril transpeptidasa ($unidadMedidaGlutaril)',
                    numOfLines: 1,
                  ),
                  EditTextArea(
                    textController: textFosfatasaResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Fosfatasa Alcalina ($unidadMedidaFosfatasa)',
                    numOfLines: 1,
                  ),

                  EditTextArea(
                    textController: textAlbuminaResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Albumina Sérica ($unidadMedidaAlbumina)',
                    numOfLines: 1,
                  ),
                  EditTextArea(
                    textController: textProteinasResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Proteinas Totales ($unidadMedidaProteinas)',
                    numOfLines: 1,
                  ),
                  EditTextArea(
                    textController: textGlobulinasResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Globulinas ($unidadMedidaGlobulinas)',
                    numOfLines: 1,
                  ),
                  // Botton ***** ******* ****** * ***
                  CrossLine(
                    color: Colors.grey,
                  ),

                ],
              ),
            ),
          ), // Hepaticos
          // Tiroideos
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(7.0),
              controller: ScrollController(),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          textController: textProtrombinaResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Tiempo de Protrombina ($unidadMedidaProtrombina)',
                          numOfLines: 1,
                        ),
                      ),
                      Expanded(
                        child: EditTextArea(
                          textController: textTromboplastinaResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Tiempo Parcial de Tromboplastina ($unidadMedidaTromboplastina)',
                          numOfLines: 1,
                        ),
                      ),
                    ],
                  ),
                  EditTextArea(
                    textController: textInrResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'I.N.R. ', // ($unidadMedidaInr)
                    numOfLines: 1,
                  ),

                  CrossLine(
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: EditTextArea(
                          textController: textAmilasaResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Amilasa Sérica ($unidadMedidaAmilasa)',
                          numOfLines: 1,
                        ),
                      ),
                      Expanded(
                        child: EditTextArea(
                          textController: textLipasaResultController,
                          keyBoardType: TextInputType.number,
                          inputFormat: MaskTextInputFormatter(),
                          labelEditText: 'Lipasa Sérica ($unidadMedidaLipasa)',
                          numOfLines: 1,
                        ),
                      ),
                    ],
                  ),
                  CrossLine(
                    color: Colors.grey,
                  ),
                  EditTextArea(
                    textController: textVSGResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Eritrosedimentación ($unidadMedidaVSG)',
                    numOfLines: 1,
                  ),
                  EditTextArea(
                    textController: textPCRResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Proteína C Reactiva ($unidadMedidaPCR)',
                    numOfLines: 1,
                  ),
                  EditTextArea(
                    textController: textProcalcitoninaResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Procalcitonina ($unidadMedidaProcalcitonina)',
                    numOfLines: 1,
                  ),
                  EditTextArea(
                    textController: textLactatoResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'Ácido Láctico ($unidadMedidaLactato)',
                    numOfLines: 1,
                  ),
                  CrossLine(
                    color: Colors.grey,
                  ),
                  EditTextArea(
                    textController: textCKResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'CK ($unidadMedidaCK)',
                    numOfLines: 1,
                  ),
                  EditTextArea(
                    textController: textCKMBResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'CK-Mb ($unidadMedidaCKMB)',
                    numOfLines: 1,
                  ),
                  CrossLine(
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ), // Coagulaciones
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(7.0),
              controller: ScrollController(),
              child: Column(
                children: [
                  EditTextArea(
                    textController: textAcAntiHCVResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'AcAntiHCV ($unidadMedidaAcAntiHCV)',
                    numOfLines: 1,
                    selection: true,
                    withShowOption: true,
                    onSelected: () {
                      setState(() {
                        // *************************************
                        textAcAntiHCVResultController.text = "0.03";
                        textHIVabResultController.text = "0.3";
                        textHbsAgResultController.text = "<0.030";
                        textHIVaGResultController.text = "0.22";
                        textHIVAgAgResultController.text = "No Reactivo";
                      });
                    },
                  ),
                  EditTextArea(
                    textController: textHIVabResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'HIVab ($unidadMedidaHIVab)',
                    numOfLines: 1,
                  ),
                  EditTextArea(
                    textController: textHbsAgResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'HbsAg ($unidadMedidaHbsAg)',
                    numOfLines: 1,
                  ),

                  EditTextArea(
                    textController: textHIVaGResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'HIVaG ($unidadMedidaHIVaG)',
                    numOfLines: 1,
                  ),
                  EditTextArea(
                    textController: textHIVAgAgResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'HIVAg-Ag ($unidadMedidaHIVAgAg)',
                    numOfLines: 1,
                  ),
                  // Botton ***** ******* ****** * ***
                  CrossLine(
                    color: Colors.grey,
                  ),
                  EditTextArea(
                    textController: textPHResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'PH',
                    numOfLines: 1,
                  ),
                  EditTextArea(
                    textController: textPCOResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'PCO ($unidadMedidaPCO)',
                    numOfLines: 1,
                  ),

                  EditTextArea(
                    textController: textPOResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'PO ($unidadMedidaPO)',
                    numOfLines: 1,
                  ),

                  EditTextArea(
                    textController: textHCOResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'HCO ($unidadMedidaHCO)',
                    numOfLines: 1,
                  ),
                  EditTextArea(
                    textController: textFIOResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'FIO ($unidadMedidaFIO)',
                    numOfLines: 1,
                  ),
                  EditTextArea(
                    textController: textSOResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'SO ($unidadMedidaSO)',
                    numOfLines: 1,
                  ),
                  // Botton ***** ******* ****** * ***
                  CrossLine(
                    color: Colors.grey,
                  ),
                  EditTextArea(
                    textController: textHbAcResultController,
                    keyBoardType: TextInputType.number,
                    inputFormat: MaskTextInputFormatter(),
                    labelEditText: 'HbAc ($unidadMedidaHbAc)',
                    numOfLines: 1,
                  ),
                  // Botton ***** ******* ****** * ***
                  CrossLine(
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ), // Virales
        ],)
    ],);
  }
}
