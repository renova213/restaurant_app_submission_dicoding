import 'dart:io';

import 'package:dio/dio.dart';

import 'app_error_type.dart';
import 'either.dart';

Future<Either<AppError, T>> safeApiCall<T>(Future<T> Function() apiFn) async {
  try {
    final result = await apiFn();
    return Right(result);
  } on DioException catch (e) {
    final statusCode = e.response?.statusCode ?? 0;
    final message =
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error';

    return Left(
      AppError(
        type: AppErrorType.network,
        message: message,
        originalError: e,
        statusCode: statusCode,
      ),
    );
  } on SocketException catch (e) {
    return Left(
      AppError(
        type: AppErrorType.network,
        message: "No Internet Connection",
        originalError: e,
        statusCode: 500,
      ),
    );
  } catch (e) {
    return Left(
      AppError(
        type: AppErrorType.network,
        message: "Unkown Error",
        originalError: e,
        statusCode: 500,
      ),
    );
  }
}
