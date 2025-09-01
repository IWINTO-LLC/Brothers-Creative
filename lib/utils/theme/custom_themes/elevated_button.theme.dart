import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          disabledBackgroundColor: Colors.grey,
          disabledForegroundColor: Colors.grey,
          // side: const BorderSide(
          //   color: Color(0xFF0099ff),
          // ),
          padding: const EdgeInsets.symmetric(vertical: 18),
          textStyle: const TextStyle(
              fontSize: 16.0,
              fontFamily: 'Tajawal',
              fontWeight: FontWeight.w600,
              color: Colors.white),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))));
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey,
          disabledForegroundColor: Colors.grey,
          // side: const BorderSide(
          //   color: Color(0xFF0099ff),
          // ),
          padding: const EdgeInsets.symmetric(vertical: 20),
          textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              fontFamily: 'Tajawal',
              color: Colors.black),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100))));
}
