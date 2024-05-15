import 'package:flutter/material.dart';
import 'problem_generator_page.dart';

class ProblemCustomPage extends StatefulWidget {
  const ProblemCustomPage({super.key});

  @override
  _ProblemCustomPageState createState() => _ProblemCustomPageState();
}

class _ProblemCustomPageState extends State<ProblemCustomPage> {
  List<Widget> problemSets = [];

  @override
  void initState() {
    super.initState();
    problemSets = List.generate(3, (index) => buildProblemSet());
  }

  Widget buildProblemSet() {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            items: ['a', 'b', 'c', 'd'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {},
            decoration: InputDecoration(
              labelText: 'Select',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Number',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Problem Custom pages'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...problemSets,
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  problemSets.add(buildProblemSet());
                });
              },
              child: Text('Add Set'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProblemGeneratorPage()),
          );
        },
        child: Icon(Icons.check),
      ),
    );
  }
}