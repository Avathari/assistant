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
      {super.key,
      required this.onChangeValue,
      required this.items,
      required this.initialValue,
      this.tittle,
      this.fontSize = 10,
      this.isRow = false,
      this.width = 100});

  @override
  State<Spinner> createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.infinity, // widget.width,
        height: 50,
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        padding: const EdgeInsets.only(left: 10, right: 8, top: 2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(20),
          shape: BoxShape.rectangle,
        ),
        child: DropdownButton(
          value: widget.initialValue,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 30,
          elevation: 8,
          isExpanded: true,
          underline: Container(),
          alignment: AlignmentDirectional.center,
          borderRadius: BorderRadius.circular(20),
          dropdownColor: Theming.secondaryColor,
          style: TextStyle(
              fontSize: widget.fontSize,
              color: Colors.white,
              overflow: TextOverflow.fade),
          selectedItemBuilder: (BuildContext context) {
            return widget.items!.map<Widget>((String item) {
              return Container(
                  alignment: Alignment.centerRight,
                  child: Text(item, textAlign: TextAlign.end));
            }).toList();
          },
          onChanged: (String? newValue) {
            widget.onChangeValue!(newValue);
          },
          items: widget.items?.map<DropdownMenuItem<String>>((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(
                val,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: widget.fontSize! > 10
                        ? widget.fontSize! - 2
                        : widget.fontSize! + 2),
              ),
            );
          }).toList(),
        ),
      ),
      Positioned(
        left: 25,
        top: 3,
        child: Container(
          color: Theming.quincuaryColor,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          child: Text("${widget.tittle}:",
              style:
                  TextStyle(color: Colors.white, fontSize: widget.fontSize!)),
        ),
      ),
    ]);
  }

  // widget.isRow == true
  // ? rowView()
  //     : isMobile(context)
  //     ? columnView()
  //     : rowView(),
  Widget columnView() {
    return DropdownButton(
      value: widget.initialValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 30,
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      dropdownColor: Colores.backgroundWidget,
      style: TextStyle(
          fontSize: widget.fontSize,
          color: Colors.white,
          overflow: TextOverflow.ellipsis),
      onChanged: (String? newValue) {
        widget.onChangeValue!(newValue);
      },
      items: widget.items?.map<DropdownMenuItem<String>>((String val) {
        return DropdownMenuItem<String>(
          value: val,
          child: SizedBox(
              width: widget.width,
              child: Text(
                val,
                style: TextStyle(fontSize: widget.fontSize! - 2),
              )),
        );
      }).toList(),
    );
  }

  Row rowView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("${widget.tittle}:",
            style: TextStyle(
              color: Colors.white,
              fontSize: widget.fontSize,
            )),
        DropdownButton(
          value: widget.initialValue,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 30,
          elevation: 8,
          borderRadius: BorderRadius.circular(20),
          dropdownColor: Colores.backgroundWidget,
          style: const TextStyle(
              color: Colors.white, overflow: TextOverflow.ellipsis),
          onChanged: (String? newValue) {
            widget.onChangeValue!(newValue);
          },
          items: widget.items?.map<DropdownMenuItem<String>>((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: SizedBox(
                  width: widget.width,
                  child: Text(
                    val,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: widget.fontSize! - 2),
                  )),
            );
          }).toList(),
        ),
      ],
    );
  }
}
