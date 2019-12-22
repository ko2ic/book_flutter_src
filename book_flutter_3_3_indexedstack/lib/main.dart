import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'IndexedStack'),
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
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          _WidgetA(),
          _WidgetB(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text('A'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('B'),
          )
        ],
      ),
    );
  }
}

class _WidgetA extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WidgetAState();
  }
}

class _WidgetAState extends State<_WidgetA> {
  var _counter = 0;

  @override
  Widget build(BuildContext context) {
    print('build _WidgetA');
    return InkWell(
      onTap: () => setState(() {
        _counter++;
      }),
      child: Center(
        child: Text('$_counter'),
      ),
    );
  }
}

class _WidgetB extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WidgetBState();
  }
}

class _WidgetBState extends State<_WidgetB> {
  var _counter = 0;

  @override
  Widget build(BuildContext context) {
    print('build _WidgetB');
    return InkWell(
      onTap: () => setState(() {
        _counter++;
      }),
      child: Center(
        child: Text('$_counter'),
      ),
    );
  }
}
