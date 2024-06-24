import 'package:carwash/common/theme/custom_themes/appbar_theme.dart';
import 'package:carwash/common/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:carwash/common/theme/custom_themes/card_theme.dart';
import 'package:carwash/common/theme/custom_themes/checkbox_theme.dart';
import 'package:carwash/common/theme/custom_themes/chip_theme.dart';
import 'package:carwash/common/theme/custom_themes/elevated_button_theme.dart';
import 'package:carwash/common/theme/custom_themes/outlined_button_theme.dart';
import 'package:carwash/common/theme/custom_themes/text_field_theme.dart';
import 'package:carwash/common/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    // 이거 쓰니 상태바가 이상함..
    // useMaterial3: true,
    // fontFamily: 'SeoulNamsan',
    fontFamily: 'Pretendard',
    brightness: Brightness.light,
    primaryColor: const Color(0xff2A9D8F),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: TAppbarTheme.lightAppBarTheme,
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TTextFieldTheme.lightTextFieldTheme,
    chipTheme: TChipTheme.lightChipTheme,
    checkboxTheme: TCheckBoxTheme.lightCheckBoxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    cardTheme: TCardTheme.lightCardTheme,
  );


  static ThemeData darkTheme = ThemeData(
    // useMaterial3: true,
    // fontFamily: 'SeoulNamsan',
    fontFamily: 'Pretendard',
    brightness: Brightness.dark,
    primaryColor: const Color(0xff2A9D8F),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: TAppbarTheme.darkAppBarTheme,
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFieldTheme.darkTextFieldTheme,
    chipTheme: TChipTheme.darkChipTheme,
    checkboxTheme: TCheckBoxTheme.darkCheckBoxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    cardTheme: TCardTheme.lightCardTheme,
  );
}