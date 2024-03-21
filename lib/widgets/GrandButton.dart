import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GrandButton extends StatefulWidget {
  String? labelButton;
  double? weigth, height;
  void Function() onPress;
  final VoidCallback? onLongPress;

  double? fontSize;

  GrandButton({
    Key? key,
    this.labelButton = "",
    this.weigth = 0,
    this.height = 0,
    this.fontSize = 14.0,
    this.onLongPress,
    required this.onPress,
  }) : super(key: key);

  @override
  State<GrandButton> createState() => _GrandButtonState();
}

class _GrandButtonState extends State<GrandButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ContainerDecoration.roundedDecoration(),
      padding: isMobile(context)
          ? const EdgeInsets.all(2.0)
          : const EdgeInsets.all(8.0),
      margin: isMobile(context)
          ? const EdgeInsets.all(2.0)
          : const EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.grey,
              backgroundColor: Colors.black54,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              minimumSize: Size(
                widget.weigth != 0.0
                    ? widget.weigth!
                    : isMobile(context) || isTablet(context)
                        ? 170
                        : 500,
                widget.height != 0.0
                    ? widget.height!
                    : isMobile(context) || isTablet(context)
                        ? 60
                        : 60,
              )),
          onPressed: () {
            SystemSound.play(SystemSoundType.click);
            widget.onPress();
          },
          onLongPress: widget.onLongPress,
          child: Text(
            widget.labelButton!,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: widget.fontSize),
          )),
    );
  }
}
