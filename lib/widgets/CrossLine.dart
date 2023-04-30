import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';

class CrossLine extends StatefulWidget {
  Color? color;
  double? height, thickness;
  bool? isHorizontal;

  CrossLine({super.key, this.color = Colores.backgroundWidget, this.thickness = 2, this.isHorizontal = true, this.height = 2});

  @override
  State<CrossLine> createState() => _CrossLineState();
}

class _CrossLineState extends State<CrossLine> {
  @override
  Widget build(BuildContext context) {
    if (widget.isHorizontal!) {
      return  Padding(
          padding: isMobile(context) ? const EdgeInsets.all(4.0) : const EdgeInsets.all(8.0),
          child: Divider(
            height: widget.height,
            thickness: widget.thickness,
            color: widget.color!,
          ));
    } else {
      return  Padding(
          padding: isMobile(context) ? const EdgeInsets.all(4.0) : const EdgeInsets.all(8.0),
          child: VerticalDivider(
            width: widget.height,
            thickness: widget.thickness,
            color: widget.color!,
          ));
    }
  }
}
