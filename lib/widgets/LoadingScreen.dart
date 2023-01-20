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
      color: Theming.bdColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(
            height: 15,
          ),
          Text(
            widget.error!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          )
        ],
      ),
    );
  }
}
