import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

enum fontSizeManager {
  small, normal, large
}

class TextStyleManager {
  static getNormalWhiteTextStyle(){
    return GoogleFonts.montserrat(
      fontSize: 14.sp,
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
    );
  }
  static getSmallWhiteTextStyle(){
    return GoogleFonts.montserrat(
      fontSize: 8.sp,
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      
    );
  }
  static getLargeWhiteTextStyle({color = Colors.white, fontSize = fontSizeManager.large, fontWeight = FontWeight.normal}){
    return GoogleFonts.montserrat(
      fontSize: (fontSize == fontSizeManager.large) ? 16.sp : fontSize,
      color: color,
      fontStyle: FontStyle.normal,
      fontWeight: fontWeight,
    );
  }
}