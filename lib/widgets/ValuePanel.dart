import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';

class ValuePanel extends StatefulWidget {
  String? firstText;
  String? secondText;
  String? thirdText;
  double padding, fontSize, margin, heigth;

  bool? withEditMessage, withBorder;
  final ValueChanged<String>? onEdit;
  void Function()? onLongPress, onPress;

  ValuePanel({
    super.key,
    this.firstText = "",
    this.secondText = "",
    this.thirdText = "",
    this.padding = 2.0,
    this.margin = 2.0,
    this.fontSize = 10,
    this.heigth = 46,
    this.withEditMessage = false,
    this.withBorder = true, // false,
    this.onPress,
    this.onLongPress,
    this.onEdit,
  });

  @override
  State<ValuePanel> createState() => _ValuePanelState();
}

class _ValuePanelState extends State<ValuePanel> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
        widget.onLongPress ?? () {
      Datos.portapapeles(context: context, text: "${widget.firstText!} ${widget.secondText!} ${widget.thirdText!}");
        },
      onDoubleTap: () {
        widget.onEdit!(widget.secondText!);
      },
      onLongPress: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                backgroundColor: Theming.secondaryColor,
                content: SizedBox(
                  height: 100,
                  child: Container(
                    decoration: ContainerDecoration.roundedDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(widget.firstText!,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: widget.fontSize,
                              color: Colors.grey,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(
                          widget.secondText!,
                          style: TextStyle(
                            fontSize: widget.fontSize - 2,
                            color: Colors.grey,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        if (widget.thirdText! != "")
                        Text(widget.thirdText!,
                            style: TextStyle(
                              fontSize: widget.fontSize - 4,
                              color: Colors.grey,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.normal,
                            )),
                      ],
                    ),
                  ),
                ),
              );

            });
      },
      child: Container(
        width: 2000,
        height: widget.heigth,
        decoration: widget.withBorder == true
            ? ContainerDecoration.roundedDecoration()
            : null,
        padding: EdgeInsets.all(widget.padding),
        margin: EdgeInsets.all(widget.margin),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          direction: Axis.vertical,
          children: [
            Text(widget.firstText!,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                )),
            Text(
              widget.secondText!,
              maxLines:
                  widget.firstText == "" && widget.thirdText == "" ? 3 : 1,
              style: TextStyle(
                fontSize: widget.firstText == "" && widget.thirdText == ""
                    ? widget.fontSize
                    : widget.fontSize - 2,
                color: Colors.grey,
                overflow: TextOverflow.ellipsis,
                fontWeight: widget.firstText == "" && widget.thirdText == ""
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
              textAlign: widget.firstText == "" && widget.thirdText == ""
                  ? TextAlign.center
                  : TextAlign.left,
            ),
            if (widget.thirdText! != "")
              Text(widget.thirdText!,
                  style: TextStyle(
                    fontSize: widget.fontSize - 4,
                    color: Colors.grey,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.normal,
                  )),

          ],
        ),
      ),
    );
  }
}
