import 'dart:convert';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';

import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/ImageDialog.dart';
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
                chyldrim: ImageDialog(
                    tittle: Pacientes.nombreCompleto,
                    stringImage: Pacientes.Paciente['Pace_FIAT'],
                    ),
              );
            },
            child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 40,
                child: Pacientes.Paciente['Pace_FIAT'] != ""
                    ? ClipOval(
                        child: Image.memory(
                        base64Decode(Pacientes.Paciente['Pace_FIAT']),
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
              const SizedBox(
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
                  stringImage: Pacientes.Paciente['Pace_FIAT'],),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0),
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
                const SizedBox(
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
        ));
  }
}
