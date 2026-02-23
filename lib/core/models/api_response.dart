class ApiResponse<T> {
  final bool isSuccess;
  final int statusCode;
  final T data;

  ApiResponse({
    required this.isSuccess,
    required this.statusCode,
    required this.data,
  });
}
