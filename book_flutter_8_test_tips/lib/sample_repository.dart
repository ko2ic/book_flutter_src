import 'sample_httpclient.dart';

class SampleRepository {
  final SampleHttpClient _client;

  SampleRepository(this._client);

  Future<SampleEntity> fetch() {
    return _client.fetch();
  }
}
