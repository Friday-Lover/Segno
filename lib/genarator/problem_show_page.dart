import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:segno/Style/style.dart';
import 'package:segno/main/file_manager.dart';

class ProblemShowPage extends StatefulWidget {
  final String value; // value 필드 추가

  const ProblemShowPage(this.value, {super.key});
  @override
  _ProblemShowPageState createState() => _ProblemShowPageState();
}


class _ProblemShowPageState extends State<ProblemShowPage> {

  List<Question> questions = [
    Question('문제 1 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
        ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 1, "해설 ㅁㅁㅁㅁ"),
    Question('문제 2!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
        ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 2, "해설 ㅁㅁㅁㅁ"),
    Question('문제 3 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
        ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 3, "해설 ㅁㅁㅁㅁ"),
    Question('문제 4!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
        ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 4, "해설 ㅁㅁㅁㅁ"),
    Question('문제 5 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
        ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 5, "해설 ㅁㅁㅁㅁ"),
    Question('문제 6!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
        ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 2, "해설 ㅁㅁㅁㅁ"),
    Question('문제 7 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
        ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 3, "해설 ㅁㅁㅁㅁ"),
    Question('문제 8!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
        ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 3, "해설 ㅁㅁㅁㅁ"),
    Question('문제 9 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
        ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 1, "해설 ㅁㅁㅁㅁ"),
    Question('문제 10!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
        ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 2, "해설 ㅁㅁㅁㅁ"),
    Question('문제 11 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
        ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 3, "해설 ㅁㅁㅁㅁ"),
    Question('문제 12!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!',
        ['선택지 1', '선택지 2', '선택지 3', '선택지 4', '선택지 5'], 3, "해설 ㅁㅁㅁㅁ"),
  ];

  void copyQuestion(List<Question> questions) {
    String copiedText = '';

    copiedText += widget.value+ "\n\n";

    for (int i = 0; i < questions.length; i++) {
      final question = questions[i];
      copiedText += '문제 ${i + 1}: ${question.text}\n';
      for (int j = 0; j < question.choices.length; j++) {
        copiedText += '${j + 1}: ${question.choices[j]}\n';
      }
      copiedText += '\n';
    }

    copiedText += '정답: ${questions.map((question) => question.answer).join(', ')}';

    Clipboard.setData(ClipboardData(text: copiedText));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('문제와 선택지가 복사되었습니다.')),
    );
  }

  Future<void> saveQuestionToFile(List<Question> questions) async {
    String fileName = await _showSaveDialog(context) ?? '';
    if (fileName.isEmpty) return;

    String fileContent = '';

    for (int i = 0; i < questions.length; i++) {
      final question = questions[i];
      fileContent += '문제 ${i + 1}: ${question.text}\n';
      for (int j = 0; j < question.choices.length; j++) {
        fileContent += '선택지 ${j + 1}: ${question.choices[j]}\n';
      }
      fileContent += '\n';
    }

    fileContent += '정답: ${questions.map((question) => question.answer).join(', ')}';

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName.txt');
    await file.writeAsString(fileContent);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('파일이 저장되었습니다.')),
    );
    Navigator.pop(context);
  }

  Future<String?> _showSaveDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String fileName = '';
        return AlertDialog(
          title: Text('파일 이름 입력'),
          content: TextField(
            onChanged: (value) {
              fileName = value;
            },
            decoration: InputDecoration(hintText: '파일 이름을 입력하세요'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('저장'),
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
        title: Text('Segno',style: AppTheme.textTheme.displaySmall,),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.mainColor),
              borderRadius: BorderRadius.circular(8),

            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(question.text,style: AppTheme.textTheme.bodyLarge,),
                  ),
                ),
                Column(
                  children: question.choices.map((choice) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(choice, style: AppTheme.textTheme.bodyLarge,),
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
                  fixedSize: Size(300,50)
              ),
              child: const Text('문제텍스트로 복사'),
              onPressed: () {
                copyQuestion(questions);
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
                  fixedSize: Size(300,50)
              ),
              child: const Text('문제 저장'),
              onPressed: () {
                saveQuestionToFile(questions);
              },
            ),
          ],
        ),
      ),
    );
  }
}
