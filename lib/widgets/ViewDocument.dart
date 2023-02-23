import 'dart:convert';
import 'dart:io';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/LoadingScreen.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// ignore: must_be_immutable
class ViewDocument extends StatefulWidget {
  var filePath, fileName;
  bool? isFromMemory;
  String? messageError;

  ViewDocument({
    Key? key,
    required this.filePath,
    this.fileName,
    this.isFromMemory = false,
    this.messageError = "Seleccione un Archivo",
  }) : super(key: key);

  @override
  State<ViewDocument> createState() => _ViewDocumentState();
}

class _ViewDocumentState extends State<ViewDocument> {
  late PdfViewerController _pdfViewerController;
  late PdfTextSearchResult _searchResult;
  OverlayEntry? _overlayEntry;

  var textSearchController = TextEditingController();

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();
    super.initState();
  }

  void _showContextMenu(
      BuildContext context, PdfTextSelectionChangedDetails details) {
    final OverlayState _overlayState = Overlay.of(context)!;
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: details.globalSelectedRegion!.center.dy - 55,
        left: details.globalSelectedRegion!.bottomLeft.dx,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: details.selectedText));
            print(
                'Text copied to clipboard: ' + details.selectedText.toString());
            _pdfViewerController.clearSelection();
          },
          // color: Colors.white,
          // elevation: 10,
          child: const Text('Copy',
              style: TextStyle(color: Colors.black, fontSize: 14)),
        ),
      ),
    );
    _overlayState.insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
            decoration: ContainerDecoration.roundedDecoration(),
            child: widget.filePath == "" || widget.filePath == null
                ? LoadingScreen(error: widget.messageError!)
                : widget.isFromMemory!
                    ? SfPdfViewer.memory(
                        base64.decode(widget.filePath!),
                        onTextSelectionChanged:
                            (PdfTextSelectionChangedDetails details) {
                          if (details.selectedText == null &&
                              _overlayEntry != null) {
                            _overlayEntry!.remove();
                            _overlayEntry = null;
                          } else if (details.selectedText != null &&
                              _overlayEntry == null) {
                            _showContextMenu(context, details);
                          }
                        },
                        controller: _pdfViewerController,
                      )
                    : SfPdfViewer.file(
                        File(widget.filePath!),
                        onTextSelectionChanged:
                            (PdfTextSelectionChangedDetails details) {
                          if (details.selectedText == null &&
                              _overlayEntry != null) {
                            _overlayEntry!.remove();
                            _overlayEntry = null;
                          } else if (details.selectedText != null &&
                              _overlayEntry == null) {
                            _showContextMenu(context, details);
                          }
                        },
                        controller: _pdfViewerController,
                      )),
      ),
    );
  }
}
