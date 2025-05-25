import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:calorie_tracker_app/src/features/calorie_tracking/data/calorie_entry.dart';

class IsarService {
  Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [CalorieEntrySchema],
      directory: dir.path,
    );
    return isar;
  }
}
