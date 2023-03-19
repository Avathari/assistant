import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:flutter/material.dart';

class ValuePanel extends StatefulWidget {
  String? firstText;
  String? secondText;
  String? thirdText;
  double padding, fontSize;

  bool? withEditMessage, withBorder;
  final ValueChanged<String>? onEdit;

  ValuePanel({
    Key? key,
    this.firstText = "",
    this.secondText = "",
    this.thirdText = "",
    this.padding = 2.0,
    this.fontSize = 12,
    this.withEditMessage = false,
    this.withBorder = true, // false,
    this.onEdit,
  }) : super(key: key);

  @override
  State<ValuePanel> createState() => _ValuePanelState();
}

class _ValuePanelState extends State<ValuePanel> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        widget.onEdit!(widget.secondText!);
      },
      child: Container(
        decoration: widget.withBorder == true
            ? ContainerDecoration.roundedDecoration()
            : null,
        padding: EdgeInsets.all(widget.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.firstText!,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                )),
            Text(
              widget.secondText!,
              style: TextStyle(
                fontSize: widget.fontSize - 2,
                color: Colors.grey,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.left,
            ),
            Text(widget.thirdText!,
                style: TextStyle(
                  fontSize: widget.fontSize - 4,
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.normal,
                )),
          ],
        ),
      ),
    );
  }
}
