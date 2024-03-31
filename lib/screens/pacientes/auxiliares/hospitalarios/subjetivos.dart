import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/operativity/pacientes/valores/semiologia/semiotica.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleSwitched.dart';
import 'package:assistant/widgets/CrossLine.dart';
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
      referidosTextController.text = Exploracion.referenciasHospitalizacion;
    });
    super.initState();
  }

  void reInit() {
     Reportes.subjetivoHospitalizacion = Exploracion.subjetivos;
Reportes.reportes['Subjetivo'] = Reportes.subjetivoHospitalizacion;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: ContainerDecoration.roundedDecoration(),
        child: Column(
          children: [
            Spinner(
                width: SpinnersValues.mediumWidth(context: context),
                tittle: 'Estado General',
                onChangeValue: (value) {
                  setState(() {
                    Exploracion.estadoGeneral = value;
                    reInit();
                  });
                },
                items: Items.estadoGeneral,
                initialValue: Exploracion.estadoGeneral),
            Spinner(
                tittle: 'Oxigeno suplementario',
                width: SpinnersValues.mediumWidth(context: context),
                onChangeValue: (value) {
                  setState(() {
                    Exploracion.oxigenSuplementario = value;
                    reInit();
                  });
                },
                items: Items.oxigenSuplementario,
                initialValue: Exploracion.oxigenSuplementario),
            CrossLine(height: 20),
            Spinner(
                tittle: 'Alimentación',
                width: SpinnersValues.mediumWidth(context: context),
                onChangeValue: (value) {
                  setState(() {
                    Exploracion.viaOral = value;
                    reInit();
                  });
                },
                items: Items.viaOralAlimentacion,
                initialValue: Exploracion.viaOral),
            Row(
              children: [
                Expanded(
                  child: Spinner(
                      tittle: 'Uresis',
                      width: SpinnersValues.minimunWidth(context: context),
                      onChangeValue: (value) {
                        setState(() {
                          Exploracion.uresisCantidad = value;
                          reInit();
                        });
                      },
                      items: Items.uresisCantidad,
                      initialValue: Exploracion.uresisCantidad),
                ),
                Expanded(
                  child: Spinner(
                      tittle: 'Excretas',
                      width: SpinnersValues.minimunWidth(context: context),
                      onChangeValue: (value) {
                        setState(() {
                          Exploracion.excretasCantidad = value;
                          reInit();
                        });
                      },
                      items: Items.excretasCantidad,
                      initialValue: Exploracion.excretasCantidad),
                ),
              ],
            ),
            Spinner(
                tittle: 'Bristol . . . ',
                width: SpinnersValues.mediumWidth(context: context),
                onChangeValue: (value) {
                  setState(() {
                    Exploracion.excretasBristol = value;
                    reInit();
                  });
                },
                items: Items.excretasBristol,
                initialValue: Exploracion.excretasBristol),
            CrossLine(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CircleSwitched(
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
                        Exploracion.referenciasHospitalizacion =
                            referidosTextController.text;
                        reInit();
                      });
                    },
                    isSwitched: switched,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: EditTextArea(
                    textController: referidosTextController,
                    keyBoardType: TextInputType.text,
                    inputFormat: MaskTextInputFormatter(),
                    numOfLines: 5,
                    onChange: (value) {
                      setState(() {
                        Exploracion.referenciasHospitalizacion = value;
                        reInit();
                      });
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
