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
      home: MyHomePage(title: 'Table'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: DefaultTextStyle(
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
        child: Table(
          border: TableBorder.all(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[
            TableRow(children: <Widget>[
              Container(
                margin: const EdgeInsets.all(2),
                color: Colors.black,
                height: 100.0,
                child: const Text("Row 1 \n Element 1"),
              ),
              Container(
                margin: const EdgeInsets.all(2),
                color: Colors.green,
                height: 50.0,
                child: const Text("Row 1 \n Element 2"),
              ),
              Container(
                margin: const EdgeInsets.all(2),
                color: Colors.amber,
                height: 50.0,
                child: const Text("Row 1 \n Element 3"),
              ),
            ]),
            TableRow(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(2),
                  color: Colors.blue,
                  height: 48.0,
                  child: const Text("Row 2 \n Element 1"),
                ),
                Container(
                  margin: const EdgeInsets.all(2),
                  color: Colors.deepPurple,
                  height: 48.0,
                  child: const Text("Row 2 \n Element 2"),
                ),
                Container(
                  margin: const EdgeInsets.all(2),
                  color: Colors.red,
                  height: 100.0,
                  child: const Text("Row 2 \n Element 3"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
