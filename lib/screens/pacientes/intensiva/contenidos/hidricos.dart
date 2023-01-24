import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/widgets/ShowText.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/widgets.dart';

class Hidricos extends StatefulWidget {
  const Hidricos({Key? key}) : super(key: key);

  @override
  State<Hidricos> createState() => _HidricosState();
}

class _HidricosState extends State<Hidricos> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        TittlePanel(textPanel: 'Análisis Hídrico'),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                ShowText(title: 'Requerimiento Hídrico', data: Valores.requerimientoHidrico, medida: 'mL',),
                ShowText(title: 'Agua Corporal Total', data: Valores.aguaCorporalTotal, medida: 'mL',),
                ShowText(title: 'Déficit de Agua Corporal', data: Valores.deficitAguaCorporal, medida: 'mL',),
                ShowText(title: 'Exceso de Agua Libre', data: Valores.excesoAguaLibre, medida: 'mL',),
                ShowText(title: 'Osmolaridad Sérica', data: Valores.osmolaridadSerica, medida: 'Osm/mL',),
                ShowText(title: 'Brecha Osmolar', data: Valores.brechaOsmolar, medida: 'Osm/mL',),
                ShowText(title: 'Delta Sodio', data: Valores.DSO, medida: 'mEq/L',),
                ShowText(title: 'Sodio Corregido', data: Valores.sodioCorregidoGlucosa, medida: 'mEq/L',),

              ],
            ),
          ),
        ),
      ],
    ));
  }
}
