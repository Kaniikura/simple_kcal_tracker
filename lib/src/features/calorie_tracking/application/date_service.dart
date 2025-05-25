import 'package:flutter_riverpod/flutter_riverpod.dart';

DateTime _normalizeDate(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

class SelectedDateNotifier extends StateNotifier<DateTime> {
  SelectedDateNotifier() : super(_normalizeDate(DateTime.now()));

  void selectDate(DateTime date) {
    state = _normalizeDate(date);
  }

  void goToNextDay() {
    state = _normalizeDate(state.add(const Duration(days: 1)));
  }

  void goToPreviousDay() {
    state = _normalizeDate(state.subtract(const Duration(days: 1)));
  }
}

final selectedDateProvider =
    StateNotifierProvider<SelectedDateNotifier, DateTime>((ref) {
  return SelectedDateNotifier();
});
