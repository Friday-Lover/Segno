import 'dart:async';

import 'package:flutter/material.dart';
import 'package:segno/main/file_manager.dart';
import 'package:segno/quiz/quiz_result.dart';
import '../style/style.dart';

class QuizScreen extends StatefulWidget {
  final int timerValue;

  const QuizScreen({super.key, required this.timerValue});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int timer = 0; // 타이머 초기값 (분 단위)
  late Timer _timer;

  //for testing
  String text = """
  import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(new ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NumberPicker Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Integer'),
              Tab(text: 'Decimal'),
            ],
          ),
          title: Text('Numberpicker example'),
        ),
        body: TabBarView(
          children: [
            _IntegerExample(),
            _DecimalExample(),
          ],
        ),
      ),
    );
  }
}

class _IntegerExample extends StatefulWidget {
  @override
  __IntegerExampleState createState() => __IntegerExampleState();
}

class __IntegerExampleState extends State<_IntegerExample> {
  int _currentIntValue = 10;
  int _currentHorizontalIntValue = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        Text('Default', style: Theme.of(context).textTheme.headline6),
        NumberPicker(
          value: _currentIntValue,
          minValue: 0,
          maxValue: 100,
          step: 10,
          haptics: true,
          onChanged: (value) => setState(() => _currentIntValue = value),
        ),
        SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => setState(() {
                final newValue = _currentIntValue - 10;
                _currentIntValue = newValue.clamp(0, 100);
              }),
            ),
            Text('Current int value: '),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => setState(() {
                final newValue = _currentIntValue + 20;
                _currentIntValue = newValue.clamp(0, 100);
              }),
            ),
          ],
        ),
        Divider(color: Colors.grey, height: 32),
        SizedBox(height: 16),
        Text('Horizontal', style: Theme.of(context).textTheme.headline6),
        NumberPicker(
          value: _currentHorizontalIntValue,
          minValue: 0,
          maxValue: 100,
          step: 10,
          itemHeight: 100,
          axis: Axis.horizontal,
          onChanged: (value) =>
              setState(() => _currentHorizontalIntValue = value),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black26),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => setState(() {
                final newValue = _currentHorizontalIntValue - 10;
                _currentHorizontalIntValue = newValue.clamp(0, 100);
              }),
            ),
            Text('Current horizontal int value: '),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => setState(() {
                final newValue = _currentHorizontalIntValue + 20;
                _currentHorizontalIntValue = newValue.clamp(0, 100);
              }),
            ),
          ],
        ),
      ],
    );
  }
}

class _DecimalExample extends StatefulWidget {
  @override
  __DecimalExampleState createState() => __DecimalExampleState();
}

class __DecimalExampleState extends State<_DecimalExample> {
  double _currentDoubleValue = 3.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        Text('Decimal', style: Theme.of(context).textTheme.headline6),
        DecimalNumberPicker(
          value: _currentDoubleValue,
          minValue: 0,
          maxValue: 10,
          decimalPlaces: 2,
          onChanged: (value) => setState(() => _currentDoubleValue = value),
        ),
        SizedBox(height: 32),
      ],
    );
  }
}
  """;

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
                  text,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('창닫기'),
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
      }
    });
  }

  void goToNextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      }
    });
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

  void endQuiz() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizResult(
          questions: questions,
          selectedChoices: selectedChoices,
        ),
      ),
    );
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
    Question currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Segno', style: AppTheme.textTheme.displaySmall),
        backgroundColor: AppTheme.mainColor,
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
                      style: TextStyle(fontSize: 24),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.mainColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: AppTheme.textTheme.displaySmall,
                        fixedSize: Size(250, 70),
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
                          icon: Icon(Icons.arrow_left),
                          onPressed: goToPreviousQuestion,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 30, bottom: 20),
                              child: TextButton(
                                child: Text("본문보기"),
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
                                  currentQuestion.text,
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
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
                          icon: Icon(Icons.arrow_right),
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
      bottomNavigationBar: Row(
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
