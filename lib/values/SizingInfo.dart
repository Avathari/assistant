import 'package:flutter/material.dart' show BuildContext, MediaQuery;

bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width < tabletSmall; // tabletSmall;
}

bool isTablet(BuildContext context) {
  return MediaQuery.of(context).size.width >= tabletSmall &&
      MediaQuery.of(context).size.width <= tabletExtraLarge; //tabletExtraLarge;
}

bool isDesktop(BuildContext context) {
  return MediaQuery.of(context).size.width > desktopMedium;
}

bool isTabletAndDesktop(BuildContext context) {
  return MediaQuery.of(context).size.width > tabletLarge &&
      MediaQuery.of(context).size.width <= desktopExtraLarge;
}

bool isMobileAndTablet(context) {
  return MediaQuery.of(context).size.width <= tabletLarge;
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
double get desktopMedium => 1100;
double get desktopNormal => 1920;
double get desktopLarge => 3840;
double get desktopExtraLarge => 4096;
