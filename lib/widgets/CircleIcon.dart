import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/GrandIcon.dart';

import 'package:flutter/material.dart';

class CircleIcon extends StatefulWidget {
  String? tittle;
  IconData? iconed;
  double? radios;
  Function? onChangeValue;

  CircleIcon(
      {Key? key,
      this.tittle = '',
      this.iconed = Icons.cable_rounded,
      this.radios = 40})
      : super(key: key);

  @override
  State<CircleIcon> createState() => _CircleIconState();
}

class _CircleIconState extends State<CircleIcon> {
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
            child: GrandIcon(
              iconData: widget.iconed!,
              onPress: () {
                // setState(() {
                //   widget.onChangeValue!(!widget.isSwitched!);
                //   widget.isSwitched = !widget.isSwitched!;
                // });
              },
            ),
          ),
        ),
      ),
    );
  }
}