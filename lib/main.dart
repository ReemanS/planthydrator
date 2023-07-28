import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:planthydrator/helpers/sql_helper.dart';
import 'home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Plant Hydrator",
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: const Color(0xff315432),
        scaffoldBackgroundColor: const Color(0xffefedeb),
        // TODO: refactor themes to use ColorScheme
        // colorScheme: const ColorScheme.light(
        //   background: Colors.white,
        // ),
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          labelLarge: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w900,
              color: Color(0xff0f1a0f),
            ),
          ),
          displayLarge: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w800,
              color: Color(0xff0f1a0f),
            ),
          ),
          displayMedium: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              color: Color(0xff0f1a0f),
            ),
          ),
          displaySmall: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Color(0xff0f1a0f),
            ),
          ),
          labelSmall: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.5,
              color: Color(0xff0f1a0f),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          iconColor: const Color(0xff0f1a0f),
          hintStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
              color: Color(0xff0f1a0f), // Customize the color of the hint text
              fontSize: 16, // Customize the font size of the hint text
              fontWeight: FontWeight.w500,
              // Customize the font weight of the hint text
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 70.0),
      ),
      home: const Home(),
    );
  }
}
