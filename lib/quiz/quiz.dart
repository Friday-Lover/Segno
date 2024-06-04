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
  final bool unlimited;

  const QuizScreen({
    super.key,
    required this.timerValue,
    required this.passage,
    required this.questions,
    required this.examName,
    required this.unlimited,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int timer = 0;
  Timer? _timer;
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
        // 마지막 문제일 경우 아무 동작 하지 않음
        //showLastQuestionPopup();
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
      if (selectedChoices[questionIndex] == choiceIndex) {
        selectedChoices[questionIndex] = null;
      } else {
        selectedChoices[questionIndex] = choiceIndex;
      }
    });
  }

  void startTimer() {
    if (!widget.unlimited) {
      const oneSec = Duration(seconds: 1);
      _timer = Timer.periodic(oneSec, (Timer timer) {
        setState(() {
          if (this.timer == 0) {
            _timer?.cancel();
          } else {
            this.timer--;
          }
        });
      });
    }
  }

  String getTimerText() {
    int minutes = timer ~/ 60;
    int seconds = timer % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void endQuiz() async {
    int correctAnswers = 0;
    int totalQuestions = widget.questions.length;

    final examFile = await isar.examFiles
        .filter()
        .examNameEqualTo(widget.examName)
        .findFirst();

    for (int i = 0; i < widget.questions.length; i++) {
      if (selectedChoices[i] != null &&
          selectedChoices[i]! + 1 == widget.questions[i].answer) {
        correctAnswers++;
      }
    }
    final now = DateTime.now();
    final formattedDate = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';


    if (examFile != null) {
      final examResult = ExamResult(
        date: formattedDate,
        examName: widget.examName,
        selectedChoices: selectedChoices.map((choice) => choice ?? -1).toList(),
        correctNumber: correctAnswers,
        totalNumber: totalQuestions,
      );

      await isar.writeTxn(() async {
        await isar.examResults.put(examResult);
        examFile.examResults.add(examResult);
        examFile.examResults.save();
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizResult(
            examName: widget.examName,
            correctAnswers: correctAnswers,
            totalQuestions: totalQuestions,
            examResult: examResult,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    selectedChoices = List<int?>.filled(widget.questions.length, null);
    timer = widget.timerValue * 60; // 이전 파일에서 받아온 값을 초 단위로 변환하여 타이머 초기값으로 설정
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    QuestionFile currentQuestion = widget.questions[currentQuestionIndex];
    int totalPages = (widget.questions.length / 5).ceil();
    int currentPage = (currentQuestionIndex / 5).floor();

    if (timer == 0) {
      endQuiz();
    }

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
                      if (!widget.unlimited)
                        Row(
                          children: [
                            SizedBox(
                                width: 50,
                                height: 50,
                                child: Image.asset("assets/images/timer.png")),
                            const SizedBox(width: 10,),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.mainColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                getTimerText(),
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      if (widget.unlimited) const SizedBox(width: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.mainColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textStyle: AppTheme.textTheme.displaySmall,
                          fixedSize: const Size(250, 60),
                        ),
                        child: const Text('시험 종료'),
                        onPressed: () async {
                          bool? shouldEndQuiz = await showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('시험 종료'),
                                content: const Text('정말로 시험을 종료하시겠습니까?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('아니오'),
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('예'),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          if (shouldEndQuiz ?? false) {
                            endQuiz();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Image.asset("assets/images/direction-arrow_4.png"),
                            style: IconButton.styleFrom(
                                maximumSize: const Size(50,50)
                            ),
                            onPressed: goToPreviousQuestion,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppTheme.subColor,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        textStyle:
                                            AppTheme.textTheme.labelLarge,
                                        fixedSize: const Size(180, 50),
                                      ),
                                      child: const Text("본문 보기"),
                                      onPressed: () {
                                        showTextPopup(context);
                                      },
                                    ),
                                    const Spacer(),
                                    Text(
                                      '문제: ${currentQuestionIndex + 1} / ${widget.questions.length}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    currentQuestion.question,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                ...List.generate(
                                  currentQuestion.choices.length,
                                  (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: selectedChoices[
                                                      currentQuestionIndex] ==
                                                  index
                                              ? AppTheme.mainColor
                                              : Colors.white,
                                          foregroundColor: selectedChoices[
                                                      currentQuestionIndex] ==
                                                  index
                                              ? Colors.white
                                              : AppTheme.mainColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            side: const BorderSide(
                                              color: AppTheme.mainColor,
                                              width: 2,
                                            ),
                                          ),
                                          textStyle:
                                              AppTheme.textTheme.labelLarge,
                                          minimumSize:
                                              const Size(double.infinity, 60),
                                        ),
                                        child: Text(
                                            currentQuestion.choices[index]),
                                        onPressed: () {
                                          selectChoice(
                                              currentQuestionIndex, index);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Image.asset("assets/images/direction-arrow_3.png"),
                            style: IconButton.styleFrom(
                              maximumSize: const Size(50,50)
                            ),
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
        bottomNavigationBar: Container(
          color: AppTheme.mainColor,
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  setState(() {
                    if (currentPage > 0) {
                      currentPage--;
                      currentQuestionIndex = currentPage * 5;
                    }
                  });
                },
              ),
              ...List.generate(5, (index) {
                int questionIndex = currentPage * 5 + index;
                if (questionIndex < widget.questions.length) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentQuestionIndex = questionIndex;
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: selectedChoices[questionIndex] != null
                            ? Colors.green
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          '${questionIndex + 1}',
                          style: TextStyle(
                            color: selectedChoices[questionIndex] != null
                                ? Colors.white
                                : AppTheme.mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox(width: 50);
                }
              }),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                onPressed: () {
                  setState(() {
                    if (currentPage < totalPages - 1) {
                      currentPage++;
                      currentQuestionIndex = currentPage * 5;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
