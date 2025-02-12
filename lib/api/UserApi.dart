import 'package:my_cloud_app/request/api_service.dart';
import 'package:my_cloud_app/utils/ApiResponse.dart';

class UserApi{


  //登录方法
  static Future login(String username, String password) async {
    final response = await ApiService.post("/auth/login", data: {
      "username": username,
      "password": password
    });
    return response;
  }

  //发送验证码
  static Future sendCode(String email) async {
    final response = await ApiService.post("/auth/sendCode", data: {
      "email": email
    });
    return response;
  }
  static Future register(String email, String code, String username, String password) async {
    final response = await ApiService.post("/auth/register", data: {
      "email": email,
      "code": code,
      "username": username,
      "password": password
    });
    return response;
  }

  static Future getUserInfo() async {
    final response = await ApiService.post("/user/getUserInfo");
    return response;
  }


}