class SampleEntity {
  const SampleEntity({
    this.name,
    this.fullName,
    this.stars,
  });

  final String name;
  final String fullName;
  final int stars;

  factory SampleEntity.fromJson(Map<String, dynamic> json) {
    return SampleEntity(
      name: json['name'],
      fullName: json['nameWithOwner'],
      stars: json['stargazers']['totalCount'],
    );
  }

  SampleEntity copyWith({
    final String name,
    final String fullName,
    final int stars,
  }) {
    return SampleEntity(
      name: name ?? this.name,
      fullName: fullName ?? this.fullName,
      stars: stars ?? this.stars,
    );
  }
}
