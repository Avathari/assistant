import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditTextArea extends StatefulWidget {
  String? labelEditText;
  MaskTextInputFormatter inputFormat;
  TextInputType keyBoardType;
  TextEditingController textController;
  bool obscureText = false;
  bool prefixIcon = false;
  bool isObscure = false;
  bool withShowOption = false, withDeleteOption = false;
  bool selection;
  int numOfLines;
  double fontSize;

  Color? iconColor;

  void Function()? onSelected;
  final ValueChanged<String>? onChange;

  IconData? iconData ;

  int? limitOfChars;

  EditTextArea({
    Key? key,
    this.labelEditText,
    required this.textController,
    required this.keyBoardType,
    required this.inputFormat,
    this.obscureText = false,
    this.prefixIcon = false,
    this.isObscure = false,
    this.fontSize = 8, // 12
    this.numOfLines = 15,
    this.limitOfChars = 0,
    this.selection = false,
    this.onSelected,
    this.onChange,
    this.withShowOption = false,
    this.withDeleteOption = false,
    this.iconData= Icons.panorama_fish_eye,
    this.iconColor = Colors.white,
  }) : super(key: key) {
    // inputFormat = MaskTextInputFormatter();
    // keyBoardType = TextInputType.multiline;
    // obscureText = false;
    // prefixIcon = false;
    // isObscure = false;
  }

  @override
  State<EditTextArea> createState() => _EditTextAreaState();
}

class _EditTextAreaState extends State<EditTextArea> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 4.0, bottom: 1.0),
      child: Row(
        children: [
          Expanded(
            flex: isDesktop(context) ? 14: 9,
            child: TextField(
              maxLength: widget.limitOfChars == 0 ? null : widget.limitOfChars,
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
                fontSize: isMobile(context) || isTablet(context) ? widget.fontSize : widget.fontSize + 2,
              ),
              textAlign: TextAlign.justify,
              decoration: InputDecoration(
                prefix: widget.prefixIcon == true
                    ? Icon(
                        widget.iconData,
                        color: widget.iconColor,
                      )
                    : null,
                helperStyle: const TextStyle(
                  color: Colors.white,
                ),
                labelText: widget.labelEditText,
                labelStyle: const TextStyle(
                  fontSize: 10,
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
                  flex: isTablet(context) ? 2 : isMobile(context) ? 3  : 2,
                  child: Container(
                    padding: const EdgeInsets.all(0.5),
                    margin: const EdgeInsets.all(1.0),
                    decoration: ContainerDecoration.roundedDecoration(),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        GrandIcon(
                          labelButton: "Ver",
                          iconData: widget.iconData,
                          iconColor: widget.iconColor,
                          onPress: widget.selection
                              ? widget.onSelected
                              : () {
                                  Operadores.openDialog(
                                    context: context,
                                    chyldrim: SingleChildScrollView(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            TittlePanel(
                                                colorText: Colors.grey,
                                                textPanel: widget.labelEditText!),
                                            Text(
                                              widget.textController.text,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            CrossLine(),
                                          ],
                                        )),
                                  );
                                },
                        ),
                        if (widget.withDeleteOption) CrossLine(),
                        if (widget.withDeleteOption) GrandIcon(
                            labelButton: "Ver",
                            iconData: Icons.cleaning_services,
                            iconColor: widget.iconColor,
                            onPress: () {
                              widget.textController.text = "";
                            }
                        )
                      ],
                    ),
                  ),
                )
              : widget.withDeleteOption
              ? Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(4.0),
              margin: const EdgeInsets.all(4.0),
              decoration: ContainerDecoration.roundedDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.withDeleteOption) GrandIcon(
                      labelButton: "Ver",
                      iconData: Icons.cleaning_services,
                      iconColor: widget.iconColor,
                      onPress: () {
                        widget.textController.text = "";
                      }
                  )
                ],
              ),
            ),
          ) : Container()
        ],
      ),
    );
  }
}
