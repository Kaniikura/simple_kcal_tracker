import 'package:calorie_tracker_app/src/features/calorie_tracking/data/calorie_entry.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MealListItem extends StatelessWidget {
  final CalorieEntry entry;
  final VoidCallback? onTap;

  const MealListItem({
    super.key,
    required this.entry,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        color: theme.cardColor, // Use theme color
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        constraints: const BoxConstraints(minHeight: 72.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${entry.amount} cal",
                  style: theme.textTheme.titleMedium?.copyWith(fontFamily: GoogleFonts.manrope().fontFamily, fontWeight: FontWeight.w500), // Use theme text style
                ),
                Text(
                  DateFormat.jm().format(entry.createdAt), // Format time from CalorieEntry
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontFamily: GoogleFonts.manrope().fontFamily,
                    color: theme.hintColor, // Use theme hint color
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
