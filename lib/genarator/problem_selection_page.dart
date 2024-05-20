import 'package:flutter/material.dart';
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
    '어법': 0,
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
    List<Map<String, dynamic>> options = [];
    for (String type in selectedTypes) {
      options.add({
        'type': type,
        'count': problemCounts[type],
      });
    }
//  Navigate to the next page with the selected options
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segno'),
        backgroundColor: AppTheme.mainColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('즐겨찾기'),
                            Text('문제 수: $totalProblems'),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: selectedTypes.map((type) {
                            return Chip(
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(type),
                                  SizedBox(width: 4.0),
                                  Text('${problemCounts[type]}'),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Column(
                  children: problemCounts.keys.map((type) {
                    return Row(
                      children: [
                        Radio(
                          value: type,
                          groupValue: selectedTypes.contains(type) ? type : '',
                          onChanged: (_) {
                            toggleProblemType(type);
                          },
                        ),
                        Text(type),
                        SizedBox(width: 8.0),
                        selectedTypes.contains(type)
                            ? NumberPicker(
                          value: problemCounts[type]!,
                          minValue: 1,
                          maxValue: 10,
                          onChanged: (value) {
                            updateProblemCount(type, value);
                          },
                        )
                            : SizedBox(),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: navigateToNextPage,
                child: Text('문제 만들기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberPicker extends StatefulWidget {
  final int value;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  NumberPicker({
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
          icon: Icon(Icons.remove),
          onPressed: _decrement,
        ),
        Text('$_currentValue'),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _increment,
        ),
      ],
    );
  }
}
