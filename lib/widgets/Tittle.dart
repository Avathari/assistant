import 'package:assistant/widgets/RoundedPanel.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

class Tittle extends StatefulWidget {
  String? tittle;
  Tittle({super.key, this.tittle = ''});

  @override
  State<Tittle> createState() => _TittleState();
}

class _TittleState extends State<Tittle> {
  @override
  Widget build(BuildContext context) {
    return  RoundedPanel(
      child: TittlePanel(textPanel: widget.tittle),
    );
  }
}
