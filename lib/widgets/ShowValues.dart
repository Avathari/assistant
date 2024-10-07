import 'package:flutter/material.dart';

class ShowValues extends StatefulWidget {
  String? label;
  double? value;

  ShowValues({super.key, this.label, this.value});

  @override
  State<ShowValues> createState() => _ShowValuesState();
}

class _ShowValuesState extends State<ShowValues> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomPaint(
              painter: OpenPainter(),
            ),
          ),
          Text(widget.label!, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  Color? color;
  OpenPainter({this.color = Colors.red});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;
    //draw arc
    canvas.drawArc(
        Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            width: 100,
            height: 100),
        3.1416, //radians
        0.99 * 3.1416, //radians
        false,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
