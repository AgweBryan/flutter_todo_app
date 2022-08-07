import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Themes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  );
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
  );

  TextStyle get subHeadingTextStyle => GoogleFonts.lato(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.grey.shade400 : Colors.grey,
      );

  TextStyle get headingTextStyle => GoogleFonts.lato(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      );

  TextStyle get titleStyle => GoogleFonts.lato(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
      );
  TextStyle get subTitleStyle => GoogleFonts.lato(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: Get.isDarkMode ? Colors.grey.shade100 : Colors.grey.shade600,
      );
}
