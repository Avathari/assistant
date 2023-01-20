import 'package:assistant/values/SizingInfo.dart';
import 'package:flutter/material.dart';

class GrandIcon extends StatefulWidget {
  String? labelButton;
  double? weigth;
  var onPress;
  IconData? iconData;

  GrandIcon(
      {Key? key,
      this.labelButton = "message",
      this.weigth = 6,
      this.iconData = Icons.wallet,
      required this.onPress})
      : super(key: key);

  @override
  State<GrandIcon> createState() => _GrandIconState();
}

class _GrandIconState extends State<GrandIcon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Tooltip(
        message: widget.labelButton!,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.black54,
              onPrimary: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              minimumSize: Size(
                  isMobileAndTablet(context) ? widget.weigth! : 60,
                  isMobileAndTablet(context) ? widget.weigth! : 60)),
          onPressed: () {
            widget.onPress();
          },
          child: Icon(widget.iconData),
        ),
      ),
    );
    ;
  }
}
