import 'package:assistant/screens/pacientes/patologicos/alergicos.dart';
import 'package:assistant/screens/pacientes/patologicos/epidemiologicos.dart';
import 'package:assistant/screens/pacientes/patologicos/patologicos.dart';
import 'package:assistant/screens/pacientes/patologicos/quirurgicos.dart';
import 'package:assistant/screens/pacientes/patologicos/toxicomanias.dart';
import 'package:assistant/screens/pacientes/patologicos/transfusionales.dart';
import 'package:assistant/screens/pacientes/patologicos/vacunales.dart';

import 'package:assistant/widgets/GridLayout.dart';
import 'package:assistant/widgets/MenuButton.dart';
import 'package:assistant/widgets/Tittle.dart';


import 'package:assistant/values/SizingInfo.dart';
import 'package:flutter/material.dart';


class MenuPersonales extends StatelessWidget {
  const MenuPersonales({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Tittle(
              tittle: "Antecedentes Personales del Paciente",
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridLayout(
                  childAspectRatio: isMobile(context)
                      ? 1.0
                      : isTablet(context)
                      ? 2.0
                      : 4.0,
                  columnCount: 2,
                  children: [
                    MenuButton(
                        iconData: Icons.family_restroom,
                        labelButton: "Antecedentes Heredofamiliares",
                        onPress: () {}),
                    MenuButton(
                        iconData: Icons.medication,
                        labelButton: "Antecedentes Personales Patológicos",
                        onPress: () {
                          toNextPage(context, GestionPatologicos());
                        }),
                    MenuButton(
                        iconData: Icons.person_pin,
                        labelButton: "Antecedentes Personales No Patológicos",
                        onPress: () {
                          toNextPage(context, GestionNoPatologicos());
                        }),
                    MenuButton(
                        iconData: Icons.draw_outlined,
                        labelButton: "Antecedentes Toxicomanos",
                        onPress: () {
                          toNextPage(context, const GestionToxicomanias());
                        }),
                    // MenuButton(
                    //     iconData: Icons.bloodtype,
                    //     labelButton: "Antecedentes Transfusionales",
                    //     onPress: () {
                    //       toNextPage(context, GestionTransfusionales());
                    //     }),
                    MenuButton(
                        iconData: Icons.medical_information_rounded,
                        labelButton: "Antecedentes Quirúrgicos",
                        onPress: () {
                          toNextPage(context, GestionQuirurgicos());
                        }),
                    // MenuButton(
                    //     iconData: Icons.vaccines,
                    //     labelButton: "Antecedentes Vacunales",
                    //     onPress: () {
                    //       toNextPage(context, GestionVacunales());
                    //     }),
                    // MenuButton(
                    //     iconData: Icons.medication_liquid,
                    //     labelButton: "Antecedentes Alérgicos",
                    //     onPress: () {
                    //       toNextPage(context, GestionAlergicos());
                    //     }),
                    MenuButton(
                        iconData: Icons.quiz,
                        labelButton: "Cuestionarios",
                        onPress: () {})
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  void toNextPage(BuildContext context, screen) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => screen)));
  }
}
