import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/RoundedPanel.dart';
import 'package:flutter/material.dart';

class ShowText extends StatefulWidget {
  String? title, medida;
  double? data, minVal, maxVal;
  TypeValueShow? typeShow;

  ShowText(
      {super.key,
      this.title,
      this.data,
      this.medida,
      this.typeShow = TypeValueShow.isNormal,
      this.minVal = 0,
      this.maxVal = 0});

  @override
  State<ShowText> createState() => _ShowTextState();
}

class _ShowTextState extends State<ShowText> {
  @override
  Widget build(BuildContext context) {
    var height = isMobile(context) ? 4.0 : 7.0;
    //
    return RoundedPanel(
      child: Column(children: [
        SizedBox(
          height: height,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${widget.data!} ',
              style: type,
            ),
            Text(
              widget.medida!,
              style: Styles.textSyle,
            ),
          ],
        ),
        Text(
          widget.title!,
          textAlign: TextAlign.center,
          style: Styles.textSyleBold,
        ),
        // const CrossLine(),
        // SizedBox(
        //   height: height,
        // ),
      ]),
    );
  }

  TextStyle get type {
    TextStyle style = Styles.textSyleNeutro;

    switch (widget.typeShow) {
      case TypeValueShow.isUpper:
        if (widget.data! > widget.minVal!) {
          return Styles.textSyleConfirm;
        } else {
          return Styles.textSyleFailed;
        }
      case TypeValueShow.isMiddle:
        if (widget.data! > widget.minVal! && widget.data! < widget.minVal!) {
          return Styles.textSyleConfirm;
        } else {
          return Styles.textSyleFailed;
        }
      case TypeValueShow.isInner:
        break;
      case TypeValueShow.fromInner:
        break;
      case TypeValueShow.fromUpper:
        break;
      case TypeValueShow.isNormal:
        return Styles.textSyle;
      default:
    }
    return style;
  }
}

enum TypeValueShow {
  isNormal,
  isUpper,
  isMiddle,
  isInner,
  fromInner,
  fromUpper
}
