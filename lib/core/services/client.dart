import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'request_interceptor.dart';

/*
 * The network client. It manages the network API calls.
 * To use this, get the Dio instance then make the necessary HTTP method call.
 * Pref: Initialize in bindings
 * Examples:
 *    - Client.dio
 */
mixin Client {
  static Dio get dio {
    final Dio dio = Dio();

    dio.options.baseUrl = 'https://stable-api.pricelocq.com/mobile/';
    dio.options.connectTimeout = 20000;
    dio.options.receiveTimeout = 0;
    dio.options.sendTimeout = 20000;
    dio.interceptors.add(RequestInterceptor());
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
          requestBody: true,
          responseBody:
              true)); // Do not delete this. Uncomment for requests logs.
    }

    return dio;
  }
}
