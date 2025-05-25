import 'package:isar/isar.dart';
import 'package:calorie_tracker_app/src/features/calorie_tracking/data/calorie_entry.dart';

class CalorieRepository {
  final Isar isar;

  CalorieRepository(this.isar);

  Future<List<CalorieEntry>> getEntriesForDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
    return await isar.calorieEntrys
        .filter()
        .createdAtBetween(startOfDay, endOfDay)
        .findAll();
  }

  Future<List<CalorieEntry>> getAllEntries() async {
    return await isar.calorieEntrys.where().findAll();
  }

  Future<void> addEntry(CalorieEntry entry) async {
    await isar.writeTxn(() async {
      await isar.calorieEntrys.put(entry);
    });
  }

  Future<void> updateEntry(CalorieEntry entry) async {
    await isar.writeTxn(() async {
      await isar.calorieEntrys.put(entry); // put handles create and update
    });
  }

  Future<bool> deleteEntry(Id entryId) async {
    return await isar.writeTxn(() async {
      return await isar.calorieEntrys.delete(entryId);
    });
  }

  Stream<List<CalorieEntry>> watchEntriesForDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
    return isar.calorieEntrys
        .filter()
        .createdAtBetween(startOfDay, endOfDay)
        .watch(fireImmediately: true);
  }
}
