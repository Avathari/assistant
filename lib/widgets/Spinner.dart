import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';

class Spinner extends StatefulWidget {
  String? tittle;
  String? initialValue;
  List<String>? items;
  Function? onChangeValue;
  bool? isRow;

  double? width, fontSize;

  Spinner(
      {Key? key,
      required this.onChangeValue,
      required this.items,
      required this.initialValue,
      this.tittle,
        this.fontSize = 10,
      this.isRow = false,
      this.width = 100})
      : super(key: key);

  @override
  State<Spinner> createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 0, left: 8, right: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.white,
                width: Ratios.borderRadius), //border of dropdown button
            borderRadius: BorderRadius.circular(20),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Colores.backgroundWidget, //shadow for button
                  blurRadius: 5) //blur radius of shadow
            ]),
        child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 4, left: 20, right: 20),
            child: widget.isRow == true
                ? rowView()
                : isMobile(context)
                    ? columnView()
                    : rowView()),
      ),
    );
  }

  GestureDetector columnView() {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("${widget.tittle}:", style:  TextStyle(color: Colors.white, fontSize: widget.fontSize!)),
          DropdownButton(
            value: widget.initialValue,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 30,
            elevation: 8,
            dropdownColor: Colores.backgroundWidget,
            style: const TextStyle(
              fontSize: 8,
                color: Colors.white, overflow: TextOverflow.ellipsis),
            onChanged: (String? newValue) {
              widget.onChangeValue!(newValue);
            },
            items: widget.items?.map<DropdownMenuItem<String>>((String val) {
              return DropdownMenuItem<String>(
                value: val,
                child: SizedBox(width: widget.width, child: Text(val)),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Row rowView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("${widget.tittle}:",
            style: const TextStyle(color: Colors.white, fontSize: 10)),
        DropdownButton(
          value: widget.initialValue,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 30,
          elevation: 8,
          dropdownColor: Colores.backgroundWidget,
          style: const TextStyle(
              color: Colors.white, overflow: TextOverflow.ellipsis),
          onChanged: (String? newValue) {
            widget.onChangeValue!(newValue);
          },
          items: widget.items?.map<DropdownMenuItem<String>>((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: SizedBox(width: widget.width, child: Text(val, overflow: TextOverflow.ellipsis,)),
            );
          }).toList(),
        ),
      ],
    );
  }
}
