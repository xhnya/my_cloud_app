import 'package:flutter/material.dart';
import 'package:my_cloud_app/component/BottomNavBar.dart';
import 'package:my_cloud_app/page/profile_page.dart';

import 'files_page.dart';
import 'home_page_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePageContent(),  // 首页内容
    FilesPage(),        // 文件页面
    ProfilePage(),      // 个人页面
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: _pages.elementAt(_selectedIndex),
      )),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

