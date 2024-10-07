import 'package:flutter/material.dart';

class ScrollableWidget extends StatelessWidget {
  final Widget child;

  const ScrollableWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
            controller: ScrollController(),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: child),
      );
}
