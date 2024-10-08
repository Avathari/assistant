import 'dart:io';

import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/widgets/AppBarText.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerScreen extends StatefulWidget {
  String? pdfPath;
  PDFViewerScreen(this.pdfPath, {super.key});

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: AppBarText("Ver PDF . . . "),
        backgroundColor: Colors.black,
        foregroundColor: Colors.grey,
        actions: [
          GrandIcon(
              iconData: Icons.picture_as_pdf_outlined,
              onPress: () async {
                await Directorios.choiseFromInternalDocuments(context)
                    .then((onValue) {
                  setState(() {
                    widget.pdfPath = onValue!.files.single.path;
                  });
                });
              }),
          SizedBox(width: 20),
        ],
      ),
      body: SfPdfViewer.file(File(widget.pdfPath!)),
    );
  }
}
