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
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Page')),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            var messageFromSecond = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  // 次の画面に値を渡すのはコンストラクタでやるだけ
                  return SecondPage('messageFromFirst');
                }, // モーダルにしたい場合は以下を使うだけ
                // fullscreenDialog: true
              ),
            );
            print('FirstPageメッセージ $messageFromSecond');
          },
          child: const Text('Next Page'),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final String messageFromFirst;

  SecondPage(this.messageFromFirst);

  Widget build(BuildContext context) {
    print('SecondPageメッセージ $messageFromFirst');
    return Scaffold(
      appBar: AppBar(title: const Text('Second Page')),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop<String>(context, "SecondPageから戻った");
          },
          child: const Text('Go back'),
        ),
      ),
    );
  }
}
