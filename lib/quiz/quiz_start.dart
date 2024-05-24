// quiz_start.dart
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:segno/quiz/quiz.dart';
import '../db/file_db.dart';
import '../style/style.dart';

class QuizStart extends StatefulWidget {
  final String examName;
  final String passage;
  final List<QuestionFile> questions;

  const QuizStart({
    super.key,
    required this.examName,
    required this.passage,
    required this.questions,
  });

  @override
  State<QuizStart> createState() => _QuizStartState();
}

class _QuizStartState extends State<QuizStart> {
  int quizTotal = 10;
  int _currentIntValue = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Segno', style: AppTheme.textTheme.displaySmall),
        backgroundColor: AppTheme.mainColor,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "총 $quizTotal문제",
            style: AppTheme.textTheme.displaySmall,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/playstore.png", width: 50, height: 50),
              NumberPicker(
                minValue: 5,
                maxValue: 60,
                value: _currentIntValue,
                step: 5,
                onChanged: (value) => setState(() => _currentIntValue = value),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.black26),
                ),
              ),
              Text(
                "분",
                style: AppTheme.textTheme.displaySmall,
              )
            ],
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
            child: const Text('시험 시작'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizScreen(
                    timerValue: _currentIntValue,
                    passage: widget.passage,
                    questions: widget.questions,
                    examName: widget.examName,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}