class PaginatedResponse<T> {
  final List<T> data;
  final String? dataNameField;
  final int page;
  final int pageSize;
  final int totalPages;
  final int totalItems;
  final bool hasMorePages;

  PaginatedResponse({
    required this.data,
    this.dataNameField,
    required this.page,
    required this.pageSize,
    required this.totalPages,
    required this.totalItems,
    required this.hasMorePages,
  });

  factory PaginatedResponse.fromJson({
    required Map<String, dynamic> json,
    required T Function(dynamic) fromJsonT,
    String? dataNameField,
  }) {
    return PaginatedResponse<T>(
      data: (json[dataNameField ?? 'data'] as List).map(fromJsonT).toList(),
      page: json['paginate']['currentPage'],
      pageSize: json['paginate']['perPage'],
      totalPages: json['paginate']['lastPage'],
      totalItems: json['paginate']['total'],
      hasMorePages: json['paginate']['has_MorePages'] ?? false,
    );
  }
}
