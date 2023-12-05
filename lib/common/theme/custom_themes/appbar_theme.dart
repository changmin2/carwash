import 'package:carwash/common/const/colors.dart';
import 'package:carwash/common/const/sizes.dart';
import 'package:flutter/material.dart';

class TAppbarTheme {
  TAppbarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    // surfaceTintColor : 고도를 나타내기 위해 앱 바의 배경색에 적용되는 표면 색조 오버레이 색상입니다.
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: TSizes.iconMd),
    actionsIconTheme: IconThemeData(color: Colors.black, size: TSizes.iconMd),
    titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
  );


  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: TSizes.iconMd),
    actionsIconTheme: IconThemeData(color: Colors.white, size: TSizes.iconMd),
    titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
  );
}