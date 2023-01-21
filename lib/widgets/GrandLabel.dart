import 'package:assistant/values/SizingInfo.dart';
import 'package:flutter/material.dart';

class GrandLabel extends StatefulWidget {
  String? labelButton;
  double? weigth;
  var onPress;
  IconData? iconData;

  GrandLabel(
      {Key? key,
      this.labelButton = "message",
      this.weigth = 6,
      this.iconData = Icons.wallet,
      required this.onPress})
      : super(key: key);

  @override
  State<GrandLabel> createState() => _GrandLabelState();
}

class _GrandLabelState extends State<GrandLabel> {
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
                  isMobileAndTablet(context)
                      ? widget.weigth!
                      : widget.weigth! * 10,
                  isMobileAndTablet(context)
                      ? widget.weigth!
                      : widget.weigth! * 10)),
          onPressed: () {
            widget.onPress();
          },
          child: Row(
            children: [
              Icon(widget.iconData),
              const SizedBox(width: 4 ,),
              Expanded(
                  child: Text(
                widget.labelButton!,
                style: const TextStyle(
                    fontSize: 8, overflow: TextOverflow.ellipsis),
              )),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
