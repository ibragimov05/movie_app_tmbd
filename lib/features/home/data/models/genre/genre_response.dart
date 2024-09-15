class GenreResponse {
  final List<Genre> genres;

  const GenreResponse({required this.genres});

  factory GenreResponse.fromJson(Map<String, dynamic> json) => GenreResponse(
        genres: (json['genres'] as List<dynamic>?)
                ?.map(
                  (e) => Genre.fromJson(e as Map<String, dynamic>),
                )
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        'genres': genres.map((v) => v.toJson()).toList(),
      };
}

/// Genre
class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json['id'] as int,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
