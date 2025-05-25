import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light Theme Colors
  static const Color lightPrimaryTextColor = Color(0xFF111518);
  static const Color lightTotalCaloriesCardBg = Color(0xFFF0F2F4);
  static const Color lightMealTimestampColor = Color(0xFF637688);
  static const Color lightFabColor = Color(0xFF268AE8);
  static const Color lightScaffoldBg = Colors.white;
  static const Color lightAppBarBg = Colors.white;
  static const Color lightCardBg = Colors.white; // For MealListItem
  static const Color lightDividerColor = Color(0xFFEEEEEE);

  // Dark Theme Colors
  static const Color darkPrimaryTextColor = Color(0xFFE0E0E0); // Slightly off-white
  static const Color darkTotalCaloriesCardBg = Color(0xFF1E1E1E);
  static const Color darkMealTimestampColor = Color(0xFF9E9E9E); // Lighter grey
  static const Color darkFabColor = Color(0xFF268AE8); // Can remain the same or use a lighter variant
  static const Color darkScaffoldBg = Color(0xFF121212);
  static const Color darkAppBarBg = Color(0xFF1E1E1E);
  static const Color darkCardBg = Color(0xFF1E1E1E);
  static const Color darkDividerColor = Color(0xFF333333);


  static final ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: lightScaffoldBg,
    primaryColor: lightFabColor,
    colorScheme: ColorScheme.light(
      primary: lightFabColor,
      secondary: lightFabColor, // Or another accent color
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      surface: lightCardBg,
      onSurface: lightPrimaryTextColor,
      background: lightScaffoldBg,
      onBackground: lightPrimaryTextColor,
      error: Colors.red,
      onError: Colors.white,
      brightness: Brightness.light,
      surfaceVariant: lightTotalCaloriesCardBg, // For TotalCaloriesCard background
      outline: lightDividerColor, // For dividers
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: lightAppBarBg,
      elevation: 0,
      iconTheme: const IconThemeData(color: lightPrimaryTextColor),
      titleTextStyle: GoogleFonts.manrope(
        color: lightPrimaryTextColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: lightFabColor,
      foregroundColor: Colors.white,
    ),
    textTheme: GoogleFonts.manropeTextTheme(ThemeData.light().textTheme).apply(
      bodyColor: lightPrimaryTextColor,
      displayColor: lightPrimaryTextColor,
    ),
    cardColor: lightCardBg,
    hintColor: lightMealTimestampColor,
    dividerColor: lightDividerColor,
    dialogBackgroundColor: Colors.white,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: lightFabColor, // For "Save" button in dialog
        textStyle: GoogleFonts.manrope(),
      )
    ),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: darkScaffoldBg,
    primaryColor: darkFabColor,
    colorScheme: ColorScheme.dark(
      primary: darkFabColor,
      secondary: darkFabColor, // Or another accent color
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      surface: darkCardBg,
      onSurface: darkPrimaryTextColor,
      background: darkScaffoldBg,
      onBackground: darkPrimaryTextColor,
      error: Colors.redAccent,
      onError: Colors.black,
      brightness: Brightness.dark,
      surfaceVariant: darkTotalCaloriesCardBg, // For TotalCaloriesCard background
      outline: darkDividerColor, // For dividers
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkAppBarBg,
      elevation: 0,
      iconTheme: const IconThemeData(color: darkPrimaryTextColor),
      titleTextStyle: GoogleFonts.manrope(
        color: darkPrimaryTextColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: darkFabColor,
      foregroundColor: Colors.white,
    ),
    textTheme: GoogleFonts.manropeTextTheme(ThemeData.dark().textTheme).apply(
      bodyColor: darkPrimaryTextColor,
      displayColor: darkPrimaryTextColor,
    ),
    cardColor: darkCardBg,
    hintColor: darkMealTimestampColor,
    dividerColor: darkDividerColor,
    dialogBackgroundColor: const Color(0xFF2C2C2C), // Slightly lighter than scaffold for dialogs
     textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: darkFabColor, // For "Save" button in dialog
        textStyle: GoogleFonts.manrope(),
      )
    ),
  );
}
