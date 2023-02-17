import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/Spinner.dart';
import 'package:assistant/widgets/Switched.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Subjetivos extends StatefulWidget {
  const Subjetivos({Key? key}) : super(key: key);

  @override
  State<Subjetivos> createState() => _SubjetivosState();
}

class _SubjetivosState extends State<Subjetivos> {
  var referidosTextController = TextEditingController();

  var switched = false;

  @override
  void initState() {
    setState(() {
      referidosTextController.text = Valores.referenciasHospitalizacion;
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
          GrandButton(labelButton: 'Subjetivo del paciente', onPress: () {}),
          Spinner(
              width: SpinnersValues.mediumWidth(context: context),
              tittle: 'Estado General',
              onChangeValue: (value) {
                setState(() {
                  Valores.estadoGeneral = value;
                  reInit();
                });
              },
              items: Items.estadoGeneral,
              initialValue: Valores.estadoGeneral),
          Spinner(
              tittle: 'Alimentación',
              width: SpinnersValues.mediumWidth(context: context),
              onChangeValue: (value) {
                setState(() {
                  Valores.viaOral = value;
                  reInit();
                });
              },
              items: Items.viaOralAlimentacion,
              initialValue: Valores.viaOral),
          Spinner(
              tittle: 'Uresis',
              width: SpinnersValues.mediumWidth(context: context),
              onChangeValue: (value) {
                setState(() {
                  Valores.uresisCantidad = value;
                  reInit();
                });
              },
              items: Items.uresisCantidad,
              initialValue: Valores.uresisCantidad),
          Spinner(
              tittle: 'Excretas',
              width: SpinnersValues.mediumWidth(context: context),
              onChangeValue: (value) {
                setState(() {
                  Valores.excretasCantidad = value;
                  reInit();
                });
              },
              items: Items.excretasCantidad,
              initialValue: Valores.excretasCantidad),
          Row(
            children: [
              Expanded(
                child: Switched(
                  tittle: 'Referencias del paciente',
                  onChangeValue: (value) {
                    setState(() {
                      if (value) {
                        referidosTextController.text = "";
                      } else {
                        referidosTextController.text =
                            "Sin referencias por parte del paciente";
                      }
                      switched = value;
                      Valores.referenciasHospitalizacion =
                          referidosTextController.text;
                      reInit();
                    });
                  },
                  isSwitched: switched,
                ),
              ),
              Expanded(
                child: EditTextArea(
                  textController: referidosTextController,
                  keyBoardType: TextInputType.text,
                  inputFormat: MaskTextInputFormatter(),
                  numOfLines: 5,
                  onChange: (value) {
                    setState(() {
                      Valores.referenciasHospitalizacion = value;
                      reInit();
                    });
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
