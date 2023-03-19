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
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(widget.firstText!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              widget.secondText!,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(widget.thirdText!,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.normal,
                )),
          ),
          widget.withEditMessage!
              ? Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: GrandIcon(
                    weigth: 10,
                    heigth: 10,
                    iconData: Icons.edit_note,
                    onPress: () {
                      widget.onEdit!(widget.secondText!);
                    },
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
