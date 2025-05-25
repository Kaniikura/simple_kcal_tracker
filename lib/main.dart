import 'package:calorie_tracker_app/src/core/isar_service.dart';
import 'package:calorie_tracker_app/src/core/providers.dart';
import 'package:calorie_tracker_app/src/features/calorie_tracking/presentation/daily_log_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isarService = IsarService();
  final Isar isar = await isarService.init();

  runApp(
    ProviderScope(
      overrides: [
        isarInstanceProvider.overrideWithValue(isar),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calorie Tracker',
      theme: ThemeData(
        fontFamily: GoogleFonts.manrope().fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const DailyLogScreen(),
    );
  }
}
