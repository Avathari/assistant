import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/GrandIcon.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CircleSwitched extends StatefulWidget {
  String? tittle;
  bool? isSwitched;
  double? radios, difRadios;
  Function? onChangeValue;

  CircleSwitched(
      {super.key,
      this.tittle,
      this.radios = 40,
        this.difRadios = 10,
      this.isSwitched = false,
      required this.onChangeValue});

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
        onTap: () {
          widget.onChangeValue!(widget.isSwitched );
        },
        onDoubleTap: () {
          SystemSound.play(SystemSoundType.click);
          SystemSound.play(SystemSoundType.click);
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
            radius: widget.radios! - widget.difRadios!,
            child: GrandIcon(
              size: 30 - widget.difRadios!,
              labelButton:  widget.tittle!,
              iconData: widget.isSwitched == true
                  ? Icons.check
                  : Icons.not_interested,
              onPress: () {
                SystemSound.play(SystemSoundType.click);
                setState(() {
                  widget.onChangeValue!(widget.isSwitched );
                  // widget.isSwitched = !widget.isSwitched!;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
