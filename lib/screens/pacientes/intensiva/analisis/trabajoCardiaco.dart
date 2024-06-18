import 'package:assistant/operativity/pacientes/valores/Valorados/antropometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/cardiometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';

class TrabajoCardiaco extends StatefulWidget {
  TrabajoCardiaco({super.key});

  @override
  State<TrabajoCardiaco> createState() => _TrabajoCardiacoState();
}

class _TrabajoCardiacoState extends State<TrabajoCardiaco> {
  @override
  Widget build(BuildContext context) {
    return TittleContainer(
      padding: 4.0,
      tittle: "Indices de Trabajo Cárdiaco",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: ValuePanel(
                  firstText: 'Fcard',
                  secondText: Valores.frecuenciaCardiaca!.toString(),
                  thirdText: 'Lat/min',
                ),
              ),
              Expanded(
                child: ValuePanel(
                  firstText: 'TAM',
                  secondText: Cardiometrias.presionArterialMedia.toStringAsFixed(2),
                  thirdText: 'mmHg',
                ),
              ),
              Expanded(
                child: ValuePanel(
                  firstText: 'SC',
                  secondText: Antropometrias.SC.toStringAsFixed(2),
                  thirdText: 'm2',
                ),
              ),
            ],
          ),
          CrossLine(),
          ValuePanel(
            firstText: 'G.C. (Fick)',
            secondText: Cardiometrias.gastoCardiacoFick.toStringAsFixed(2),
            thirdText: 'Lt/min',
          ),
          ValuePanel(
            firstText: 'I.C.',
            secondText: Cardiometrias.indiceCardiaco.toStringAsFixed(2),
            thirdText: 'Lt/min',
          ),
          CrossLine(), // **********************************
          Row(
            children: [
              Expanded(
                child: ValuePanel(
                  firstText: 'CW',
                  secondText: Cardiometrias.poderCardiaco.toStringAsFixed(2),
                  thirdText: 'Watts',
                ),
              ),
              Expanded(
                child: ValuePanel(
                  firstText: 'iCW',
                  secondText:
                      Cardiometrias.poderCardiacoIndexado.toStringAsFixed(2),
                  thirdText: 'Watts',
                ),
              ),
            ],
          ), // PODER CARDIACO
          CrossLine(), // **********************************
          Row(
            children: [
              Expanded(
                child: ValuePanel(
                  firstText: 'Vol. Lat. Sys. ',
                  secondText: Cardiometrias.volumenSistolico.toStringAsFixed(2),
                  thirdText: 'mL/min',
                ),
              ),
              Expanded(
                child: ValuePanel(
                  firstText: 'I, Vol. Lat. Sys. ',
                  secondText: Cardiometrias.volumenSistolicoIndexado.toStringAsFixed(2),
                  thirdText: 'mL/min/m2',
                ),
              ),
            ],
          ), // VOLUMEN LATIDO

          CrossLine(), // **********************************
          CrossLine(), // **********************************
          Row(
            children: [
              Expanded(
                child: ValuePanel(
                  firstText: 'T. Card. Izq. ',
                  secondText: Cardiometrias.trabajoCardiacoIzquierdo.toStringAsFixed(2),
                  thirdText: 'g*m',
                ),
              ),
              Expanded(
                child: ValuePanel(
                  firstText: 'iTCI',
                  secondText: Cardiometrias.indiceTrabajoCardiacoIzquierdo.toStringAsFixed(2),
                  thirdText: 'g*m/m2',
                ),
              ),
            ],
          ), // TRABAJO VENTRICULAR IZQUIERDO
          Row(
            children: [
              Expanded(
                child: ValuePanel(
                  firstText: 'TLVI',
                  secondText: Cardiometrias.trabajoLatidoVentricularIzquierdo
                      .toStringAsFixed(2),
                  thirdText: 'g*m/m2',
                ),
              ),
              Expanded(
                child: ValuePanel(
                  firstText: 'I. TLVI',
                  secondText: Cardiometrias.indiceTrabajoCardiacoIzquierdo.toStringAsFixed(2),
                  thirdText: 'g*m/m2',
                ),
              ),
            ],
          ), // TRABAJO VENTRICULAR IZQUIERDO
          CrossLine(), // **********************************
          ValuePanel(
            firstText: 'Rest. V. Sist.',
            secondText: Valores.RVS.toStringAsFixed(2),
            thirdText: 'dinas/seg/cm2',
          ),
        ],
      ),
    );
  }
}
