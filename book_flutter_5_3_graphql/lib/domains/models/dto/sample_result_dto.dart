import 'package:book_flutter_5_3_graphql/domains/models/entities/sample_entity.dart';

class SampleResultDto {
  const SampleResultDto({
    this.totalCount = 0,
    this.items = const [],
  });

  final int totalCount;

  final List<SampleEntity> items;

  factory SampleResultDto.fromJson(Map<String, dynamic> json) {
    final repoList = <SampleEntity>[];
    for (var repo in json['edges']) {
      repoList.add(SampleEntity.fromJson(repo['node']));
    }

    return SampleResultDto(
      totalCount: json['repositoryCount'],
      items: repoList,
    );
  }
}
