import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Grade {
  final String name;
  final int score;

  const Grade(this.name, this.score);
}

class _MyHomePageState extends State<MyHomePage> {
  final grades = [
    const Grade('えりな', 100),
    const Grade('くるみ', 10),
    const Grade('みなみ', 2),
  ];

  final _selected = [];
  var _sort = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DataTable')),
      body: DataTable(
        sortAscending: _sort,
        sortColumnIndex: 1,
        columns: [
          const DataColumn(
            label: Text("名前"),
          ),
          DataColumn(
            label: const Text("点数"),
            numeric: true,
            onSort: (int columnIndex, bool ascending) {
              if (columnIndex == 1) {
                if (ascending) {
                  grades.sort((a, b) => a.score.compareTo(b.score));
                } else {
                  grades.sort((a, b) => b.score.compareTo(a.score));
                }
                setState(() {
                  _sort = !_sort;
                });
              }
            },
          ),
        ],
        rows: [
          for (var grade in grades)
            DataRow(
              selected: _selected.contains(grade.name),
              onSelectChanged: (bool value) {
                setState(() {
                  if (value) {
                    _selected.add(grade.name);
                  } else {
                    _selected.remove(grade.name);
                  }
                });
              },
              cells: [
                DataCell(
                  Text(grade.name),
                ),
                DataCell(
                  Text(grade.score.toString()),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
