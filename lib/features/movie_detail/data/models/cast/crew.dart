part of 'credits_response.dart';

class Crew {
  final bool adult;
  final num gender;
  final num id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String profilePath;
  final String creditId;
  final String department;
  final String job;

  Crew({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.creditId,
    required this.department,
    required this.job,
  });

  factory Crew.fromJson(Map<String, dynamic> json) => Crew(
        adult: json['adult'] as bool? ?? false,
        gender: json['gender'] as num? ?? -1,
        id: json['id'] as num? ?? -1,
        knownForDepartment: json['known_for_department'] as String? ?? 'null',
        name: json['name'] as String,
        originalName: json['original_name'] as String? ?? 'null',
        popularity: (json['popularity'] as num? ?? -1).toDouble(),
        profilePath: json['profile_path'] as String? ?? 'null',
        creditId: json['credit_id'] as String? ?? 'null',
        department: json['department'] as String? ?? 'null',
        job: json['job'] as String? ?? 'null',
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
        'credit_id': creditId,
        'department': department,
        'job': job,
      };
}
