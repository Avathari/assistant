import 'dart:convert';

import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/values/SizingInfo.dart';

import 'package:assistant/widgets/ThreeLabelText.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

class Detalles extends StatefulWidget {
  const Detalles({super.key});

  @override
  State<Detalles> createState() => _DetallesState();
}

class _DetallesState extends State<Detalles> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TittlePanel(padding: 5, textPanel: 'Datos generales del paciente'),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: isTablet(context) ? 3 : 1,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(8.0),
                  controller: ScrollController(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ThreeLabelTextAline(
                        padding: 2.0,
                        firstText: 'Nombre C.',
                        secondText: Pacientes.nombreCompleto,
                      ),
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
                        firstText: 'Teléfono',
                        secondText: Pacientes.Paciente['Pace_Tele'],
                      ),
                      ThreeLabelTextAline(
                        padding: 2.0,
                        firstText: 'Modo Atención',
                        secondText: Pacientes.Paciente['Pace_Hosp'],
                      ),
                      ThreeLabelTextAline(
                        padding: 2.0,
                        firstText: 'Estado Civil',
                        secondText: Pacientes.Paciente['Pace_Edo_Civ'],
                      ),
                      ThreeLabelTextAline(
                        padding: 2.0,
                        firstText: 'Ocupación',
                        secondText: Pacientes.Paciente['Pace_Ocupa'],
                      ),
                      ThreeLabelTextAline(
                        padding: 2.0,
                        firstText: 'Religión',
                        secondText: Pacientes.Paciente['Pace_Reli'],
                      ),
                      ThreeLabelTextAline(
                        padding: 2.0,
                        firstText: 'C.U.R.P.',
                        secondText: Pacientes.Paciente['Pace_Curp'],
                      ),
                      ThreeLabelTextAline(
                        padding: 2.0,
                        firstText: 'R.F.C.',
                        secondText: Pacientes.Paciente['Pace_RFC'],
                      ),
                    ],
                  ),
                ),
              ),
              isTablet(context)
                  ? Expanded(
                flex: isTablet(context) ? 2 : 0,
                child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 100,
                    child: ClipOval(
                        child: Image.memory(
                          base64Decode(Pacientes.imagenPaciente),
                          fit: BoxFit.cover,
                        ))),
              )
                  : Container()
            ],
          )
        ]);
  }
}
