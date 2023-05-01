import 'package:assistant/values/SizingInfo.dart';
import 'package:flutter/material.dart';

class GrandIcon extends StatefulWidget {
  String? labelButton;
  double? weigth, heigth;
  var onPress;
  IconData? iconData;
  Color? iconColor;

  GrandIcon(
      {Key? key,
      this.labelButton = "message",
      this.weigth = 6,
      this.heigth = 6,
      this.iconColor = Colors.grey,
      this.iconData = Icons.wallet,
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
      child: IconButton(
        icon: Icon(widget.iconData, color: widget.iconColor),
        // style: ElevatedButton.styleFrom(
        //     foregroundColor: widget.iconColor == Colors.white ? Colors.white : Colors.grey,
        //     backgroundColor:  widget.iconColor == Colors.white ? Colors.grey : Colors.white,
        //     shape:
        //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        //     minimumSize: Size(
        //         isMobileAndTablet(context)
        //             ? widget.weigth!
        //             : widget.weigth! * 10,
        //         isMobileAndTablet(context)
        //             ? widget.heigth!
        //             : widget.heigth! * 10)),
        onPressed: () {
          widget.onPress();
        },
        // child: Icon(widget.iconData),
      ),
    );
    ;
  }
}
