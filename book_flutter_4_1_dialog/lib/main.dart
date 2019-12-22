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
  var _value = '';

  Future _askUser() async {
    // SimpleDialogの場合
//    var answer = await showDialog<int>(
//      context: context,
//      builder: (context) {
//        return SimpleDialog(
//          title: const Text('質問です'),
//          children: <Widget>[
//            SimpleDialogOption(
//              child: const Text('回答1'),
//              onPressed: () {
//                Navigator.pop(context, 1);
//              },
//            ),
//            SimpleDialogOption(
//              child: const Text('回答2'),
//              onPressed: () {
//                Navigator.pop(context, 2);
//              },
//            ),
//          ],
//        );
//      },
//    );
//
//    setState(() {
//      switch (answer) {
//        case 1:
//          _value = '回答1';
//          break;
//        case 2:
//          _value = '回答2';
//          break;
//      }
//    });

    // AlertDialogの場合
//    await showDialog<void>(
//      context: context,
//      barrierDismissible: false, // user must tap button!
//      builder: (BuildContext context) {
//        return AlertDialog(
//          title: Text('タイトル'),
//          content: SingleChildScrollView(
//            child: ListBody(
//              children: const <Widget>[
//                Text('たくさん書いてもスクロールできます。'),
//                Text('contentをSingleChildScrollViewにしてるためです。'),
//                Text('短いダイアログだったら、Textだけで良いです。'),
//              ],
//            ),
//          ),
//          actions: <Widget>[
//            FlatButton(
//              child: const Text('OK'),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );

    // BottomSheetの場合
    await showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.group),
              title: const Text('選択肢１'),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: Icon(Icons.insert_emoticon),
              title: const Text('選択肢2'),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dialog'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(_value),
              RaisedButton(
                onPressed: _askUser,
                child: const Text('開く'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
