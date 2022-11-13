import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class TStyles {
  static TextStyle veryLargeText = GoogleFonts.cairo().copyWith(
    fontSize: 24,
  );

  static TextStyle largeText = GoogleFonts.cairo().copyWith(
    fontSize: 22,
  );
  static TextStyle mediumText = GoogleFonts.cairo().copyWith(
    fontSize: 19,
  );
  static TextStyle smallText = GoogleFonts.cairo().copyWith(
    fontSize: 17,
  );
  static TextStyle verySmallText = GoogleFonts.cairo().copyWith(
    fontSize: 15,
  );
}
