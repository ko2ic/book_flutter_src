import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String lastSelectedValue;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoActionSheet'),
      ),
      child: Center(
        child: CupertinoButton(
          onPressed: () {
            showCupertinoModalPopup<String>(
              context: context,
              builder: (BuildContext context) {
                return CupertinoActionSheet(
                  title: const Text('タイトル'),
                  message: const Text('メッセージ'),
                  actions: <Widget>[
                    CupertinoActionSheetAction(
                      child: const Text('選択肢１'),
                      onPressed: () {
                        Navigator.pop(context, 'selected1');
                      },
                    ),
                    CupertinoActionSheetAction(
                      child: const Text('選択肢2'),
                      onPressed: () {
                        Navigator.pop(context, 'selected2');
                      },
                    ),
                    CupertinoActionSheetAction(
                      isDestructiveAction: true,
                      child: const Text('キャンセル'),
                      onPressed: () {
                        Navigator.pop(context, 'cancel');
                      },
                    ),
                  ],
                );
              },
            ).then((String value) {
              if (value != null) {
                setState(() {
                  lastSelectedValue = value;
                });
              }
            });
          },
          child: const Text('開く'),
        ),
      ),
    );
  }
}
