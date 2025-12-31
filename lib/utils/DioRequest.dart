import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web/contants/index.dart';

class DioRequest {
  final Dio _dio = Dio();

  DioRequest() {
    String baseUrl = '';
    if (kReleaseMode) {
      baseUrl = GlobalConstants.BASE_URL;
    }
    // 判断是否是调试模式
    if (kDebugMode) {
      baseUrl = GlobalConstants.DEV_BASE_URL;
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

  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>;
      if (data["code"] == GlobalConstants.SUCCESS_CODE) {
        return data;
      }
      // 抛出异常
      throw DioException(
        requestOptions: res.requestOptions,
        message: data["msg"] ?? "加载数据失败",
      );
    } catch (e) {
      rethrow;
    }
  }

  // get
  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  // post
  Future<dynamic> post(String url, {Map<String, dynamic>? data}) {
    return _handleResponse(_dio.post(url, data: data));
  }
}

final dioRequest = DioRequest(); // 单例对象
