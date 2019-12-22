import 'dart:math';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  ScrollController _scrollController;

  int _counter = 0;

  void _refreshData() async {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(
        () {
          if (_shouldRefresh()) {
            print('再描画');
            setState(_refreshData);
          }
        },
      );
  }

  // ここの引数を1にすると常に再描画されるのでパフォーマンスが悪い
  bool _shouldRefresh() => Random().nextInt(10000) == 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: 1000,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('index = $index'),
            subtitle: Text('counter = $_counter'),
          );
        },
      ),
    );
  }
}
