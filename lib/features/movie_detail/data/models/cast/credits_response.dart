part 'cast.dart';

part 'crew.dart';

class CreditsResponse {
  final num id;
  final List<Cast> cast;
  final List<Crew> crew;

  const CreditsResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  factory CreditsResponse.fromJson(Map<String, dynamic> json) => CreditsResponse(
        id: json['id'] as num? ?? -1,
        cast: (json['cast'] as List<dynamic>?)
                ?.map((e) => Cast.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        crew: (json['crew'] as List<dynamic>?)
                ?.map((e) => Crew.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'cast': cast.map((v) => v.toJson()).toList(),
        'crew': crew.map((v) => v.toJson()).toList(),
      };
}
