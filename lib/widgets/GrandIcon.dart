import 'package:assistant/values/SizingInfo.dart';
import 'package:flutter/material.dart';

class GrandIcon extends StatefulWidget {
  String? labelButton;
  double? weigth, heigth;
  var onPress;
  void Function()? onLongPress;
  IconData? iconData;
  Color? iconColor;

  GrandIcon(
      {Key? key,
      this.labelButton = "message",
      this.weigth = 6,
      this.heigth = 6,
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
        onLongPress: widget.onLongPress ?? () {},
        onTap:  () {
          widget.onPress();
        },
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Icon(widget.iconData, color: widget.iconColor),
        ),
      ),
    );
    ;
  }
}
