import 'package:brothers_creative/utils/constants/color.dart';
import 'package:brothers_creative/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:brothers_creative/utils/theme/custom_themes/elevated_button.theme.dart';
import 'package:brothers_creative/utils/theme/custom_themes/text_field_theme.dart';
import 'package:brothers_creative/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_themes/appbar_theme.dart';

class TAppTheme {
  TAppTheme._();
  static ThemeData lightThemeArabic = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.tajawal().fontFamily, // 'IBMPlexSansArabic',//AvenirArabic',
    brightness: Brightness.light,
    primaryColor: const Color(0xFF0099ff),
    primaryColorLight: const Color(0xFF0099ff),
    primaryColorDark: const Color(0xFF0099ff),

    // accentColor:Color.yellow,

    // primaryColor: TColors.primary,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lightTextTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationThem,
  );

  static ThemeData lightThemeEg = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.notoSans().fontFamily,
    // fontFamily:  'IBMPlexSansArabic',//'GTWalsheimPro',
    brightness: Brightness.light,
    primaryColor: const Color(0xFF0099ff),
    primaryColorLight: const Color(0xFF0099ff),
    primaryColorDark: const Color(0xFF0099ff),

    // accentColor:Color.yellow,

    // primaryColor: TColors.primary,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TTextTheme.lightTextTheme,
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationThem,
  );
  static ThemeData darkThemeEg = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.notoSans().fontFamily,
    //fontFamily:'IBMPlexSansArabic',// 'GTWalsheimPro',
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF3F50CB),
    primaryColorLight: const Color(0xFF0099ff),
    primaryColorDark: const Color(0xFF3F50CB),
    // primaryColor: TColors.primary,
    scaffoldBackgroundColor: TColors.containerdarkColor,
    textTheme: TTextTheme.darkTextTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationThem,
  );
  static ThemeData darkThemeAr = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.tajawal().fontFamily,
    // fontFamily: 'IBMPlexSansArabic',//'AvenirArabic',
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF3F50CB),
    primaryColorLight: const Color(0xFF0099ff),
    primaryColorDark: const Color(0xFF3F50CB),
    // primaryColor: TColors.primary,
    scaffoldBackgroundColor: TColors.containerdarkColor,
    textTheme: TTextTheme.darkTextTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationThem,
  );
}
