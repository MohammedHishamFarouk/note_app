import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class ThemeManager {
  static ThemeData getThemeData(bool isDark,BuildContext context) {
    return ThemeData(
        scaffoldBackgroundColor: isDark ? Colors.black : Colors.white,
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.black,
          centerTitle: true,
          color: Colors.grey,
          titleTextStyle:
              const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
              ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: isDark ? Colors.black : Colors.white,
          ),
        ),
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.grey),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith((state)=>Colors.black),
        )
      ),
      textTheme: Theme.of(context).textTheme.apply(
        fontSizeFactor: 1.5,
        fontSizeDelta: 0,
      ),
    );
  }
}
