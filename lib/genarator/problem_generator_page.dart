import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:segno/Style/style.dart';
import 'package:segno/db/file_db.dart';
import 'package:segno/genarator/problem_show_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:http/http.dart' as http;

class ProblemGeneratorPage extends StatefulWidget {
  final String passage;
  final List<Map<String, dynamic>> questionTypes;

  const ProblemGeneratorPage({
    super.key,
    required this.passage,
    required this.questionTypes,
  });

  @override
  _ProblemGeneratorPageState createState() => _ProblemGeneratorPageState();
}

class _ProblemGeneratorPageState extends State<ProblemGeneratorPage> {
  bool _isLoading = true;
  bool _isError = false;

  Future<List<QuestionFile>> generateQuestions(
      String passage, List<Map<String, dynamic>> questionTypes) async {
    const url = 'https://asia-northeast3-segno-a4dbc.cloudfunctions.net/Question_Generator';
    final requestBody = {
      'passage': passage,
      'questionTypes': questionTypes,
    };
    final response = await http.post(
      Uri.parse(url),
      body: json.encode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );
    debugPrint(response.body);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<QuestionFile> questions =
      responseData['question'].map<QuestionFile?>((questionData) {
        try {
          final choices = List<String>.from(questionData['choices']);
          final answerString = questionData['answer'].toString().toLowerCase();

          // 정답이 문자열인 경우 숫자로 변환
          int answer;
          if (answerString == 'a') {
            answer = 1;
          } else if (answerString == 'b') {
            answer = 2;
          } else if (answerString == 'c') {
            answer = 3;
          } else if (answerString == 'd') {
            answer = 4;
          } else if (answerString == 'e') {
            answer = 5;
          } else {
            answer = int.parse(answerString);
          }

          // 선택지 셔플
          final shuffledChoices = List<String>.from(choices)..shuffle();
          // 정답 인덱스 찾기
          final answerIndex = shuffledChoices.indexOf(choices[answer - 1]);

          return QuestionFile(
            question: questionData['text'],
            choices: shuffledChoices,
            answer: answerIndex + 1,
            comment: questionData['comment'],
            highlight: questionData['highlight'] ?? '',
            type: questionData['type'],
          );
        } catch (e) {
          //debugPrint('Invalid question format: ${e.toString()}');
          return null;
        }
      }).whereType<QuestionFile>().toList();
      // questions 리스트 셔플
      questions.shuffle();
      return questions;
    } else {
      final errorData = json.decode(response.body) as Map<String, dynamic>;
      final errorMessage = errorData['error']?.toString() ?? 'Unknown error';
      final errorDetails = errorData['details']?.toString() ?? 'No details';
      throw Exception('Failed to generate questions. '
          'Status code: ${response.statusCode}, '
          'Error message: $errorMessage, '
          'Details: $errorDetails');
    }
  }

  Future<void> _generateQuestions() async {
    try {
      final questions = await generateQuestions(
        widget.passage,
        widget.questionTypes,
      ).timeout(const Duration(seconds: 180));

      // 결과 처리 및 다음 페이지로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ProblemShowPage(
              widget.passage,
              questions: questions,
            )),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
        _isError = true;
      });

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('오류'),
          content: Text(e.toString()), // 실제 오류 메시지를 표시
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('확인'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Segno', style: AppTheme.textTheme.displaySmall),
        backgroundColor: AppTheme.mainColor,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: _isLoading
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.hexagonDots(
              color: AppTheme.mainColor,
              size: 200,
            ),
            const SizedBox(height: 16.0),
            Text(
              '문제를 생성하고 있습니다...',
              style: AppTheme.textTheme.displaySmall,
            ),
          ],
        )
            : _isError
            ? Container()
            : Container(),
      ),
    );
  }
}