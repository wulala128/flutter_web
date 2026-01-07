import 'package:flutter/material.dart';
import 'package:flutter_web/components/CarouselWidget.dart';
import 'package:flutter_web/utils/DioRequest.dart';
import 'package:flutter_web/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  final String? message;
  const HomeView({super.key, this.message});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    _getBanners();
    _getChannels();
  }

  List<BannerItem> _banners = [];
  List<Map<String, dynamic>> _list = [];

  /// 获取轮播图数据
  void _getBanners() async {
    try {
      // 假设接口返回格式: { "code": 200, "result": [{ "id": "...", "imgUrl": "..." }] }
      Map<String, dynamic> response = await dioRequest.get('home/banner');
      if (response['result'] != null) {
        setState(() {
          _banners = (response['result'] as List)
              .map((item) => BannerItem.formJSON(item))
              .toList();
        });
      }
    } catch (e) {
      // 如果接口不存在或失败，使用 mock 数据作为降级方案
      print('获取轮播图失败: $e');
      // 可以在这里设置 mock 数据，或者保持空列表（轮播图会隐藏）
      // setState(() {
      //   _banners = [
      //     BannerItem(id: '1', imgUrl: 'https://example.com/banner1.jpg'),
      //     BannerItem(id: '2', imgUrl: 'https://example.com/banner2.jpg'),
      //   ];
      // });
    }
  }

  void _getChannels() async {
    try {
      Map<String, dynamic> response = await dioRequest.get(
        'home/category/head',
      );
      setState(() {
        _list = List<Map<String, dynamic>>.from(response['result']);
      });
      // ignore: empty_catches
    } catch (e) {
      print(e);
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant HomeView oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 顶部轮播图区域
        CarouselWidget(banners: _banners, height: 200),
        // 原有分类列表内容
        Expanded(
          child: Container(
            height: 300, // 给容器设置高度以便滚动
            child: ListView.builder(
              itemCount: _list.length,
              itemBuilder: (BuildContext context, int index) {
                var item = _list[index];
                return Text('${item['name']}'); // 渲染name字段
              },
            ),
          ),
        ),
        SizedBox(
          height: 210,
          child: Card(
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    '1625 Main Street',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: const Text('My City, CA 99984'),
                  leading: Icon(Icons.restaurant_menu, color: Colors.blue[500]),
                ),
                const Divider(),
                ListTile(
                  title: const Text(
                    '(408) 555-1212',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  leading: Icon(Icons.contact_phone, color: Colors.blue[500]),
                ),
                ListTile(
                  title: const Text('costa@example.com'),
                  leading: Icon(Icons.contact_mail, color: Colors.blue[500]),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
