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
    'Title': 0, //'Title''제목'
    'Summary': 0, //'Summary''요약'
    'MultipleChoice': 0, //'MultipleChoice''선다형문제'
  };
  Map<String, String> problemName = {
    'Title': '제목', //'Title''제목'
    'Summary': '요약', //'Summary''요약'
    'MultipleChoice': '다지선다', //'MultipleChoice''선다형문제'
  };

  List<Map<String, Map<String, int>>> favorites = [
    {
      '제목5, 요약5': {
        'Title': 5,
        'Summary': 5,
      }
    },
    {
      '제목5, 선다5': {
        'Title': 5,
        'MultipleChoice': 5,
      }
    },
    {
      '요약5, 선다5': {
        'Summary': 5,
        'MultipleChoice': 5,
      }
    },
  ];

  void selectFavorite(int index) {
    setState(() {
      String favoriteName = favorites[index].keys.first;
      Map<String, int> favoriteCounts = favorites[index][favoriteName]!;

      // 기존에 선택된 문제 유형과 개수 초기화
      selectedTypes.clear();
      problemCounts.updateAll((key, value) => 0);
      totalProblems = 0;

      // 즐겨찾기의 문제 유형과 개수로 업데이트
      favoriteCounts.forEach((type, count) {
        selectedTypes.add(type);
        problemCounts[type] = count;
        totalProblems += count;
      });
    });
  }

  void toggleProblemType(String type) {
    setState(() {
      if (selectedTypes.contains(type)) {
        selectedTypes.remove(type);
        totalProblems -= problemCounts[type]!;
        problemCounts[type] = 0;
      } else {
        int totalProblemsAfterSelection = totalProblems + 1;

        if (totalProblemsAfterSelection <= 20) {
          selectedTypes.add(type);
          if (problemCounts[type] == 0) {
            problemCounts[type] = 1;
            totalProblems++;
          }
        }
      }
    });
  }

  void updateProblemCount(String type, int count) {
    setState(() {
      int totalProblemsAfterUpdate =
          totalProblems - problemCounts[type]! + count;

      if (totalProblemsAfterUpdate <= 20) {
        totalProblems -= problemCounts[type]!;
        problemCounts[type] = count;
        totalProblems += count;
      }
    });
  }

  void navigateToNextPage() {
    List<Map<String, dynamic>> questionTypes = [];
    for (String type in selectedTypes) {
      questionTypes.add({
        'type': type,
        'count': problemCounts[type],
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
                    width: 8,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                right: BorderSide(
                                    color: AppTheme.mainColor, width: 8))),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.7,
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: AppTheme.mainColor,
                                          width: 8))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "즐겨찾기",
                                      style: AppTheme.textTheme.labelLarge,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: List.generate(3, (index) {
                                      String favoriteName =
                                          favorites[index].keys.first;
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          onPressed: () =>
                                              selectFavorite(index),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppTheme.mainColor,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            textStyle:
                                                AppTheme.textTheme.labelLarge,
                                            fixedSize: const Size(200, 50),
                                          ),
                                          child: Text(favoriteName),
                                        ),
                                      );
                                    }),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: ListView(
                                children: selectedTypes.map((type) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, left: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Chip(
                                            shape:
                                                const ContinuousRectangleBorder(
                                                    side: BorderSide(
                                                        color: Colors.white,
                                                        width: 0)),
                                            onDeleted: () {
                                              setState(() {
                                                selectedTypes.remove(type);
                                                totalProblems -=
                                                    problemCounts[type]!;
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
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  child: Center(
                                                      child: Text(
                                                          problemName[type]!)),
                                                ),
                                                const SizedBox(width: 8.0),
                                                Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                            AppTheme.mainColor,
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 5,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                            '${problemCounts[type]}'))),
                                                Container(
                                                  width: 5,
                                                ),
                                                const Text('문제'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
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
                      child: Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppTheme.mainColor,
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
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "문제 유형",
                              style: AppTheme.textTheme.labelLarge,
                            ),
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
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Container(
                                          width: 150,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppTheme.mainColor,
                                              style: BorderStyle.solid,
                                              width: 5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              problemName[type]!,
                                              style:
                                                  AppTheme.textTheme.labelLarge,
                                            ),
                                          )),
                                    ),
                                    const SizedBox(width: 1.0),
                                    selectedTypes.contains(type)
                                        ? NumberPicker(
                                            key: ValueKey(type),
                                            value: problemCounts[type]!,
                                            minValue: 1,
                                            maxValue: 20 -
                                                (totalProblems -
                                                    problemCounts[type]!),
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
