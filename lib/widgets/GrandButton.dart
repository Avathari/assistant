import 'package:assistant/values/SizingInfo.dart';
import 'package:flutter/material.dart';

class GrandButton extends StatefulWidget {
  String? labelButton;
  double? weigth;
  void Function() onPress;

  GrandButton(
      {Key? key, this.labelButton, this.weigth = 0, required this.onPress})
      : super(key: key);

  @override
  State<GrandButton> createState() => _GrandButtonState();
}

class _GrandButtonState extends State<GrandButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isMobile(context)
          ? const EdgeInsets.all(4.0)
          : const EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.black54,
              onPrimary: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              minimumSize: Size(
                  widget.weigth != 0.0
                      ? widget.weigth!
                      : isMobileAndTablet(context)
                          ? 170
                          : 500,
                  60)),
          onPressed: () {
            widget.onPress();
          },
          child: Text(
            widget.labelButton!,
            textAlign: TextAlign.center,
          )),
    );
  }
}
