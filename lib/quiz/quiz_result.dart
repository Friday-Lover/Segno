import 'package:flutter/material.dart';
import 'package:segno/main/file_manager.dart';

class QuizResult extends StatelessWidget {
  final List<Question> questions;
  final List<int?> selectedChoices;

  QuizResult({required this.questions, required this.selectedChoices});

  @override
  Widget build(BuildContext context) {
    int correctAnswers = 0;
    int totalQuestions = questions.length;

    for (int i = 0; i < questions.length; i++) {
      if (selectedChoices[i] != null && selectedChoices[i]! + 1 == questions[i].answer) {
        correctAnswers++;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('시험 결과'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '맞은 문제: $correctAnswers / 전체 문제: $totalQuestions',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('결과 이미지로 저장하기'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('결과 확인'),
            ),
          ],
        ),
      ),
    );
  }
}