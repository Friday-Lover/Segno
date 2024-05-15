import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segno'),
        actions: [
          TextButton(
            onPressed: () {
              // 시험 종료 버튼 클릭 시 동작
            },
            child: Text(
              '시험 종료',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '1. 문제1 내용 abcdefasdfasdfqfasfasdf',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // 선택지1 클릭 시 동작
                  },
                  child: Text('선택지1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 선택지2 클릭 시 동작
                  },
                  child: Text('선택지2'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 선택지3 클릭 시 동작
                  },
                  child: Text('선택지3'),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // 선택지4 클릭 시 동작
                  },
                  child: Text('선택지4'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 선택지5 클릭 시 동작
                  },
                  child: Text('선택지5'),
                ),
              ],
            ),
          ],
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