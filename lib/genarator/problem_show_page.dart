import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:segno/Style/style.dart';
import 'package:segno/db/file_db.dart';

final getIt = GetIt.instance;
final isar = getIt.get<Isar>();

class ProblemShowPage extends StatefulWidget {
  final String passage;
  final List<QuestionFile> questions;

  const ProblemShowPage(this.passage, {super.key, required this.questions});

  @override
  _ProblemShowPageState createState() => _ProblemShowPageState();
}

class _ProblemShowPageState extends State<ProblemShowPage> {
  void copyQuestion(List<QuestionFile> questions) {
    String copiedText = '';

    copiedText += "${widget.passage}\n\n";

    for (int i = 0; i < questions.length; i++) {
      final question = questions[i];
      copiedText += '문제 ${i + 1}: ${question.question}\n';
      for (int j = 0; j < question.choices.length; j++) {
        copiedText += '${j + 1}: ${question.choices[j]}\n';
      }
      copiedText += '\n';
    }

    copiedText +=
    '정답: ${questions.map((question) => question.answer).join(', ')}';

    Clipboard.setData(ClipboardData(text: copiedText));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('문제와 선택지가 복사되었습니다.')),
    );
  }

  Future<void> saveQuestionToFile(List<QuestionFile> questions) async {
    final questionFiles = questions.map((question) {
      return QuestionFile(
        question: question.question,
        choices: question.choices,
        answer: question.answer,
        comment: question.comment,
        highlight: question.highlight,
        type: question.type,
      );
    }).toList();

    String examName = await _showSaveDialog(context) ?? '';
    if (examName.isEmpty) return;

    final now = DateTime.now();
    final formattedDate = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';

    // 파일 이름 중복 확인
    final existingExamFile =
    await isar.examFiles.filter().examNameEqualTo(examName).findFirst();
    if (existingExamFile != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이미 존재하는 파일 이름입니다.')),
      );
      return;
    }

    final examFile = ExamFile(
      passage: widget.passage,
      date: formattedDate,
      examName: examName,
      path: '/',
    );

    await isar.writeTxn(() async {
      // QuestionFile 인스턴스들을 데이터베이스에 저장하고 ID 목록을 받습니다.
      final questionFileIds = await isar.questionFiles.putAll(questionFiles);

      // 반환된 ID 목록을 사용하여 각 QuestionFile 인스턴스를 ExamFile의 questions에 추가합니다.
      for (var questionFileId in questionFileIds) {
        // 저장된 QuestionFile 인스턴스를 가져옵니다.
        final questionFile = await isar.questionFiles.get(questionFileId);
        if (questionFile != null) {
          // ExamFile의 questions에 추가합니다.
          examFile.questions.add(questionFile);
          examFile.questions.save();
        }
      }
      // ExamFile 인스턴스를 데이터베이스에 저장합니다.
      await isar.examFiles.put(examFile);
    });

    await isar.writeTxn(() async {
      await examFile.questions.save();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('문제가 저장되었습니다.')),
    );
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<String?> _showSaveDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String fileName = '';
        return AlertDialog(
          title: const Text('파일 이름 입력'),
          content: TextField(
            onChanged: (value) {
              fileName = value;
            },
            decoration: const InputDecoration(hintText: '파일 이름을 입력하세요'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('저장'),
              onPressed: () {
                Navigator.of(context).pop(fileName);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppTheme.mainColor,
        title: Text(
          'Segno',
          style: AppTheme.textTheme.displaySmall,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.9),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset("assets/images/back-arrow.png"),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: ListView.builder(
              itemCount: widget.questions.length,
              itemBuilder: (context, index) {
                final question = widget.questions[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: AppTheme.mainColor, width: 3),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: AppTheme.mainColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Text(
                          '문제 ${index + 1}',
                          style: AppTheme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          question.question,
                          style: AppTheme.textTheme.bodyLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: List.generate(question.choices.length, (choiceIndex) {
                            final choice = question.choices[choiceIndex];
                            return Chip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(
                                    color: AppTheme.mainColor, width: 1),
                              ),
                              label: Text(
                                '${choiceIndex + 1}. $choice',
                                style: AppTheme.textTheme.bodyLarge?.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.mainColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: AppTheme.textTheme.labelLarge,
                  fixedSize: const Size(300, 50)),
              child: const Text('문제텍스트로 복사'),
              onPressed: () {
                copyQuestion(widget.questions);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.mainColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: AppTheme.textTheme.labelLarge,
                  fixedSize: const Size(300, 50)),
              child: const Text('문제 저장'),
              onPressed: () {
                saveQuestionToFile(widget.questions);
              },
            ),
          ],
        ),
      ),
    );
  }
}