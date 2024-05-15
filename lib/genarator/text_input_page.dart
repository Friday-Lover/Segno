import 'package:flutter/material.dart';
import 'package:segno/Style/style.dart';
import 'package:segno/genarator/problem_generator_page.dart';

class TextInputPage extends StatefulWidget {
  @override
  _TextInputPageState createState() => _TextInputPageState();
}

class _TextInputPageState extends State<TextInputPage> {
  final TextEditingController _textController = TextEditingController();

  late String value ="";

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          title:  Text('Segno',style: AppTheme.textTheme.displaySmall),
          backgroundColor: AppTheme.mainColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 450,
                child: TextField(
                  minLines: 20,//기기별 수정 필요
                  controller: _textController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: '문제 생성에 사용할 지문을 입력하세요',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (text) {
                    value = text;
                  },
                ),
              ),
              const SizedBox(height: 100.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.mainColor,
                        foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: AppTheme.textTheme.labelLarge,
                      fixedSize: Size(300,50)
                    ),
                    child: const Text('Scan 하기'),
                    onPressed: () {},
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.mainColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: AppTheme.textTheme.labelLarge,
                        fixedSize: Size(300,50)
                    ),
                    child: const Text('확인'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                               ProblemGeneratorPage(value)),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
