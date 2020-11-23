// 1 Mockクラスを継承し、モック対象を実装
import 'package:book_flutter_8_test_tips/sample_httpclient.dart';
import 'package:book_flutter_8_test_tips/sample_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockSampleHttpClient extends Mock implements SampleHttpClient {}

main() {
  group('fetch()', () {
    var client = MockSampleHttpClient();
    test('return null.', () async {
// 2 whenでモック対象のメソッドを指定して、thenAnswerで戻り値を指定します。
      when(client.fetch()).thenAnswer((_) => Future.value(null));
      var target = SampleRepository(client);

      var actual = await target.fetch();
      expect(actual, isNull);
    });
    test('return entity', () async {
      var entity = const SampleEntity(sample: 'sample');
      when(client.fetch()).thenAnswer((_) => Future.value(entity));
      var target = SampleRepository(client);
      var actual = await target.fetch();
      expect(actual.sample, 'sample');
    });
  });
}
