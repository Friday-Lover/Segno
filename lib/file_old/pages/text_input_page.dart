import 'package:flutter/material.dart';
import 'package:segno/Style/style.dart';
import 'text_show_page.dart';

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
          title:  Text('Segno 영어 문제 생성기',style: AppTheme.textTheme.displaySmall),
          //backgroundColor: AppTheme.mainColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
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
              const SizedBox(height: 180.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: const Text('Scan 하기'),
                    onPressed: () {},
                  ),
                  ElevatedButton(
                    child: const Text('확인'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TextShowPage(inputText: value)),
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
