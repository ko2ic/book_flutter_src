import 'package:book_flutter_4_2_theming/backdrop.dart';
import 'package:book_flutter_4_2_theming/buttons.dart';
import 'package:book_flutter_4_2_theming/forms.dart';
import 'package:book_flutter_4_2_theming/labels.dart';
import 'package:book_flutter_4_2_theming/lists.dart';
import 'package:book_flutter_4_2_theming/my_theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: MyTheme().data(),
      darkTheme: MyDarkTheme().data(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDemoDialog<String>(
                context: context,
                child: AlertDialog(
                  title: const Text("title"),
                  content: const Text("aaaaaaaaa"),
                  actions: <Widget>[
                    FlatButton(
                        child: const Text('CANCEL'),
                        onPressed: () {
                          Navigator.pop(context, "cancel");
                        }),
                    OutlineButton(
                      child: const Text('NO'),
                      onPressed: () {
                        Navigator.pop(context, "no");
                      },
                    ),
                    RaisedButton(
                      textTheme: Theme.of(context).buttonTheme.textTheme,
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.pop(context, "ok");
                      },
                    )
                  ],
                ),
              );
            }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return BackdropPage();
                  },
                  fullscreenDialog: true,
                ),
              );
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          ButtonsPage(),
          const FormsPage(),
          const ListsPage(),
          LabelsPage(),
        ],
        onPageChanged: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _page,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            title: Text("ボタン"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.input),
            title: Text("フォーム"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            title: Text("リスト"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_color_text),
            title: Text("ラベル"),
          ),
        ],
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
      ),
    );
  }

  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('You selected: $value'),
            action: SnackBarAction(
                label: 'Action',
                onPressed: () {
                  print("action");
                }),
          ),
        );
      }
    });
  }
}
