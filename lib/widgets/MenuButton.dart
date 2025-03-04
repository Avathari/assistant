import 'package:assistant/values/SizingInfo.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  IconData? iconData;
  String? labelButton;
  void Function() onPress;

  MenuButton({super.key, this.iconData = Icons.add_chart, this.labelButton = '', required this.onPress});

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.grey, backgroundColor: Colors.black54,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            minimumSize: Size(isMobileAndTablet(context) ? 200 : 500, 500)),
        onPressed: widget.onPress,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                widget.iconData!,
                size: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(widget.labelButton!,
              textAlign: TextAlign.end,),
            ],
          ),
        ));
  }
}
