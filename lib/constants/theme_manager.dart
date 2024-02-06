import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_getx/constants/color_manager.dart';

class ThemeManager{
  static const lightThemeFont = "ComicNeue", darkThemeFont = "Poppins";

  static final lightTheme = ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorManager.primaryColor,
      foregroundColor: ColorManager.secondaryContainer
    )
    ,
    buttonTheme: ButtonThemeData(
      buttonColor: ColorManager.primaryColor
    ),
    primaryColor: ColorManager.primaryColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
    fontFamily: lightThemeFont,
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) => ColorManager.primaryColor)
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: ColorManager.primaryColor,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontSize: 23,
      ),
      iconTheme: IconThemeData(color: ColorManager.primaryColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark
      ),
    )
  );
}