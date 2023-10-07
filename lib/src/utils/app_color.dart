import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFF8F0E5);
  static const Color secondaryColor = Color(0xFF102C57);
  static const Color tertiaryColor = Color(0xFF102C57);
  static const Color inputBorderColor = Color(0xFF102C57);
  static Color inputFilledColor = const Color(0xFF102C57).withOpacity(0.1);
  static const Color bottomAppBarColor = Color(0xFF102C57);
  static Map<int, Color> color = {
    50: const Color.fromRGBO(0, 126, 142, .1),
    100: const Color.fromRGBO(0, 126, 142, .2),
    200: const Color.fromRGBO(0, 126, 142, .3),
    300: const Color.fromRGBO(0, 126, 142, .4),
    400: const Color.fromRGBO(0, 126, 142, .5),
    500: const Color.fromRGBO(0, 126, 142, .6),
    600: const Color.fromRGBO(0, 126, 142, .7),
    700: const Color.fromRGBO(0, 126, 142, .8),
    800: const Color.fromRGBO(0, 126, 142, .9),
    900: const Color.fromRGBO(0, 126, 142, 1),
  };
}
