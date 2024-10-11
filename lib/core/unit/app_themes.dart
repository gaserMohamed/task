import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../logic/helper_methods.dart';

ThemeData getLightTheme() {
  return ThemeData(
    fontFamily: 'DM Sans',
    primaryColor: const Color(0xff5F33E1),
    shadowColor: const Color(0xFF03DAC6),
    scaffoldBackgroundColor:  Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,

      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    datePickerTheme:const DatePickerThemeData(
      backgroundColor: Colors.white,

    ),
    inputDecorationTheme:  InputDecorationTheme(
      // alignLabelWithHint: true,
      labelStyle: const TextStyle(
        color: Color(0xffB1B1B1),
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        borderSide: const BorderSide(
          color:Color.fromRGBO(95, 51, 225, 1),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        borderSide: const BorderSide(
          color: Color.fromRGBO(95, 51, 225, 1),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(
          color: Color(0xFFf3f3f3),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        padding: WidgetStateProperty.all(
           EdgeInsets.symmetric(vertical: 24.w),
        ),
        side: WidgetStateProperty.all(
          const BorderSide(
            color: Color.fromRGBO(95, 51, 225, 1),
          ),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          const Color.fromRGBO(95, 51, 225, 1),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        padding: WidgetStateProperty.all(
           EdgeInsets.symmetric(vertical: 24.w),
        ),
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      buttonColor: const Color.fromRGBO(95, 51, 225, 1),
    ),

    primarySwatch: primarySwatch(),
  );

}