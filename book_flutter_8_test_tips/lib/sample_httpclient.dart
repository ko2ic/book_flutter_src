import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class SampleHttpClient {
  final String baseUrl;
  static SampleHttpClient _instance;

  factory SampleHttpClient({String baseUrl = 'https://sample.com'}) {
    _instance ??= SampleHttpClient._internal(baseUrl);
    return _instance;
  }

  SampleHttpClient._internal(this.baseUrl);

  Future<SampleEntity> fetch() async {
    final response = await http.get('$baseUrl/sample');
    final responseJson = json.decode(response.body);
    return SampleEntity.fromJson(responseJson);
  }
}

class SampleEntity {
  final String sample;

  const SampleEntity({
    this.sample,
  });

  factory SampleEntity.fromJson(Map<String, dynamic> json) {
    return SampleEntity(sample: json['sample']);
  }
}
