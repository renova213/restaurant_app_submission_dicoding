enum AppErrorType {
  network,
  unauthorized,
  forbidden,
  notFound,
  server,
  badRequest,
  unknown,
}

class AppError implements Exception {
  final AppErrorType type;
  final String message;
  final dynamic originalError;
  final int? statusCode;

  const AppError({
    required this.type,
    required this.message,
    this.originalError,
    this.statusCode,
  });

  @override
  String toString() =>
      'AppError(type: $type, message: $message, statusCode: $statusCode)';
}
