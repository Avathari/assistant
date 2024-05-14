import 'package:assistant/screens/pacientes/intensiva/analisis/ventilatorios.dart';

import 'package:flutter/material.dart';

class AnalisisVentilatorio extends StatefulWidget {
  const AnalisisVentilatorio({Key? key}) : super(key: key);

  @override
  State<AnalisisVentilatorio> createState() => _AnalisisVentilatorioState();
}

class _AnalisisVentilatorioState extends State<AnalisisVentilatorio> {
  @override
  Widget build(BuildContext context) {
    return Ventilatorios();
  }
}
