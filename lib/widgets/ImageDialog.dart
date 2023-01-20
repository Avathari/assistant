import 'dart:convert';

import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatefulWidget {
  String? tittle;
  String? stringImage;
  var onClose;

  ImageDialog({Key? key, this.tittle, this.stringImage, required this.onClose})
      : super(key: key);

  @override
  State<ImageDialog> createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 42, 41, 41),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.tittle!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 5)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: widget.stringImage != ""
                    ? Image.memory(
                        base64Decode(widget.stringImage!),
                        width: 300,
                        height: 400,
                        scale: 0.5,
                        fit: BoxFit.cover,
                      )
                    : const ClipOval(
                        child: Icon(Icons.person),
                      ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colores.backgroundWidget,
                    onPrimary: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    minimumSize: const Size(270, 45)),
                onPressed: () {
                  widget.onClose();
                },
                child: const Text("Cerrar")),
          ],
        ),
      ),
    );
    ;
  }
}
