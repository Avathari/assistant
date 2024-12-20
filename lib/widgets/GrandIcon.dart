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
      {super.key,
      this.labelButton = "message",
      this.weigth = 15,
      this.heigth = 15,
        this.size = 32, // 28
      this.iconColor = Colors.grey,
      this.iconData = Icons.wallet,
      this.onLongPress,
      required this.onPress});

  @override
  State<GrandIcon> createState() => _GrandIconState();
}

class _GrandIconState extends State<GrandIcon> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.labelButton!,
      // height: widget.heigth,
      child: GestureDetector(
        onLongPress: widget.onLongPress ?? () {

          SystemSound.play(SystemSoundType.alert);
        },
        onTap:  () {
          SystemSound.play(SystemSoundType.click);
          widget.onPress!();
        },
        child: Icon(size: widget.size!, widget.iconData, color: widget.iconColor),
      ),
    );
  }
}
