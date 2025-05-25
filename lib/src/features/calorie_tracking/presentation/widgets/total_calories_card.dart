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
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant, // Use theme color
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Total Calories",
            style: theme.textTheme.titleMedium?.copyWith(fontFamily: GoogleFonts.manrope().fontFamily) , // Use theme text style
          ),
          const SizedBox(height: 4),
          Text(
            totalCalories.toString(),
            style: theme.textTheme.headlineSmall?.copyWith(
              fontFamily: GoogleFonts.manrope().fontFamily,
              fontWeight: FontWeight.bold, // Keep bold as per original design
              letterSpacing: -0.5, // Keep letterSpacing as per original design
            ),
          ),
        ],
      ),
    );
  }
}
