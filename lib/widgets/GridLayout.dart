import 'package:assistant/values/SizingInfo.dart';
import 'package:flutter/material.dart';

class GridLayout extends StatefulWidget {
  int? columnCount;
  double? childAspectRatio;
  List<Widget> children;

  GridLayout(
      {super.key,
      this.columnCount = 0,
      this.childAspectRatio = 0,
      required this.children});

  @override
  State<GridLayout> createState() => _GridLayoutState();
}

class _GridLayoutState extends State<GridLayout> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        controller: ScrollController(),
        childAspectRatio: widget.childAspectRatio! != 0
            ? widget.childAspectRatio!
            : isMobile(context)
                ? (widget.columnCount! / widget.columnCount!) + 0.8
                : widget.columnCount! != 0
                    ? (widget.columnCount! / widget.columnCount!) + 0.5
                    : 2.0, // La mitad del columCount -0.5
        crossAxisCount: isMobile(context)
            ? 2
            //? widget.columnCount! >= 2
            //  ? widget.columnCount! ~/ 2
            //  : 2
            : widget.columnCount!,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        shrinkWrap: true,
        children: widget.children);
  }
}
