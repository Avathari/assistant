import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/conexiones/controladores/Pacientes.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/antropometricos.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/balancesHidrico.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/basico.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/cardiovasculares.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/gasometricos.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/hidricos.dart';
import 'package:assistant/screens/pacientes/intensiva/analisis/ventilatorios.dart';
import 'package:assistant/screens/pacientes/intensiva/contenidos/concentraciones.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:flutter/material.dart';

class AnalisisLaterales extends StatefulWidget {
  int actualLateralPage;

  AnalisisLaterales({super.key, this.actualLateralPage = 7});

  @override
  State<AnalisisLaterales> createState() => _AnalisisLateralesState();
}

class _AnalisisLateralesState extends State<AnalisisLaterales> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 8,
          child: widget.actualLateralPage == 0
              ?  const Concentraciones()
              : widget.actualLateralPage == 1
              ? Hidricos(isLateral: true)
              : widget.actualLateralPage == 2
              ? const Ventilatorios()
              : widget.actualLateralPage == 3
              ? const Gasometricos()
              : widget.actualLateralPage == 4
              ? Cardiovasculares()
              : widget.actualLateralPage == 5
              ? const Antropometricos()
              : widget.actualLateralPage == 6
              ? const BalanceHidrico()
              : const Basico(),
        ),
        // CrossLine(color:Colors.grey),
        Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GrandIcon(
                    labelButton: 'Concentraciones',
                    iconData: Icons.menu_rounded,
                    onPress: () => setState(() {
                      widget.actualLateralPage = 0;
                    })),
                GrandIcon(
                    labelButton: "Hídricos",
                    iconData: Icons.water_drop,
                    onPress: () => setState(() {
                      widget.actualLateralPage = 1;
                    })),
                GrandIcon(
                    labelButton: "Ventilatorios",
                    iconData: Icons.air,
                    onPress: () => setState(() {
                      widget.actualLateralPage = 2;
                    })),
                GrandIcon(
                    labelButton: "Gasométricos",
                    onPress: () => setState(() {
                      widget.actualLateralPage = 3;
                    })),
                GrandIcon(
                    labelButton: "Cardiovasculares",
                    iconData: Icons.monitor_heart_outlined,
                    onPress: () => setState(() {
                      widget.actualLateralPage = 4;
                    })),
                GrandIcon(
                    labelButton: "Antropometrías",
                    iconData: Icons.monitor_weight_outlined,
                    onPress: () => setState(() {
                      widget.actualLateralPage = 5;
                    })),
                GrandIcon(
                    labelButton: "Balances",
                    iconData: Icons.waterfall_chart,
                    onPress: () => setState(() {
                      widget.actualLateralPage = 6;
                    })),
                GrandIcon(
                    labelButton: " . . . ",
                    iconData: Icons.account_balance_outlined,
                    onPress: () => setState(() {
                      widget.actualLateralPage = 7;
                    })),
              ],
            )),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GrandIcon(
                iconData: Icons.checklist_rtl,
                labelButton: "Laboratorios",
                onPress: () {
                  Operadores.selectOptionsActivity(
                    context: context,
                    tittle: "Elija la fecha de los estudios . . . ",
                    options: Listas.listWithoutRepitedValues(
                      Listas.listFromMapWithOneKey(
                        Pacientes.Paraclinicos!,
                        keySearched: 'Fecha_Registro',
                      ),
                    ),
                    onClose: (value) {
                      setState(() {
                        Datos.portapapeles(
                            context: context,
                            text: Auxiliares.porFecha(fechaActual: value));
                        Navigator.of(context).pop();
                      });
                    },
                  );
                },
              ),
              GrandIcon(
                iconData: Icons.list_alt_sharp,
                labelButton: "Laboratorios",
                onPress: () {
                  Datos.portapapeles(
                      context: context, text: Auxiliares.historial());
                },
                onLongPress: () {
                  Datos.portapapeles(
                      context: context,
                      text: Auxiliares.historial(esAbreviado: true));
                },
              ),
              GrandIcon(
                iconData: Icons.line_style,
                labelButton: "Laboratorios",
                onPress: () {
                  Datos.portapapeles(
                      context: context, text: Auxiliares.getUltimo());
                },
                onLongPress: () {
                  Datos.portapapeles(
                      context: context,
                      text: Auxiliares.getUltimo(esAbreviado: true));
                },
              ),
              GrandIcon(
                iconData: Icons.linear_scale_rounded,
                labelButton: "Actual e Historial",
                onPress: () {
                  Datos.portapapeles(
                      context: context,
                      text: Auxiliares.getUltimo(withoutInsighs: true));
                },
                onLongPress: () {
                  Datos.portapapeles(
                      context: context,
                      text: Auxiliares.historial(withoutInsighs: true));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }


}

_analisisLaterales(BuildContext context) {

}