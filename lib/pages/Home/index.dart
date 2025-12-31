import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/utils/DioRequest.dart';

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
    _getChannels();
  }

  List<Map<String, dynamic>> _list = [];

  void _getChannels() async {
    try {
      Map<String, dynamic> response = await dioRequest.get('home/category/head');
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
    return Container(
      height: 300, // 给容器设置高度以便滚动
      child: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          var item = _list[index];
          return Text('${item['name']}'); // 渲染name字段
        },
      ),
    );
  }
}
