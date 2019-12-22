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
        middle: Text('CupertinoAlertDialog'),
      ),
      child: Center(
        child: CupertinoButton(
          onPressed: () {
            showCupertinoDialog<String>(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: const Text('タイトル'),
                  content: const Text('内容'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      child: const Text('削除'),
                      onPressed: () {
                        Navigator.pop(context, 'delete');
                      },
                    ),
                    CupertinoDialogAction(
                      child: const Text('キャンセル'),
                      onPressed: () {
                        Navigator.pop(context, 'cancel');
                      },
                    ),
// もう一つ追加すると選択肢ダイアログになる
//                    CupertinoDialogAction(
//                      child: const Text('選択肢とか'),
//                      onPressed: () {
//                        Navigator.pop(context, 'selection1');
//                      },
//                    ),
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
