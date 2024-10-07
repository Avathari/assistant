import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';

import 'package:flutter/material.dart';

class Switched extends StatefulWidget {
  String? tittle;
  bool? isSwitched;
  Function? onChangeValue;

  Switched(
      {super.key,
      this.tittle,
      this.isSwitched = false,
      required this.onChangeValue});

  @override
  State<Switched> createState() => _SwitchedState();
}

class _SwitchedState extends State<Switched> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                backgroundColor: Theming.secondaryColor,
                content: SizedBox(
                  height: 100,
                  child: Container(
                    decoration: ContainerDecoration.roundedDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(widget.tittle!,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            )),

                      ],
                    ),
                  ),
                ),
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
            padding: EdgeInsets.only(
                top: 10,
                bottom: 4,
                left: isMobile(context) ? 15 : 20,
                right: isMobile(context) ? 15 : 20),
            child: Row(
              children: [
                Expanded(
                  child: Text("${widget.tittle}:",

                      style: const TextStyle(fontSize: 10, color: Colors.white, overflow: TextOverflow.ellipsis)),
                ),
                Expanded(
                  child: Switch(
                    onChanged: (bool? newValue) {
                      widget.onChangeValue!(newValue);
                    },
                    value: widget.isSwitched!,
                    activeColor: Colors.redAccent,
                    activeTrackColor: Colors.orange,
                    inactiveThumbColor: Colors.black,
                    inactiveTrackColor: Colors.grey,
                  ),
                ),
                isMobile(context)
                    ? Container()
                    : Expanded(
                      child: Text(
                          Dicotomicos.fromBoolean(widget.isSwitched!, toInt: false)
                              .toString(),
                          style:
                              const TextStyle(fontSize: 10, color: Colors.white)),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
