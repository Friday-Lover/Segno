import 'package:flutter/material.dart';
import 'package:segno/Style/style.dart';
import 'package:segno/genarator/problem_selection_page.dart';

class TextInputPage extends StatefulWidget {
  const TextInputPage({super.key});

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
          automaticallyImplyLeading: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.95),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset("assets/images/back-arrow.png"),
              ),
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
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
            ),
            const SizedBox(height: 50.0),
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
                      fixedSize: const Size(300,50)
                  ),
                  child: const Text('확인'),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                             ProblemSelectionPage(value)),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
