import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calorie_tracker_app/src/features/calorie_tracking/data/calorie_repository.dart';

final isarInstanceProvider = Provider<Isar>((ref) {
  // This will be overridden in main.dart's ProviderScope
  throw UnimplementedError('Isar instance not provided');
});

final calorieRepositoryProvider = Provider<CalorieRepository>((ref) {
  final isar = ref.watch(isarInstanceProvider);
  return CalorieRepository(isar);
});
