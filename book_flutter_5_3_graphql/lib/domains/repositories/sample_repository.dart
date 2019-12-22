import 'package:book_flutter_5_3_graphql/domains/models/dto/sample_result_dto.dart';

abstract class SampleRepository {
  Future<SampleResultDto> fetch(String freeWord);
}
