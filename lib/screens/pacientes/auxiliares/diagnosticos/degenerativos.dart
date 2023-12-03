import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/conexiones.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';

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
    // Terminal.printWarning(
    //     message: " . . . Iniciando Actividad - Antecedentes Degenerativos");
    Archivos.readJsonToMap(filePath: fileAssocieted).then((value) {
      setState(() {
        Pacientes.Patologicos = value;
      });
    }).onError((error, stackTrace) {
      // Terminal.printAlert(
      //     message: "Iniciando actividad : : \n "
      //         "Consulta de Antecedentes Degenerativos . . .");
      Actividades.consultarAllById(
              Databases.siteground_database_regpace,
              Patologicos.patologicos['consultByIdPrimaryQuery'],
              Pacientes.ID_Paciente)
          .then((value) {
        setState(() {
          // Terminal.printSuccess(
          //     message:
          //         "Actualizando Antecedentes Degenerativos del paciente . . . ");
          Pacientes.Patologicos = value;
          Archivos.createJsonFromMap(Pacientes.Patologicos!,
              filePath: fileAssocieted);
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
        TittlePanel(padding: 5, textPanel: 'Diagnóstico(s)', fontSize: 11),
        Expanded(
            flex: 3,
            child: ListView.separated(
                controller: ScrollController(),
                itemBuilder: ((context, index) {
                  return ListTile(
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
                                        "${Pacientes.Patologicos![index]['Pace_APP_DEG']}"),
                                const SizedBox(height: 20,),
                                Text(
                                  Pacientes.Patologicos![index]
                                      ['Pace_APP_DEG_com'],
                                  style: Styles.textSyleGrowth(fontSize: 14),
                                ),
                                Text(
                                  "Diagnósticado hace ${Pacientes.Patologicos![index]['Pace_APP_DEG_dia']} años",
                                  style: Styles.textSyleGrowth(fontSize: 12),
                                ),
                                CrossLine(height: 20,),
                                const SizedBox(height: 20,),
                                Text(
                                  Pacientes.Patologicos![index]
                                      ['Pace_APP_DEG_tra'],
                                  maxLines: 10,
                                  style: Styles.textSyleGrowth(),
                                ),
                                Text(
                                  Pacientes.Patologicos![index]
                                      ['Pace_APP_DEG_sus'],
                                  maxLines: 10,
                                  style: Styles.textSyleGrowth(),
                                ),
                              ],
                            ),
                          ));
                    },
                    isThreeLine: false,
                    title: Text(
                      Pacientes.Patologicos![index]['Pace_APP_DEG'],
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: isDesktop(context) || isMobile(context) ? 10 : 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      Pacientes.Patologicos![index]['Pace_APP_DEG_com'],
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: isDesktop(context) || isMobile(context) ? 8 : 12,
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
