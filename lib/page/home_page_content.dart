import 'package:flutter/material.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Home Page11'),
        elevation: 0, // 确保没有阴影
        shadowColor: Colors.transparent,

      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(100, (index) {
            return ListTile(
              title: Text('Item $index'),
            );
          }),
        ),
      ),
    );
  }
}