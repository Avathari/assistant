import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:assistant/operativity/pacientes/valores/Valores.dart';
import 'package:assistant/operativity/pacientes/valores/semiologia/semiotica.dart';
import 'package:assistant/screens/pacientes/auxiliares/revisiones/generales.dart';
import 'package:assistant/screens/pacientes/reportes/gestores/auxiliares/info/info.dart';
import 'package:assistant/values/SizingInfo.dart';
import 'package:assistant/values/Strings.dart';
import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircleIcon.dart';
import 'package:assistant/widgets/CircleLabel.dart';
import 'package:assistant/widgets/CircleSwitched.dart';
import 'package:assistant/widgets/CrossLine.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/CircleSwitched.dart';
import 'package:assistant/widgets/CircleSwitched.dart';
import 'package:assistant/widgets/GrandIcon.dart';
import 'package:assistant/widgets/GrandLabel.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Semiologicos extends StatefulWidget {
  const Semiologicos({super.key});

  @override
  State<Semiologicos> createState() => _SemiologicosState();
}

class _SemiologicosState extends State<Semiologicos> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      endDrawer: _drawerForm(context),
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.only(top: 25.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: _getComponents(entries: Exploracion.semiotica),
                  )),
            ),
            Expanded(
              child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: _getComponents(entries: Exploracion.cervical),
                  )),
            ),
            _centralPanel(context),
            Expanded(
              child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: _getComponents(entries: Exploracion.torax),
                  )),
            ),
            Expanded(
              child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: _getComponents(entries: Exploracion.abdomen),
                  )),
            ),
          ],
        ),
      ),
      floatingActionButton: _floattingActionButton(context),
    );
  }

  List<Widget> _getComponents(
      {required Map<String, dynamic> entries, bool isSpinner = false}) {
    List<Widget> list = [];

    for (int index = 0; index < entries.length; index++) {
      // Exploracion.initialValue=entries.values.elementAt(index).first;

      list.add(Stack(
        children: [
          Container(
              width: double.infinity, // widget.width,
              height: entries.values.elementAt(index).length > 5 ? 110 : 75,
              margin: const EdgeInsets.all(12.0),
              padding:
                  const EdgeInsets.only(left: 10, right: 8, top: 7, bottom: 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(20),
                shape: BoxShape.rectangle,
              ),
              child: entries.values.elementAt(index).length > 4
                  // ? isSpinner == false || entries.values.elementAt(index).length <= 10
                  ? GridView(
                      shrinkWrap: true,
                      controller: ScrollController(),
                      gridDelegate: GridViewTools.gridDelegate(
                          crossAxisCount: isMobile(context) ? 3 : 5,
                          mainAxisExtent: isMobile(context) ||
                                  isTablet(context) ||
                                  isDesktop(context)
                              ? 45
                              : 45,
                          childAspectRatio: isMobile(context) ||
                                  isTablet(context) ||
                                  isDesktop(context)
                              ? 2.0
                              : 1.0,
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: 1.0),
                      children: entries.values
                          .elementAt(index)
                          .map<Widget>((title) => CircleLabel(
                                tittle: title,
                                onChangeValue: () {
                                  // Handle button press here
                                  Exploracion.toJson(
                                      entries.keys.elementAt(index), title);
                                  //
                                  expoTextController.text =
                                      Exploracion.exploracionGeneral;
                                },
                              ))
                          .toList())
                  // : Spinner(
                  //     initialValue: '${Exploracion.initialValue}',
                  //     items: List<String>.from(entries.values.elementAt(index)),
                  //     onChangeValue: (String value) {
                  //       Exploracion.toJson(
                  //           entries.keys.elementAt(index), value);
                  //       //
                  //       setState(() {
                  //         Exploracion.initialValue = value;
                  //       });
                  //       //
                  //       expoTextController.text =
                  //           Exploracion.exploracionGeneral;
                  //     },
                  //   )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: entries.values
                          .elementAt(index)
                          .map<Widget>((title) => Expanded(
                                child: CircleLabel(
                                  tittle: title,
                                  onChangeValue: () {
                                    // Handle button press here
                                    Exploracion.toJson(
                                        entries.keys.elementAt(index), title);
                                    //
                                    expoTextController.text =
                                        Exploracion.exploracionGeneral;
                                  },
                                ),
                              ))
                          .toList())),
          Positioned(
            left: 5,
            top: 0,
            child: Container(
              color: Theming.bdColor,
              margin: const EdgeInsets.only(left: 20, right: 10, top: 2),
              padding: const EdgeInsets.only(left: 20, right: 10, top: 0),
              child: Text(descompose(entries.keys.elementAt(index)),
                  style: const TextStyle(color: Colors.white, fontSize: 10)),
            ),
          ),
        ],
      ));
    }

    return list;
  }

  descompose(String value) {
    return value.contains(RegExp(r'[A-Z]'))
        ? Sentences.capitalize(value.replaceRange(
            value.indexOf(RegExp(r'[A-Z]')),
            value.indexOf(RegExp(r'[A-Z]')) + 1,
            " ${RegExp(r'[A-Z]').stringMatch(value).toString()}"))
        : value;
  }

  // VARIABLES
  var expoTextController = TextEditingController();

  // COMPONENTES ****************************************************
  _drawerForm(BuildContext context) => Drawer(
        width: 100,
        backgroundColor: Theming.cuaternaryColor,
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.grey),
                bottom: BorderSide(color: Colors.grey),
                left: BorderSide(color: Colors.grey)),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16), topLeft: Radius.circular(16)),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: DrawerHeader(
                    child: CircleIcon(
                  difRadios: 15,
                  iconed: Icons.line_weight_sharp,
                  onChangeValue: () {},
                )),
              ),
              Expanded(flex: 10, child: Column(children: sidePanel(context),)),
              CrossLine(thickness: 3, height: 20, color: Colors.grey),
              Expanded(
                flex: 2,
                child: CircleIcon(
                  radios: 30,
                  difRadios: 5,
                  tittle: 'Copiar Esquema del Reporte',
                  iconed: Icons.copy_all_sharp,
                  onChangeValue: () {
                    // Datos.portapapeles(
                    //     context: context,
                    //     text: Reportes.copiarReporte(
                    //         tipoReporte: getTypeReport()));
                    _key.currentState!.closeEndDrawer();
                  },
                ),
              ),
            ],
          ),
        ),
      );

  _centralPanel(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.only(top: 75.0, bottom: 10.0),
          decoration: ContainerDecoration.roundedDecoration(
              colorBackground: Theming.bdColor),
          child: Column(
            children: [
              CrossLine(thickness: 1, color: Colors.grey),
              EditTextArea(
                  textController: expoTextController,
                  labelEditText: "Exploración física",
                  keyBoardType: TextInputType.multiline,
                  numOfLines: 7,
                  inputFormat: MaskTextInputFormatter()),
              // ************************** **** *** **    *
              CrossLine(thickness: 2, color: Colors.grey),
              Expanded(
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: _getComponents(entries: Exploracion.aspectuales),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  _appBar(BuildContext context) => AppBar(
        foregroundColor: Colors.white,
        shape: CustomShapeBorder(),
        backgroundColor: Colors.black,
        centerTitle: true,
        toolbarHeight: 50.0,
        elevation: 0,
        // title: CircleIcon(
        //     iconed: Icons.person,
        //     tittle: Sentences.app_bar_usuarios,
        //     onChangeValue: () {}),
        actions: [
          GrandIcon(
              iconData: Icons.receipt,
              labelButton: "Generales . . . ",
              onPress: () => Cambios.toNextActivity(context,
                  tittle: 'Generales diarios del Paciente . . . ',
                  chyld: const Generales())),
          CrossLine(height: 15, isHorizontal: false, thickness: 2),
          GrandIcon(
              iconData: Icons.drag_indicator_sharp,
              labelButton: "Menu",
              onPress: () => _key.currentState!.openEndDrawer()),
          CrossLine(height: 15, isHorizontal: false, thickness: 0),
        ],
      );

  _floattingActionButton(BuildContext context) => FloatingActionButton(
      backgroundColor: Colors.black,
      onPressed: () => showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                color: Theming.cuaternaryColor,
                border: Border(
                    top: BorderSide(color: Colors.grey),
                    right: BorderSide(color: Colors.grey),
                    left: BorderSide(color: Colors.grey)),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16)),
              ),
              child: downPanel(context),
            );
          }));

  downPanel(BuildContext context) {
    return Column(
      children: [
        GrandLabel(
            labelButton: 'Copiar en Portapapeles . . . ',
            onPress: () => Datos.portapapeles(
                context: context, text: Exploracion.exploracionGeneral)),
      ],
    );
  }

  sidePanel(BuildContext context) =><Widget>[];
}
