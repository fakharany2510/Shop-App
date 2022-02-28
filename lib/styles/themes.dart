import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
ThemeData lightMood=ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    // color: Colors.pink.shade900,
    //backwardsCompatibility: true,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: Colors.pinkAccent,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.pink,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 0,
    selectedItemColor: Colors.pinkAccent,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color:Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,
    ),
  ),
);

ThemeData darkMood=ThemeData(
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
    backgroundColor: HexColor('333739'),
    actionsIconTheme:IconThemeData(
      color: Colors.pink,
    ),
    elevation: 0.0,
    // color: Colors.pink.shade900,
    //backwardsCompatibility: true,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: TextStyle(
      color: Colors.pinkAccent,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: HexColor('333739'),
      elevation: 0,
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.grey
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color:Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,
    ),
  ),
);