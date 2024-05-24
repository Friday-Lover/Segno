import 'package:flutter/material.dart';

class QuizResult extends StatelessWidget {
  final String examName;
  final int correctAnswers;
  final int totalQuestions;

  const QuizResult({
    super.key,
    required this.examName,
    required this.correctAnswers,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('시험 결과'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '맞은 문제: $correctAnswers / 전체 문제: $totalQuestions',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 결과 이미지 저장 기능 구현
              },
              child: const Text('결과 이미지로 저장하기'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 결과 확인 화면으로 이동
              },
              child: const Text('결과 확인'),
            ),
          ],
        ),
      ),
    );
  }
}