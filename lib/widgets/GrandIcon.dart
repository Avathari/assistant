import 'package:assistant/values/SizingInfo.dart';
import 'package:flutter/material.dart';

class GrandIcon extends StatefulWidget {
  String? labelButton;
  double? weigth, heigth;
  var onPress;
  IconData? iconData;

  GrandIcon(
      {Key? key,
      this.labelButton = "message",
      this.weigth = 6,
        this.heigth = 6,
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
        icon: Icon(widget.iconData, color: Colors.grey,),
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.grey, backgroundColor: Colors.black54,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            minimumSize: Size(
                isMobileAndTablet(context) ? widget.weigth! : widget.weigth! * 10,
                isMobileAndTablet(context) ? widget.heigth! : widget.heigth! * 10)),
        onPressed: () {
          widget.onPress();
        },
        // child: Icon(widget.iconData),
      ),
    );
    ;
  }
}
