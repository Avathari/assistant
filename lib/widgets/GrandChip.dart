import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GrandChip extends StatefulWidget {
  String? labelButton;
  double? weigth, height;
  void Function() onPress;
  final VoidCallback? onLongPress;

  double? fontSize;

  GrandChip({
    Key? key,
    this.labelButton,
    this.weigth = 0,
    this.height = 0,
    this.fontSize = 10.0,
    this.onLongPress,
    required this.onPress,
  }) : super(key: key);

  @override
  State<GrandChip> createState() => _GrandChipState();
}

class _GrandChipState extends State<GrandChip> {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.grey,
      radius: 25,
      child: CircleAvatar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.grey,
          radius: 20,
        child: Tooltip(message: widget.labelButton!,
            child: Icon(
              Icons.add
            )),
      ),
    );
    //   child: InputChip(
    //       onPressed: () {
    //         SystemSound.play(SystemSoundType.click);
    //         widget.onPress();
    //       },
    //       label: Text(
    //         widget.labelButton!,
    //         textAlign: TextAlign.center,
    //         style: TextStyle(fontSize: widget.fontSize, color: Colors.grey),
    //       ),
    //     selectedColor: Colors.grey,
    //     disabledColor: Colors.black,
    //     checkmarkColor: Colors.grey,
    //     backgroundColor: Colors.black,),
    // );
  }
}
