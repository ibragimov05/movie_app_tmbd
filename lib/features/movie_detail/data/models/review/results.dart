part of 'reviews_response.dart';

class Review {
  final String author;
  final AuthorDetails authorDetails;
  final String content;
  final String createdAt;
  final String id;
  final String updatedAt;
  final String url;

  const Review({
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
    required this.id,
    required this.updatedAt,
    required this.url,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        author: json['author'] as String? ?? 'null',
        authorDetails: AuthorDetails.fromJson(json['author_details'] ?? {}),
        content: json['content'] as String? ?? 'null',
        createdAt: json['created_at'] as String? ?? 'null',
        id: json['id'] as String? ?? 'null',
        updatedAt: json['updated_at'] as String? ?? 'null',
        url: json['url'] as String? ?? 'null',
      );

  Map<String, dynamic> toJson() => {
        'author': author,
        'author_details': authorDetails.toJson(),
        'content': content,
        'created_at': createdAt,
        'id': id,
        'updated_at': updatedAt,
        'url': url,
      };
}
