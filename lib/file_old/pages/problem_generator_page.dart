import 'package:flutter/material.dart';
import 'package:segno/Style/style.dart';
import 'package:segno/file_old/pages/text_show_page.dart';

class ProblemGeneratorPage extends StatefulWidget {
  const ProblemGeneratorPage({super.key});

  @override
  _ProblemGeneratorPageState createState() => _ProblemGeneratorPageState();
}

class _ProblemGeneratorPageState extends State<ProblemGeneratorPage> {
  get value => null;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TextShowPage(inputText: value)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16.0),
            Text('문제를 생성하고 있습니다...', style: AppTheme.textTheme.displaySmall,),
          ],
        ),
      ),
    );
  }
}