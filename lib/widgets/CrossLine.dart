import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';

class CrossLine extends StatefulWidget {
  const CrossLine({super.key});

  @override
  State<CrossLine> createState() => _CrossLineState();
}

class _CrossLineState extends State<CrossLine> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.all(8.0),
        child: Divider(
          height: 2,
          thickness: 2,
          color: Colores.backgroundWidget,
        ));
  }
}
