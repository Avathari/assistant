import 'package:assistant/operativity/pacientes/valores/Valorados/gasometricos.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/hepatometrias.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/lipidometria.dart';
import 'package:assistant/operativity/pacientes/valores/Valorados/renometrias.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';

class Conclusiones extends StatefulWidget {
  const Conclusiones({super.key});

  @override
  State<Conclusiones> createState() => _ConclusionesState();
}

class _ConclusionesState extends State<Conclusiones> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              ValuePanel(
                firstText: "CG-TFG",
                secondText: Renometrias.tasaRenalCrockoft_Gault.toStringAsFixed(2),
                thirdText: "mL/min/1.72 m2",
              ),
              ValuePanel(
                firstText: "CKD-EPI-TFG",
                secondText: Renometrias.tasaRenalCKDEPI.toStringAsFixed(2),
                thirdText: "mL/min/1.72 m2",
              ),
              ValuePanel(
                firstText: "MDRD-TFG",
                secondText: Renometrias.tasaRenalMDRD.toStringAsFixed(2),
                thirdText: "mL/min/1.72 m2",
              ),
              CrossLine(),
              ValuePanel(
                firstText: "Ure/Cr",
                secondText: Renometrias.ureaCreatinina.toStringAsFixed(2),
                thirdText: "",
              ),
              ValuePanel(
                secondText: "",
                firstText: Renometrias.uremia,
                thirdText: "",
              ),
              CrossLine(thickness: 3),
              ValuePanel(
                firstText: "Factor R",
                secondText: Hepatometrias.factorR.toStringAsFixed(2),
              ),
              CrossLine(thickness: 2),
              ValuePanel(
                firstText: "ALT/FA",
                secondText: Hepatometrias.relacionALTFA.toStringAsFixed(2),
              ),
              ValuePanel(
                firstText: "ALT/AST",
                secondText: Hepatometrias.relacionALTAST.toStringAsFixed(2),
              ),
              ValuePanel(
                firstText: "ALT/DHL",
                secondText: Hepatometrias.relacionALTDHL.toStringAsFixed(2),
              ),
              ValuePanel(
                firstText: "GGT/FA",
                secondText: Hepatometrias.relacionGGTFA.toStringAsFixed(2),
              ),
            ],
          ),
        ),
        Expanded(child: Column(
          children: [
            ValuePanel(
              firstText: 'IndAter',
              secondText:
              Lipidometria.indiceAterogenico.toStringAsFixed(2),
              thirdText: '',
            ),
            CrossLine(),
            ValuePanel(
              firstText: 'cLDL/cHDL',
              secondText:
              Lipidometria.indiceLDLHDL.toStringAsFixed(2),
              thirdText: '',
            ),
            ValuePanel(
              firstText: 'TG/cHDL',
              secondText:
              Lipidometria.indiceTrigliceridosHDL.toStringAsFixed(2),
              thirdText: '',
            ),
          ],
        )),
        Expanded(child: Column(children: [
          ValuePanel(
            firstText: 'PiO2',
            secondText:
            Gasometricos.PIO.toStringAsFixed(2),
            thirdText: 'mmHg',
          ),
          ValuePanel(
            firstText: 'PAO2',
            secondText:
            Gasometricos.PAO.toStringAsFixed(2),
            thirdText: 'mmHg',
          ),
          ValuePanel(
            firstText: 'GA-a O2',
            secondText:
            Gasometricos.GAA.toStringAsFixed(2),
            thirdText: 'mmHg',
          ),
          // ** * * * * * * *
          CrossLine(),
          // ValuePanel(
          //   firstText:
          //   'CaO2', // Contenido Arterial de Oxígeno
          //   secondText: Valores.CAO.toStringAsFixed(2),
          //   thirdText: 'mL/O2%',
          // ),
          // ValuePanel(
          //   firstText:
          //   'CcO2', // Contenido Capilar de Oxígeno
          //   secondText: Valores.CCO.toStringAsFixed(2),
          //   thirdText: 'mL/O2%',
          // ),
          // ValuePanel(
          //   firstText:
          //   'CvO2', // Contenido Arterial de Oxígeno
          //   secondText: Valores.CVO.toStringAsFixed(2),
          //   thirdText: 'mL/O2%',
          // ),
          // CrossLine(),
          // ValuePanel(
          //   firstText:
          //   'Da-vO2', // Diferencia Arterio-venosa de Oxígeno
          //   secondText: Valores.DAV.toStringAsFixed(2),
          //   thirdText: 'mL',
          // ),
          // CrossLine(),
          // ValuePanel(
          //   firstText: 'VO2', // Consumo de Oxígeno
          //   secondText: Valores.CO.toStringAsFixed(2),
          //   thirdText: 'mL/min',
          // ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: ValuePanel(
          //         firstText: 'DO2',
          //         secondText: Valores.DO.toStringAsFixed(2),
          //         thirdText: 'mL/min',
          //       ),
          //     ),
          //     Expanded(
          //       child: ValuePanel(
          //         firstText: 'iDO2',
          //         secondText: Valores.iDO.toStringAsFixed(2),
          //         thirdText: 'mL/min/m2',
          //       ),
          //     ),
          //   ],
          // ),
          //
          // ValuePanel(
          //   firstText: 'QS/QT', // Shunt Arterio-venoso
          //   secondText: Valores.SF.toStringAsFixed(2),
          //   thirdText: '%',
          // ),
          ValuePanel(
            firstText: 'PAFI', //
            secondText:
            Gasometricos.PAFI.toStringAsFixed(0),
          ),
          // ValuePanel(
          //   firstText:
          //   'IEO2%', // Indice de Extracción Oxígeno
          //   secondText: Valores.IEO.toStringAsFixed(2),
          //   thirdText: '%',
          // ),
          // ValuePanel(
          //   firstText: 'I. Resp. ',
          //   secondText: Valores.CI.toStringAsFixed(2),
          // ),
          // //
          // ValuePanel(
          //   firstText: 'ΔCO2',
          //   secondText: Gasometricos.DeltaCOS.toStringAsFixed(2),
          //   thirdText: 'mmHg',
          // ),
          // ValuePanel(
          //   firstText: 'ΔΔCO2',
          //   secondText: Valores.DavCO2.toStringAsFixed(2),
          //   thirdText: 'mmHg',
          // ),
          // ValuePanel(
          //   firstText: 'ΔPavCO2/\nΔPavO2',
          //   secondText:
          //   Valores.D_PavCO2D_PavO2.toStringAsFixed(
          //       2),
          //   thirdText: "", // 'mmHg/mL',
          // ),
          // ValuePanel(
          //   firstText: 'Indice \nMitocondrial',
          //   secondText: Valores.indiceMitocondrial
          //       .toStringAsFixed(2),
          //   thirdText: "", // 'mmHg/mL',
          // ),
          CrossLine(),
          ValuePanel(
            firstText: "I-APRI",
            secondText: Hepatometrias.APRI.toStringAsFixed(2),
          ),
          ValuePanel(
            firstText: "FIB-4",
            secondText: Hepatometrias.Fib4.toStringAsFixed(2),
          ),
          ValuePanel(
            firstText: "MELD",
            secondText: Hepatometrias.MELD.toStringAsFixed(2),
          ),
        ],), )

      ],
    );
  }
}
