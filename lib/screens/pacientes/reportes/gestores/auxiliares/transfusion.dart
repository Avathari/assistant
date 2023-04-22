import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/terapias.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/DialogSelector.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Transfusion extends StatefulWidget {
  bool? isTerapia;

  Transfusion({super.key, this.isTerapia = false});

  @override
  State<Transfusion> createState() => _TransfusionState();
}

class _TransfusionState extends State<Transfusion> {
  // ######################### ### # ### ############################
  // INICIO DE LAS OPERACIONES STATE() Y BUILD().
  // ######################### ### # ### ############################

  @override
  void initState() {
    setState(() {
      hemotipoAdmnistradoTextController.text = Reportes.reportes['Hemotipo_Admnistrado'];
      cantidadUnidadesTextController.text = Reportes.reportes['Cantidad_Unidades'];
      volumenAdministradoTextController.text = Reportes.reportes['Volumen_Administrado'];
      numIdentificacionTextController.text = Reportes.reportes['Num_Identificacion'];
      fechaInicioTransfusionTextController.text = Reportes.reportes['Inicio_Transfusion'];
      fechaTerminoTransfusionTextController.text = Reportes.reportes['Termino_Transfusion'];
      estadoFinalTransfusionTextController.text = Reportes.reportes['Estado_Final_Transfusion'];
      reaccionesPresentadasTextController.text = Reportes.reportes['Reacciones_Presentadas'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        EditTextArea(
            textController: hemotipoAdmnistradoTextController,
            labelEditText: "Hemoderivado Administrado",
            keyBoardType: TextInputType.multiline,
            numOfLines: 1,
            withShowOption: true,
            selection: true,
            onSelected: () {
              showDialog(
                  useSafeArea: true,
                  context: context,
                  builder: (context) {
                    return Dialog(
                        child: DialogSelector(
                          tittle: 'Hemotipo Administrado',
                          pathForFileSource:
                          'assets/diccionarios/Transfusionales.txt',
                          typeOfDocument: 'txt',
                          onSelected: ((value) {
                            setState(() {
                              Valores.hemotipoAdmnistrado = value;
                              Reportes.reportes['Hemotipo_Admnistrado'] = value;
                              hemotipoAdmnistradoTextController.text = value;
                            });
                          }),
                        ));
                  });
            },
            onChange: (value) {
              setState(() {
                Valores.hemotipoAdmnistrado = value;
                Reportes.reportes['Hemotipo_Admnistrado'] =
                    Pacientes.motivoPrequirurgico();
              });
            },
            inputFormat: MaskTextInputFormatter()),
        CrossLine(),
        EditTextArea(
            textController: cantidadUnidadesTextController,
            labelEditText: "Cantidad de Unidades",
            keyBoardType: TextInputType.number,
            numOfLines: 1,
            onChange: ((value) {
              Valores.cantidadUnidades = value;
              Reportes.reportes['Cantidad_Unidades'] = value;
            }),
            inputFormat: MaskTextInputFormatter()),
        EditTextArea(
            textController: volumenAdministradoTextController,
            labelEditText: "Volumen Administrado (mL)",
            keyBoardType: TextInputType.number,
            numOfLines: 1,
            onChange: ((value) {
              Valores.volumenAdministrado = value;
              Reportes.reportes['Volumen_Administrado'] = "$value mL.";
            }),
            inputFormat: MaskTextInputFormatter()),
        EditTextArea(
            textController: numIdentificacionTextController,
            labelEditText: "No. Identificación (Folio)",
            keyBoardType: TextInputType.multiline,
            numOfLines: 1,
            onChange: ((value) {
              Valores.numIdentificacion = value.toUpperCase();
              Reportes.reportes['Num_Identificacion'] = value.toUpperCase();
            }),
            inputFormat: MaskTextInputFormatter()),
        if (!isMobile(context)) Container() ,
        EditTextArea(
          labelEditText: "Fecha de Inicio",
          numOfLines: 1,
          textController: fechaInicioTransfusionTextController,
          keyBoardType: TextInputType.datetime,
          withShowOption: true,
          selection: true,
          iconData: Icons.calculate_outlined,
          onSelected: () {
            setState(() {
              fechaInicioTransfusionTextController.text =
                  Calendarios.today(format: "yyyy/MM/dd kk:mm");
              Valores.fechaInicioTransfusion = Calendarios.today(format: "yyyy/MM/dd kk:mm");
              Reportes.reportes['Inicio_Transfusion'] = "${Calendarios.today(format: "yyyy/MM/dd kk:mm")} Horas";
            });
          },
          onChange: ((value) {
            Valores.fechaInicioTransfusion = value;
            Reportes.reportes['Inicio_Transfusion'] = value;
          }),
          inputFormat: MaskTextInputFormatter(
              mask: '####/##/## ##:##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
        ),
        EditTextArea(
          labelEditText: "Fecha de Término",
          numOfLines: 1,
          textController: fechaTerminoTransfusionTextController,
          keyBoardType: TextInputType.datetime,
          withShowOption: true,
          selection: true,
          iconData: Icons.calculate_outlined,
          onSelected: () {
            setState(() {
              fechaTerminoTransfusionTextController.text =
                  Calendarios.today(format: "yyyy/MM/dd kk:mm");
              Valores.fechaTerminoTransfusion = Calendarios.today(format: "yyyy/MM/dd kk:mm");
              Reportes.reportes['Termino_Transfusion'] = "${Calendarios.today(format: "yyyy/MM/dd kk:mm")} Horas";
            });
          },
          onChange: ((value) {
            Valores.fechaTerminoTransfusion = value;
            Reportes.reportes['Termino_Transfusion'] = value;
          }),
          inputFormat: MaskTextInputFormatter(
              mask: '####/##/## ##:##',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy),
        ),
        EditTextArea(
            textController: reaccionesPresentadasTextController,
            labelEditText: "Reacciones Adversas Presentadas ",
            keyBoardType: TextInputType.multiline,
            numOfLines: 5,
            onChange: ((value) {
              Valores.numIdentificacion = value;
              Reportes.reportes['Reacciones_Presentadas'] = value;
            }),
            inputFormat: MaskTextInputFormatter()),
      ]),
    );
  }

  // // Controladores de widgets tipo valores. ************** ************ *****
  var hemotipoAdmnistradoTextController = TextEditingController();
  var cantidadUnidadesTextController = TextEditingController();
  var volumenAdministradoTextController = TextEditingController();
  var numIdentificacionTextController = TextEditingController();
  var fechaInicioTransfusionTextController = TextEditingController();
  var fechaTerminoTransfusionTextController = TextEditingController();
  var estadoFinalTransfusionTextController = TextEditingController();
  var reaccionesPresentadasTextController = TextEditingController();
}
