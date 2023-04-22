import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/DialogSelector.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Hemoderivados extends StatefulWidget {
  const Hemoderivados({Key? key}) : super(key: key);

  @override
  State<Hemoderivados> createState() => _HemoderivadosState();
}

class _HemoderivadosState extends State<Hemoderivados> {

  var motivoTextController = TextEditingController();
  var caducidadTextController = TextEditingController();
  var hemotipoAdmnistradoTextController = TextEditingController();
  var cantidadUnidadesTextController = TextEditingController();
  var volumenAdministradoTextController = TextEditingController();
  var numIdentificacionTextController = TextEditingController();

  var switched = false;

  @override
  void initState() {
    setState(() {
      Archivos.readJsonToMap(filePath: "${Pacientes.localRepositoryPath}transfusiones.json").then((value) {
        Valores.motivoTransfusion = value['Motivo_Transfusion'];
        Valores.hemotipoAdmnistrado = value['Caducidad'];
        Valores.fechaCaducidad = value['Hemotipo_Administrado'];
        Valores.cantidadUnidades = value['Cantidad_Unidades'];
        Valores.volumenAdministrado = value['Volumen_Administrado'];
        Valores.numIdentificacion = value['No_Identificacion'];
      }).onError((error, stackTrace) => null);

      motivoTextController.text = Valores.motivoTransfusion;
      hemotipoAdmnistradoTextController.text = Valores.hemotipoAdmnistrado;
      caducidadTextController.text = Valores.fechaCaducidad;
      cantidadUnidadesTextController.text = Valores.cantidadUnidades;
      volumenAdministradoTextController.text = Valores.volumenAdministrado;
      numIdentificacionTextController.text = Valores.numIdentificacion;
    });
    super.initState();
  }

  void reInit() {
     Reportes.subjetivoHospitalizacion = Formatos.subjetivos;
    Reportes.reportes['Subjetivo'] = Reportes.subjetivoHospitalizacion;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        children: [
          GrandButton(labelButton: 'Información del Hemoderivado', onPress: () {}),
          EditTextArea(
              textController: motivoTextController,
              labelEditText: "Motivo de la Transfusión",
              keyBoardType: TextInputType.multiline,
              numOfLines: 5,
              onChange: ((value) {
                Valores.motivoTransfusion = "$value.";
                Reportes.reportes['Motivo_Transfusion'] =
                "$value.";
              }),
              inputFormat: MaskTextInputFormatter()),
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
          EditTextArea(
              textController: cantidadUnidadesTextController,
              labelEditText: "Cantidad de Unidades",
              keyBoardType: TextInputType.number,
              numOfLines: 1,
              onChange: ((value) {
                Valores.cantidadUnidades = "$value.";
                Reportes.reportes['Cantidad_Unidades'] = "$value.";
              }),
              inputFormat: MaskTextInputFormatter()),
          EditTextArea(
              textController: volumenAdministradoTextController,
              labelEditText: "Volumen Administrado (mL)",
              keyBoardType: TextInputType.number,
              numOfLines: 1,
              onChange: ((value) {
                Valores.volumenAdministrado = "$value.";
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
          EditTextArea(
              textController: caducidadTextController,
              labelEditText: "Fecha de Caducidad",
              keyBoardType: TextInputType.datetime,
              numOfLines: 1,
              onChange: ((value) {
                Valores.fechaCaducidad = value;
                // Reportes.reportes['Cantidad_Unidades'] = "$value.";
              }),
              inputFormat: MaskTextInputFormatter()),
          CrossLine(),
          GrandButton(labelButton: 'Copiar en Portapapeles', onPress: () {
            Archivos.createJsonFromMap([{
              'Motivo_Transfusion': motivoTextController.text,
              'Caducidad': caducidadTextController.text,
              'Hemotipo_Administrado': hemotipoAdmnistradoTextController.text,
              'Cantidad_Unidades': cantidadUnidadesTextController.text,
              'Volumen_Administrado': volumenAdministradoTextController.text,
              'No_Identificacion': numIdentificacionTextController.text,
            }],  filePath:  "${Pacientes.localRepositoryPath}transfusiones.json");
            Datos.portapapeles(context: context, text: Formatos.transfusiones);
          }),
        ],
      ),
    );
  }
}
