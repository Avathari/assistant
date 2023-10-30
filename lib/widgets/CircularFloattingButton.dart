import 'package:assistant/values/WidgetValues.dart';
import 'package:assistant/widgets/CircularFloattingButton.dart';
import 'package:flutter/material.dart';

class CircularFloattingButton extends StatefulWidget {
  const CircularFloattingButton({super.key});

  @override
  State<CircularFloattingButton> createState() =>
      _CircularFloattingButtonState();
}

class _CircularFloattingButtonState extends State<CircularFloattingButton>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    super.initState();
  }

  final double iconSize = 55;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowMenuDelegate(animationController: animationController),
      children: <IconData>[
        Icons.sms,
        Icons.call,
        Icons.call,
        Icons.mail,
        Icons.menu
      ].map<Widget>(MenuItem).toList(),
    );
  }

  Widget MenuItem(IconData icon) => SizedBox(
        width: iconSize,
        height: iconSize,
        child: FloatingActionButton(
          elevation: 0,
          splashColor: Colors.black87,
          backgroundColor: Colors.black,
          foregroundColor: Colors.grey,
          onPressed: () {
            if (animationController.status == AnimationStatus.completed) {
              animationController.reverse();
            } else {
              animationController.forward();
            }
          },
          child: Icon(
            icon,
            color: Colors.grey,
            size: iconSize - 30,
          ),
        ),
      );
}

// **********************************
class VerticalFloattingButton extends StatefulWidget {

  List<Widget> buttoms;

  VerticalFloattingButton({super.key, required this.buttoms});

  @override
  State<VerticalFloattingButton> createState() =>
      _VerticalFloattingButtonState();
}

class _VerticalFloattingButtonState extends State<VerticalFloattingButton>
    with SingleTickerProviderStateMixin {
  final actionButtonColor = Colors.black;
  late AnimationController animationController;
  final menuIsOpen = ValueNotifier(false);

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    super.initState();
  }

  final double iconSize = 45;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

   toogleMenu() {
     print("menuIsOpen.value : ${menuIsOpen.value}");
    menuIsOpen.value
        ? animationController.reverse()
        : animationController.forward();
    menuIsOpen.value = !menuIsOpen.value;
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
        delegate:
            FlowVerticalDelegate(animationController: animationController, toogle: toogleMenu),
        children: widget.buttoms.map((e) =>gestureMod(e)).toList());
  }

  //     .map((e) => Card(
  // color: Colors.blueGrey[300],
  // child: Column(
  // children: <Widget>[
  // Row(
  // children: <Widget>[
  // Text(e.labelOne),
  // Text(e.labelTwo),
  // Text(e.labelThree)
  // ],
  // )
  // ],
  // ),
  // )).toList(),
  // ),
  Widget gestureMod(Widget child) => SizedBox(
      width: 40,
      height: 40,
      child: GestureDetector(onTap: toogleMenu, child: child));

  // children: <IconData>[
  // Icons.sms,
  // Icons.call,
  // Icons.call,
  // Icons.mail,
  // Icons.menu
  // ].map<Widget>(MenuItem).toList(),

  Widget MenuItem(IconData icon) => SizedBox(
        width: iconSize,
        height: iconSize,
        child: IconButton.filled(
          onPressed: toogleMenu,
          icon: Icon(icon),
          color: Colors.grey,
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.black)),
        ),
      );
}
