//dart run build_runner build

  import 'package:isar/isar.dart';

  part 'file_db.g.dart';

  @collection
  class Folder {
  Id id = Isar.autoIncrement;
  late String folderName;
  late String path;

  Folder({required this.folderName, required this.path});
  }

  @collection
  class ExamFile {
  Id id = Isar.autoIncrement;
  late String examName;
  late String passage;
  late String path;
  final questions = IsarLinks<QuestionFile>();
  var examResults = IsarLinks<ExamResult>();

  ExamFile({required this.passage, required this.examName, required this.path});
  }

  @collection
  class QuestionFile {
  Id id = Isar.autoIncrement;
  late String question;
  late List<String> choices;
  late int answer;
  late String comment;

  QuestionFile({
  required this.question,
  required this.choices,
  required this.answer,
  required this.comment,
  });
  }

  @collection
  class ExamResult {
  Id id = Isar.autoIncrement;
  late String examName;
  late int correctNumber;
  late int totalNumber;
  late List<int> selectedChoices;

  ExamResult({
    required this.examName,
    required this.selectedChoices,
    required this.correctNumber,
    required this.totalNumber,
  });
}
