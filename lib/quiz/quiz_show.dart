import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:segno/Style/style.dart';
import 'package:segno/db/file_db.dart';
import 'package:segno/quiz/quiz_start.dart';

final getIt = GetIt.instance;
final isar = getIt.get<Isar>();

class QuizShowPage extends StatefulWidget {
  final String examName; // examName 필드로 변경
  final String passage; // value 필드 추가

  const QuizShowPage(this.examName,this.passage, {super.key});

  @override
  _QuizShowPageState createState() => _QuizShowPageState();
}

class _QuizShowPageState extends State<QuizShowPage> {
  List<QuestionFile> questionTest = [];

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

  Future<void> loadQuestions() async {
    final examFile = await isar.examFiles
        .filter()
        .examNameEqualTo(widget.examName) // examName으로 필터링
        .findFirst();

    if (examFile != null) {
      setState(() {
        questionTest = examFile.questions.toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadQuestions();
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
      body: ListView.builder(
        itemCount: questionTest.length,
        itemBuilder: (context, index) {
          final question = questionTest[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.mainColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      question.question,
                      style: AppTheme.textTheme.bodyLarge,
                    ),
                  ),
                ),
                Column(
                  children: question.choices.map((choice) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        choice,
                        style: AppTheme.textTheme.bodyLarge,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
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
                copyQuestion(questionTest);
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
              child: const Text('시험 보기'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizStart(
                      examName: widget.examName,
                      passage: widget.passage,
                      questions: questionTest,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
