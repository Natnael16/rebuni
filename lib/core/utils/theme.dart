import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'colors.dart';

var appTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    useMaterial3: true,
    cardColor: containerBackgroundColor,
    scaffoldBackgroundColor: white,
    
    textTheme: TextTheme(
      labelMedium: TextStyle(
        fontFamily: 'Poppins',
        color: white,
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Poppins',
        color: black,
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Poppins',
        color: black,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Poppins',
        color: black,
        fontSize: 15.sp,
      ),

      labelLarge: TextStyle(
        fontFamily: 'Poppins',
        color: blackTextColor,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
      ),
      labelSmall: TextStyle(
          fontFamily: "Poppins", fontSize: (15).sp, color: textFieldGrayColor),
      displayLarge: TextStyle(
        fontFamily: "Poppins",
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
      ),
      
    ));
