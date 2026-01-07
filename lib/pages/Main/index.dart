import 'package:flutter/material.dart';
import 'package:flutter_web/pages/Cart/index.dart';
import 'package:flutter_web/pages/Category/index.dart';
import 'package:flutter_web/pages/Home/index.dart';
import 'package:flutter_web/pages/Mine/index.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // test
  List tabData = [
    {
      "name": "首页",
      "icon": "lib/assets/ic_public_home_normal.png",
      "active_icon": "lib/assets/ic_public_home_active.png",
    },
    {
      "name": "分类",
      "icon": "lib/assets/ic_public_pro_normal.png",
      "active_icon": "lib/assets/ic_public_pro_active.png",
    },
    {
      "name": "购物车",
      "icon": "lib/assets/ic_public_cart_normal.png",
      "active_icon": "lib/assets/ic_public_cart_active.png",
    },
    {
      "name": "我的",
      "icon": "lib/assets/ic_public_my_normal.png",
      "active_icon": "lib/assets/ic_public_my_active.png",
    },
  ];
  int _currentIndex = 0;

  List<Widget> _getChildWidget() {
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  List<BottomNavigationBarItem> _getTabBarWidget() {
    List<BottomNavigationBarItem> list = [];
    for (var item in tabData) {
      list.add(
        BottomNavigationBarItem(
          icon: Image.asset(item["icon"]!, width: 30, height: 30),
          activeIcon: Image.asset(item["active_icon"]!, width: 30, height: 30),
          label: item["name"],
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _getChildWidget()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: (value) => setState(() {
          _currentIndex = value;
        }),
        currentIndex: _currentIndex,
        items: _getTabBarWidget(),
      ),
    );
  }
}