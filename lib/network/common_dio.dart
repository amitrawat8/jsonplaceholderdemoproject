import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jsondemoproject/constant/rest_path.dart';
/**
 * Created by Amit Rawat on 3/30/2022.
 */

class ApiClient {
  ApiClient._privateConstructor();

  static final ApiClient _instance = ApiClient._privateConstructor();

  static ApiClient get instance => _instance;
  static Dio? clientDio;

  clear() {
    clientDio = null;
  }

  Dio getdio() {
    if (clientDio == null) {
      clientDio = Dio(); // with default Options

      // dio.options.connectTimeout = 5000; //5s
      // dio.options.receiveTimeout = 5000;
      clientDio!.interceptors
          .add(InterceptorsWrapper(onRequest: (options, handler) {
        options.headers[RestPath.CONTENT_TYPE] = RestPath.CONTENT_FORMAT;
        options.headers[RestPath.ACCEPT] = RestPath.CONTENT_FORMAT;
        return handler.next(options); //continue
      }, onResponse: (response, handler) {
        return handler.next(response); // continue
      }, onError: (DioError e, handler) {
        return handler.next(e); //continue
      }));

      /*not in release mode: log print*/
      if (!kReleaseMode) {
        clientDio!.interceptors.add(logInterceptor(true));
      } else {
        clientDio!.interceptors.add(logInterceptor(false));
      }
    }
    return clientDio!;
  }

  LogInterceptor logInterceptor(bool value) {
    return LogInterceptor(
        responseBody: value,
        requestHeader: value,
        requestBody: value,
        error: value,
        request: value,
        responseHeader: value);
  }
}
