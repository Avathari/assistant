import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleSwitched.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/Switched.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SituacionesHospitalizacion extends StatefulWidget {
  const SituacionesHospitalizacion({Key? key}) : super(key: key);

  @override
  State<SituacionesHospitalizacion> createState() =>
      _SituacionesHospitalizacionState();
}

class _SituacionesHospitalizacionState
    extends State<SituacionesHospitalizacion> {

  @override
  void initState() {
    // *********** ********* *********
    Actividades.consultarId(Databases.siteground_database_reghosp,
            Situaciones.situacion['consultQuery'], Pacientes.ID_Hospitalizacion)
        .then((response) {
      print("RESPUESTA $response");
      if (response['Error'] == 'Hubo un error') {
      } else {
        setState(() {
          Situaciones.ID_Situaciones = response['ID_Siti'];
          dispositivoOxigenoValue =
              response['Disp_Oxigen'] ?? 'Sin Dispositivo';
          Valores.dispositivoOxigeno =
              response['Disp_Oxigen'] ?? Items.dispositivosOxigeno[0];
          // *********** ********* *********
          Valores.isCateterPeriferico =
              Dicotomicos.fromInt(response['CVP'], toBoolean: true) as bool?;
          Valores.isCateterLargoPeriferico =
              Dicotomicos.fromInt(response['CVLP'], toBoolean: true) as bool?;
          Valores.isCateterVenosoCentral =
              Dicotomicos.fromInt(response['CVC'], toBoolean: true) as bool?;
          Valores.isCateterHemodialisis =
              Dicotomicos.fromInt(response['MAH'], toBoolean: true) as bool?;
          Valores.isSondaFoley =
              Dicotomicos.fromInt(response['S_Foley'], toBoolean: true)
                  as bool?;
          Valores.isSondaNasogastrica =
              Dicotomicos.fromInt(response['SNG'], toBoolean: true) as bool?;
          Valores.isSondaOrogastrica =
              Dicotomicos.fromInt(response['SOG'], toBoolean: true) as bool?;
          Valores.isDrenajePenrose =
              Dicotomicos.fromInt(response['Drenaje'], toBoolean: true)
                  as bool?;
          Valores.isPleuroVac =
              Dicotomicos.fromInt(response['Pleuro_Vac'], toBoolean: true)
                  as bool?;
          Valores.isColostomia =
              Dicotomicos.fromInt(response['Colostomia'], toBoolean: true)
                  as bool?;
          Valores.isGastrostomia =
              Dicotomicos.fromInt(response['Gastrostomia'], toBoolean: true)
                  as bool?;
          Valores.isDialisisPeritoneal = Dicotomicos.fromInt(
              response['Dialisis_Peritoneal'],
              toBoolean: true) as bool?;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isMobile(context) ? mobileView() : otherView();
  }

  // *****************************************************************
  otherView() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
              child: TittlePanel(
                  textPanel: 'Situación General en la Hospitalización')),
          Expanded(child: Row(
            children: [
              Expanded(
                child: CircleSwitched(
                    tittle: 'Cáteter Venoso Periférico',
                    onChangeValue: (value) {
                      setState(() {
                        Valores.isCateterPeriferico = value;
                      });
                    },
                    isSwitched: Valores.isCateterPeriferico),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    EditTextArea(
                      labelEditText: 'Fecha de colocación',
                      keyBoardType: TextInputType.number,
                      numOfLines: 1,
                      inputFormat: MaskTextInputFormatter(
                          mask: '####/##/##',
                          filter: {"#": RegExp(r'[0-9]')},
                          type: MaskAutoCompletionType.lazy),
                      textController: fechaCVPTextController,
                      iconColor: Colors.white,
                      withShowOption: true,
                      selection: true,
                      onSelected: () {
                        fechaCVPTextController.text =
                            Calendarios.today(format: 'yyyy-MM-dd');
                      },
                    ),
                    EditTextArea(
                      labelEditText: 'Observaciones . . . ',
                      keyBoardType: TextInputType.text,
                      numOfLines: 1,
                      inputFormat: MaskTextInputFormatter(),
                      textController: fechaCVPTextController,
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      EditTextArea(
                        labelEditText: 'Fecha de colocación',
                        keyBoardType: TextInputType.number,
                        numOfLines: 4,
                        inputFormat: MaskTextInputFormatter(
                            mask: '####/##/##',
                            filter: {"#": RegExp(r'[0-9]')},
                            type: MaskAutoCompletionType.lazy),
                        textController: fechaCVPTextController,
                        iconColor: Colors.white,
                      ),
                    ],
                  )),
              Expanded(
                child: CircleSwitched(
                  isSwitched: true,
                    onChangeValue: (onChangeValue) {
                  Situaciones.actualizarRegistro();
                }),
              )
            ],
          ),),
          // Expanded(
          //   flex: 8,
          //   child: GridView(
          //     controller: ScrollController(),
          //     gridDelegate: GridViewTools.gridDelegate(
          //         crossAxisCount: 2, mainAxisExtent: 125),
          //     children: [
          //       Row(
          //         children: [
          //           Expanded(
          //             child: CircleSwitched(
          //                 tittle: 'Cáteter Venoso Periférico',
          //                 onChangeValue: (value) {
          //                   setState(() {
          //                     Valores.isCateterPeriferico = value;
          //                   });
          //                 },
          //                 isSwitched: Valores.isCateterPeriferico),
          //           ),
          //           Expanded(
          //             flex: 3,
          //             child: Column(
          //               children: [
          //                 EditTextArea(
          //                   labelEditText: 'Fecha de colocación',
          //                   keyBoardType: TextInputType.number,
          //                   numOfLines: 1,
          //                   inputFormat: MaskTextInputFormatter(
          //                       mask: '####/##/##',
          //                       filter: {"#": RegExp(r'[0-9]')},
          //                       type: MaskAutoCompletionType.lazy),
          //                   textController: fechaCVPTextController,
          //                   iconColor: Colors.white,
          //                   withShowOption: true,
          //                   selection: true,
          //                   onSelected: () {
          //                     fechaCVPTextController.text =
          //                         Calendarios.today(format: 'yyyy-MM-dd');
          //                   },
          //                 ),
          //                 EditTextArea(
          //                   labelEditText: 'Observaciones . . . ',
          //                   keyBoardType: TextInputType.text,
          //                   numOfLines: 1,
          //                   inputFormat: MaskTextInputFormatter(),
          //                   textController: fechaCVPTextController,
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Expanded(
          //             flex: 2,
          //               child: Column(
          //             children: [
          //               EditTextArea(
          //                 labelEditText: 'Fecha de colocación',
          //                 keyBoardType: TextInputType.number,
          //                 numOfLines: 4,
          //                 inputFormat: MaskTextInputFormatter(
          //                     mask: '####/##/##',
          //                     filter: {"#": RegExp(r'[0-9]')},
          //                     type: MaskAutoCompletionType.lazy),
          //                 textController: fechaCVPTextController,
          //                 iconColor: Colors.white,
          //               ),
          //             ],
          //           ))
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Switched(
          //               tittle: 'Cáteter Largo Periférico',
          //               onChangeValue: (value) {
          //                 setState(() {
          //                   Valores.isCateterLargoPeriferico = value;
          //                 });
          //               },
          //               isSwitched: Valores.isCateterLargoPeriferico,
          //             ),
          //           ),
          //           Expanded(
          //             child: EditTextArea(
          //               labelEditText: 'Fecha de colocación',
          //               keyBoardType: TextInputType.number,
          //               numOfLines: 1,
          //               inputFormat: MaskTextInputFormatter(
          //                   mask: '####/##/##',
          //                   filter: {"#": RegExp(r'[0-9]')},
          //                   type: MaskAutoCompletionType.lazy),
          //               textController: fechaCVPTextController,
          //               iconColor: Colors.white,
          //               withShowOption: true,
          //               selection: true,
          //               onSelected: () {
          //                 fechaCVPTextController.text =
          //                     Calendarios.today(format: 'yyyy-MM-dd');
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Switched(
          //                 tittle: 'Cáteter Venoso Central',
          //                 onChangeValue: (value) {
          //                   setState(() {
          //                     Valores.isCateterVenosoCentral = value;
          //                     Valores.isCateterVenosoCentral = value;
          //                   });
          //                 },
          //                 isSwitched: Valores.isCateterVenosoCentral),
          //           ),
          //           Expanded(
          //             child: EditTextArea(
          //               labelEditText: 'Fecha de colocación',
          //               keyBoardType: TextInputType.number,
          //               numOfLines: 1,
          //               inputFormat: MaskTextInputFormatter(
          //                   mask: '####/##/##',
          //                   filter: {"#": RegExp(r'[0-9]')},
          //                   type: MaskAutoCompletionType.lazy),
          //               textController: fechaCVPTextController,
          //               iconColor: Colors.white,
          //               withShowOption: true,
          //               selection: true,
          //               onSelected: () {
          //                 fechaCVPTextController.text =
          //                     Calendarios.today(format: 'yyyy-MM-dd');
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Switched(
          //                 tittle: 'Sonda Orogástrica',
          //                 onChangeValue: (value) {
          //                   setState(() {
          //                     Valores.isSondaOrogastrica = value;
          //                     Valores.isSondaOrogastrica = value;
          //                   });
          //                 },
          //                 isSwitched: Valores.isSondaOrogastrica),
          //           ),
          //           Expanded(
          //             child: EditTextArea(
          //               labelEditText: 'Fecha de colocación',
          //               keyBoardType: TextInputType.number,
          //               numOfLines: 1,
          //               inputFormat: MaskTextInputFormatter(
          //                   mask: '####/##/##',
          //                   filter: {"#": RegExp(r'[0-9]')},
          //                   type: MaskAutoCompletionType.lazy),
          //               textController: fechaCVPTextController,
          //               iconColor: Colors.white,
          //               withShowOption: true,
          //               selection: true,
          //               onSelected: () {
          //                 fechaCVPTextController.text =
          //                     Calendarios.today(format: 'yyyy-MM-dd');
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Switched(
          //               tittle: 'Sonda Nasogástrica',
          //               onChangeValue: (value) {
          //                 setState(() {
          //                   Valores.isSondaNasogastrica = value;
          //                   Valores.isSondaNasogastrica = value;
          //                 });
          //               },
          //               isSwitched: Valores.isSondaNasogastrica,
          //             ),
          //           ),
          //           Expanded(
          //             child: EditTextArea(
          //               labelEditText: 'Fecha de colocación',
          //               keyBoardType: TextInputType.number,
          //               numOfLines: 1,
          //               inputFormat: MaskTextInputFormatter(
          //                   mask: '####/##/##',
          //                   filter: {"#": RegExp(r'[0-9]')},
          //                   type: MaskAutoCompletionType.lazy),
          //               textController: fechaCVPTextController,
          //               iconColor: Colors.white,
          //               withShowOption: true,
          //               selection: true,
          //               onSelected: () {
          //                 fechaCVPTextController.text =
          //                     Calendarios.today(format: 'yyyy-MM-dd');
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Switched(
          //                 tittle: 'Cáteter Hemodiálisis',
          //                 onChangeValue: (value) {
          //                   setState(() {
          //                     Valores.isCateterHemodialisis = value;
          //                     Valores.isCateterHemodialisis = value;
          //                   });
          //                 },
          //                 isSwitched: Valores.isCateterHemodialisis),
          //           ),
          //           Expanded(
          //             child: EditTextArea(
          //               labelEditText: 'Fecha de colocación',
          //               keyBoardType: TextInputType.number,
          //               numOfLines: 1,
          //               inputFormat: MaskTextInputFormatter(
          //                   mask: '####/##/##',
          //                   filter: {"#": RegExp(r'[0-9]')},
          //                   type: MaskAutoCompletionType.lazy),
          //               textController: fechaCVPTextController,
          //               iconColor: Colors.white,
          //               withShowOption: true,
          //               selection: true,
          //               onSelected: () {
          //                 fechaCVPTextController.text =
          //                     Calendarios.today(format: 'yyyy-MM-dd');
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Switched(
          //                 tittle: 'Sonda Foley',
          //                 onChangeValue: (value) {
          //                   setState(() {
          //                     Valores.isSondaFoley = value;
          //                     Valores.isSondaFoley = value;
          //                   });
          //                 },
          //                 isSwitched: Valores.isSondaFoley),
          //           ),
          //           Expanded(
          //             child: EditTextArea(
          //               labelEditText: 'Fecha de colocación',
          //               keyBoardType: TextInputType.number,
          //               numOfLines: 1,
          //               inputFormat: MaskTextInputFormatter(
          //                   mask: '####/##/##',
          //                   filter: {"#": RegExp(r'[0-9]')},
          //                   type: MaskAutoCompletionType.lazy),
          //               textController: fechaCVPTextController,
          //               iconColor: Colors.white,
          //               withShowOption: true,
          //               selection: true,
          //               onSelected: () {
          //                 fechaCVPTextController.text =
          //                     Calendarios.today(format: 'yyyy-MM-dd');
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Switched(
          //                 tittle: 'Drenaje Penrose',
          //                 onChangeValue: (value) {
          //                   setState(() {
          //                     Valores.isDrenajePenrose = value;
          //                     Valores.isDrenajePenros = value;
          //                   });
          //                 },
          //                 isSwitched: Valores.isDrenajePenrose),
          //           ),
          //           Expanded(
          //             child: EditTextArea(
          //               labelEditText: 'Fecha de colocación',
          //               keyBoardType: TextInputType.number,
          //               numOfLines: 1,
          //               inputFormat: MaskTextInputFormatter(
          //                   mask: '####/##/##',
          //                   filter: {"#": RegExp(r'[0-9]')},
          //                   type: MaskAutoCompletionType.lazy),
          //               textController: fechaCVPTextController,
          //               iconColor: Colors.white,
          //               withShowOption: true,
          //               selection: true,
          //               onSelected: () {
          //                 fechaCVPTextController.text =
          //                     Calendarios.today(format: 'yyyy-MM-dd');
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Switched(
          //               tittle: 'Sello Pleural',
          //               onChangeValue: (value) {
          //                 setState(() {
          //                   Valores.isPleuroVac = value;
          //                   Valores.isPleuroVac = value;
          //                 });
          //               },
          //               isSwitched: Valores.isPleuroVac,
          //             ),
          //           ),
          //           Expanded(
          //             child: EditTextArea(
          //               labelEditText: 'Fecha de colocación',
          //               keyBoardType: TextInputType.number,
          //               numOfLines: 1,
          //               inputFormat: MaskTextInputFormatter(
          //                   mask: '####/##/##',
          //                   filter: {"#": RegExp(r'[0-9]')},
          //                   type: MaskAutoCompletionType.lazy),
          //               textController: fechaCVPTextController,
          //               iconColor: Colors.white,
          //               withShowOption: true,
          //               selection: true,
          //               onSelected: () {
          //                 fechaCVPTextController.text =
          //                     Calendarios.today(format: 'yyyy-MM-dd');
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Switched(
          //                 tittle: 'Colostomía',
          //                 onChangeValue: (value) {
          //                   setState(() {
          //                     Valores.isColostomia = value;
          //                     Valores.isColostomia = value;
          //                   });
          //                 },
          //                 isSwitched: Valores.isColostomia),
          //           ),
          //           Expanded(
          //             child: EditTextArea(
          //               labelEditText: 'Fecha de colocación',
          //               keyBoardType: TextInputType.number,
          //               numOfLines: 1,
          //               inputFormat: MaskTextInputFormatter(
          //                   mask: '####/##/##',
          //                   filter: {"#": RegExp(r'[0-9]')},
          //                   type: MaskAutoCompletionType.lazy),
          //               textController: fechaCVPTextController,
          //               iconColor: Colors.white,
          //               withShowOption: true,
          //               selection: true,
          //               onSelected: () {
          //                 fechaCVPTextController.text =
          //                     Calendarios.today(format: 'yyyy-MM-dd');
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Switched(
          //               tittle: 'Gaastrostomia',
          //               onChangeValue: (value) {
          //                 setState(() {
          //                   Valores.isGastrostomia = value;
          //                 });
          //               },
          //               isSwitched: Valores.isGastrostomia,
          //             ),
          //           ),
          //           Expanded(
          //             child: EditTextArea(
          //               labelEditText: 'Fecha de colocación',
          //               keyBoardType: TextInputType.number,
          //               numOfLines: 1,
          //               inputFormat: MaskTextInputFormatter(
          //                   mask: '####/##/##',
          //                   filter: {"#": RegExp(r'[0-9]')},
          //                   type: MaskAutoCompletionType.lazy),
          //               textController: fechaCVPTextController,
          //               iconColor: Colors.white,
          //               withShowOption: true,
          //               selection: true,
          //               onSelected: () {
          //                 fechaCVPTextController.text =
          //                     Calendarios.today(format: 'yyyy-MM-dd');
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Switched(
          //                 tittle: 'Diálisis Peritoneal',
          //                 onChangeValue: (value) {
          //                   setState(() {
          //                     Valores.isDialisisPeritoneal = value;
          //                   });
          //                 },
          //                 isSwitched: Valores.isDialisisPeritoneal),
          //           ),
          //           Expanded(
          //             child: EditTextArea(
          //               labelEditText: 'Fecha de colocación',
          //               keyBoardType: TextInputType.number,
          //               numOfLines: 1,
          //               inputFormat: MaskTextInputFormatter(
          //                   mask: '####/##/##',
          //                   filter: {"#": RegExp(r'[0-9]')},
          //                   type: MaskAutoCompletionType.lazy),
          //               textController: fechaCVPTextController,
          //               iconColor: Colors.white,
          //               withShowOption: true,
          //               selection: true,
          //               onSelected: () {
          //                 fechaCVPTextController.text =
          //                     Calendarios.today(format: 'yyyy-MM-dd');
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Switched(
          //               tittle: 'Cáteter Largo Periférico',
          //               onChangeValue: (value) {
          //                 setState(() {
          //                   Valores.isCateterLargoPeriferico = value;
          //                 });
          //               },
          //               isSwitched: Valores.isCateterLargoPeriferico,
          //             ),
          //           ),
          //           Expanded(
          //             child: EditTextArea(
          //               labelEditText: 'Fecha de colocación',
          //               keyBoardType: TextInputType.number,
          //               numOfLines: 1,
          //               inputFormat: MaskTextInputFormatter(
          //                   mask: '####/##/##',
          //                   filter: {"#": RegExp(r'[0-9]')},
          //                   type: MaskAutoCompletionType.lazy),
          //               textController: fechaCVPTextController,
          //               iconColor: Colors.white,
          //               withShowOption: true,
          //               selection: true,
          //               onSelected: () {
          //                 fechaCVPTextController.text =
          //                     Calendarios.today(format: 'yyyy-MM-dd');
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Switched(
          //               tittle: 'Cáteter Largo Periférico',
          //               onChangeValue: (value) {
          //                 setState(() {
          //                   Valores.isCateterLargoPeriferico = value;
          //                 });
          //               },
          //               isSwitched: Valores.isCateterLargoPeriferico,
          //             ),
          //           ),
          //           Expanded(
          //             child: EditTextArea(
          //               labelEditText: 'Fecha de colocación',
          //               keyBoardType: TextInputType.number,
          //               numOfLines: 1,
          //               inputFormat: MaskTextInputFormatter(
          //                   mask: '####/##/##',
          //                   filter: {"#": RegExp(r'[0-9]')},
          //                   type: MaskAutoCompletionType.lazy),
          //               textController: fechaCVPTextController,
          //               iconColor: Colors.white,
          //               withShowOption: true,
          //               selection: true,
          //               onSelected: () {
          //                 fechaCVPTextController.text =
          //                     Calendarios.today(format: 'yyyy-MM-dd');
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Switched(
          //               tittle: 'Cáteter Largo Periférico',
          //               onChangeValue: (value) {
          //                 setState(() {
          //                   Valores.isCateterLargoPeriferico = value;
          //                 });
          //               },
          //               isSwitched: Valores.isCateterLargoPeriferico,
          //             ),
          //           ),
          //           Expanded(
          //             child: EditTextArea(
          //               labelEditText: 'Fecha de colocación',
          //               keyBoardType: TextInputType.number,
          //               numOfLines: 1,
          //               inputFormat: MaskTextInputFormatter(
          //                   mask: '####/##/##',
          //                   filter: {"#": RegExp(r'[0-9]')},
          //                   type: MaskAutoCompletionType.lazy),
          //               textController: fechaCVPTextController,
          //               iconColor: Colors.white,
          //               withShowOption: true,
          //               selection: true,
          //               onSelected: () {
          //                 fechaCVPTextController.text =
          //                     Calendarios.today(format: 'yyyy-MM-dd');
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: Switched(
          //               tittle: 'Cáteter Largo Periférico',
          //               onChangeValue: (value) {
          //                 setState(() {
          //                   Valores.isCateterLargoPeriferico = value;
          //                 });
          //               },
          //               isSwitched: Valores.isCateterLargoPeriferico,
          //             ),
          //           ),
          //           Expanded(
          //             child: EditTextArea(
          //               labelEditText: 'Fecha de colocación',
          //               keyBoardType: TextInputType.number,
          //               numOfLines: 1,
          //               inputFormat: MaskTextInputFormatter(
          //                   mask: '####/##/##',
          //                   filter: {"#": RegExp(r'[0-9]')},
          //                   type: MaskAutoCompletionType.lazy),
          //               textController: fechaCVPTextController,
          //               iconColor: Colors.white,
          //               withShowOption: true,
          //               selection: true,
          //               onSelected: () {
          //                 fechaCVPTextController.text =
          //                     Calendarios.today(format: 'yyyy-MM-dd');
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          Expanded(flex: 4, child: Container(
            decoration: ContainerDecoration.roundedDecoration(),
            // child: ListView.builder(controller: ScrollController(), itemBuilder: (context, int a) {
            //   return Container();
            // }),
          ),),
          GrandButton(
            weigth: 2000,
            labelButton: "Actualizar",
            onPress: () {
              Situaciones.actualizarRegistro();
            },
          ),
        ],
      ),
    );
  }

  mobileView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      controller: ScrollController(),
      child: Column(
        children: [
          TittlePanel(textPanel: 'Situación General en la Hospitalización'),
          Spinner(
              tittle: 'Dispositivo de Oxígeno',
              width: isDesktop(context)
                  ? 600
                  : isTablet(context)
                      ? 200
                      : 100,
              onChangeValue: (value) {
                setState(() {
                  dispositivoOxigenoValue = value;
                  Valores.dispositivoOxigeno = value;
                });
              },
              items: Items.dispositivosOxigeno,
              initialValue: dispositivoOxigenoValue),
          CrossLine(),
          Row(
            children: [
              Expanded(
                child: Switched(
                    tittle: 'Cáteter Venoso Periférico',
                    onChangeValue: (value) {
                      setState(() {
                        Valores.isCateterPeriferico = value;
                      });
                    },
                    isSwitched: Valores.isCateterPeriferico),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                  tittle: 'Cáteter Largo Periférico',
                  onChangeValue: (value) {
                    setState(() {
                      Valores.isCateterLargoPeriferico = value;
                    });
                  },
                  isSwitched: Valores.isCateterLargoPeriferico,
                ),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                    tittle: 'Cáteter Venoso Central',
                    onChangeValue: (value) {
                      setState(() {
                        Valores.isCateterVenosoCentral = value;
                        Valores.isCateterVenosoCentral = value;
                      });
                    },
                    isSwitched: Valores.isCateterVenosoCentral),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                    tittle: 'Sonda Orogástrica',
                    onChangeValue: (value) {
                      setState(() {
                        Valores.isSondaOrogastrica = value;
                        Valores.isSondaOrogastrica = value;
                      });
                    },
                    isSwitched: Valores.isSondaOrogastrica),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                  tittle: 'Sonda Nasogástrica',
                  onChangeValue: (value) {
                    setState(() {
                      Valores.isSondaNasogastrica = value;
                      Valores.isSondaNasogastrica = value;
                    });
                  },
                  isSwitched: Valores.isSondaNasogastrica,
                ),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                    tittle: 'Cáteter Hemodiálisis',
                    onChangeValue: (value) {
                      setState(() {
                        Valores.isCateterHemodialisis = value;
                        Valores.isCateterHemodialisis = value;
                      });
                    },
                    isSwitched: Valores.isCateterHemodialisis),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                    tittle: 'Sonda Foley',
                    onChangeValue: (value) {
                      setState(() {
                        Valores.isSondaFoley = value;
                        Valores.isSondaFoley = value;
                      });
                    },
                    isSwitched: Valores.isSondaFoley),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                    tittle: 'Drenaje Penrose',
                    onChangeValue: (value) {
                      setState(() {
                        Valores.isDrenajePenrose = value;
                        Valores.isDrenajePenros = value;
                      });
                    },
                    isSwitched: Valores.isDrenajePenrose),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                  tittle: 'Sello Pleural',
                  onChangeValue: (value) {
                    setState(() {
                      Valores.isPleuroVac = value;
                      Valores.isPleuroVac = value;
                    });
                  },
                  isSwitched: Valores.isPleuroVac,
                ),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                    tittle: 'Colostomía',
                    onChangeValue: (value) {
                      setState(() {
                        Valores.isColostomia = value;
                        Valores.isColostomia = value;
                      });
                    },
                    isSwitched: Valores.isColostomia),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                  tittle: 'Gaastrostomia',
                  onChangeValue: (value) {
                    setState(() {
                      Valores.isGastrostomia = value;
                    });
                  },
                  isSwitched: Valores.isGastrostomia,
                ),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                    tittle: 'Diálisis Peritoneal',
                    onChangeValue: (value) {
                      setState(() {
                        Valores.isDialisisPeritoneal = value;
                      });
                    },
                    isSwitched: Valores.isDialisisPeritoneal),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                  tittle: 'Cáteter Largo Periférico',
                  onChangeValue: (value) {
                    setState(() {
                      Valores.isCateterLargoPeriferico = value;
                    });
                  },
                  isSwitched: Valores.isCateterLargoPeriferico,
                ),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                  tittle: 'Cáteter Largo Periférico',
                  onChangeValue: (value) {
                    setState(() {
                      Valores.isCateterLargoPeriferico = value;
                    });
                  },
                  isSwitched: Valores.isCateterLargoPeriferico,
                ),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                  tittle: 'Cáteter Largo Periférico',
                  onChangeValue: (value) {
                    setState(() {
                      Valores.isCateterLargoPeriferico = value;
                    });
                  },
                  isSwitched: Valores.isCateterLargoPeriferico,
                ),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Switched(
                  tittle: 'Cáteter Largo Periférico',
                  onChangeValue: (value) {
                    setState(() {
                      Valores.isCateterLargoPeriferico = value;
                    });
                  },
                  isSwitched: Valores.isCateterLargoPeriferico,
                ),
              ),
              Expanded(
                child: EditTextArea(
                  labelEditText: 'Fecha de colocación',
                  keyBoardType: TextInputType.number,
                  numOfLines: 1,
                  inputFormat: MaskTextInputFormatter(
                      mask: '####/##/##',
                      filter: {"#": RegExp(r'[0-9]')},
                      type: MaskAutoCompletionType.lazy),
                  textController: fechaCVPTextController,
                  iconColor: Colors.white,
                  withShowOption: true,
                  selection: true,
                  onSelected: () {
                    fechaCVPTextController.text =
                        Calendarios.today(format: 'yyyy-MM-dd');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // VARIABLES ********************************************************
  var dispositivoOxigenoValue = Items.dispositivosOxigeno[0];
  var fechaCVPTextController = TextEditingController();

}
