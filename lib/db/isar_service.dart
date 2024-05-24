// isar_service.dart
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:segno/db/file_db.dart';

final getIt = GetIt.instance;

Future<void> initializeIsar() async {
  if (Isar.instanceNames.isEmpty) {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [FolderSchema, ExamFileSchema, QuestionFileSchema, ExamResultSchema],
      directory: dir.path,
    );
    getIt.registerSingleton<Isar>(isar);
  } else {
    final isar = Isar.getInstance();
    if (isar != null) {
      getIt.registerSingleton<Isar>(isar);
    }
  }
}