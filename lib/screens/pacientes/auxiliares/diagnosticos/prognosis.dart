import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:flutter/material.dart';

class Prognosis extends StatefulWidget {
  const Prognosis({super.key});

  @override
  State<Prognosis> createState() => _PrognosisState();
}

class _PrognosisState extends State<Prognosis> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            // onTap: () {
            //   Operadores.openWindow(
            //       context: context,
            //       chyldrim: Container(
            //         padding: const EdgeInsets.all(8.0),
            //         margin: const EdgeInsets.all(8.0),
            //         decoration: ContainerDecoration.roundedDecoration(),
            //         child: Column(
            //           children: [
            //             TittlePanel(
            //                 textPanel:
            //                 "${Pacientes.Patologicos![index]['Pace_APP_DEG']}"),
            //             const SizedBox(height: 20,),
            //             Text(
            //               Pacientes.Patologicos![index]
            //               ['Pace_APP_DEG_com'],
            //               style: Styles.textSyleGrowth(fontSize: 14),
            //             ),
            //             Text(
            //               "Diagnósticado hace ${Pacientes.Patologicos![index]['Pace_APP_DEG_dia']} años",
            //               style: Styles.textSyleGrowth(fontSize: 12),
            //             ),
            //             CrossLine(height: 20,),
            //             const SizedBox(height: 20,),
            //             Text(
            //               Pacientes.Patologicos![index]
            //               ['Pace_APP_DEG_tra'],
            //               maxLines: 10,
            //               style: Styles.textSyleGrowth(),
            //             ),
            //             Text(
            //               Pacientes.Patologicos![index]
            //               ['Pace_APP_DEG_sus'],
            //               maxLines: 10,
            //               style: Styles.textSyleGrowth(),
            //             ),
            //           ],
            //         ),
            //       ));
            // },
            isThreeLine: false,
            title: Text(
              "mSOFA",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.grey,
                fontSize: isDesktop(context) || isMobile(context) ? 10 : 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              Valorados.mSOFA,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.grey,
                fontSize: isDesktop(context) || isMobile(context) ? 8 : 12,
              ),
            ),
          ),
          ListTile(
            // onTap: () {
            //   Operadores.openWindow(
            //       context: context,
            //       chyldrim: Container(
            //         padding: const EdgeInsets.all(8.0),
            //         margin: const EdgeInsets.all(8.0),
            //         decoration: ContainerDecoration.roundedDecoration(),
            //         child: Column(
            //           children: [
            //             TittlePanel(
            //                 textPanel:
            //                 "${Pacientes.Patologicos![index]['Pace_APP_DEG']}"),
            //             const SizedBox(height: 20,),
            //             Text(
            //               Pacientes.Patologicos![index]
            //               ['Pace_APP_DEG_com'],
            //               style: Styles.textSyleGrowth(fontSize: 14),
            //             ),
            //             Text(
            //               "Diagnósticado hace ${Pacientes.Patologicos![index]['Pace_APP_DEG_dia']} años",
            //               style: Styles.textSyleGrowth(fontSize: 12),
            //             ),
            //             CrossLine(height: 20,),
            //             const SizedBox(height: 20,),
            //             Text(
            //               Pacientes.Patologicos![index]
            //               ['Pace_APP_DEG_tra'],
            //               maxLines: 10,
            //               style: Styles.textSyleGrowth(),
            //             ),
            //             Text(
            //               Pacientes.Patologicos![index]
            //               ['Pace_APP_DEG_sus'],
            //               maxLines: 10,
            //               style: Styles.textSyleGrowth(),
            //             ),
            //           ],
            //         ),
            //       ));
            // },
            isThreeLine: false,
            title: Text(
              "mAPACHE",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.grey,
                fontSize: isDesktop(context) || isMobile(context) ? 10 : 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              Valorados.mAPACHE,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.grey,
                fontSize: isDesktop(context) || isMobile(context) ? 8 : 12,
              ),
            ),
          ),
          ListTile(
            // onTap: () {
            //   Operadores.openWindow(
            //       context: context,
            //       chyldrim: Container(
            //         padding: const EdgeInsets.all(8.0),
            //         margin: const EdgeInsets.all(8.0),
            //         decoration: ContainerDecoration.roundedDecoration(),
            //         child: Column(
            //           children: [
            //             TittlePanel(
            //                 textPanel:
            //                 "${Pacientes.Patologicos![index]['Pace_APP_DEG']}"),
            //             const SizedBox(height: 20,),
            //             Text(
            //               Pacientes.Patologicos![index]
            //               ['Pace_APP_DEG_com'],
            //               style: Styles.textSyleGrowth(fontSize: 14),
            //             ),
            //             Text(
            //               "Diagnósticado hace ${Pacientes.Patologicos![index]['Pace_APP_DEG_dia']} años",
            //               style: Styles.textSyleGrowth(fontSize: 12),
            //             ),
            //             CrossLine(height: 20,),
            //             const SizedBox(height: 20,),
            //             Text(
            //               Pacientes.Patologicos![index]
            //               ['Pace_APP_DEG_tra'],
            //               maxLines: 10,
            //               style: Styles.textSyleGrowth(),
            //             ),
            //             Text(
            //               Pacientes.Patologicos![index]
            //               ['Pace_APP_DEG_sus'],
            //               maxLines: 10,
            //               style: Styles.textSyleGrowth(),
            //             ),
            //           ],
            //         ),
            //       ));
            // },
            isThreeLine: false,
            title: Text(
              "Nutri Score",
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.grey,
                fontSize: isDesktop(context) || isMobile(context) ? 10 : 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              Valorados.mNutriScore,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Colors.grey,
                fontSize: isDesktop(context) || isMobile(context) ? 8 : 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
