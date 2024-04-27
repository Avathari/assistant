import 'dart:math';

import 'package:assistant/values/SizingInfo.dart';
import 'package:carousel_slider/carousel_options.dart';
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
  static const Color terciaryColor = Color.fromARGB(255, 51, 48, 48);
  static const Color cuaternaryColor = Color.fromARGB(255, 36, 43, 54);
  static const Color textColor = Colors.grey;
  static const Color bdColor = Color.fromARGB(255, 66, 65, 65);
  static const Color quincuaryColor = Color.fromARGB(255, 40, 37, 37);
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
    Color.fromARGB(255, 1, 113, 20),
    Color.fromARGB(255, 113, 1, 1),
    Color.fromARGB(255, 211, 29, 19),
    Color.fromARGB(255, 204, 193, 33),
    Color.fromARGB(255, 113, 1, 161),
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
    Color.fromARGB(255, 59, 41, 7),
    Color.fromARGB(255, 39, 32, 6),

  ];
}

class Font {
  static const double fontTileSize = 11;
}

class Styles {
  static const TextStyle textSyleBold =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  static const TextStyle textSyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.normal,
    overflow: TextOverflow.ellipsis,
    fontSize: 14,
  ); //

  static TextStyle textSyleGrowth({double fontSize = 14}) {
    return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      overflow: TextOverflow.ellipsis,
      fontSize: fontSize,
    ); //
  }

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

class SpinnersValues {
  static double mediumWidth({required BuildContext context}) {
    return isTablet(context)
        ? 250
        : isMobile(context)
            ? 178
            : 300;
  }

  static double minimunWidth({required BuildContext context}) {
    return isTablet(context)
        ? 150
        : isMobile(context)
            ? 70
            : 200;
  }

  static double maximumWidth({required BuildContext context}) {
    return isDesktop(context)
        ? 400
        : isTabletAndDesktop(context)
            ? 140
            : isTablet(context)
                ? 170
                : isMobile(context)
                    ? 100
                    : 200;
  }
}

class ClipOvalClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return const Rect.fromLTWH(0, 0, 200, 100);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    // TODO: implement shouldReclip
    // throw UnimplementedError();
    return false;
  }
}



class ContainerDecoration {
  static BoxDecoration containerDecoration({double radius = 20.0}) {
    return BoxDecoration(
      color: Colores.backgroundPanel,
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
    );
  }

  static BoxDecoration roundedDecoration(
      {Color colorBackground = Colors.black,
      Color borderColor = Colors.grey,
      double radius = 20.0,
      double width = 1.0}) {
    return BoxDecoration(
      color: colorBackground,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: borderColor,
        style: BorderStyle.solid,
        width: width,
      ),
    );
  }
}

class Carousel {
  static CarouselOptions carouselOptions(
      {required BuildContext context, double height = 0}) {
    return CarouselOptions(
        height: height != 0
            ? height
            : isMobile(context)
                ? 1000
                : isTablet(context)
                    ? 1600
                    : isDesktop(context)
                        ? 800
                        : 1000,
        enableInfiniteScroll: false,
        viewportFraction: 1.0);
  }
}

class GridViewTools {
  static SliverGridDelegateWithFixedCrossAxisCount gridDelegate(
      {int crossAxisCount = 3,
      double mainAxisExtent = 250,
      childAspectRatio = 1.0,
      crossAxisSpacing = 10.0,
      mainAxisSpacing = 10.0}) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      mainAxisExtent: mainAxisExtent,
      childAspectRatio: childAspectRatio,
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  final AnimationController animationController;


  FlowMenuDelegate({required this.animationController})
      : super(repaint: animationController);

  @override
  void paintChildren(FlowPaintingContext context) {
    final xPosition = context.size.width - 75;
    final yPosition = context.size.height - 75;
    final iconCount = context.childCount;

    for (int i = 0; i < iconCount; i++) {
      final isLastIcon = i == context.childCount - 1;
      final radius = 180 * animationController.value;
      final tetha = i * pi * 0.5 / (iconCount - 2);
      final x = xPosition - (isLastIcon ? 0.0 : (radius * cos(tetha)));
      final y = yPosition - (isLastIcon ? 0.0 : (radius * sin(tetha)));

      context.paintChild(i,
          transform: Matrix4.identity()
            ..translate(x, y, 0)
            ..translate(-75 / 2, -75 / 21)
            ..rotateZ(isLastIcon
                ? 0.0
                : 180 * (1 - animationController.value) * pi / 180)
            ..scale(isLastIcon
                ? 1.0
                : max(
                    animationController.value,
                    0.5,
                  ))
            ..translate(-75 / 2, -75 / 2));
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}

class FlowVerticalDelegate extends FlowDelegate {
  final AnimationController animationController;
  var toogle;

  FlowVerticalDelegate({required this.animationController, this.toogle})
      : super(repaint: animationController);

  @override
  void paintChildren(FlowPaintingContext context) {
    const buttonSize = 46;
    const buttonRadius = buttonSize / 2;
    const buttonMargin = 20;

    final xPosition = context.size.width - buttonSize;
    final yPosition = context.size.height - buttonSize;

    final lastFabIndex = context.childCount - 1;

    for (int i = lastFabIndex; i >= 0; i--) {
      final y = yPosition -
          ((buttonSize + buttonMargin) * i * animationController.value);
      final size = (i != 0) ? animationController.value : 1.0;

      context.paintChild(i,
          transform: Matrix4.translationValues(xPosition, y, 0.0)
            ..translate(buttonRadius, buttonRadius)
            ..scale(size)
            ..translate(-buttonRadius, -buttonRadius),
      ); // Hacia Arriba . . .
      // context.paintChild(i,
      //     transform: Matrix4.translationValues(x, yPosition, 0.0)); // Hacia la Izquierda
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {

    const double innerCircleRadius = 150.0;

    Path path = Path();
    path.lineTo(0, rect.height);
    path.quadraticBezierTo(rect.width / 2 - (innerCircleRadius / 2) - 30, rect.height + 15, rect.width / 2 - 75, rect.height + 50);
    path.cubicTo(
        rect.width / 2 - 40, rect.height + innerCircleRadius - 40,
        rect.width / 2 + 40, rect.height + innerCircleRadius - 40,
        rect.width / 2 + 75, rect.height + 50
    );
    path.quadraticBezierTo(rect.width / 2 + (innerCircleRadius / 2) + 30, rect.height + 15, rect.width, rect.height);
    path.lineTo(rect.width, 0.0);
    path.close();

    return path;
  }
}