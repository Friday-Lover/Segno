import 'dart:async';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:segno/db/file_db.dart';
import 'package:segno/main/file_manager.dart';
import 'package:segno/quiz/quiz_result.dart';
import '../style/style.dart';

class QuizScreen extends StatefulWidget {
  final int timerValue;
  final String passage;
  final String examName;
  final List<QuestionFile> questions;

  const QuizScreen({
    super.key,
    required this.timerValue,
    required this.passage,
    required this.questions, required this.examName,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int timer = 0;
  late Timer _timer;
  List<int?> selectedChoices = [];

  void showTextPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.passage,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('창닫기'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void goToPreviousQuestion() {
    setState(() {
      if (currentQuestionIndex > 0) {
        currentQuestionIndex--;
      } else {
        // 첫 번째 문제일 경우 아무 동작 하지 않음
        return;
      }
    });
  }

  void goToNextQuestion() {
    setState(() {
      if (currentQuestionIndex < widget.questions.length - 1) {
        currentQuestionIndex++;
      } else {
        // 마지막 문제일 경우 팝업 표시
        showLastQuestionPopup();
      }
    });
  }

  void showLastQuestionPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            Navigator.of(context).pop();
          }
        });

        return const AlertDialog(
          content: Text("마지막 문제입니다."),
        );
      },
    );
  }

  void selectChoice(int questionIndex, int choiceIndex) {
    setState(() {
      selectedChoices[questionIndex] = choiceIndex;
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      setState(() {
        if (this.timer == 0) {
          _timer.cancel();
        } else {
          this.timer--;
        }
      });
    });
  }

  String getTimerText() {
    int minutes = timer ~/ 60;
    int seconds = timer % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void endQuiz() async {
    int correctAnswers = 0;
    int totalQuestions = widget.questions.length;

    for (int i = 0; i < widget.questions.length; i++) {
      if (selectedChoices[i] != null && selectedChoices[i]! + 1 == widget.questions[i].answer) {
        correctAnswers++;
      }
    }

    await saveQuizResult(correctAnswers, totalQuestions);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResult(
          examName: widget.examName,
          correctAnswers: correctAnswers,
          totalQuestions: totalQuestions,
        ),
      ),
    );
  }

  Future<void> saveQuizResult(int correctAnswers, int totalQuestions) async {
    final examFile = await isar.examFiles.filter().examNameEqualTo(widget.examName).findFirst();

    if (examFile != null) {
      final examResult = ExamResult(
        examName: widget.examName,
        selectedChoices: selectedChoices.map((choice) => choice ?? -1).toList(),
        correctNumber: correctAnswers,
        totalNumber: totalQuestions,
      );

      await isar.writeTxn(() async {
        await isar.examResults.put(examResult);
        examFile.examResults.add(examResult);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    selectedChoices = List<int?>.filled(questions.length, null);
    timer = widget.timerValue * 60; // 이전 파일에서 받아온 값을 초 단위로 변환하여 타이머 초기값으로 설정
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    QuestionFile currentQuestion = widget.questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Segno', style: AppTheme.textTheme.displaySmall),
        backgroundColor: AppTheme.mainColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTimerText(),
                      style: const TextStyle(fontSize: 24),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.mainColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: AppTheme.textTheme.displaySmall,
                        fixedSize: const Size(250, 70),
                      ),
                      child: const Text('시험 종료'),
                      onPressed: () {
                        endQuiz();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_left),
                          onPressed: goToPreviousQuestion,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 30, bottom: 20),
                              child: TextButton(
                                child: const Text("본문보기"),
                                onPressed: () {
                                  showTextPopup(context);
                                },
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              height: MediaQuery.of(context).size.height * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: AppTheme.mainColor,
                                  style: BorderStyle.solid,
                                  width: 5,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  currentQuestion.question,
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                  currentQuestion.choices.length, (index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: selectedChoices[
                                                  currentQuestionIndex] ==
                                              index
                                          ? Colors.blue
                                          : null,
                                      minimumSize: Size(MediaQuery.of(context).size.width * 0.6, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      textStyle: AppTheme.textTheme.labelLarge,
                                    ),
                                    child: Text(currentQuestion.choices[index]),
                                    onPressed: () {
                                      selectChoice(currentQuestionIndex, index);
                                    },
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_right),
                          onPressed: goToNextQuestion,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.circle, color: Colors.blue),
          SizedBox(width: 10),
          Icon(Icons.circle, color: Colors.grey),
          SizedBox(width: 10),
          Icon(Icons.circle, color: Colors.grey),
          SizedBox(width: 10),
          Icon(Icons.circle, color: Colors.grey),
          SizedBox(width: 10),
          Icon(Icons.circle, color: Colors.grey),
        ],
      ),
    );
  }
}
