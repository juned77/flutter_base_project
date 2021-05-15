import 'package:flutter/material.dart';

class AppColors {
  static Color bgColor = HexColor("#E5E5E5");
  static Color primaryColor = HexColor("#0661A7");
  static Color dodgerBlue = HexColor("#2997FF");
  static Color frenchGrey = HexColor("#BDBDBD");
  static Color martinique = HexColor("#3B3B4D");
  static Color cloudBurst = HexColor("#3B3C4D");
  static Color bleuDeFrance = HexColor("#4285F4");
  static Color lightForestGreen = HexColor("#5DB075");
  static Color roman = HexColor("#DB665A");
  
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColorString) {
    var hexColor = hexColorString;
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(String hexColor) : super(_getColorFromHex(hexColor));
}
