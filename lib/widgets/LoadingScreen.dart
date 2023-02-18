import 'package:assistant/values/WidgetValues.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  String? error;

  LoadingScreen({super.key, this.error});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Theming.secondaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 200,
            width: 200,
            child: CircularProgressIndicator(),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            widget.error!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
