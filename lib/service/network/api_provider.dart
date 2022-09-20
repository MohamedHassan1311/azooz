import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../common/config/keys.dart';
import '../../utils/util_shared.dart';
import 'package:dio/dio.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

class ApiProvider {
  static final ApiProvider _instance = ApiProvider.internal();

  ApiProvider.internal();

  factory ApiProvider() => _instance;

  final Dio _dio = Dio();
  final HttpClient _httpClient = HttpClient();

  String? lang = 'en';
  String? token = '';

  static const Map<String, String> apiHeaders = {
    'Content-Type': 'application/json',
    "Accept": "application/json, text/plain, */*",
    "X-Requested-With": "XMLHttpRequest",
  };

  ///POST Method
  Future post({
    required String? apiRoute,
    required dynamic data,
    required void Function(dynamic response)? successResponse,
    required void Function(dynamic response)? errorResponse,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response? response;
    Map<String, String>? headers;

    lang = UtilShared.readStringPreference(key: keyLocale);
    token = UtilShared.readStringPreference(key: keyToken);

    print('Token From Shared (POST Request) $apiRoute: $token');
    // print('Locale From Shared (POST Request) $apiRoute: $lang');

    token == ''
        ? headers = {
            "Accept-Language": lang == 'en' ? 'en-us' : 'ar-eg',
            ...apiHeaders
          }
        : headers = {
            "Accept-Language": lang == 'en' ? 'en-us' : 'ar-eg',
            "Authorization": token!,
            ...apiHeaders
          };

    try {
      if (kDebugMode) {
        _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: true,
        ));
      }
      _dio
        ..options.receiveTimeout = _defaultReceiveTimeout
        ..options.connectTimeout = _defaultConnectTimeout
        ..options.receiveTimeout = _defaultReceiveTimeout
        ..options.headers = headers
        ..options.followRedirects;
      // _dio.interceptors.add(RetryOnConnectionChangeInterceptor(
      //   requestRetrier: DioConnectivityRequestRetrier(
      //     dio: Dio(),
      //     connectivity: Connectivity(),
      //   ),
      // ));
      response = await _dio.post(
        apiRoute!,
        data: data,
        queryParameters: queryParameters,
      );
      successResponse!(response.data);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on DioError catch (e) {
      errorResponse!(e.response!.data);
      rethrow;
    }
  }

  ///PUT Method
  Future put({
    required String? apiRoute,
    required var data,
    required void Function(dynamic response)? successResponse,
    required void Function(dynamic response)? errorResponse,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response? response;
    Map<String, String>? headers;

    lang = UtilShared.readStringPreference(key: keyLocale);
    token = UtilShared.readStringPreference(key: keyToken);

    print('Token From Shared (PUT Request) $apiRoute: $token');
    // print('Locale From Shared (PUT Request) $apiRoute: $lang');

    token == ''
        ? headers = {
            "Accept-Language": lang == 'en' ? 'en-us' : 'ar-eg',
            ...apiHeaders
          }
        : headers = {
            "Accept-Language": lang == 'en' ? 'en-us' : 'ar-eg',
            "Authorization": token!,
            ...apiHeaders
          };

    try {
      if (kDebugMode) {
        _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: true,
        ));
      }
      _dio
        ..options.receiveTimeout = _defaultReceiveTimeout
        ..options.connectTimeout = _defaultConnectTimeout
        ..options.receiveTimeout = _defaultReceiveTimeout
        ..options.headers = headers;
      // _dio.interceptors.add(RetryOnConnectionChangeInterceptor(
      //   requestRetrier: DioConnectivityRequestRetrier(
      //     dio: Dio(),
      //     connectivity: Connectivity(),
      //   ),
      // ));
      response = await _dio.put(
        apiRoute!,
        data: data,
        queryParameters: queryParameters,
      );
      successResponse!(response.data);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on DioError catch (e) {
      errorResponse!(e.response!.data);
      rethrow;
    }
  }

  ///Delete Method
  Future delete({
    required String? apiRoute,
    required var data,
    required void Function(dynamic response)? successResponse,
    required void Function(dynamic response)? errorResponse,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response? response;
    Map<String, String>? headers;

    lang = UtilShared.readStringPreference(key: keyLocale);
    token = UtilShared.readStringPreference(key: keyToken);

    print('Token From Shared (DELETE Request) $apiRoute: $token');
    // print('Locale From Shared (DELETE Request) $apiRoute: $lang');

    token == ''
        ? headers = {
            "Accept-Language": lang == 'en' ? 'en-us' : 'ar-eg',
            ...apiHeaders
          }
        : headers = {
            "Accept-Language": lang == 'en' ? 'en-us' : 'ar-eg',
            "Authorization": token!,
            ...apiHeaders
          };

    try {
      if (kDebugMode) {
        _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: true,
        ));
      }
      _dio
        ..options.receiveTimeout = _defaultReceiveTimeout
        ..options.connectTimeout = _defaultConnectTimeout
        ..options.receiveTimeout = _defaultReceiveTimeout
        ..options.headers = headers;
      // _dio.interceptors.add(RetryOnConnectionChangeInterceptor(
      //   requestRetrier: DioConnectivityRequestRetrier(
      //     dio: Dio(),
      //     connectivity: Connectivity(),
      //   ),
      // ));
      response = await _dio.delete(
        apiRoute!,
        data: data,
        queryParameters: queryParameters,
      );
      successResponse!(response.data);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on DioError catch (e) {
      errorResponse!(e.response!.data);
      rethrow;
    }
  }

  ///GET Method
  Future get({
    required String? apiRoute,
    required void Function(dynamic response)? successResponse,
    required void Function(dynamic response)? errorResponse,
    Map<String, dynamic>? queryParameters,
  }) async {
    Response? response;
    Map<String, String>? headers;

    lang = UtilShared.readStringPreference(key: keyLocale);
    token = UtilShared.readStringPreference(key: keyToken);

    print('Token From Shared (GET Request) $apiRoute: $token');
    // print('Locale From Shared (GET Request) $apiRoute: $lang');

    token == ''
        ? headers = {
            "Accept-Language": lang == 'en' ? 'en-us' : 'ar-eg',
            ...apiHeaders
          }
        : headers = {
            "Accept-Language": lang == 'en' ? 'en-us' : 'ar-eg',
            "Authorization": token!,
            ...apiHeaders
          };

    try {
      // if (kDebugMode) {
      //   _dio.interceptors.add(LogInterceptor(
      //     responseBody: true,
      //     error: true,
      //     requestHeader: false,
      //     responseHeader: false,
      //     request: false,
      //     requestBody: false,
      //   ));
      // }
      _dio
        ..options.receiveTimeout = _defaultReceiveTimeout
        ..options.connectTimeout = _defaultConnectTimeout
        ..options.receiveTimeout = _defaultReceiveTimeout
        ..options.headers = headers;
      // _dio.interceptors.add(RetryOnConnectionChangeInterceptor(
      //   requestRetrier: DioConnectivityRequestRetrier(
      //     dio: Dio(),
      //     connectivity: Connectivity(),
      //   ),
      // ));
      response = await _dio.get(
        apiRoute!,
        queryParameters: queryParameters,
      );
      print("I am dio:: Get Response: ${response.data}");
      successResponse!(response.data);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on DioError catch (e) {
      errorResponse!(e.response!.data);
      rethrow;
    }
  }
}
