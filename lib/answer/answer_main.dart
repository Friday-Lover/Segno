import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:segno/db/file_db.dart';
import '../style/style.dart';

class QuizResultScreen extends StatefulWidget {
  final String examName;
  final ExamResult examResult;

  const QuizResultScreen({
    super.key,
    required this.examName,
    required this.examResult,
  });

  @override
  _QuizResultScreenState createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  int _currentQuestionIndex = 0;
  ExamFile? _examFile;

  @override
  void initState() {
    super.initState();
    _fetchExamFile();
  }

  Future<void> _fetchExamFile() async {
    final getIt = GetIt.instance;
    final isar = getIt.get<Isar>();
    final examFile = await isar.examFiles.filter().examNameEqualTo(widget.examName).findFirst();
    setState(() {
      _examFile = examFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_examFile == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Segno', style: AppTheme.textTheme.displaySmall),
        backgroundColor: AppTheme.mainColor,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.mainColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: AppTheme.textTheme.labelLarge,
                    fixedSize: const Size(150, 50),
                  ),
                  child: const Text('메인화면'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Row(
                    children: [
                      Text(
                        '점수',
                        style: AppTheme.textTheme.labelLarge,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppTheme.mainColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                          child: Text(
                            '${widget.examResult.correctNumber}/${_examFile!.questions.length}',
                            style: const TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  runAlignment: WrapAlignment.start,
                  children: List.generate(
                    _examFile!.questions.length,
                        (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentQuestionIndex = index;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: widget.examResult.selectedChoices[index] ==
                            _examFile!.questions.elementAt(index).answer - 1
                            ? Colors.green
                            : Colors.red,
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            _examFile!.passage,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildQuestionWidget(),
                  ),
                ),
                /*Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _examFile!.questions.elementAt(_currentQuestionIndex).comment,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionWidget() {
    final question = _examFile!.questions.elementAt(_currentQuestionIndex);
    final userAnswer = widget.examResult.selectedChoices[_currentQuestionIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppTheme.mainColor,
              width: 2,
            ),
          ),
          child: Text(
            question.question,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(height: 8),
        ...question.choices.asMap().entries.map((entry) {
          final choice = entry.value;
          final choiceIndex = entry.key;
          final isCorrect = question.answer - 1 == choiceIndex;
          final isSelected = userAnswer == choiceIndex;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Icon(
                  isCorrect
                      ? Icons.check_circle
                      : isSelected
                      ? Icons.cancel
                      : Icons.circle,
                  color: isCorrect
                      ? Colors.green
                      : isSelected
                      ? Colors.red
                      : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  choice,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isCorrect ? FontWeight.bold : FontWeight.normal,
                    color: isSelected && !isCorrect ? Colors.red : Colors.black,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}