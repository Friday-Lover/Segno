import 'package:flutter/material.dart';

import 'style/style.dart';

class Practice extends StatelessWidget {
  const Practice({super.key});

  //연습할 함수선언은 여기에

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text('Segno',style: AppTheme.textTheme.displaySmall),
        backgroundColor: AppTheme.mainColor,
      ),
      body:
        Column(
          children: const [
            //앱에서 보이는 것은 여기에 (column 제거하고 다른거 써도 무방)
            Text("연습장"),
          ],

      ),
    );
  }
}
