import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  // ================= COLORS =================
  static const Color primaryColor = Color(0xFFFF6A00);
  static const Color backgroundColor = Color(0xFFC3C3C3);

  // ================= RESPONSIVE SCALE =================
  static double _scale(BuildContext context, double size) {
    final screenWidth = MediaQuery.of(context).size.width;
    const double baseWidth = 375.0;
    return (size / baseWidth) * screenWidth;
  }

  // ================= TEXT =================
  static TextStyle text({
    BuildContext? context,        // optional — existing widgets pass nothing
    double size = 14,
    Color? color,
    FontWeight weight = FontWeight.w400,
    double height = 1.4,
  }) {
    return GoogleFonts.manrope(
      fontSize: context != null ? _scale(context, size) : size,  // scale only if context passed
      color: color,
      fontWeight: weight,
      height: height,
    );
  }
}