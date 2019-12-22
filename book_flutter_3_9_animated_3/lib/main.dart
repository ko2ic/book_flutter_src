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
      home: MyHomePage(title: 'AnimationController'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation1;
  Animation<double> _animation2;

  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation1 = _controller
        .drive(
          CurveTween(
            curve: Interval(
              0.0,
              0.6,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        )
        .drive(
          Tween(
            begin: 1,
            end: 0,
          ),
        );

    _animation2 = _controller
        .drive(
          CurveTween(
            curve: const Interval(
              0.4,
              1.0,
            ),
          ),
        )
        .drive(
          Tween(
            begin: 0,
            end: 1,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: <Widget>[
          FadeTransition(
            // 別々のアニメーションクラス
            opacity: _animation1,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.green,
            ),
          ),
          FadeTransition(
            // 別々のアニメーションクラス
            opacity: _animation2,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.forward();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
