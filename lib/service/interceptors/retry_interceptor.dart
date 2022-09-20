import 'package:dio/dio.dart';

import '../../common/config/tools.dart';
import 'dio_connectivity_request_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({required this.requestRetrier});

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    logger.e("onError: ${err.response?.statusCode ?? 0}");
    return handler.next(err);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print("onRequest@@@@");
    return super.onRequest(options, handler);
  }
}
