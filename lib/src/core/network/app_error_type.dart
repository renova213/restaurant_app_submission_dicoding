class AppError implements Exception {
  final String message;
  final dynamic originalError;
  final int? statusCode;

  const AppError({required this.message, this.originalError, this.statusCode});

  @override
  String toString() => 'AppError(message: $message, statusCode: $statusCode)';
}
