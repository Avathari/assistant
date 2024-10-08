import 'package:assistant/screens/pacientes/paraclinicos/operadores/electrocardiograma.dart';
import 'package:assistant/screens/pacientes/paraclinicos/operadores/imagenologias.dart';
import 'package:assistant/screens/pacientes/paraclinicos/operadores/laboratorios.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/MenuButton.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

class Paraclinicos extends StatefulWidget {
  const Paraclinicos({super.key});

  @override
  State<Paraclinicos> createState() => _ParaclinicosState();
}

class _ParaclinicosState extends State<Paraclinicos> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(5.0),
            margin: const EdgeInsets.all(5.0),
            decoration: ContainerDecoration.roundedDecoration(colorBackground: Colors.black),
            child: TittlePanel(
              textPanel: 'Repositorio de Auxiliares Diagnósticos',
            )),
        Expanded(
          flex: 8,
          child: Container(
            // padding: const EdgeInsets.all(5.0),
            // margin: const EdgeInsets.all(5.0),
            decoration: ContainerDecoration.roundedDecoration(colorBackground: Colors.black),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: MenuButton(
                      iconData: Icons.hdr_weak_sharp,
                      labelButton: 'Getión de Laboratorios',
                      onPress: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const LaboratoriosGestion())));
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: MenuButton(
                      iconData: Icons.hdr_weak_sharp,
                      labelButton: 'Getión de Imagenológicos',
                      onPress: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) =>
                                const ImagenologiasGestion())));
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: MenuButton(
                      iconData: Icons.hdr_weak_sharp,
                      labelButton: 'Getión de Electrocardiogramas',
                      onPress: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) =>
                                const ElectrocardiogramasGestion())));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
