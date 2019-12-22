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

class _MyHomePageState extends State<MyHomePage> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExpansionPanel'),
      ),
      body: ListView(
        children: <Widget>[
          ExpansionPanelList(
            // (1) tapしたときに呼び出される関数
            expansionCallback: (int panelIndex, bool isExpanded) {
              setState(() {
                _isExpanded = !isExpanded;
              });
            },
            children: <ExpansionPanel>[
              ExpansionPanel(
                // (2) 開閉状態を指定。trueで開いた状態
                isExpanded: _isExpanded,
                // (3) header部分のウィジェットを返す
                headerBuilder: (
                  BuildContext context,
                  bool isExpanded,
                ) {
                  return const ListTile(
                    leading: Icon(Icons.insert_emoticon),
                    title: Text('ExpansionPanel headerBuilder'),
                  );
                },
                // (4) 開いたときに表示するウィジェットを指定
                body: Image.asset('images/flutter_logo.png'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
