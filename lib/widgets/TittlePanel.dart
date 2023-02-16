import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:flutter/material.dart';

class TittlePanel extends StatefulWidget {
  String? textPanel;
  double? padding;
  Color? color;
  Color colorText;

  TittlePanel(
      {Key? key,
      this.padding = 8.0,
      this.colorText = Colors.white,
      this.color = Colores.backgroundPanel,
      required this.textPanel})
      : super(key: key);

  @override
  State<TittlePanel> createState() => _TittlePanelState();
}

class _TittlePanelState extends State<TittlePanel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 8.0, right: 8.0, top: 12.0, bottom: widget.padding!),
      child: Container(
        decoration: BoxDecoration(
            color: widget.color!,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
                // topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: Column(
          children: [
            const SizedBox(height: 12.0),
            Text(
              widget.textPanel!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: widget.colorText,
              ),
            ),
            const SizedBox(height: 8.0),
            const CrossLine()
          ],
        ),
      ),
    );
  }
}
