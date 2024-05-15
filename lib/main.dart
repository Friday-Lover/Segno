import 'package:flutter/material.dart';
import 'package:segno/main/start_page.dart';
import 'Style/style.dart';

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
      debugShowCheckedModeBanner: false,
      home: MainPage(folder: Folder(name: 'root folder')),
    );
  }
}
