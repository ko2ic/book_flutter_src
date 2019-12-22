import 'package:book_flutter_5_3_http/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_web_server/mock_web_server.dart';

void main() {
  // (1) MockWebServerを用意
  var _server = MockWebServer(port: 8081);

  setUp(() async {
    // (2) 必ずstartさせる
    await _server.start();
  });

  tearDown(() {
    // (3) 終わったら後始末
    _server.shutdown();
  });

  test("fetch()", () async {
    // (4) HTTP通信で戻ってくる値を定義
    _server.enqueue(body: '''
{
  "title" : "abcdefg"
}       
    ''');

    // (5) MockWebServerのURLを渡す
    var target = PostHttpClient(baseUrl: "http://127.0.0.1:8081");
    var actual = await target.fetch();
    // (6) responseを検証
    expect(actual.title, "abcdefg");

    // (7) requestも検証
    var request = _server.takeRequest();
    expect(request.uri.path, "/posts/1");
  });
}
