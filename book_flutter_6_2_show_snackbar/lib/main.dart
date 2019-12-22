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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Text(
          'SnackBarのテスト',
          style: Theme.of(context).textTheme.display1,
        ),
      ),
      floatingActionButton: Builder(
        builder: (contextOfBuilder) {
          return FloatingActionButton(
            onPressed: () {
              _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Key')));
              Scaffold.of(contextOfBuilder).showSnackBar(SnackBar(content: Text('Builder')));
              //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Builder'))); // これはエラー
            },
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }
}
