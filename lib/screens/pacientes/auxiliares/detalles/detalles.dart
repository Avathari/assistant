import 'dart:convert';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/hospitalizacion.dart';
import 'package:assistant/screens/pacientes/hospitalizacion/pendientes.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandLabel.dart';

import 'package:assistant/widgets/ThreeLabelText.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

class Detalles extends StatefulWidget {
  bool? withImage;

  Detalles({super.key, this.withImage = false});

  @override
  State<Detalles> createState() => _DetallesState();
}

class _DetallesState extends State<Detalles> {

  @override
  Widget build(BuildContext context) {
    return TittleContainer(
      centered: true,
      tittle: 'Datos generales del paciente',
      child: Row(
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
                  Row(
                    children: [
                      Expanded(
                        child: ThreeLabelTextAline(
                          padding: 2.0,
                          firstText: 'ID',
                          secondText: Pacientes.Paciente['ID_Pace'].toString() ?? '',
                        ),
                      ),
                      Expanded(
                        child: ThreeLabelTextAline(
                          padding: 2.0,
                        //                         firstText: 'Nombre C.',
                          secondText: Pacientes.nombreCompleto,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ThreeLabelTextAline(
                          padding: 2.0,
                          firstText: 'Fecha Nacimiento',
                          secondText: Pacientes.Paciente['Pace_Nace'] ?? '',
                        ),
                      ),
                      Expanded(
                        child: ThreeLabelTextAline(
                          padding: 2.0,
                          firstText: 'Edad',
                          secondText: '${Pacientes.Paciente['Pace_Eda']} Años',
                        ),
                      ),
                    ],
                  ),
                  ThreeLabelTextAline(
                    padding: 2.0,
                    firstText: 'Sexo',
                    secondText: Pacientes.Paciente['Pace_Ses'] ?? '',
                  ),
                  // ThreeLabelTextAline(
                  //   padding: 2.0,
                  //   firstText: 'Teléfono',
                  //   secondText: Pacientes.Paciente['Pace_Tele'] ?? '',
                  // ),
                  ThreeLabelTextAline(
                    padding: 2.0,
                    firstText: 'Modo Atención',
                    secondText: Pacientes.Paciente['Pace_Hosp'] ?? '',
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ThreeLabelTextAline(
                          padding: 2.0,
                          firstText: 'Estado Civil',
                          secondText: Pacientes.Paciente['Pace_Edo_Civ'] ?? '',
                        ),
                      ),
                      Expanded(
                        child: ThreeLabelTextAline(
                          padding: 2.0,
                          firstText: 'Ocupación',
                          secondText: Pacientes.Paciente['Pace_Ocupa'].substring(0, 5) ?? '',
                        ),
                      ),
                    ],
                  ),
                  ThreeLabelTextAline(
                    padding: 2.0,
                    firstText: 'Religión',
                    secondText: Pacientes.Paciente['Pace_Reli'] ?? '',
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ThreeLabelTextAline(
                          padding: 2.0,
                          firstText: 'C.U.R.P.',
                          secondText: Pacientes.Paciente['Pace_Curp'] ?? '',
                        ),
                      ),
                      Expanded(
                        child: ThreeLabelTextAline(
                          padding: 2.0,
                          firstText: 'R.F.C.',
                          secondText: Pacientes.Paciente['Pace_RFC'] ?? '',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (widget.withImage!) Expanded(
            flex: isTablet(context) ? 2 : 0,
            child: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 120,
                child: ClipOval(
                    child: Image.memory(
                      base64Decode(Pacientes.imagenPaciente),
                      fit: BoxFit.cover,
                    ))),
          ),
        ],
      ),
    );
  }

}
