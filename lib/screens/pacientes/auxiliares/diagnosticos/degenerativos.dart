import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';

import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

class Degenerativos extends StatefulWidget {
  const Degenerativos({super.key});

  @override
  State<Degenerativos> createState() => _DegenerativosState();
}

class _DegenerativosState extends State<Degenerativos> {

  var fileAssocieted = Patologicos.fileAssocieted;
  
  @override
  void initState() {
    Terminal.printWarning(
        message: " . . . Iniciando Actividad - Antecedentes Degenerativos");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        Pacientes.Patologicos = value;
      });
    }).onError((error, stackTrace) {
      Terminal.printAlert(
          message: "Iniciando actividad : : \n "
              "Consulta de Antecedentes Degenerativos . . .");
      Actividades.consultarAllById(
          Databases.siteground_database_regpace,
          Patologicos.patologicos['consultByIdPrimaryQuery'],
          Pacientes.ID_Paciente)
          .then((value) {
        setState(() {
          Terminal.printSuccess(
              message: "Actualizando Antecedentes Degenerativos del paciente . . . ");
          Pacientes.Patologicos = value;
          Archivos.createJsonFromMap(Pacientes.Patologicos!, filePath: fileAssocieted);
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
        TittlePanel(padding: 5, textPanel: 'Diagnóstico(s)'),
        Expanded(
            flex: 3,
            child: ListView.separated(
                controller: ScrollController(),
                itemBuilder: ((context, index) {
                  return ListTile(
                    isThreeLine: false,
                    title: Text(
                      Pacientes.Patologicos![index]['Pace_APP_DEG'],
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      Pacientes.Patologicos![index]['Pace_APP_DEG_com'],
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
                itemCount: Pacientes.Patologicos!.length))
      ],
    );
  }
}
