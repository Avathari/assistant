import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/GrandIcon.dart';

import 'package:flutter/material.dart';

class CircleLabel extends StatefulWidget {
  String? tittle;
  bool? isSwitched;
  double? radios;
  Function? onChangeValue;

  CircleLabel(
      {Key? key,
      this.tittle,
      this.radios = 40,
      this.isSwitched = false})
      : super(key: key);

  @override
  State<CircleLabel> createState() => _CircleLabelState();
}

class _CircleLabelState extends State<CircleLabel> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            radius: widget.radios! - 10,
            child: Text(
              widget.tittle!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
