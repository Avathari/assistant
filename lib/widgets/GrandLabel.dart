import 'package:assistant/values/SizingInfo.dart';
import 'package:flutter/material.dart';

class GrandLabel extends StatefulWidget {
  String? labelButton;
  double? weigth;
  var onPress;
  IconData? iconData;

  double? fontSized;

  GrandLabel(
      {Key? key,
      this.labelButton = "message",
      this.weigth = 6,
      this.fontSized = 8,
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
                  isMobile(context) ? widget.weigth! : widget.weigth! * 10,
                  isTablet(context)
                      ? widget.weigth! * 10
                      : isDesktop(context)
                          ? widget.weigth! * 10
                          : widget.weigth! * 10)),
          onPressed: () {
            widget.onPress();
          },
          child: Row(
            children: [
              Icon(widget.iconData),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                  child: Text(
                widget.labelButton!,
                style: TextStyle(
                    fontSize: widget.fontSized!,
                    overflow: TextOverflow.ellipsis),
              )),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
