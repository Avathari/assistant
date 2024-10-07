import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerScreen extends StatelessWidget {
  final String pdfPath;

  PDFViewerScreen(this.pdfPath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ver PDF"),
      ),
      body: SfPdfViewer.file(File(pdfPath)),
    );
  }
}