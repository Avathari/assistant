import 'dart:convert';

import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Padding editPassword(
    bool prefixIcon,
    String labelEditText,
    TextEditingController passwordTextController,
    bool obscureText,
    bool isObscure,
    onPress) {
  // isObscure = false;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      controller: passwordTextController,
      autofocus: false,
      keyboardType: TextInputType.text,
      autocorrect: true,
      obscureText: isObscure,
      style: const TextStyle(
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        helperStyle: const TextStyle(
          color: Colors.white,
        ),
        labelText: labelEditText,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        contentPadding: const EdgeInsets.all(20),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        focusColor: Colors.white,
        suffixIcon: IconButton(
          icon: Icon(
            isObscure ? Icons.visibility : Icons.password,
            color: Colors.white,
          ),
          onPressed: () {
            onPress();
          },
        ),
      ),
    ),
  );
}

Padding editText(bool prefixIcon, String labelEditText,
    TextEditingController textController, bool obscureText) {
  bool _isObscure = obscureText;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      controller: textController,
      autofocus: false,
      keyboardType: TextInputType.text,
      autocorrect: true,
      obscureText: obscureText,
      style: const TextStyle(
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        prefix: prefixIcon == true
            ? const Icon(
                Icons.person,
                color: Colors.white,
              )
            : null,
        helperStyle: const TextStyle(
          color: Colors.white,
        ),
        labelText: labelEditText,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        contentPadding: const EdgeInsets.all(20),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        focusColor: Colors.white,
        suffixIcon: _isObscure
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.password,
                  color: Colors.white,
                ),
                onPressed: () {
                  _isObscure = !_isObscure;
                },
              )
            : null,
      ),
    ),
  );
}

Padding editFormattedText(
    TextInputType? keyBoardType,
    inputFormat,
    bool prefixIcon,
    String labelEditText,
    TextEditingController textController,
    bool obscureText) {
  bool _isObscure = obscureText;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      inputFormatters: [inputFormat],
      controller: textController,
      autofocus: false,
      keyboardType: keyBoardType,
      autocorrect: true,
      obscureText: obscureText,
      style: const TextStyle(
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        prefix: prefixIcon == true
            ? const Icon(
                Icons.person,
                color: Colors.white,
              )
            : null,
        helperStyle: const TextStyle(
          color: Colors.white,
        ),
        labelText: labelEditText,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        contentPadding: const EdgeInsets.all(20),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0.5),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        focusColor: Colors.white,
        suffixIcon: _isObscure
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.password,
                  color: Colors.white,
                ),
                onPressed: () {
                  _isObscure = !_isObscure;
                },
              )
            : null,
      ),
    ),
  );
}

Future toast(String msg) {
  return Fluttertoast.showToast(
      msg: msg, fontSize: 18, gravity: ToastGravity.BOTTOM);
}

Text labelText(String data) {
  return Text(data,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
}

Text labelTextBlack(String data) {
  return Text(data,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold));
}

AlertDialog alertDialog(String? tittle, String? msg, onCloss, onAcept) {
  return AlertDialog(
    backgroundColor: Theming.secondaryColor,
    title: Text(
      tittle!,
      style: const TextStyle(color: Colors.grey),
    ),
    content: Text(
      msg!,
      style: const TextStyle(color: Colors.grey),
    ),
    actions: [
      OutlinedButton(
          onPressed: () {
            onCloss();
          },
          child: const Text("Cancelar", style: TextStyle(color: Colors.white))),
      ElevatedButton(
          onPressed: () {
            onAcept();
          },
          child: const Text("Aceptar", style: TextStyle(color: Colors.white)))
    ],
  );
}

ElevatedButton textButton(context, String? labelButton, onPress) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.black54,
          onPrimary: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          minimumSize: Size(isMobileAndTablet(context) ? 75 : 250, 50)),
      onPressed: () {
        onPress();
      },
      child: Text(labelButton!));
}

