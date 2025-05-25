import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MealListItem extends StatelessWidget {
  final String calories;
  final String time;

  const MealListItem({
    super.key,
    required this.calories,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
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
                calories,
                style: GoogleFonts.manrope(
                  textStyle: const TextStyle(
                    color: Color(0xFF111518),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                time,
                style: GoogleFonts.manrope(
                  textStyle: const TextStyle(
                    color: Color(0xFF637688),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
