import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:segno/Style/style.dart';
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
  //cloudfunction으로 보낼내용
  Future<void> generateQuestions(
      String passage, List<Map<String, dynamic>> questionTypes) async {
    final url = 'urlssssssssssssssssssssss';
    final requestBody = {
      'passage': passage,//문제를 생성할 본분 전체
      'questionTypes': questionTypes,//문제 생성하기 위한 유형 및 개수
    };
    final response = await http.post(
      Uri.parse(url),
      body: json.encode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<Question> questions =
          responseData['questions'].map<Question>((questionData) {
        return Question(
          questionData['text'],
          List<String>.from(questionData['choices']),
          questionData['answer'],
          questionData['comment'],
        );
      }).toList();
      // Process the generated questions and update the UI
    } else {
      // Handle the error
    }
  }

  String test()
  {
    String questionTypesText = '';

    for (var questionType in widget.questionTypes) {
      String type = questionType['string'];
      int count = questionType['int'];
      questionTypesText += '$type: $count\n';
    }

    return questionTypesText;
  }


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        //수정 필요
        MaterialPageRoute(builder: (context) => ProblemShowPage(widget.passage)),
      );
    });
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16.0),
            Text(
              '문제를 생성하고 있습니다...',
              style: AppTheme.textTheme.displaySmall,
            ),
            Text(
              widget.passage,
              style: AppTheme.textTheme.displaySmall,
            ),
            Text(
              test(),
              style: AppTheme.textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }
}
