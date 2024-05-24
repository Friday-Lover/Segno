import 'package:flutter/material.dart';
import 'package:segno/main/file_manager.dart';
import '../style/style.dart';

class QuizResultScreen extends StatelessWidget {
  final List<Question> questions;
  final List<int> userAnswers;
  final int score;

  const QuizResultScreen({super.key,
    required this.questions,
    required this.userAnswers,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Segno', style: AppTheme.textTheme.displaySmall),
        backgroundColor: AppTheme.mainColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Button action
                  },
                  child: const Text('메인화면'),
                ),
                Text(
                  '점수: $score/${questions.length}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(
                    questions.length,
                    (index) => GestureDetector(
                      onTap: () {
                        // Navigate to the corresponding question
                      },
                      child: CircleAvatar(
                        backgroundColor:
                            userAnswers[index] == questions[index].answer
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
                const Expanded(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          """
  import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(new ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NumberPicker Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Integer'),
              Tab(text: 'Decimal'),
            ],
          ),
          title: Text('Numberpicker example'),
        ),
        body: TabBarView(
          children: [
            _IntegerExample(),
            _DecimalExample(),
          ],
        ),
      ),
    );
  }
}

class _IntegerExample extends StatefulWidget {
  @override
  __IntegerExampleState createState() => __IntegerExampleState();
}

class __IntegerExampleState extends State<_IntegerExample> {
  int _currentIntValue = 10;
  int _currentHorizontalIntValue = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        Text('Default', style: Theme.of(context).textTheme.headline6),
        NumberPicker(
          value: _currentIntValue,
          minValue: 0,
          maxValue: 100,
          step: 10,
          haptics: true,
          onChanged: (value) => setState(() => _currentIntValue = value),
        ),
        SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => setState(() {
                final newValue = _currentIntValue - 10;
                _currentIntValue = newValue.clamp(0, 100);
              }),
            ),
            Text('Current int value: '),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => setState(() {
                final newValue = _currentIntValue + 20;
                _currentIntValue = newValue.clamp(0, 100);
              }),
            ),
          ],
        ),
        Divider(color: Colors.grey, height: 32),
        SizedBox(height: 16),
        Text('Horizontal', style: Theme.of(context).textTheme.headline6),
        NumberPicker(
          value: _currentHorizontalIntValue,
          minValue: 0,
          maxValue: 100,
          step: 10,
          itemHeight: 100,
          axis: Axis.horizontal,
          onChanged: (value) =>
              setState(() => _currentHorizontalIntValue = value),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black26),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => setState(() {
                final newValue = _currentHorizontalIntValue - 10;
                _currentHorizontalIntValue = newValue.clamp(0, 100);
              }),
            ),
            Text('Current horizontal int value: '),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => setState(() {
                final newValue = _currentHorizontalIntValue + 20;
                _currentHorizontalIntValue = newValue.clamp(0, 100);
              }),
            ),
          ],
        ),
      ],
    );
  }
}

class _DecimalExample extends StatefulWidget {
  @override
  __DecimalExampleState createState() => __DecimalExampleState();
}

class __DecimalExampleState extends State<_DecimalExample> {
  double _currentDoubleValue = 3.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 16),
        Text('Decimal', style: Theme.of(context).textTheme.headline6),
        DecimalNumberPicker(
          value: _currentDoubleValue,
          minValue: 0,
          maxValue: 10,
          decimalPlaces: 2,
          onChanged: (value) => setState(() => _currentDoubleValue = value),
        ),
        SizedBox(height: 32),
      ],
    );
  }
}
  """,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        final question = questions[index];
                        final userAnswer = userAnswers[index];
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
                            ...question.choices.map((choice) {
                              final isCorrect = question.answer ==
                                  question.choices.indexOf(choice);
                              final isSelected = userAnswer ==
                                  question.choices.indexOf(choice);
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
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
                                        fontWeight: isCorrect
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        color: isSelected && !isCorrect
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            const SizedBox(height: 16),
                          ],
                        );
                      },
                    ),
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
