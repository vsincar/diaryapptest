import 'package:flutter/material.dart';

// Define the light theme
final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  appBarTheme: AppBarTheme(
    color: Colors.blue,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white, 
      fontSize: 20, 
      fontWeight: FontWeight.bold
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    bodySmall: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black54),
  ),
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
    thumbColor: MaterialStateProperty.all<Color>(Colors.blue),
  ),
);

// Define the dark theme
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blueGrey,
  appBarTheme: AppBarTheme(
    color: Colors.black,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white, 
      fontSize: 20, 
      fontWeight: FontWeight.bold
    ),
  ),
  scaffoldBackgroundColor: Colors.black,
  textTheme: TextTheme(
    bodySmall: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
  ),
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all<Color>(Colors.grey),
    thumbColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
  ),
);
