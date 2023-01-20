import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';

class ListValue extends StatefulWidget {
  String? title;
  String? subtitle;
  String? thirdTittle;
  var onPress;
  IconData? iconData;

  ListValue(
      {Key? key,
      this.title,
      this.subtitle,
      this.thirdTittle,
      required this.onPress,
      this.iconData})
      : super(key: key);

  @override
  State<ListValue> createState() => _ListValueState();
}

class _ListValueState extends State<ListValue> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.black54,
              onPrimary: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              minimumSize: Size(isMobileAndTablet(context) ? 170 : 400, 60)),
          onPressed: () {
            widget.onPress();
          },
          child: Text(
            widget.title!,
            textAlign: TextAlign.center,
          )),
    );
  }
}
