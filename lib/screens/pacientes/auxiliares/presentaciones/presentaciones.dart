import 'dart:convert';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';

import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/ImageDialog.dart';
import 'package:assistant/widgets/ThreeLabelText.dart';
import 'package:flutter/material.dart';

class PresentacionPacientes extends StatefulWidget {
  const PresentacionPacientes({super.key});

  @override
  State<PresentacionPacientes> createState() => _PresentacionPacientesState();
}

class _PresentacionPacientesState extends State<PresentacionPacientes> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(6.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          GestureDetector(
            onTap: () {
              Operadores.openDialog(
                context: context,
                chyldrim: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ImageDialog(
                        tittle: Pacientes.nombreCompleto,
                        stringImage: Pacientes.imagenPaciente, //Paciente['Pace_FIAT'],
                      ),
                      Expanded(
                        flex: isTablet(context) ? 3 : 1,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(8.0),
                          decoration: ContainerDecoration.roundedDecoration(),
                          child: SingleChildScrollView(
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
                      ),
                    ],
                  ),
                ),
              );
            },
            child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 40,
                child: Pacientes.imagenPaciente != ""
                    ? ClipOval(
                        child: Image.memory(
                        base64Decode(Pacientes.imagenPaciente), // Pacientes.Paciente['Pace_FIAT']),
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ))
                    : const ClipOval(child: Icon(Icons.person))),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${Pacientes.Paciente['Pace_Ape_Pat']} ${Pacientes.Paciente['Pace_Ape_Mat']} \n"
                "${Pacientes.Paciente['Pace_Nome_PI']} ${Pacientes.Paciente['Pace_Nome_SE']}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "${Pacientes.Paciente['Pace_NSS']} ${Pacientes.Paciente['Pace_AGRE']}",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,

                ),
              ),
              Text(
                "Edad: ${Pacientes.Paciente['Pace_Eda'].toString()} Años",
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
               SizedBox(
                height: 20,
                child: CrossLine(),
              ),
              Text(
                "Estado actual: ${Pacientes.Paciente['Pace_Stat']}",
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                "Turno de Atención: ${Pacientes.Paciente['Pace_Turo']}",
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ]));
  }
}

class PresentacionPacientesSimple extends StatefulWidget {
  const PresentacionPacientesSimple({super.key});

  @override
  State<PresentacionPacientesSimple> createState() =>
      _PresentacionPacientesSimpleState();
}

class _PresentacionPacientesSimpleState
    extends State<PresentacionPacientesSimple> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(6.0),
        child: GestureDetector(
          onTap: () {
            Operadores.openDialog(
              context: context,
              chyldrim: ImageDialog(
                tittle: Pacientes.nombreCompleto,
                stringImage: Valores.imagenUsuario,
              ), //Pacientes.Paciente['Pace_FIAT'],),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0),
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${Pacientes.Paciente['Pace_Ape_Pat']} ${Pacientes.Paciente['Pace_Ape_Mat']} \n"
                    "${Pacientes.Paciente['Pace_Nome_PI']} ${Pacientes.Paciente['Pace_Nome_SE']}",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "${Pacientes.Paciente['Pace_NSS']} ${Pacientes.Paciente['Pace_AGRE']}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "Edad: ${Pacientes.Paciente['Pace_Eda'].toString()} Años",
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: CrossLine(),
                  ),
                  Text(
                    "Estado actual: ${Pacientes.Paciente['Pace_Stat']}",
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "Turno de Atención: ${Pacientes.Paciente['Pace_Turo']}",
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
