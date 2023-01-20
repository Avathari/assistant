import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoundedPanel extends StatefulWidget {
  Widget? child;
  double? padding;
  double? width, heigth, radius;

  RoundedPanel(
      {super.key,
      this.child,
      this.padding = 8.0,
      this.radius = 20.0,
      this.width,
      this.heigth});

  @override
  State<RoundedPanel> createState() => _RoundedPanelState();
}

class _RoundedPanelState extends State<RoundedPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(widget.padding!),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(widget.radius!))),
      child: widget.child,
    );
  }
}
