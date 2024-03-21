import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';

class TittleContainer extends StatefulWidget {
  String? tittle;
  Widget? child;
  Color? color;
  bool? centered;
  double? padding;

  TittleContainer(
      {super.key,
      required this.child,
      this.tittle = "",
        this.padding = 0,
      this.centered = false,
      this.color = Theming.bdColor});

  @override
  State<TittleContainer> createState() => _TittleContainerState();
}

class _TittleContainerState extends State<TittleContainer> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          width: double.infinity,
          // height: double.infinity,
          margin: EdgeInsets.all(widget.padding! == 0? 10.0:widget.padding!),
          padding: EdgeInsets.only(left: widget.padding! == 0? 10 : widget.padding!, right: widget.padding!, top: 7, bottom: 5,),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(20),
            shape: BoxShape.rectangle,
          ),
          child: widget.child),
      Positioned(
        left: widget.centered == true ? 100 : 5,
        top: 0,
        child: Container(
          color: widget.color! != Theming.bdColor ? widget.color! : Theme.of(context).cardColor,// widget.color!,
          margin: const EdgeInsets.only(left: 10, right: 10, top: 2),
          padding: const EdgeInsets.only(left: 10, right: 10, top: 0),
          child: Text(widget.tittle!,
              style: TextStyle(color: Colors.white, fontSize: widget.centered == true ? 12: 10)),
        ),
      )
    ]);
  }
}
