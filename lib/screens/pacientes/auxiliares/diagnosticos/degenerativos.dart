import 'package:assistant/conexiones/controladores/Pacientes.dart';

import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

class Degenerativos extends StatefulWidget {
  const Degenerativos({super.key});

  @override
  State<Degenerativos> createState() => _DegenerativosState();
}

class _DegenerativosState extends State<Degenerativos> {
  @override
  void initState() {
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
