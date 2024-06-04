import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:segno/db/file_db.dart';
import '../style/style.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

final getIt = GetIt.instance;
final isar = getIt.get<Isar>();

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
  final ScrollController _scrollController = ScrollController();
  bool _highlightText = false;
  bool _isHighlightActivated = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchExamFile().then((_) {
      setState(() {
        _isHighlightActivated = _examFile!.questions
            .any((question) => question.highlight.isNotEmpty);
      });
    });
  }

  Future<void> _fetchExamFile() async {
    final getIt = GetIt.instance;
    final isar = getIt.get<Isar>();
    final examFile = await isar.examFiles
        .filter()
        .examNameEqualTo(widget.examName)
        .findFirst();
    setState(() {
      _examFile = examFile;
    });
  }

  void _scrollToText() {
    setState(() {
      _highlightText = true;
    });

    final text =
        _examFile!.questions.elementAt(_currentQuestionIndex).highlight;
    final passage = _examFile!.passage;
    final firstSentence = text.split(RegExp(r'(?<=[.?!])\s+(?![a-z])'))[0];
    final index = passage.indexOf(firstSentence);

    if (index != -1) {
      final beforeText = passage.substring(0, index);
      final textSpan = TextSpan(
        text: beforeText,
        style: const TextStyle(fontSize: 18),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout(maxWidth: MediaQuery.of(context).size.width - 32);
      final textOffset = textPainter.height;

      _scrollController.animateTo(
        textOffset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _sendDataToCloudFunction() async {
    const url =
        'https://asia-northeast3-segno-a4dbc.cloudfunctions.net/Highlight_Generator';
    final requestBody = {
      'passage': _examFile!.passage,
      'questions':
          _examFile!.questions.map((question) => question.toJson()).toList(),
    };

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('하이라이트 연동중....')),
    );

    final response = await http.post(
      Uri.parse(url),
      body: json.encode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    debugPrint(response.body);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final List<QuestionFile> updatedQuestions =
          responseData['highlights'].map<QuestionFile>((highlightData) {
        final question = _examFile!.questions.firstWhere(
          (q) => q.question == highlightData['question_text'],
          orElse: () => QuestionFile(
            question: '',
            choices: [],
            answer: 0,
            comment: '',
            highlight: '',
            type: '',
          ),
        );
        return QuestionFile(
          question: question.question,
          choices: question.choices,
          answer: question.answer,
          comment: question.comment,
          highlight: highlightData['highlight'] ?? '',
          type: question.type,
        );
      }).toList();

      await saveHighlight(updatedQuestions);
    } else {
      final errorData = json.decode(response.body) as Map<String, dynamic>;
      final errorMessage = errorData['error']?.toString() ?? 'Unknown error';
      final errorDetails = errorData['details']?.toString() ?? 'No details';
      throw Exception('Failed to update highlights. '
          'Status code: ${response.statusCode}, '
          'Error message: $errorMessage, '
          'Details: $errorDetails');
    }
  }

  Future<void> saveHighlight(List<QuestionFile> questions) async {
    try {
      await isar.writeTxn(() async {
        for (var question in questions) {
          final existingQuestions = await isar.questionFiles
              .filter()
              .questionEqualTo(question.question)
              .findAll();

          for (var existingQuestion in existingQuestions) {
            existingQuestion.highlight = question.highlight;
            await isar.questionFiles.put(existingQuestion);
          }
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('하이라이트가 저장되었습니다.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('하이라이트 저장에 실패했습니다.')),
      );
    }
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
                  onPressed: _scrollToText,
                  child: const Text('문장 찾기'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isHighlightActivated ||
                            _examFile!.questions.any(
                                (question) => question.highlight.isNotEmpty)
                        ? AppTheme.mainColor
                        : Colors.grey,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: AppTheme.textTheme.labelLarge,
                    fixedSize: const Size(300, 50),
                  ),
                  onPressed: () async {
                    if (_isHighlightActivated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('하이라이트 기능이 이미 활성화되었습니다.')),
                      );
                    } else {
                      // 로딩 상태 표시
                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        await _sendDataToCloudFunction();
                        setState(() {
                          _isHighlightActivated = true;
                          _isLoading = false;
                        });
                      } catch (e) {
                        // 에러 처리
                        //print('Error: $e');
                        setState(() {
                          _isLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('하이라이트 기능 활성화 중 오류가 발생했습니다.')),
                        );
                      }
                      try {
                        await _fetchExamFile();
                      } catch (e) {
                        // 에러 처리
                        //print('Error: $e');
                        setState(() {
                          _isLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('하이라이트 기능 활성화 중 오류가 발생했습니다.')),
                        );
                      }
                    }
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text('하이라이트 기능 활성화'),
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
                            style: const TextStyle(
                                fontSize: 24, color: Colors.white),
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
                          _highlightText = false;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: widget
                                    .examResult.selectedChoices[index] ==
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
                      controller: _scrollController,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text.rich(
                            TextSpan(
                              children: _buildTextSpans(
                                _examFile!.passage,
                                _examFile!.questions
                                    .elementAt(_currentQuestionIndex)
                                    .highlight,
                              ),
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<TextSpan> _buildTextSpans(String text, String highlightText) {
    final List<TextSpan> spans = [];
    final List<String> sentences =
        highlightText.split(RegExp(r'(?<=[.?!])\s+(?![a-z])'));

    int startIndex = 0;
    for (String sentence in sentences) {
      final index = text.indexOf(sentence, startIndex);
      if (index != -1) {
        spans.add(TextSpan(text: text.substring(startIndex, index)));
        spans.add(TextSpan(
          text: sentence,
          style: TextStyle(
            backgroundColor:
                _highlightText ? Colors.yellowAccent : Colors.transparent,
          ),
        ));
        startIndex = index + sentence.length;
      }
    }

    spans.add(TextSpan(text: text.substring(startIndex)));

    return spans;
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
                Expanded(
                  child: Text(
                    choice,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          isCorrect ? FontWeight.bold : FontWeight.normal,
                      color:
                          isSelected && !isCorrect ? Colors.red : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 16),
        if (question.comment.isNotEmpty)
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '해설',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      question.comment,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
