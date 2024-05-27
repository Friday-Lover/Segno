// quiz_start.dart
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:segno/main/file_manager.dart';
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
  int quizTotal = questions.length;
  int _currentIntValue = 10;
  bool _unlimitedTime = false;

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
        children: [
          Padding(
            padding:
                EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.9),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset("assets/images/back-arrow.png"),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Text(
                "총 ${quizTotal ~/ 6}문제",
                style: AppTheme.textTheme.displaySmall,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/timer.png",
                      width: 100, height: 100),
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppTheme.mainColor,
                          style: BorderStyle.solid,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: NumberPicker(
                      textStyle: AppTheme.textTheme.labelLarge,
                      minValue: 5,
                      maxValue: 60,
                      value: _currentIntValue,
                      step: 5,
                      onChanged: (value) =>
                          setState(() => _currentIntValue = value),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    "분",
                    style: AppTheme.textTheme.displaySmall,
                  )
                ],
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      checkColor: AppTheme.mainColor,
                        value: _unlimitedTime,
                        onChanged: (value) {
                          setState(() {
                            _unlimitedTime = value!;
                          });
                        }

                        ),
                    Text("시간 제한없이 보기",style: AppTheme.textTheme.labelLarge,)
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
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
                        unlimited: _unlimitedTime,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
