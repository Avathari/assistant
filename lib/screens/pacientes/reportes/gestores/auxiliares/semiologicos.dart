import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/GrandButton.dart';
import 'package:assistant/widgets/TittlePanel.dart';
import 'package:flutter/material.dart';

class Semiologicos extends StatefulWidget {
  const Semiologicos({Key? key}) : super(key: key);

  @override
  State<Semiologicos> createState() => _SemiologicosState();
}

class _SemiologicosState extends State<Semiologicos> {
  late bool _value = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ContainerDecoration.roundedDecoration(),
      child: Column(
        children: [
          TittlePanel(
            textPanel: 'Exploración Física',
          ),
          Expanded(
            flex: 8,
            child: ListView(
              padding: const EdgeInsets.all(10),
              // This next line does the trick.
              scrollDirection: Axis.horizontal,
              // gridDelegate: GridViewTools.gridDelegate(crossAxisCount: 3, mainAxisExtent: 40),
              children: [
                ChoiceChip(
                  label: const Text('Neurológicamente integro'),
                  selected: _value,
                  side:const BorderSide(color: Colors.white),
                  selectedColor: Colors.white,
                  backgroundColor: Colors.black,
                  labelStyle:
                      TextStyle(color: _value ? Colors.black : Colors.white),
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected == true ? true : false;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text(' integro'),
                  selected: _value,
                  side:const BorderSide(color: Colors.white),
                  selectedColor: Colors.white,
                  backgroundColor: Colors.black,
                  labelStyle:
                  TextStyle(color: _value ? Colors.black : Colors.white),
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected == true ? true : false;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('Neurológicamente'),
                  selected: _value,
                  side:const BorderSide(color: Colors.white),
                  selectedColor: Colors.white,
                  backgroundColor: Colors.black,
                  labelStyle:
                  TextStyle(color: _value ? Colors.black : Colors.white),
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected == true ? true : false;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('Neurológicamente integro'),
                  selected: _value,
                  side:const BorderSide(color: Colors.white),
                  selectedColor: Colors.white,
                  backgroundColor: Colors.black,
                  labelStyle:
                  TextStyle(color: _value ? Colors.black : Colors.white),
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected == true ? true : false;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('Neurológicamente integro'),
                  selected: _value,
                  side:const BorderSide(color: Colors.white),
                  selectedColor: Colors.white,
                  backgroundColor: Colors.black,
                  labelStyle:
                  TextStyle(color: _value ? Colors.black : Colors.white),
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected == true ? true : false;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('Neurológicamente integro'),
                  selected: _value,
                  side:const BorderSide(color: Colors.white),
                  selectedColor: Colors.white,
                  backgroundColor: Colors.black,
                  labelStyle:
                  TextStyle(color: _value ? Colors.black : Colors.white),
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected == true ? true : false;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('Neurológicamente integro'),
                  selected: _value,
                  side:const BorderSide(color: Colors.white),
                  selectedColor: Colors.white,
                  backgroundColor: Colors.black,
                  labelStyle:
                  TextStyle(color: _value ? Colors.black : Colors.white),
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected == true ? true : false;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('Neurológicamente integro'),
                  selected: _value,
                  side:const BorderSide(color: Colors.white),
                  selectedColor: Colors.white,
                  backgroundColor: Colors.black,
                  labelStyle:
                  TextStyle(color: _value ? Colors.black : Colors.white),
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected == true ? true : false;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('Neurológicamente integro'),
                  selected: _value,
                  side:const BorderSide(color: Colors.white),
                  selectedColor: Colors.white,
                  backgroundColor: Colors.black,
                  labelStyle:
                  TextStyle(color: _value ? Colors.black : Colors.white),
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected == true ? true : false;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('Neurológicamente integro'),
                  selected: _value,
                  side:const BorderSide(color: Colors.white),
                  selectedColor: Colors.white,
                  backgroundColor: Colors.black,
                  labelStyle:
                  TextStyle(color: _value ? Colors.black : Colors.white),
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected == true ? true : false;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('Neurológicamente integro'),
                  selected: _value,
                  side:const BorderSide(color: Colors.white),
                  selectedColor: Colors.white,
                  backgroundColor: Colors.black,
                  labelStyle:
                  TextStyle(color: _value ? Colors.black : Colors.white),
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected == true ? true : false;
                    });
                  },
                ),
                ChoiceChip(
                  label: const Text('Neurológicamente integro'),
                  selected: _value,
                  side:const BorderSide(color: Colors.white),
                  selectedColor: Colors.white,
                  backgroundColor: Colors.black,
                  labelStyle:
                  TextStyle(color: _value ? Colors.black : Colors.white),
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected == true ? true : false;
                    });
                  },
                ),

              ],
            ),
          ),
          Expanded(child: GrandButton(labelButton: 'Aceptar', weigth: 2000, onPress: () {}))
        ],
      ),
    );
  }
}
