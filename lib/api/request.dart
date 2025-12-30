import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioUtils {
  final Dio _dio = Dio();

  DioUtils() {
    String baseUrl = '';
    if (kReleaseMode) {
      baseUrl = "";
    }
    // 判断是否是调试模式
    if (kDebugMode) {
      baseUrl = "https://geek.itheima.net/v1_0/";
    }
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = Duration(seconds: 10);
    _dio.options.receiveTimeout = Duration(seconds: 10);
    _dio.options.sendTimeout = Duration(seconds: 10);

    // 拦截器
    _addInterceptors();
  }

  void _addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        // 请求拦截器
        onRequest: (options, handler) {
          return handler.next(options);
        },
        // 响应拦截器
        onResponse: (response, handler) {
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            return handler.next(response);
          }
          return handler.reject(
            DioException(requestOptions: response.requestOptions),
          );
        },
        // 错误拦截器
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  // get请求
  Future<Response<dynamic>> get(String path, {Map<String, dynamic>? params}) {
    return _dio.get(path, queryParameters: params);
  }
}
