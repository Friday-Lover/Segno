import 'package:flutter/material.dart';
import 'package:segno/answer/answer_main.dart';
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

  String formatDate(String date){
    String formattedDate = '${date.substring(0, 4)}-${date.substring(4, 6)}-${date.substring(6)}';
    return  formattedDate;
  }

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Image.asset(
                  "assets/images/back-arrow.png",
                  width: 50,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.4),
                child: Text(
                  widget.examName,
                  style: AppTheme.textTheme.headlineSmall,
                ),
              ),
              const Spacer()
            ],
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              "본문",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Flexible(
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.5,
                              height: MediaQuery.sizeOf(context).height * 0.8,
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
                ),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Center(
                          child: Text(
                        "시험 이력",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                      Expanded(
                        flex: 1,
                        child: ListView.builder(
                          itemCount: widget.examResults.length,
                          itemBuilder: (context, index) {
                            final examResult = widget.examResults[index];
                            examResult.selectedChoices
                                .asMap()
                                .entries
                                // ignore: unnecessary_null_comparison
                                .where((entry) => entry.value != null)
                                .map((entry) =>
                                    'Q${entry.key + 1}: ${entry.value + 1}')
                                .toList();
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QuizResultScreen(
                                      examName: examResult.examName,
                                      examResult: examResult,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          examResult.examName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4,
                                            horizontal: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppTheme.mainColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            '${examResult.correctNumber} / ${examResult.totalNumber}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '시험 일자: ${formatDate(examResult.date)}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 0.5,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.check_circle,
                                          color: AppTheme.mainColor,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '정답률: ${((examResult.correctNumber / examResult.totalNumber) * 100).toStringAsFixed(1)}%',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: AppTheme.mainColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
                                builder: (context) => QuizShowPage(
                                    widget.examName, widget.passage),
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
