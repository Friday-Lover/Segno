import 'package:flutter/material.dart';
import 'package:segno/db/file_db.dart';
import 'package:segno/quiz/quiz_show.dart';
import '../style/style.dart';

class QuizInfo extends StatefulWidget {
  final String passage;
  final String examName;
  final List<ExamResult> examResults;

  const QuizInfo({
    super.key,
    required this.passage,
    required this.examResults,
    required this.examName,
  });

  @override
  _QuizInfoState createState() => _QuizInfoState();
}

class _QuizInfoState extends State<QuizInfo> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppTheme.mainColor,
        title: Text(
          'Segno',
          style: AppTheme.textTheme.displaySmall,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Text(widget.examName),
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "본문",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: RawScrollbar(
                              controller: _scrollController,
                              thumbColor: Colors.grey,
                              thickness: 8,
                              radius: const Radius.circular(4),
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(widget.passage),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    children: [
                      const Text("시험 이력"),
                      Expanded(
                        flex: 1,
                        child: ListView.builder(
                          itemCount: widget.examResults.length,
                          itemBuilder: (context, index) {
                            final examResult = widget.examResults[index];
                            final selectedChoices = examResult.selectedChoices
                                .asMap()
                                .entries
                                .where((entry) => entry.value != null)
                                .map((entry) => 'Q${entry.key + 1}: ${entry.value + 1}')
                                .join(', ');

                            return ListTile(
                              title: Text(examResult.examName),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Correct: ${examResult.correctNumber} / Total: ${examResult.totalNumber}'),
                                  Text('Selected: $selectedChoices'),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.mainColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textStyle: AppTheme.textTheme.labelLarge,
                            minimumSize: const Size(200, 50),
                          ),
                          child: const Text('문제 보러가기'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizShowPage(widget.examName,widget.passage),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
