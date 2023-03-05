import 'package:assistant/values/SizingInfo.dart';
import 'package:flutter/material.dart';

class GrandLabel extends StatefulWidget {
  String? labelButton;
  double? weigth, height;
  var onPress;
  IconData? iconData;

  double? fontSized;

  GrandLabel(
      {Key? key,
      this.labelButton = "message",
      this.weigth,
      this.height,
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            minimumSize: Size(
              widget.weigth != null
                  ? widget.weigth!
                  : isMobile(context)
                      ? 6
                      : 6 * 10,
              widget.height != null
                  ? widget.height!
                  : isTablet(context)
                      ? 6 * 10
                      : isDesktop(context)
                          ? 6 * 10
                          : 6 * 10,
            ),
          ),
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
