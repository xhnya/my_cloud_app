import 'package:flutter/material.dart';
import 'package:my_cloud_app/api/UserApi.dart';
import 'package:my_cloud_app/page/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_cloud_app/request/api_service.dart';
import 'package:my_cloud_app/utils/StorageUtil.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // 登录按钮点击事件
  Future<void> _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showErrorToast('用户名或密码不能为空');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // 发起登录请求
      final response = await UserApi.login(username, password);

      setState(() {
        _isLoading = false;
      });

      if (response.code == 200) {
        final token = response.data;
        if (response.code  == 1001) {
         //用户不存在
          _showErrorToast('用户不存在');
          return;
        }


        if (token != null) {
          // 保存 token 和登录状态
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('loggedIn', true);
          await prefs.setString('token', token);

          // 更新 StorageUtil
          await StorageUtil.saveToken(token);
          await StorageUtil.saveLoggedInStatus(true);

          // 登录成功，跳转到首页
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else {
          _showErrorToast('登录失败');
        }
      } else {
        _showErrorToast('用户名或密码错误');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorToast('网络错误，请稍后再试');
    }
  }

  // 显示错误提示
  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '欢迎回来！',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 40),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: '用户名',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: '密码',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
            SizedBox(height: 40),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                '登录',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text(
                '没有账号？去注册',
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
