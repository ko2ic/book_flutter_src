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
  String _value = '';

  Future _select() async {
    // (1) showDatePicker()でカレンダーが開き、
    // OK押下で選択した日付が変える
    var selected = await showDatePicker(
      context: context,
      // (2) 表示したとき直後の日付
      initialDate: DateTime(2019, 9, 30),
      // (3) firestDateとlastDateの間が選択できる
      firstDate: DateTime(2018),
      lastDate: DateTime(2020),
      // (4) localeは必ず指定する
      locale: Localizations.localeOf(context),
    );
    if (selected != null) {
      setState(() => _value = selected.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('showDatePicker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(_value),
              RaisedButton(
                onPressed: _select,
                child: const Text('開く'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
