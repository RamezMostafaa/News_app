import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryLightColor = const Color(0xff39A552);
  static Color whiteColor = const Color(0xffffffff);
  static Color blackColor = const Color(0xff303030);
  static Color redColor = const Color(0xffc91c22);
  static Color darkBlueColor = const Color(0xff003e90);
  static Color pinkColor = const Color(0xffed1e79);
  static Color brownColor = const Color(0xffcf7e48);
  static Color blueColor = const Color(0xff4882cf);
  static Color yellowColor = const Color(0xfff2d352);
  static Color greyColor = const Color(0xff4f5a69);

  static ThemeData lightTeme = ThemeData(
      primaryColor: primaryLightColor,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: whiteColor, size: 25),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40))),
        backgroundColor: primaryLightColor,
        elevation: 0,
        toolbarHeight: 100,
        centerTitle: true,
      ),
      textTheme: TextTheme(
          titleLarge: TextStyle(
              color: whiteColor, fontWeight: FontWeight.bold, fontSize: 22),
          titleMedium: TextStyle(
              color: blackColor, fontWeight: FontWeight.bold, fontSize: 20),
          titleSmall: TextStyle(
              color: blackColor, fontWeight: FontWeight.bold, fontSize: 18)));
}
