import 'package:flutter/material.dart';
import 'main_page.dart';
import 'exam_page.dart';

class ExamCustomPage extends StatefulWidget {
  @override
  _ExamCustomPageState createState() => _ExamCustomPageState();
}

class _ExamCustomPageState extends State<ExamCustomPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Custom pages'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[200],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: '시험지 제작'),
                    Tab(text: '형태'),
                    Tab(text: '문제 순서'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Container(color: Colors.red[100]),
                      Container(color: Colors.green[100]),
                      Container(color: Colors.blue[100]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('저장'),
                content: Text('시험지를 저장하시겠습니까?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                            (route) => false,
                      );
                    },
                    child: Text('저장'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ExamPage()),
                      );
                    },
                    child: Text('시험'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.save),
      ),
    );
  }
}