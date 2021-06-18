import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class AppColors {
  static get primary => Color.fromRGBO(0xA8, 0x67, 0x26, 1.0);
}

abstract class AppTheme {
  static get light => ThemeData(
      primaryColor: Color.fromRGBO(0xA8, 0x67, 0x26, 1.0),
      backgroundColor: Color.fromRGBO(0xE5, 0xE5, 0xE5, 1.0),
      appBarTheme: AppBarTheme(
        color: Colors.white,
      ),
      textTheme: TextTheme(
          bodyText1: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14),
          headline2: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 20)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 4,
        selectedIconTheme: IconThemeData(color: AppColors.primary),
        selectedLabelStyle: TextStyle(color: AppColors.primary, fontSize: 12),
        unselectedLabelStyle: TextStyle(
            color: Color.fromRGBO(0x72, 0x72, 0x72, 1.0), fontSize: 12),
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ));
}
