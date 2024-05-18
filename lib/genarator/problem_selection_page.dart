import 'package:flutter/material.dart';
import 'package:segno/Style/style.dart';
import 'package:segno/genarator/problem_generator_page.dart';

class ProblemSelectionPage extends StatefulWidget {
  final String value; // value 필드 추가

  const ProblemSelectionPage(this.value, {super.key}); // 생성자에서 value 초기화

  @override
  State<ProblemSelectionPage> createState() => _ProblemSelectionPageState();
}

class _ProblemSelectionPageState extends State<ProblemSelectionPage> {
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
                    child: const Text('문제 만들기'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProblemGeneratorPage(widget.value)),
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
