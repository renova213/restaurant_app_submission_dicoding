import '../core.dart';

Future<Either<AppError, T>> safeApiCall<T>(Future<T> Function() apiFn) async {
  try {
    final result = await apiFn();
    return Right(result);
  } catch (e) {
    if (e is NetworkException) {
      return Left(
        AppError(
          message: e.message,
          originalError: e,
          statusCode: e.statusCode ?? 500,
        ),
      );
    }
    return Left(
      AppError(message: "Unkown Error", originalError: e, statusCode: 500),
    );
  }
}
