import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';  // 首页页面
import 'login_page.dart';  // 登录页面


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MyCloud',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,

      ),
      home: CheckLoginStatus(),
    );
  }
}

class CheckLoginStatus extends StatelessWidget {
  const CheckLoginStatus({super.key});

  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    // 假设保存的登录信息是'loggedIn'
    return prefs.getBool('loggedIn') ?? false;  // 默认为false
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data == true) {
          return HomePage();  // 用户已登录，跳转到首页
        } else {
          return LoginPage();  // 用户未登录，跳转到登录页面
        }
      },
    );
  }
}