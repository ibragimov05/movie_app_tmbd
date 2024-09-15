part of 'credits_response.dart';

class Cast {
  final bool adult;
  final num gender;
  final num id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String profilePath;
  final num castId;
  final String character;
  final String creditId;
  final num order;

  const Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json['adult'] as bool? ?? false,
        gender: json['gender'] as num? ?? -1,
        id: json['id'] as num? ?? -1,
        knownForDepartment: json['known_for_department'] as String? ?? 'null',
        name: json['name'] as String? ?? 'null',
        originalName: json['original_name'] as String? ?? 'null',
        popularity: (json['popularity'] as num? ?? 0.0).toDouble(),
        profilePath: json['profile_path'] as String? ?? 'null',
        castId: json['cast_id'] as num? ?? -1,
        character: json['character'] as String? ?? 'null',
        creditId: json['credit_id'] as String? ?? 'null',
        order: json['order'] as num? ?? -1,
      );

  Map<String, dynamic> toJson() => {
        'adult': adult,
        'gender': gender,
        'id': id,
        'known_for_department': knownForDepartment,
        'name': name,
        'original_name': originalName,
        'popularity': popularity,
        'profile_path': profilePath,
        'cast_id': castId,
        'character': character,
        'credit_id': creditId,
        'order': order,
      };
}
