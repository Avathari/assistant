import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';

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
/*    Terminal.printWarning(
        message: " . . . Iniciando Actividad - Antecedentes Degenerativos");*/
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        Pacientes.Diagnosticos = value;
        // Terminal.printSuccess(
        //     message: "Diagnósticos de la hospitalizacion del paciente . . . ");
      });
    }).onError((error, stackTrace) {
      // Terminal.printAlert(
      //     message: "Iniciando actividad : : \n "
      //         "Consulta de Antecedentes Degenerativos . . .");
      Actividades.consultarAllById(
          Databases.siteground_database_reghosp,
          Diagnosticos.diagnosticos['consultByIdPrimaryQuery'],
          Pacientes.ID_Paciente)
          .then((value) {
        setState(() {
          // Terminal.printSuccess(
          //     message: "Actualizando Diagnósticos de la hospitalizacion del paciente . . . ");
          Pacientes.Diagnosticos = value;
          Archivos.createJsonFromMap(Pacientes.Diagnosticos!, filePath: fileAssocieted);
        });
      });
    });
    // Terminal.printWarning(message: " . . . Actividad Iniciada");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TittlePanel(padding: 5, textPanel: 'Diagnóstico(s) en la Hospitalización', fontSize: 11),
        Expanded(
            flex: 3,
            child: ListView.separated(
                controller: ScrollController(),
                itemBuilder: ((context, index) {
                  return ListTile(
                    isThreeLine: false,
                    onTap: () {
                      Operadores.openWindow(
                          context: context,
                          chyldrim: Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.all(8.0),
                            decoration: ContainerDecoration.roundedDecoration(),
                            child: Column(
                              children: [
                                TittlePanel(
                                    textPanel:
                                    "${Pacientes.Diagnosticos![index]['Pace_APP_DEG']}"),
                                const SizedBox(height: 20,),
                                Text(
                                  Pacientes.Diagnosticos![index]
                                  ['Pace_APP_DEG_com'],
                                  style: Styles.textSyleGrowth(fontSize: isDesktop(context) ? 10: 16),
                                  maxLines: 5,
                                ),
                                Text(
                                  "Diagnósticado hace ${Pacientes.Diagnosticos![index]['Pace_APP_DEG_dia']} años",
                                  style: Styles.textSyleGrowth(fontSize: 14),
                                ),
                                CrossLine(height: 20,),
                                const SizedBox(height: 20,),
                                Text(
                                  Pacientes.Diagnosticos![index]
                                  ['Pace_APP_DEG_tra'],
                                  maxLines: 10,
                                  style: Styles.textSyleGrowth(fontSize: isDesktop(context) ? 8: 14),
                                ),
                                Text(
                                  Pacientes.Diagnosticos![index]
                                  ['Pace_APP_DEG_sus'],
                                  maxLines: 10,
                                  style: Styles.textSyleGrowth(),
                                ),
                              ],
                            ),
                          ));
                    },
                    title: Text(
                      Pacientes.Diagnosticos![index]['Pace_APP_DEG'],
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: isDesktop(context) ? 10: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      Pacientes.Diagnosticos![index]['Pace_APP_DEG_com'],
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: isDesktop(context) ? 8: 12,
                      ),
                    ),
                  );
                }),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 0
                ),
                itemCount: Pacientes.Diagnosticos!.length))
      ],
    );
  }
}
