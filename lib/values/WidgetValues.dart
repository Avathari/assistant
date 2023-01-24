import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class gadgets {
  static const sizedBox = SizedBox(
    height: 12,
  );
}

class Indices {
  static int indice = 0;
}

class Theming {
  static const Color primaryColor = Color.fromARGB(255, 0, 0, 0);
  static const Color secondaryColor = Color(0xFF2A2D3E);
  static const Color terciaryColor = Color.fromARGB(255, 63, 15, 4);
  static const Color textColor = Colors.grey;
  static const Color bdColor = Color.fromARGB(255, 66, 65, 65);
}

class Padd {
  static const double defaultPadding = 10.0;
}

class Ratios {
  static const double borderRadius = 0.5;
}

class Colores {
  static const Color backgroundWidget = Color.fromARGB(255, 65, 62, 62);
  static const Color backgroundPanel = Colors.black54;

  static const List<Color?> locales = [
    Color.fromARGB(255, 113, 1, 161),
    Color.fromARGB(255, 113, 1, 1),
    Color.fromARGB(255, 211, 29, 19),
    Color.fromARGB(255, 204, 193, 33),
    Color.fromARGB(255, 1, 113, 20),
    Color.fromARGB(255, 211, 19, 157),
    Color.fromARGB(255, 255, 153, 0),
    Color.fromARGB(255, 113, 1, 78),
    Color.fromARGB(255, 19, 118, 211),
    Color.fromARGB(255, 0, 131, 52),
    Color.fromARGB(255, 113, 70, 1),
    Color.fromARGB(255, 93, 19, 211),
    Color.fromARGB(255, 225, 255, 0),
    Color.fromARGB(255, 108, 31, 31),
    Color.fromARGB(255, 8, 78, 87),
    Color.fromARGB(255, 17, 13, 75),
    Color.fromARGB(255, 23, 85, 21),
    Color.fromARGB(255, 153, 211, 19),
    Color.fromARGB(255, 0, 72, 255),
    Color.fromARGB(255, 165, 9, 118),
    Color.fromARGB(255, 104, 5, 22),
    Color.fromARGB(255, 58, 129, 14),
    Color.fromARGB(255, 24, 159, 9),
    Color.fromARGB(255, 211, 144, 19),
    Color.fromARGB(255, 6, 27, 80),
    Color.fromARGB(255, 51, 7, 38),
    Color.fromARGB(255, 69, 20, 28),
    Color.fromARGB(255, 194, 196, 193),
    Color.fromARGB(255, 9, 67, 159),
    Color.fromARGB(255, 59, 41, 7)
  ];
}

class Font {
  static const double fontTileSize = 12;
}

class Styles {
  static const TextStyle textSyleBold =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  static const TextStyle textSyle = TextStyle(
      color: Colors.white, fontWeight: FontWeight.normal, fontSize: 14); //

  static TextStyle textSyleFailed = const TextStyle(
      color: Colors.red, fontWeight: FontWeight.bold, fontSize: 24);

  static TextStyle textSyleConfirm = const TextStyle(
      color: Colors.green, fontWeight: FontWeight.bold, fontSize: 24);

  static TextStyle textSyleNeutro = const TextStyle(
      color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 24);
}

class TextFormat {
  static MaskTextInputFormatter dateFormat = MaskTextInputFormatter(
  mask: '####/##/##',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy);

  static MaskTextInputFormatter numberFourFormat = MaskTextInputFormatter(
  mask: '####',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy);
}