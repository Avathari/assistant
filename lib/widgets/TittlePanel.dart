import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:flutter/material.dart';

class TittlePanel extends StatefulWidget {
  String? textPanel;
  double? padding, fontSize;
  Color? color;
  Color colorText;

  TittlePanel(
      {Key? key,
      this.padding = 8.0,
      this.fontSize = 16,
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
    return Container(
      padding: EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: widget.padding! + 3.0,
          bottom: widget.padding!),
      // margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: widget.color!,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      // topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const SizedBox(height: 12.0),
            Text(
              widget.textPanel!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: widget.fontSize,
                color: widget.colorText,
              ),
            ),
            // SizedBox(height: widget.padding!),
            CrossLine()
          ],
        ),
      ),
    );
  }
}
