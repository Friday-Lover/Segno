import 'package:flutter/material.dart';
import 'package:segno/genarator/problem_generator_page.dart';
import 'package:segno/style/style.dart';

class ProblemSelectionPage extends StatefulWidget {
  final String value; // value 필드 추가

  const ProblemSelectionPage(this.value, {super.key}); // 생성자에서 value 초기화
  @override
  _ProblemSelectionPageState createState() => _ProblemSelectionPageState();
}

class _ProblemSelectionPageState extends State<ProblemSelectionPage> {
  int totalProblems = 0;
  List<String> selectedTypes = [];
  Map<String, int> problemCounts = {
    '제목': 0,
    '순서': 0,
    '어휘': 0,
    '요약': 0,
    '내용 일치': 0,
  };

  void toggleProblemType(String type) {
    setState(() {
      if (selectedTypes.contains(type)) {
        selectedTypes.remove(type);
        totalProblems -= problemCounts[type]!;
        problemCounts[type] = 0;
      } else {
        selectedTypes.add(type);
        if (problemCounts[type] == 0) {
          problemCounts[type] = 1;
          totalProblems++;
        }
      }
    });
  }

  void updateProblemCount(String type, int count) {
    setState(() {
      totalProblems -= problemCounts[type]!;
      problemCounts[type] = count;
      totalProblems += count;
    });
  }

  void navigateToNextPage() {
    List<Map<String, dynamic>> questionTypes = [];
    for (String type in selectedTypes) {
      questionTypes.add({
        'string': type,
        'int': problemCounts[type],
      });
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProblemGeneratorPage(
          passage: widget.value,
          questionTypes: questionTypes,
        ),
      ),
    );
  }

//  Navigate to the next page with the selected options

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segno', style: AppTheme.textTheme.displaySmall),
        centerTitle: true,
        backgroundColor: AppTheme.mainColor,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:
                EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.9),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset("assets/images/back-arrow.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 30),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTheme.mainColor,
                    style: BorderStyle.solid,
                    width: 3,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.mainColor,
                            style: BorderStyle.solid,
                            width: 3,
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppTheme.mainColor,
                                    style: BorderStyle.solid,
                                    width: 3,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: ListView(
                                children: selectedTypes.map((type) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Chip(
                                          shape: const ContinuousRectangleBorder(
                                              side: BorderSide(
                                                  color: Colors.white, width: 0)),
                                          onDeleted: () {
                                            setState(() {
                                              selectedTypes.remove(type);
                                              totalProblems -= problemCounts[type]!;
                                              problemCounts[type] = 0;
                                            });
                                          },
                                          label: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 200,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: AppTheme.mainColor,
                                                    style: BorderStyle.solid,
                                                    width: 5,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5.0),
                                                ),
                                                child: Center(child: Text(type)),
                                              ),
                                              const SizedBox(width: 8.0),
                                              Container(
                                                width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: AppTheme.mainColor,
                                                      style: BorderStyle.solid,
                                                      width: 5,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(5.0),
                                                  ),
                                                  child:
                                                      Center(child: Text('${problemCounts[type]}'))),
                                              Container(width: 5,),
                                              const Text('문제'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.mainColor,
                            style: BorderStyle.solid,
                            width: 3,
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.mainColor,
                                  border: Border.all(
                                    color: AppTheme.mainColor,
                                    style: BorderStyle.solid,
                                    width: 3,
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        '문제 수',
                                        style: AppTheme.textTheme.labelLarge,
                                      ),
                                      Text(
                                        '$totalProblems',
                                        style: AppTheme.textTheme.displayMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text("문제 유형", style: AppTheme.textTheme.labelLarge,),
                            ),
                            Expanded(
                              flex: 6,
                              child: ListView(
                                children: problemCounts.keys.map((type) {
                                  return Row(
                                    children: [
                                      Radio(
                                        value: type,
                                        groupValue: selectedTypes.contains(type)
                                            ? type
                                            : '',
                                        onChanged: (_) {
                                          toggleProblemType(type);
                                        },
                                      ),
                                      Container(
                                          width: 110,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppTheme.mainColor,
                                              style: BorderStyle.solid,
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              type,
                                              style:
                                                  AppTheme.textTheme.labelLarge,
                                            ),
                                          )),
                                      const SizedBox(width: 1.0),
                                      selectedTypes.contains(type)
                                          ? NumberPicker(
                                              value: problemCounts[type]!,
                                              minValue: 1,
                                              maxValue: 10,
                                              onChanged: (value) {
                                                updateProblemCount(type, value);
                                              },
                                            )
                                          : const SizedBox(),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.mainColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: AppTheme.textTheme.labelLarge,
              fixedSize: const Size(180, 50),
            ),
            child: const Text('문제 만들기'),
            onPressed: () {
              navigateToNextPage();
            },
          ),
        ],
      ),
    );
  }
}

class NumberPicker extends StatefulWidget {
  final int value;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const NumberPicker({
    super.key,
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
  });

  @override
  _NumberPickerState createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPicker> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  void _increment() {
    setState(() {
      if (_currentValue < widget.maxValue) {
        _currentValue++;
        widget.onChanged(_currentValue);
      }
    });
  }

  void _decrement() {
    setState(() {
      if (_currentValue > widget.minValue) {
        _currentValue--;
        widget.onChanged(_currentValue);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: _decrement,
        ),
        Text('$_currentValue'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: _increment,
        ),
      ],
    );
  }
}
