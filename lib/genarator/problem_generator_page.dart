import 'package:flutter/material.dart';
import 'package:segno/Style/style.dart';
import 'package:segno/genarator/problem_show_page.dart';

class ProblemGeneratorPage extends StatefulWidget {
  final String value; // value 필드 추가

  const ProblemGeneratorPage(this.value, {super.key}); // 생성자에서 value 초기화

  @override
  _ProblemGeneratorPageState createState() => _ProblemGeneratorPageState();
}

class _ProblemGeneratorPageState extends State<ProblemGeneratorPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProblemShowPage(widget.value)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text('Segno',style: AppTheme.textTheme.displaySmall),
        backgroundColor: AppTheme.mainColor,
      ),
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