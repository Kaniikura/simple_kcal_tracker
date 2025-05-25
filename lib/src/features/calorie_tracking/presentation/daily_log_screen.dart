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
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            "Add Calorie Entry",
            style: theme.textTheme.titleLarge?.copyWith(fontFamily: GoogleFonts.manrope().fontFamily),
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
                ),
                style: GoogleFonts.manrope(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () async {
                final amount = int.tryParse(calorieController.text);
                if (amount != null && amount > 0) {
                  final newEntry = CalorieEntry(
                    amount: amount,
                    createdAt: DateTime.now(), // For new entries, createdAt is now
                  );
                  try {
                    await ref
                        .read(calorieRepositoryProvider)
                        .addEntry(newEntry);
                    Navigator.of(dialogContext).pop();
                  } catch (e) {
                    debugPrint("Error adding entry: $e");
                  }
                } else {
                  debugPrint("Invalid calorie amount entered");
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditCalorieDialog(BuildContext context, WidgetRef ref, CalorieEntry entry) {
    final TextEditingController calorieController =
        TextEditingController(text: entry.amount.toString());
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            "Edit Calorie Entry",
            style: theme.textTheme.titleLarge?.copyWith(fontFamily: GoogleFonts.manrope().fontFamily),
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
                ),
                style: GoogleFonts.manrope(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              child: const Text("Save"),
              onPressed: () async {
                final amount = int.tryParse(calorieController.text);
                if (amount != null && amount > 0) {
                  final updatedEntry = CalorieEntry(
                    amount: amount,
                    createdAt: entry.createdAt, // Preserve original createdAt
                  )..id = entry.id; // Preserve original id
                  try {
                    await ref
                        .read(calorieRepositoryProvider)
                        .updateEntry(updatedEntry);
                    Navigator.of(dialogContext).pop();
                  } catch (e) {
                    debugPrint("Error updating entry: $e");
                  }
                } else {
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            'lib/src/assets/icons/caret_left.svg',
            colorFilter: ColorFilter.mode(
                theme.appBarTheme.iconTheme?.color ?? theme.colorScheme.onSurface,
                BlendMode.srcIn),
            width: 24,
            height: 24,
          ),
          onPressed: () {
            ref.read(selectedDateProvider.notifier).goToPreviousDay();
          },
        ),
        title: Text(_formatDate(selectedDate)),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'lib/src/assets/icons/caret_right.svg',
              colorFilter: ColorFilter.mode(
                  theme.appBarTheme.actionsIconTheme?.color ?? theme.appBarTheme.iconTheme?.color ?? theme.colorScheme.onSurface,
                  BlendMode.srcIn),
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
                style: theme.textTheme.titleLarge,
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
                        style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
                      ),
                    ),
                  );
                }
                return Expanded( // Added Expanded here
                  child: ListView.separated(
                    shrinkWrap: true, // Can be true if parent is not Expanded, but Expanded is better here
                    // physics: const NeverScrollableScrollPhysics(), // Not needed if ListView is Expanded
                    itemCount: entries.length,
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      return Dismissible(
                        key: ValueKey(entry.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: theme.colorScheme.errorContainer,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Icon(
                            Icons.delete,
                            color: theme.colorScheme.onErrorContainer,
                          ),
                        ),
                        onDismissed: (direction) async {
                          try {
                            await ref.read(calorieRepositoryProvider).deleteEntry(entry.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Entry deleted', style: GoogleFonts.manrope()),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          } catch (e) {
                             debugPrint("Error deleting entry: $e");
                             ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error deleting entry', style: GoogleFonts.manrope()),
                                duration: const Duration(seconds: 2),
                                backgroundColor: theme.colorScheme.error,
                              ),
                            );
                          }
                        },
                        child: MealListItem(
                          entry: entry,
                          onTap: () => _showEditCalorieDialog(context, ref, entry),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        Divider(height: 1, color: theme.dividerColor),
                  ),
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
        child: SvgPicture.asset(
          'lib/src/assets/icons/plus.svg',
          colorFilter: ColorFilter.mode(
            theme.floatingActionButtonTheme.foregroundColor ?? Colors.white,
            BlendMode.srcIn
          ),
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
