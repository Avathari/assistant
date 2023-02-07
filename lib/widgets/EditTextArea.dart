import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditTextArea extends StatefulWidget {
  String? labelEditText;
  MaskTextInputFormatter inputFormat;
  TextInputType keyBoardType;
  TextEditingController textController;
  bool obscureText = false;
  bool prefixIcon = false;
  bool isObscure = false;
  bool withShowOption = false;
  bool selection;
  int numOfLines;
  double fontSize;

  void Function()? onSelected;
  final ValueChanged<String>? onChange;

  IconData? iconData = Icons.person;

    EditTextArea(
      {Key? key,
      this.labelEditText,
      required this.textController,
      required this.keyBoardType,
      required this.inputFormat,
      this.obscureText = false,
      this.prefixIcon = false,
      this.isObscure = false,
      this.fontSize = 12,
      this.numOfLines = 15,
      this.selection = false,
      this.onSelected,
      this.onChange,
      this.withShowOption = false,
      this.iconData})
      : super(key: key) {
    inputFormat = MaskTextInputFormatter();
    keyBoardType = TextInputType.multiline;

    obscureText = false;
    prefixIcon = false;
    isObscure = false;
  }

  @override
  State<EditTextArea> createState() => _EditTextAreaState();
}

class _EditTextAreaState extends State<EditTextArea> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            flex: 9,
            child: TextField(
              inputFormatters: [widget.inputFormat],
              controller: widget.textController,
              autofocus: false,
              maxLines: widget.numOfLines,
              keyboardType: widget.keyBoardType,
              autocorrect: true,
              onChanged: widget.onChange,
              obscureText: widget.obscureText,
              style: TextStyle(
                color: Colors.white,
                fontSize: widget.fontSize,
              ),
              textAlign: TextAlign.justify,
              decoration: InputDecoration(
                prefix: widget.prefixIcon == true
                    ? Icon(
                        widget.iconData,
                        color: Colors.white,
                      )
                    : null,
                helperStyle: const TextStyle(
                  color: Colors.white,
                ),
                labelText: widget.labelEditText,
                labelStyle: const TextStyle(
                  color: Colors.white,
                ),
                contentPadding: const EdgeInsets.all(20),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.5),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                focusColor: Colors.white,
                suffixIcon: widget.isObscure
                    ? IconButton(
                        icon: Icon(
                          widget.obscureText
                              ? Icons.visibility
                              : Icons.password,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          widget.isObscure = !widget.isObscure;
                        },
                      )
                    : null,
              ),
            ),
          ),
          widget.withShowOption
              ? Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Tooltip(
                      message: "Ver",
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.grey, backgroundColor: Colors.black54,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              minimumSize: const Size(500, 100)),
                          onPressed: widget.selection
                              ? widget.onSelected
                              : () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Dialog(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SingleChildScrollView(
                                                child: Column(
                                              children: [
                                                TittlePanel(
                                                    colorText: Colors.black,
                                                    textPanel:
                                                        widget.labelEditText!),
                                                Text(
                                                  widget.textController.text,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const CrossLine(),
                                              ],
                                            )),
                                          ),
                                        );
                                      });
                                },
                          child: const Icon(Icons.slideshow)),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
