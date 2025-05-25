import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalCaloriesCard extends StatelessWidget {
  final int totalCalories;

  const TotalCaloriesCard({
    super.key,
    required this.totalCalories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2F4),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Total Calories",
            style: GoogleFonts.manrope(
              textStyle: const TextStyle(
                color: Color(0xFF111518),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            totalCalories.toString(),
            style: GoogleFonts.manrope(
              textStyle: const TextStyle(
                color: Color(0xFF111518),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
