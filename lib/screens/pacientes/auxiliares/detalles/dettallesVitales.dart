import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';

import 'package:assistant/widgets/ThreeLabelText.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

class DetallesVitales extends StatefulWidget {
  const DetallesVitales({super.key});

  @override
  State<DetallesVitales> createState() => _DetallesVitalesState();
}

class _DetallesVitalesState extends State<DetallesVitales> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TittlePanel(padding: 5, textPanel: 'Signos vitales del paciente'),
      SingleChildScrollView(
        controller: ScrollController(),
        child: isMobile(context) ? mobileView() : desktopView(),
      )
    ]);
  }

  Row desktopView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Fecha Nacimiento',
              secondText: Pacientes.Paciente['Pace_Nace'],
            ),
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Edad',
              secondText: '${Pacientes.Paciente['Pace_Eda']} Años',
            ),
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Sexo',
              secondText: Pacientes.Paciente['Pace_Ses'],
            ),
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Tensión arterial sistémica',
              secondText:
              "${Valores.tensionArterialSystolica}/ ${Valores.tensionArterialDyastolica} mmHg",
            ),
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Frecuencia cardiaca',
              secondText: "${Valores.frecuenciaCardiaca} L/min",
            ),
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Frecuencia respiratoria',
              secondText: "${Valores.frecuenciaRespiratoria} Resp/min",
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Saturación periférica de oxígeno',
              secondText: "${Valores.saturacionPerifericaOxigeno} %",
            ),
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Peso corporal toral',
              secondText: '${Valores.pesoCorporalTotal} Kg',
            ),
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Estatura',
              secondText: '${Valores.alturaPaciente} mts',
            ),
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'I.M.C.',
              secondText: '${Valores.imc.toStringAsFixed(2)} Kg/m2',
            ),
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Glucemia capilar',
              secondText: '${Valores.glucemiaCapilar} mg/dL',
            ),
            ThreeLabelTextAline(
              padding: 2.0,
              firstText: 'Horas de ayuno',
              secondText: "${Valores.horasAyuno} Hrs",
            ),
          ],
        ),
      ],
    );
  }

  Row mobileView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        firstComponent(),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Tooltip(
              message: "Signos Vitales",
              child: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return Dialog(
                            backgroundColor: Colors.black,
                            child: secondComponent(),
                          );
                        }));
                  },
                  icon: const Icon(
                    Icons.view_agenda,
                    color: Colors.grey,
                  )),
            )
          ],
        )
      ],
    );
  }

  Column firstComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Fecha Nacimiento',
          secondText: Pacientes.Paciente['Pace_Nace'],
        ),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Edad',
          secondText: '${Pacientes.Paciente['Pace_Eda']} Años',
        ),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Sexo',
          secondText: Pacientes.Paciente['Pace_Ses'],
        ),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Tensión arterial sistémica',
          secondText:
          "${Valores.tensionArterialSystolica}/ ${Valores.tensionArterialDyastolica} mmHg",
        ),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Frecuencia cardiaca',
          secondText: "${Valores.frecuenciaCardiaca} L/min",
        ),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Frecuencia respiratoria',
          secondText: "${Valores.frecuenciaRespiratoria} Resp/min",
        ),
      ],
    );
  }

  Column secondComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TittlePanel(textPanel: "Signos Vitales"),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Saturación periférica de oxígeno',
          secondText: "${Valores.saturacionPerifericaOxigeno} %",
        ),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Peso corporal toral',
          secondText: '${Valores.pesoCorporalTotal} Kg',
        ),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Estatura',
          secondText: '${Valores.alturaPaciente} mts',
        ),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'I.M.C.',
          secondText: '${Valores.imc.toStringAsFixed(2)} Kg/m2',
        ),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Glucemia capilar',
          secondText: '${Valores.glucemiaCapilar} mg/dL',
        ),
        ThreeLabelTextAline(
          padding: 2.0,
          firstText: 'Horas de ayuno',
          secondText: "${Valores.horasAyuno} Hrs",
        ),
      ],
    );
  }
}
