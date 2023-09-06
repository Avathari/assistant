import 'package:flutter/material.dart';

class AppBarText extends StatefulWidget {

  String? text;

  AppBarText(this.text, {Key? key}) : super(key: key);

  @override
  State<AppBarText> createState() => _AppBarTextState();
}

class _AppBarTextState extends State<AppBarText> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text!,
      style: const TextStyle(color:Colors.white, fontSize: 14));
  }
}
