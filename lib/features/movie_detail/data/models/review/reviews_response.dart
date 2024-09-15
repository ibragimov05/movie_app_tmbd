part 'author_details.dart';

part 'results.dart';

class ReviewsResponse {
  final num id;
  final num page;
  final List<Review> results;
  final num totalPages;
  final num totalResults;

  const ReviewsResponse({
    required this.id,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory ReviewsResponse.fromJson(Map<String, dynamic> json) =>
      ReviewsResponse(
        id: json['id'] as num? ?? -1,
        page: json['page'] as num? ?? -1,
        results: (json['results'] as List<dynamic>?)
                ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        totalPages: json['total_pages'] as num? ?? -1,
        totalResults: json['total_results'] as num? ?? -1,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'page': page,
        'results': results.map((v) => v.toJson()).toList(),
        'total_pages': totalPages,
        'total_results': totalResults,
      };
}
