class NetworkResponseDio {
  const NetworkResponseDio({
    required this.isSuccess,
    this.statusCode,
    this.data,
    this.errorMessage,
  });

  final int? statusCode;
  final bool isSuccess;
  final dynamic data;
  final String? errorMessage;

  Map<String, dynamic>? get jsonResponse {
    final response = data;
    return response is Map<String, dynamic> ? response : null;
  }
}
