import 'package:flutter/material.dart';
import 'Style/style.dart';
import 'pages/start_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Segno',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: StartPage(),
    );
  }
}