ElevatedButton grandButton(context, String? labelButton, onPress,
    {double? weigth}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.black54,
          onPrimary: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          minimumSize:
              Size(isMobileAndTablet(context) ? 170 : weigth ?? 500, 60)),
      onPressed: () {
        onPress();
      },
      child: Text(labelButton!));
}

Dialog emergentDialog(context, String? tittle, String? msg, onPress) {
  return Dialog(
      backgroundColor: Theming.bdColor,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theming.primaryColor),
                  child: Text(
                    tittle!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: SingleChildScrollView(
              controller: ScrollController(),
              padding: const EdgeInsets.all(20),
              child: Text(
                msg!,
                style: const TextStyle(color: Colors.grey),
              ),
            )),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                textButton(context, "Cerrar", () {
                  Navigator.of(context).pop();
                }),
                const SizedBox(
                  width: 10,
                ),
                grandButton(context, "Aceptar", () {
                  onPress();
                }),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ));
}

Dialog imageDialog(String? tittle, String? stringImage, onClose) {
  return Dialog(
    backgroundColor: const Color.fromARGB(255, 42, 41, 41),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tittle!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 5)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: stringImage != ""
                  ? Image.memory(
                      base64Decode(stringImage!),
                      width: 300,
                      height: 400,
                      scale: 0.5,
                      fit: BoxFit.cover,
                    )
                  : const ClipOval(
                      child: Icon(Icons.person),
                    ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colores.backgroundWidget,
                  onPrimary: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  minimumSize: const Size(270, 45)),
              onPressed: () {
                onClose();
              },
              child: const Text("Cerrar")),
        ],
      ),
    ),
  );
}

Padding spinner(context, String tittle, String initialValue, List<String> items,
    onChangeValue) {
  return Padding(
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
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$tittle:", style: const TextStyle(color: Colors.white)),
            DropdownButton(
              value: initialValue,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 30,
              elevation: 8,
              dropdownColor: Colores.backgroundWidget,
              style: const TextStyle(color: Colors.white),
              onChanged: (String? newValue) {
                onChangeValue(newValue);
              },
              items: items.map<DropdownMenuItem<String>>((String val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: SizedBox(
                      width: isMobile(context) ? 140 : 250, child: Text(val)),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    ),
  );
}

GridView gridView(context, childAspectRatio,
    {required List<Widget> children, columnCount = 0}) {
  return GridView.count(
      childAspectRatio: childAspectRatio != 0 ? childAspectRatio : 10.0,
      crossAxisCount: columnCount == 0
          ? isMobile(context)
              ? 2
              : 2
          : columnCount,
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 10.0,
      shrinkWrap: true,
      children: children);
}

Padding tileStat(IconData? icon, String tittle, String stat) {
  return Padding(
    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
    child: ListTile(
      leading: Icon(icon!, color: Colors.white),
      title: Text(
        tittle,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        stat,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}

List<PieChartSectionData> listChartSections(
    Map<String, dynamic> data, int total) {
  List<PieChartSectionData> list = [];
  Indices.indice = 0;

  data.forEach((key, value) {
    list.add(PieChartSectionData(
      color: Colores.locales[Indices.indice],
      value: (value! / total),
      title: "${(value! / total).roundToDouble()} %",
      radius: 20,
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ));
    Indices.indice++;
  });
  return list;
}

ElevatedButton menuButton(
    context, IconData? iconData, String? labelButton, onPress) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.black54,
          onPrimary: Colors.grey,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          minimumSize: Size(isMobileAndTablet(context) ? 200 : 500, 500)),
      onPressed: () {
        onPress();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(
              iconData!,
              size: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(labelButton!),
          ],
        ),
      ));
}

Padding tittleCard({Color? color, String? text}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Expanded(
        child: Container(
      padding: const EdgeInsets.all(10),
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Theming.bdColor),
      child: Text(
        text!,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    )),
  );
}

DataCell dataCell(String? text, {Function? onTapped}) {
  return DataCell(
    Text(
      text!,
      style: const TextStyle(color: Colors.white),
    ),
    onTap: () {
      onTapped!();
    },
  );
}
