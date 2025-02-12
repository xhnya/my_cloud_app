import 'package:flutter/material.dart';
import 'package:my_cloud_app/api/UserApi.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userInfo = '';

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  void _fetchUserInfo() async {
    try {
      final response = await UserApi.getUserInfo();
      setState(() {
        _userInfo = 'User: ${response.data['userName']}';
      });
    } catch (e) {
      setState(() {
        _userInfo = '获取用户信息失败';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_userInfo)
          ],
        ),
      ),
    );
  }
}