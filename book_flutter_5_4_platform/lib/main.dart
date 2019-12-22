import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  static const _channel = MethodChannel('sample/toPlatformScreen');

  String startTimePlatformScreen = "";

  String endTimePlatformScreen = "";

  _toPlatformScreen() async {
    try {
      var result = await _channel.invokeMethod(
        'toPlatformScreen',
        <String, dynamic>{"label_from_dart": "Label From Dart"},
      );
      print(result);
      setState(() {
        startTimePlatformScreen = '${DateTime.now().toIso8601String()} $result';
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    _channel.setMethodCallHandler((MethodCall call) {
      switch (call.method) {
        case "onClosed":
          var map = call.arguments.cast<String, String>();
          var callbackMessage = map["from_platform"];
          print(callbackMessage);
          setState(() {
            endTimePlatformScreen = '${DateTime.now().toIso8601String()} $callbackMessage';
          });
          break;
      }
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Platform screen start time",
              style: Theme.of(context).textTheme.title,
            ),
            Text(startTimePlatformScreen),
            const SizedBox(height: 100),
            Text(
              "Platform screen end time",
              style: Theme.of(context).textTheme.title,
            ),
            Text(endTimePlatformScreen),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toPlatformScreen,
        child: Platform.isAndroid ? Icon(Icons.android) : Icon(Icons.phone_iphone),
      ),
    );
  }
}
