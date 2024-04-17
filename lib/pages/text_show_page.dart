import 'package:flutter/material.dart';
import '../Style/style.dart';
import 'problem_generator_page.dart';
import 'problem_custom_page.dart';

class TextShowPage extends StatelessWidget {
  final String inputText;

  const TextShowPage({required this.inputText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('입력한 텍스트'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '입력한 텍스트입니다:',
                style: AppTheme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  inputText,
                  style: AppTheme.textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: const Text('Auto'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProblemGeneratorPage()),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Custom'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProblemCustomPage()),
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