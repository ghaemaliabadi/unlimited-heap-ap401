import 'package:flutter/material.dart';

ThemeData buildThemeData() {

  return ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: Colors.green[500],
      secondary: Colors.grey[300],
    ),
    // primarySwatch: Color.green,
    // accentColor: Colors.greenAccent,
    fontFamily: 'kalameh',
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      displayMedium: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      displaySmall: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headlineLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      // signup page: navigate to login page
      headlineSmall: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        decoration: TextDecoration.underline,
      ),
      bodyLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w300,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w300,
        color: Colors.black,
      ),
      // Account page: app bar
      titleMedium: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
      ),
      // account page: user info
      labelMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.blueAccent,
      ),
    ),
  );
}

BoxDecoration defaultBoxDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.white,
    border: Border.all(
      color: Colors.black38,
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 4,
        offset: const Offset(0, 3),
      ),
    ],
  );
}