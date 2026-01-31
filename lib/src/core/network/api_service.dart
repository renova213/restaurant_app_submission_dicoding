import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService({required String baseUrl})
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
        ),
      ) {
    dio.interceptors.add(ChuckerDioInterceptor());
    dio.interceptors.add(InterceptorsWrapper(onRequest: _onRequest));
  }

  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    handler.next(options);
  }
}
