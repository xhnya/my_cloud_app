import 'package:my_cloud_app/request/api_service.dart';

class UserApi{


  //登录方法
  static Future login(String username, String password) async {
    final response = await ApiService.post("/auth/login", data: {
      "username": username,
      "password": password
    });
    return response;
  }
}