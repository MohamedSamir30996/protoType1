import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:udemy_start/shared/styles/colors.dart';

ThemeData LightTheme = ThemeData(
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
  primarySwatch: defaultColor,
  primaryColor: defaultColor,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    elevation: 0.0,
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 20.0,
  ),
  fontFamily: 'OpenSans',
);

ThemeData DarkTheme = ThemeData(
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    ),
  ),
  primarySwatch: defaultDarkColor,
  primaryColor: defaultDarkColor,
  appBarTheme: AppBarTheme(
    backgroundColor: HexColor('111518'),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('111518'),
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: TextStyle(
      color: Colors.grey,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.grey,
    ),
    elevation: 0.0,
  ),
  scaffoldBackgroundColor: HexColor('111518'),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultDarkColor,
    unselectedItemColor: Colors.grey,
    backgroundColor: HexColor('111518'),
    elevation: 20.0,
  ),
  fontFamily: 'OpenSans',
);