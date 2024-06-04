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
  late String date;
  late String passage;
  late String path;
  final questions = IsarLinks<QuestionFile>();
  var examResults = IsarLinks<ExamResult>();

  ExamFile({required this.passage, required this.examName, required this.path, required this.date});
}

@collection
class QuestionFile {
  Id id = Isar.autoIncrement;
  late String question;
  late List<String> choices;
  late int answer;
  late String comment;
  late String highlight;
  late String type;

  QuestionFile({
    required this.question,
    required this.choices,
    required this.answer,
    required this.comment,
    required this.highlight,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'choices': choices,
      'answer': answer,
      'comment': comment,
      'highlight': highlight,
      'type' : type,
    };
  }
}

@collection
class ExamResult {
  Id id = Isar.autoIncrement;
  late String examName;
  late String date;
  late int correctNumber;
  late int totalNumber;
  late List<int> selectedChoices;

  ExamResult({
    required this.examName,
    required this.selectedChoices,
    required this.correctNumber,
    required this.totalNumber,
    required this.date,
  });
}
