import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var appTheme = ThemeData(
    fontFamily: GoogleFonts.nunito().fontFamily,
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      button: TextStyle(
        letterSpacing: 1.5,
        fontWeight: FontWeight.bold,
      ),
      headline1: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      subtitle1: TextStyle(
        color: Colors.grey,
      ),
    ));
