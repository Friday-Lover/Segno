import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:segno/Style/style.dart';
import 'package:segno/db/file_db.dart';
import 'package:segno/genarator/problem_show_page.dart';
import 'package:http/http.dart' as http;
import 'package:segno/main/file_manager.dart';

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
    final url = 'https://asia-northeast3-segno-a4dbc.cloudfunctions.net/question_test';
    final requestBody = {
      'passage': passage,
      'questionTypes': questionTypes,
    };
    final response = await http.post(
      Uri.parse(url),
      body: json.encode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<QuestionFile> questions =
      responseData['questions'].map<QuestionFile>((questionData) {
        return QuestionFile(
          question: questionData['text'],
          choices: List<String>.from(questionData['choices']),
          answer: questionData['answer'],
          comment: questionData['comment'],
        );
      }).toList();
      return questions;
    } else {
      throw Exception('Failed to generate questions');
    }
  }

  Future<void> _generateQuestions() async {
    try {
      final questions = await generateQuestions(
        widget.passage,
        widget.questionTypes,
      ).timeout(const Duration(seconds: 30));

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
          content: const Text('응답이 없습니다.'),
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
            const CircularProgressIndicator(),
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