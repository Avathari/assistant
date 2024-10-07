import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/RoundedPanel.dart';
import 'package:flutter/material.dart';

class ShowText extends StatefulWidget {
  String? title, medida;
  double? data, minVal, maxVal;
  int? fontSize;
  bool inRow;
  TypeValueShow? typeShow;

  int fractionDigits;

  ShowText(
      {super.key,
      this.title,
      this.data,
      this.medida,
      this.inRow = true,
      this.fontSize = 0,
      this.fractionDigits = 2,
      this.typeShow = TypeValueShow.isNormal,
      this.minVal = 0,
      this.maxVal = 0});

  @override
  State<ShowText> createState() => _ShowTextState();
}

class _ShowTextState extends State<ShowText> {
  @override
  Widget build(BuildContext context) {
    var height = isMobile(context) ? 4.0 : 5.0;
    //
    return RoundedPanel(
        child: Column(
      children: [
        SizedBox(
          height: height,
        ),
        widget.inRow
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: component(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: component(),
              )
      ],
    ));
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

  component() {
    return [
      Text(
        widget.title!,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: Styles.textSyleBold,
      ),
      Text(
        '${widget.data!.toStringAsFixed(widget.fractionDigits)} ',
        textAlign: TextAlign.end,
        overflow: TextOverflow.ellipsis,
        style: type,
      ),
      Text(
        widget.medida!,
        overflow: TextOverflow.ellipsis,
        style: Styles.textSyle,
      ),
    ];
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
