class MovieRequest {
  final int page;
  final String category;

  const MovieRequest({
    this.page = 1,
    required this.category,
  });
}
