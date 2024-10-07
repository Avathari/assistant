
import 'dart:convert';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageDialog extends StatefulWidget {
  String? tittle;
  String? stringImage;

  ImageDialog({super.key, this.tittle, this.stringImage});

  @override
  State<ImageDialog> createState() => _ImageDialogState();
}

class _ImageDialogState extends State<ImageDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ContainerDecoration.roundedDecoration(),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TittlePanel(textPanel: widget.tittle!),
          Expanded(
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: ContainerDecoration.roundedDecoration(),
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
          ),
        ],
      ),
    );
  }
}
