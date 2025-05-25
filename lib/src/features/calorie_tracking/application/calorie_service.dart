import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calorie_tracker_app/src/features/calorie_tracking/data/calorie_entry.dart';
import 'package:calorie_tracker_app/src/features/calorie_tracking/application/date_service.dart';
import 'package:calorie_tracker_app/src/core/providers.dart';

final entriesForSelectedDateProvider =
    StreamProvider.autoDispose<List<CalorieEntry>>((ref) {
  final selectedDate = ref.watch(selectedDateProvider);
  final calorieRepository = ref.watch(calorieRepositoryProvider);
  return calorieRepository.watchEntriesForDate(selectedDate);
});

final totalCaloriesForSelectedDateProvider = Provider.autoDispose<int>((ref) {
  final entriesAsyncValue = ref.watch(entriesForSelectedDateProvider);
  return entriesAsyncValue.when(
    data: (entries) =>
        entries.fold(0, (sum, entry) => sum + entry.amount),
    loading: () => 0, // Or a specific loading state if preferred
    error: (_, __) => 0, // Or handle error appropriately
  );
});
