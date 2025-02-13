class ApiResponse {
  final String timestamp;
  final int code;
  final String message;
  var data;
  final Pagination? pagination;

  ApiResponse({
    required this.timestamp,
    required this.code,
    required this.message,
    required this.data,
    this.pagination,
  });

  // 用于将 JSON 转换为 ApiResponse
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      timestamp: json['timestamp'],
      code: json['code'],
      message: json['message'],
      data: json['data'],
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
    );
  }
}

class Pagination {
  final int currentPage;
  final int totalPages;
  final int totalItems;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
  });

  // 将分页数据从 JSON 转换为 Pagination 对象
  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalItems: json['totalItems'],
    );
  }
}
