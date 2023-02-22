import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';

class HomeButton extends StatefulWidget {
  Function()? onPress;
  IconData? iconData;
  String? labelButton;

  HomeButton(
      {Key? key, required this.onPress, this.iconData = Icons.medical_services, this.labelButton = "Titulo"})
      : super(key: key);

  @override
  State<HomeButton> createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.grey,
            backgroundColor: Colores.backgroundWidget,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            minimumSize: const Size(50, 50)),
        onPressed: () {
          widget.onPress!();
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.iconData!,
                size: 70,
              ),
              const SizedBox(height: 10),
              Text(widget.labelButton!, style: const TextStyle(color: Colors.white))
            ]));
  }
}
