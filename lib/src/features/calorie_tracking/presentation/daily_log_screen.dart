import 'package:calorie_tracker_app/src/features/calorie_tracking/application/calorie_service.dart';
import 'package:calorie_tracker_app/src/features/calorie_tracking/application/date_service.dart';
import 'package:calorie_tracker_app/src/features/calorie_tracking/data/calorie_entry.dart';
import 'package:calorie_tracker_app/src/features/calorie_tracking/presentation/widgets/meal_list_item.dart';
import 'package:calorie_tracker_app/src/features/calorie_tracking/presentation/widgets/total_calories_card.dart';
import 'package:calorie_tracker_app/src/core/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DailyLogScreen extends ConsumerWidget {
  const DailyLogScreen({super.key});

  void _showAddCalorieDialog(BuildContext context, WidgetRef ref) {
    final TextEditingController calorieController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            "Add Calorie Entry",
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: calorieController,
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Calories (kcal)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: GoogleFonts.manrope(color: Colors.black54),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: Text(
                "Save",
                style: GoogleFonts.manrope(color: const Color(0xFF268AE8)),
              ),
              onPressed: () async {
                final amount = int.tryParse(calorieController.text);
                if (amount != null && amount > 0) {
                  final newEntry = CalorieEntry(
                    amount: amount,
                    createdAt: DateTime.now(),
                  );
                  try {
                    await ref
                        .read(calorieRepositoryProvider)
                        .addEntry(newEntry);
                    Navigator.of(dialogContext).pop();
                  } catch (e) {
                    debugPrint("Error adding entry: $e");
                    // Optionally show an error message to the user
                  }
                } else {
                  // Optionally show an error message for invalid input
                  debugPrint("Invalid calorie amount entered");
                }
              },
            ),
          ],
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);

    if (date == today) {
      return "Today";
    } else if (date == yesterday) {
      return "Yesterday";
    } else if (date == tomorrow) {
      return "Tomorrow";
    } else {
      return DateFormat.yMMMMd().format(date);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final totalCalories = ref.watch(totalCaloriesForSelectedDateProvider);
    final entriesAsyncValue = ref.watch(entriesForSelectedDateProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'lib/src/assets/icons/caret_left.svg',
            colorFilter:
                const ColorFilter.mode(Color(0xFF111518), BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
          onPressed: () {
            ref.read(selectedDateProvider.notifier).goToPreviousDay();
          },
        ),
        title: Text(
          _formatDate(selectedDate),
          style: GoogleFonts.manrope(
            color: const Color(0xFF111518),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'lib/src/assets/icons/caret_right.svg',
              colorFilter:
                  const ColorFilter.mode(Color(0xFF111518), BlendMode.srcIn),
              width: 24,
              height: 24,
            ),
            onPressed: () {
              ref.read(selectedDateProvider.notifier).goToNextDay();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TotalCaloriesCard(totalCalories: totalCalories),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Text(
                "Meals",
                style: GoogleFonts.manrope(
                  textStyle: const TextStyle(
                    color: Color(0xFF111518),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            entriesAsyncValue.when(
              data: (entries) {
                if (entries.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Text(
                        "No records yet.",
                        style: GoogleFonts.manrope(
                          textStyle: const TextStyle(
                            color: Color(0xFF637688),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    return MealListItem(
                      calories: "${entry.amount} cal",
                      time: DateFormat.jm().format(entry.createdAt),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1, color: Color(0xFFEEEEEE)),
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text("Error: $error")),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCalorieDialog(context, ref),
        backgroundColor: const Color(0xFF268AE8),
        shape: const CircleBorder(),
        child: SvgPicture.asset(
          'lib/src/assets/icons/plus.svg',
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
