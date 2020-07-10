
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {

  static LinearGradient linearGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF13547A),
      Color(0xFF80D0C7),
    ],
  );

  static LinearGradient linearGradient2 = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF80D0C7),
      Color(0xFF13547A),
    ],
  );

  static Color color1 = Color(0xFF13547A);

  static Color color2 = Color(0xFF80D0C7);

  static Map<int, Color> colorCodes = {
    50: Color(colorCode1),
    100:Color(colorCode1),
    200:Color(colorCode1),
    300:Color(colorCode1),
    400:Color(colorCode1),
    500:Color(colorCode1),
    600:Color(colorCode1),
    700:Color(colorCode1),
    800:Color(colorCode1),
    900:Color(colorCode1),
  };

  static int colorCode1 = 0xFF13547A;

  static int colorCode2 = 0xFF80D0C7;

}