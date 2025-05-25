import 'package:isar/isar.dart';

part 'calorie_entry.g.dart';

@collection
class CalorieEntry {
  Id id = Isar.autoIncrement;

  late int amount;

  @Index()
  late DateTime createdAt;

  CalorieEntry({
    required this.amount,
    required this.createdAt,
  });
}
