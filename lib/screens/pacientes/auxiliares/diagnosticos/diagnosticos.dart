import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';

import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

class Diagnosis extends StatefulWidget {
  const Diagnosis({super.key});

  @override
  State<Diagnosis> createState() => _DiagnosisState();
}

class _DiagnosisState extends State<Diagnosis> {

  var fileAssocieted = Diagnosticos.fileAssocieted;

  @override
  void initState() {
    Terminal.printWarning(
        message: " . . . Iniciando Actividad - Antecedentes Degenerativos");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        Pacientes.Diagnosticos = value;
        Terminal.printSuccess(
            message: "Diagnósticos de la hospitalizacion del paciente . . . ");
      });
    }).onError((error, stackTrace) {
      Terminal.printAlert(
          message: "Iniciando actividad : : \n "
              "Consulta de Antecedentes Degenerativos . . .");
      Actividades.consultarAllById(
          Databases.siteground_database_reghosp,
          Diagnosticos.diagnosticos['consultByIdPrimaryQuery'],
          Pacientes.ID_Paciente)
          .then((value) {
        setState(() {
          Terminal.printSuccess(
              message: "Actualizando Diagnósticos de la hospitalizacion del paciente . . . ");
          Pacientes.Diagnosticos = value;
          Archivos.createJsonFromMap(Pacientes.Diagnosticos!, filePath: fileAssocieted);
        });
      });
    });
    Terminal.printWarning(message: " . . . Actividad Iniciada");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(padding: 5, textPanel: 'Diagnóstico(s) en la Hospitalización'),
        Expanded(
            flex: 3,
            child: ListView.separated(
                controller: ScrollController(),
                itemBuilder: ((context, index) {
                  return ListTile(
                    isThreeLine: false,
                    title: Text(
                      Pacientes.Diagnosticos![index]['Pace_APP_DEG'],
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      Pacientes.Diagnosticos![index]['Pace_APP_DEG_com'],
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  );
                }),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 0,
                ),
                itemCount: Pacientes.Diagnosticos!.length))
      ],
    );
  }
}
