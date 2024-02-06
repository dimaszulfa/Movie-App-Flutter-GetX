import 'package:flutter/material.dart';

class ColorManager{
  static Color primaryColor = HexColor.fromHex('#6096B4');
  static Color secondaryColor = HexColor.fromHex('#93BFCF');
  static Color primaryContainer = HexColor.fromHex('#BDCDD6');
  static Color secondaryContainer = HexColor.fromHex('#EEE9DA');
  
}


extension HexColor on Color{
   static Color fromHex(String hexColor){
    hexColor = hexColor.replaceAll('#', '');
    if(hexColor.length == 6){
      hexColor = 'FF$hexColor';
    }

    return Color(int.parse(hexColor, radix: 16));
   }  
}