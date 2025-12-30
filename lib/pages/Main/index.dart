import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, String>> _tabList = [
    {
      "icon": "ic_public_home_normal.png",
      "active_icon": "ic_public_home_active.png",
      "text": "首页",
    },
    {
      "icon": "ic_public_pro_normal.png",
      "active_icon": "ic_public_pro_active.png",
      "text": "分类",
    },
    {
      "icon": "ic_public_cart_normal.png",
      "active_icon": "ic_public_cart_active.png",
      "text": "购物车",
    },
    {
      "icon": "ic_public_my_normal.png",
      "active_icon": "ic_public_my_active.png",
      "text": "我的",
    },
  ];

  List<BottomNavigationBarItem> _getTabBarWidget() {
    List<BottomNavigationBarItem> list = [];
    for (var item in _tabList) {
      list.add(
        BottomNavigationBarItem(
          icon: Image.asset(
            item["icon"]!,
            width: 30,
            height: 30,
          ),
          activeIcon: Image.asset(
            item["active_icon"]!,
            width: 30,
            height: 30,
          ),
          label: item["text"],
        )
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/login');
          },
          child: const Text('Login'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: _getTabBarWidget()),
    );
  }
}