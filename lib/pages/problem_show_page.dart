import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'exam_custom_page.dart';

class ProblemShowPage extends StatelessWidget {
  final List<String> problems = List.generate(10, (index) => '임의의 문장 ${index + 1}');

  ProblemShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generated Problems'),
      ),
      body: ListView.builder(
        itemCount: problems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(problems[index]),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: problems.join('\n')));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('텍스트가 복사되었습니다.')),
                );
              },
              child: Text('텍스트 복사'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExamCustomPage()),
                );
              },
              child: Text('시험지 생성'),
            ),
          ],
        ),
      ),
    );
  }
}