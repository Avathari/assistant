import 'package:assistant/conexiones/actividades/auxiliares.dart';
import 'package:flutter/material.dart'
    show BuildContext, MediaQuery, WidgetsBinding;

bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width < mobileNormal; // tabletSmall;
}

bool isMobileAndTablet(context) {
  return MediaQuery.of(context).size.width <= tabletSmall;
}

bool isTablet(BuildContext context) {
  return MediaQuery.of(context).size.width >= tabletSmall &&
      MediaQuery.of(context).size.width <= tabletLarge; //tabletExtraLarge;
}

bool isTabletAndDesktop(BuildContext context) {
  return MediaQuery.of(context).size.width > tabletLarge && // tabletSmall
      MediaQuery.of(context).size.width <= desktopSmall;
}

bool isDesktop(BuildContext context) {
  return MediaQuery.of(context).size.width > desktopSmall // desktopNormal
      &&
      MediaQuery.of(context).size.width <= desktopNormal;
}

bool isLargeDesktop(BuildContext context) {
  return MediaQuery.of(context).size.width > desktopNormal // desktopNormal
      &&
      MediaQuery.of(context).size.width <= desktopExtraLarge;
}

// print("MediaQuery.of(context).size.width  ${MediaQuery.of(context).size.width}");

//Mobile size
double get mobileSmall => 320;
double get mobileNormal => 375;
double get mobileLarge => 414;
double get mobileExtraLarge => 480;

//table size
double get tabletSmall => 600;
double get tabletNormal => 768;
double get tabletLarge => 850;
double get tabletExtraLarge => 900;

//desktop size
double get desktopSmall => 1150; //950;
double get desktopMedium => 1200;
double get desktopNormal => 1500;
double get desktopIntermedium => 1990;
double get desktopLarge => 3840;
double get desktopExtraLarge => 4096;

class Keyboard {
  static bool isDesktopOpen(BuildContext context) {
    Terminal.printAlert(message: "HOLO ${MediaQuery.of(context).viewInsets.bottom}");
    if (MediaQuery.of(context).viewInsets.bottom != 0) {
      return true; // Keyboard is visible.
    } else {
      return false; // Keyboard is not visible.
    }
  }
}
