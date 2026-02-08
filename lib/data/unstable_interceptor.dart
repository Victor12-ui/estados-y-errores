import 'dart:math';
import 'package:dio/dio.dart';

class UnstableInterceptor extends Interceptor {
  final _random = Random();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final delay = 1 + _random.nextInt(4);
    await Future.delayed(Duration(seconds: delay));

    final fail = _random.nextInt(100) < 20;

    if (fail) {
      final isAuthError = _random.nextBool();

      handler.reject(
        DioException(
          requestOptions: options,
          response: Response(
            requestOptions: options,
            statusCode: isAuthError ? 401 : 500,
          ),
          type: DioExceptionType.badResponse,
        ),
      );
      return;
    }

    handler.next(options);
  }
}
