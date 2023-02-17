import 'package:assistant/conexiones/controladores/Pacientes.dart';

import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

class Diagnosticos extends StatefulWidget {
  const Diagnosticos({super.key});

  @override
  State<Diagnosticos> createState() => _DiagnosticosState();
}

class _DiagnosticosState extends State<Diagnosticos> {
  @override
  void initState() {
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
