import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/EditTextArea.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Antecedentes extends StatefulWidget {
  const Antecedentes({Key? key}) : super(key: key);

  @override
  State<Antecedentes> createState() => _AntecedentesState();
}

class _AntecedentesState extends State<Antecedentes> {
  var antecedentesTexController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: TittlePanel(
          textPanel: 'Antecedentes de la Patología',
        )),
        Expanded(
          flex: 6,
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: ContainerDecoration.roundedDecoration(),
                    child: Column(
                      children: [
                        TittlePanel(
                          textPanel: 'Antecedentes de la Patología',
                        ),
                        Row(children: [
                          Expanded(child: GrandButton(labelButton: '', onPress: () {  },)),
                          Expanded(child: GrandButton(labelButton: '', onPress: () {  },)),
                          Expanded(child: GrandButton(labelButton: '', onPress: () {  },)),
                        ],),
                        TittlePanel(
                          textPanel: 'Antecedentes de la Patología',
                        ),
                        Row(children: [
                          Expanded(child: GrandButton(labelButton: '', onPress: () {  },)),
                          Expanded(child: GrandButton(labelButton: '', onPress: () {  },)),
                          Expanded(child: GrandButton(labelButton: '', onPress: () {  },)),
                        ],),
                      ],
                    )
                  )),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: ContainerDecoration.roundedDecoration(),
                  child: ListView(
                    children: [
                      GrandButton(labelButton: '', onPress: () {}),
                      GrandButton(labelButton: '', onPress: () {}),
                      GrandButton(labelButton: '', onPress: () {}),
                      GrandButton(labelButton: '', onPress: () {}),
                      GrandButton(labelButton: '', onPress: () {}),
                      GrandButton(labelButton: '', onPress: () {}),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
