import 'package:flutter/material.dart';
import 'package:segno/Style/style.dart';
import 'result_page.dart';

class ExamPage extends StatelessWidget {
  const ExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam pages',style: AppTheme.textTheme.displaySmall,),
        //backgroundColor: AppTheme.mainColor,
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ResultPage()),
              (route) => false,
          );
        },
        child: Icon(Icons.check),
      ),
    );
  }
}