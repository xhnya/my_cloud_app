import 'package:dio/dio.dart';
import 'package:my_cloud_app/constant/ApiConstant.dart';

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
  );


  /// 封装 POST 请求
  static Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
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
