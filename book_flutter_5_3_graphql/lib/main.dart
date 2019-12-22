import 'package:flutter/material.dart';

import 'infrastructures/repositories/sample_repository_impl.dart';
import 'ui/top_page.dart';

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

class MyHomePage extends StatelessWidget {
  final _repository = SampleRepositoryImpl();

  final String title;

  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: <Widget>[
          const Divider(),
          ListTile(
            title: const Text("サンプル"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TopPage(_repository),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
