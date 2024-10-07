import 'package:assistant/values/WidgetValues.dart';

import 'package:flutter/material.dart';

class CircleLabel extends StatefulWidget {
  String? tittle;
  bool? isSwitched;
  double? radios, difRadios, fontSize;
  void Function()? onChangeValue;

  CircleLabel(
      {super.key,
      this.tittle,
      this.radios = 40,
        this.difRadios = 10,
        this.fontSize = 16,
      this.isSwitched = false,
      this.onChangeValue});

  @override
  State<CircleLabel> createState() => _CircleLabelState();
}

class _CircleLabelState extends State<CircleLabel> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChangeValue!(),
      onDoubleTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                backgroundColor: Theming.secondaryColor,
                content: SizedBox(
                  height: 100,
                  child: Container(
                    decoration: ContainerDecoration.roundedDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(widget.tittle!,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
      child: Tooltip(
        message: widget.tittle!,
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: widget.radios!,
          child: CircleAvatar(
            backgroundColor: Colors.black,
            radius: widget.radios! - widget.difRadios!,
            child: Text(
              widget.tittle!.length <= 4 ? widget.tittle! : "",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: widget.tittle!.length <= 3 ? widget.fontSize! : 9),
            ),
          ),
        ),
      ),
    );
  }
}
