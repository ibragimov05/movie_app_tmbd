part of 'reviews_response.dart';

class AuthorDetails {
  final String name;
  final String username;
  final String avatarPath;
  final num rating;

  const AuthorDetails({
    required this.name,
    required this.username,
    required this.avatarPath,
    required this.rating,
  });

  factory AuthorDetails.fromJson(Map<String, dynamic> json) => AuthorDetails(
        name: json['name'] as String? ?? 'null',
        username: json['username'] as String? ?? 'null',
        avatarPath: json['avatar_path'] as String? ?? 'null',
        rating: json['rating'] as num? ?? -1,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'username': username,
        'avatar_path': avatarPath,
        'rating': rating,
      };
}
