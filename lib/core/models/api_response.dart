class ApiResponse {
  final bool isSuccess;
  final int statusCode;
  final dynamic data;

  ApiResponse({
    required this.isSuccess,
    required this.statusCode,
    required this.data,
  });
}
