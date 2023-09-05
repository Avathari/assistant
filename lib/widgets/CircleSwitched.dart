import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/GrandIcon.dart';

import 'package:flutter/material.dart';

class CircleSwitched extends StatefulWidget {
  String? tittle;
  bool? isSwitched;
  double? radios;
  Function? onChangeValue;

  CircleSwitched(
      {Key? key,
      this.tittle,
      this.radios = 40,
      this.isSwitched = false,
      required this.onChangeValue})
      : super(key: key);

  @override
  State<CircleSwitched> createState() => _CircleSwitchedState();
}

class _CircleSwitchedState extends State<CircleSwitched> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tittle!,
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
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
        child: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: widget.radios!,
          child: CircleAvatar(
            backgroundColor: Colors.black,
            radius: widget.radios! - 10,
            child: GrandIcon(
              labelButton:  widget.tittle!,
              iconData: widget.isSwitched == true
                  ? Icons.check
                  : Icons.not_interested,
              onPress: () {
                setState(() {
                  widget.onChangeValue!(!widget.isSwitched!);
                  widget.isSwitched = !widget.isSwitched!;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
