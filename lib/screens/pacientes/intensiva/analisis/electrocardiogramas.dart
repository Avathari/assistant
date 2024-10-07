// ignore: must_be_immutable
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GridLayout.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';

class AnalisisElectrocardiograma extends StatefulWidget {
  bool operationActivity = true; // Si true entonces REGISTER.register.
  AnalisisElectrocardiograma({super.key, required this.operationActivity});

  @override
  State<AnalisisElectrocardiograma> createState() =>
      _AnalisisElectrocardiogramaState();
}

class _AnalisisElectrocardiogramaState
    extends State<AnalisisElectrocardiograma> {
  @override
  Widget build(BuildContext context) {
    return TittleContainer(
      tittle: 'Analisis de Electrocardiograma',
      centered: isMobile(context) ? false : true,
      padding: 4.0,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theming.quincuaryColor),
          child: SingleChildScrollView(
            padding: isMobile(context)
                ? const EdgeInsets.all(4.0)
                : const EdgeInsets.all(12.0),
            controller: ScrollController(),
            child:
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.all(4.0),
                decoration: ContainerDecoration.roundedDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ValuePanel(
                        firstText: "Fecha de realización",
                        secondText: (Valores.fechaElectrocardiograma ?? ''),
                      ),
                    ),
                    Expanded(
                      child: ValuePanel(
                        firstText: "Ritmo Cardiaco",
                        secondText: (Valores.ritmoCardiaco ?? ''),
                      ),
                    ),
                    Expanded(
                      child: ValuePanel(
                        firstText: "Segmento ST",
                        secondText: (Valores.segmentoST ?? ''),
                      ),
                    ),
                  ],
                ),
              ),
              CrossLine(),
              Container(
                margin: const EdgeInsets.all(4.0),
                padding: const EdgeInsets.all(4.0),
                decoration: ContainerDecoration.roundedDecoration(),
                child: GridLayout(
                    columnCount: isMobile(context) ? 1 : 4,
                    childAspectRatio: isMobile(context) ? 5 : 0,
                    children: [
                      ValuePanel(
                        firstText: "Frecuencia Cardica",
                        secondText:
                        (1500 / Valores.intervaloRR!).toStringAsFixed(0),
                        thirdText: "L/min",
                      ),
                      ValuePanel(
                        firstText: "Eje Cardiaco",
                        secondText: (Valores.ejeCardiaco!).toStringAsFixed(2),
                        thirdText: "°",
                      ),
                      ValuePanel(
                        firstText: "Indice Sokolow-Lyon",
                        secondText:
                        Valores.indiceSokolowLyon.toStringAsFixed(2),
                        thirdText: "mV",
                      ),
                      ValuePanel(
                        firstText: "Indice de Gubner", //-Underleider",
                        secondText:
                        Valores.indiceGubnerUnderleiger.toStringAsFixed(2),
                        thirdText: "mV",
                      ),
                      ValuePanel(
                        firstText: "Indice de Lewis",
                        secondText: Valores.indiceLewis.toStringAsFixed(2),
                        thirdText: "mV",
                      ),
                      ValuePanel(
                        firstText: "Voltaje de Cornell",
                        secondText: Valores.voltajeCornell.toStringAsFixed(2),
                        thirdText: "mV",
                      ),
                      ValuePanel(
                        firstText: "Indice Enrique Cabrera",
                        secondText:
                        Valores.indiceEnriqueCabrera.toStringAsFixed(2),
                        thirdText: "mV",
                      ),
                    ]),
              ),
            ]),
          )),
    );
  }
}
