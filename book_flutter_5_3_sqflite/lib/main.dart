import 'package:book_flutter_5_3_sqflite/sqflite_sample.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

final dao = UserDao(DatabaseFactory());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dao.save(1, "名前1");

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sqflite demo'),
      ),
      body: Center(
        child: FutureBuilder<User>(
          future: dao.fetch(1),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('エラー');
              } else if (!snapshot.hasData) {
                return const Text('データなし');
              }
              return Text('${snapshot.data.name}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
