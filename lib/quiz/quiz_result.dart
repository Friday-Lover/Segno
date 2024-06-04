import 'package:flutter/material.dart';
import 'package:segno/answer/answer_main.dart';
import 'package:segno/style/style.dart';

import '../db/file_db.dart';

class QuizResult extends StatelessWidget {
  final String examName;
  final int correctAnswers;
  final int totalQuestions;
  final ExamResult examResult;

  const QuizResult({
    super.key,
    required this.examName,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.examResult,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = (correctAnswers / totalQuestions) * 100;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Segno', style: AppTheme.textTheme.displaySmall),
          backgroundColor: AppTheme.mainColor,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                size: 100,
                color: AppTheme.mainColor,
              ),
              const SizedBox(height: 20),
              Text(
                '시험 결과',
                style: AppTheme.textTheme.displaySmall,
              ),
              const SizedBox(height: 20),
              Text(
                '$correctAnswers / $totalQuestions',
                style: AppTheme.textTheme.displaySmall,
              ),
              const SizedBox(height: 10),
              Text(
                '정답률: ${percentage.toStringAsFixed(1)}%',
                style: AppTheme.textTheme.labelLarge,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.mainColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: AppTheme.textTheme.labelLarge,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                child: const Text('메인 화면으로 이동하기'),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.mainColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: AppTheme.textTheme.labelLarge,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  '결과 확인',
                  style: TextStyle(color: AppTheme.mainColor),
                ),
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizResultScreen(
                        examName: examResult.examName,
                        examResult: examResult,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}