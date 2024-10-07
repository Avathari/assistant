import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/semiologia/semiotica.dart';
import 'package:assistant/widgets/TittleContainer.dart';
import 'package:assistant/widgets/ValuePanel.dart';
import 'package:flutter/material.dart';

class Infusiones extends StatefulWidget {
  const Infusiones({super.key});

  @override
  State<Infusiones> createState() => _InfusionesState();
}

class _InfusionesState extends State<Infusiones> {
  @override
  Widget build(BuildContext context) {
    return TittleContainer(
      padding: 5.0,
      tittle: 'Infusiones',
      child: Column(
        children: [
          Expanded(
            child: ValuePanel(
                heigth: 60,
                firstText: 'Noradrenalina',
                secondText:
                Vasoactivos.getNoradrenalina().toStringAsFixed(2) +
                    " mcg/Kg/min",
                withEditMessage: true,
                onEdit: (value) {
                  Operadores.editActivity(
                      context: context,
                      tittle: "Editar . . . ",
                      message: "¿Noradrenalina (mL/Hr)? . . . ",
                      onAcept: (value) {
                        // Terminal.printSuccess(
                        //     message:
                        //         "recieve $value");
                        setState(() {
                          Vasoactivos.noradrenalina = double.parse(value);
                          Navigator.of(context).pop();
                        });
                      });
                }),
          ),
          Expanded(
            child: ValuePanel(
              heigth: 60,
              firstText: 'Midazolam',
            ),
          ),
          Expanded(
            child: ValuePanel(
              heigth: 60,
              firstText: 'Buprenorfina',
            ),
          ),
        ],
      ),
    );
  }
}
