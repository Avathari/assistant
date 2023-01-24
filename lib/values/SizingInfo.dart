import 'package:flutter/material.dart' show BuildContext, MediaQuery;

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
  return MediaQuery.of(context).size.width > tabletSmall &&
      MediaQuery.of(context).size.width <= desktopNormal;
}

bool isDesktop(BuildContext context) {
  print(
      "MediaQuery.of(context).size.width  ${MediaQuery.of(context).size.width}");
  return MediaQuery.of(context).size.width > desktopNormal;
}

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
double get desktopSmall => 950;
double get desktopMedium => 1200;
double get desktopNormal => 1500;
double get desktopIntermedium => 1990;
double get desktopLarge => 3840;
double get desktopExtraLarge => 4096;
