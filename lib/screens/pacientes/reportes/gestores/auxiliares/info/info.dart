import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CircleSwitched.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class infoSemiologias {
  static Widget infograma(
    BuildContext context,
    List<Widget> componentes, {
    String tittle = "",
    String subTittle = "",
    IconData iconTittle = Icons.title,
    IconData iconSubTittle = Icons.subtitles,
    bool isVertical = true,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(right: 4.0, left: 4.0, top: 8.0, bottom: 8.0),
      child: isVertical
          ? Column(
              children: [
                SizedBox(
                  height: 70,
                  child: CircleIcon(
                    radios: 40,
                    difRadios: 5,
                    tittle: tittle,
                    iconed: iconTittle,
                    onChangeValue: () {},
                  ),
                ),
                SizedBox(
                  height: 20,
                  child: CrossLine(),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: componentes,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                  child: CrossLine(),
                ),
                SizedBox(
                  height: 70,
                  child: CircleIcon(
                    tittle: subTittle,
                    radios: 30,
                    difRadios: 5,
                    iconed: iconSubTittle,
                    onChangeValue: () async {},
                  ),
                ),
              ],
            )
          : Row(
              children: [
                SizedBox(
                  width: 5,
                  child: CrossLine(isHorizontal: false)
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(tittle, style: TextStyle(fontSize: 10, color: Colors.grey),),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: componentes,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                    width: 5,
                    child: CrossLine(isHorizontal: false)
                ),
              ],
            ),
    );
  }
}
