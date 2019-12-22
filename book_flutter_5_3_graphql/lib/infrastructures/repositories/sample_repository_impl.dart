import 'package:book_flutter_5_3_graphql/domains/models/dto/sample_result_dto.dart';
import 'package:book_flutter_5_3_graphql/domains/repositories/sample_repository.dart';
import 'package:book_flutter_5_3_graphql/infrastructures/http/sample_http_client.dart';

class SampleRepositoryImpl implements SampleRepository {
  SampleResultDto beforeValue;

  Future<SampleResultDto> fetch(String freeWord) {
    if (freeWord == 'error') {
      return Future.delayed(const Duration(seconds: 2)).then((_) {
        return Future.error({'error': 'エラーですよ', 'beforeValue': beforeValue});
      });
    }
    var client = SampleHttpClient();
    return client.fetch(freeWord).then((value) {
      // 例えば、エラーの場合でも成功時のデータを表示したい場合とか、こんな感じで保持しておくとか。
      beforeValue = value;
      return value;
    });
  }
}
