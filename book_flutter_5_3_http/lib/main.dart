import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostHttpClient {
  final String baseUrl;

  PostHttpClient({this.baseUrl = 'https://jsonplaceholder.typicode.com'});

  Future<Post> fetch() async {
    try {
      // (2) getメソッドで取得。第二引数でheaderも渡せる
      final response = await http.get('$baseUrl/posts/1');
      // (3) convertパッケージでresponseの文字列をMapに変換
      final responseJson = json.decode(response.body);
      // (4) このようにfactoryコンストラクタで変換するのが常套手段
      return Post.fromJson(responseJson);
    } on Exception catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Post> create(Post data) async {
    final response = await http.post(
      '$baseUrl/posts',
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      // (5) bodyに文字列を渡す
      body: json.encode(data.toJson()),
    );
    final responseJson = json.decode(response.body);
    return Post.fromJson(responseJson);
  }
}

class Post {
  final String title;

  Post({this.title});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
      };
}

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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('http demo'),
      ),
      body: Center(
        child: FutureBuilder<Post>(
          future: PostHttpClient().fetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('エラー');
              } else if (!snapshot.hasData) {
                return const Text('データなし');
              }
              return Text('${snapshot.data.title}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
