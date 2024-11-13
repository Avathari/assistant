import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/cardiometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/renometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/gasometricos.dart' as Gas ;
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';

class Basico extends StatefulWidget {
   const Basico({super.key});

  @override
  State<Basico> createState() => _BasicoState();
}

class _BasicoState extends State<Basico> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ValuePanel(
            firstText: "TAM",
            secondText:
            Cardiometrias.presionArterialMedia.toStringAsFixed(2),
            thirdText: "mmHg",
          ),
          ValuePanel(
            firstText: "P. pulso",
            secondText: Cardiometrias.presionPulso.toString(),
            thirdText: "mmHg",
          ),
          CrossLine(),
          ValuePanel(
            firstText: "UKH",
            secondText: Valores.diuresis.toStringAsFixed(2),
            thirdText: "mL/Kg/${Valores.horario} Hr",
          ),
          ValuePanel(
            firstText: "TFG (CKD-EPI)",
            secondText:
                Renometrias.tasaRenalCKDEPI != null ?  Renometrias.tasaRenalCKDEPI.toStringAsFixed(2) : "0",
            thirdText: "mL/min/1.72 m2",
          ),
          CrossLine(),
          ValuePanel(
            firstText: "P.P.",
            secondText: Antropometrias.pesoCorporalPredicho
                .toStringAsFixed(2),
            thirdText: "kG",
          ),
          ValuePanel(
            firstText: "S.C.",
            secondText: Antropometrias.SC.toStringAsFixed(2),
            thirdText: "m2",
          ),
          CrossLine(),
          ValuePanel(
            firstText: "SaFi",
            secondText: Gas.Gasometricos.SAFI.toStringAsFixed(2),
            thirdText: "%",
          ),
          ValuePanel(
            firstText: "Indice Rox",
            secondText: Antropometrias.indiceRox.toStringAsFixed(2),
            thirdText: "%",
          ),
          ValuePanel(
            firstText: "PaFi",
            secondText: Gas.Gasometricos.PAFI.toStringAsFixed(2),
            thirdText: "%",
          ),
          CrossLine(),
          // Container(
          //   margin: const EdgeInsets.all(5.0),
          //   decoration: ContainerDecoration.roundedDecoration(),
          //   child: GrandButton(
          //       labelButton: "Agregar Datos",
          //       weigth: 2000,
          //       onPress: () {
          //         operationMethod(context);
          //       }),
          // )
        ],
      ),
    );
  }
}
