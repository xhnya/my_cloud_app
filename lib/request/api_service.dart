import 'package:dio/dio.dart';
import 'package:my_cloud_app/constant/ApiConstant.dart';
import 'package:my_cloud_app/utils/ApiResponse.dart';

import 'package:my_cloud_app/utils/StorageUtil.dart';

class ApiService {
  static const String baseUrl = ApiConstant.baseUrl; // 设置基础API地址

  // 创建 Dio 实例
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 5), // 连接超时时间
      receiveTimeout: Duration(seconds: 3), // 响应超时时间
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  )..interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      // 从本地存储中获取 token
      String? token = await StorageUtil.getToken(); // 假设你有一个 StorageUtil 工具类用于存取 token
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token'; // 将 token 放入请求头
      }
      return handler.next(options); // 继续请求
    },
    onResponse: (response, handler) {
      return handler.next(response); // 直接返回响应
    },
    onError: (DioError e, handler) {
      return handler.next(e); // 错误处理
    },
  ));


  /// 封装 POST 请求
  static Future<ApiResponse> post(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(path, data: data);

      return  ApiResponse.fromJson( response.data);
    } catch (e) {
      rethrow;
    }
  }

  /// 封装 GET 请求
  static Future<Response> get(String path, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(path, queryParameters: params);
      return response;
    } catch (e) {
      rethrow;
    }
  }



}
