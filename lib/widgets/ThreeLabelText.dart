import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:flutter/material.dart';

class ThreeLabelTextAline extends StatefulWidget {
  String? firstText;
  String? secondText;
  String? thirdText;
  double padding;

  bool? withEditMessage, withBorder;
  final ValueChanged<String>? onEdit;

  ThreeLabelTextAline({
    Key? key,
    this.firstText = "",
    this.secondText = "",
    this.thirdText = "",
    this.padding = 2.0,
    this.withEditMessage = false,
    this.withBorder = false,
    this.onEdit,
  }) : super(key: key);

  @override
  State<ThreeLabelTextAline> createState() => _ThreeLabelTextAlineState();
}

class _ThreeLabelTextAlineState extends State<ThreeLabelTextAline> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.withBorder == true?ContainerDecoration.roundedDecoration() : null,
      padding: EdgeInsets.all(widget.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.firstText!,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
              )),
          Text(
            widget.firstText == '' ?
            widget.secondText! : widget.secondText!,
            style: TextStyle(
              fontSize: widget.firstText == '' ? 13 : 12,
              color: widget.secondText! == '0000-00-00' ? Colors.red: Colors.grey,
              overflow: TextOverflow.fade,
              fontWeight: FontWeight.normal,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
          ),
          Text(widget.thirdText!,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.normal,
              )),
          widget.withEditMessage!
              ? GrandIcon(
                weigth: 10,
                heigth: 10,
                iconData: Icons.edit_note,
                onPress: () {
                  widget.onEdit!(widget.secondText!);
                },
              )
              : Container()
        ],
      ),
    );
  }
}
