import 'package:assistant/values/SizingInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GrandIcon extends StatefulWidget {
  String? labelButton;
  double? weigth, heigth, size;
  var onPress;
  void Function()? onLongPress;
  IconData? iconData;
  Color? iconColor;

  GrandIcon(
      {Key? key,
      this.labelButton = "message",
      this.weigth = 10,
      this.heigth = 10,
        this.size = 28,
      this.iconColor = Colors.grey,
      this.iconData = Icons.wallet,
      this.onLongPress,
      required this.onPress})
      : super(key: key);

  @override
  State<GrandIcon> createState() => _GrandIconState();
}

class _GrandIconState extends State<GrandIcon> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.labelButton!,
      child: GestureDetector(
        onLongPress: widget.onLongPress ?? () {
          SystemSound.play(SystemSoundType.alert);
        },
        onTap:  () {
          SystemSound.play(SystemSoundType.click);
          widget.onPress();
        },
        child: Icon(size: widget.size!, widget.iconData, color: widget.iconColor),
      ),
    );
    ;
  }
}
