import 'package:book_flutter_8_test_tips/sample_httpclient.dart';
import 'package:mock_web_server/mock_web_server.dart';
import 'package:test/test.dart';

void main() {
// 1 MockWebServerを用意
  var _server = MockWebServer(port: 8081);
  setUp(() async {
    // 2 必ずstartさせる
    await _server.start();
  });
  tearDown(() {
// 3 終わったら後始末
    _server.shutdown();
  });
  test("fetch()", () async {
// 4 HTTP通信で戻ってくる値を定義
    _server.enqueue(body: ''' {
"sample" : "abcdefg" }
''');
    // 5 MockWebServerのURLを渡す
    var target = SampleHttpClient(baseUrl: "http://127.0.0.1:8081");
    var actual = await target.fetch();
// 6 responseを検証
    expect(actual.sample, "abcdefg");
// 7 requestも検証
    var request = _server.takeRequest();
    expect(request.uri.path, "/sample");
  });
}
