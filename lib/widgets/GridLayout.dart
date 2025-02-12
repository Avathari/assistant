import 'package:assistant/values/SizingInfo.dart';
import 'package:flutter/material.dart';

class GridLayout extends StatefulWidget {
  int? columnCount;
  double? childAspectRatio, crossAxisSpacing, mainAxisSpacing;
  List<Widget> children;

  GridLayout(
      {super.key,
      this.columnCount = 0,
      this.childAspectRatio = 0,
        this.crossAxisSpacing = 10.0,
        this.mainAxisSpacing = 10.0,
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
            : isTablet(context)
                ? (widget.columnCount! / widget.columnCount!) + 0.9
                : isMobile(context)
                    ? (widget.columnCount! / widget.columnCount!) + 0.9
                    : widget.columnCount! != 0
                        ? (widget.columnCount! / widget.columnCount!) + 0.9
                        : 2.0,
        crossAxisCount: widget.columnCount! != 0
            ? widget.columnCount!
            : isMobile(context)
                ? 1
                //? widget.columnCount! >= 2
                //  ? widget.columnCount! ~/ 2
                //  : 2
                : widget.columnCount!,
        crossAxisSpacing: widget.crossAxisSpacing!,
        mainAxisSpacing: widget.mainAxisSpacing!,
        shrinkWrap: true,
        children: widget.children);
  }
}
