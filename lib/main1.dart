import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/api/request.dart';

class FulState extends StatefulWidget {
  final String? message;
  const FulState({super.key, this.message});

  @override
  State<FulState> createState() => _FulStateState();
}

class _FulStateState extends State<FulState> {
  @override
  void initState() {
    super.initState();
    _getChannels();
  }

  List<Map<String, dynamic>> _list = [];

  void _getChannels() async {
    DioUtils request = DioUtils();
    try {
      Response response = await request.get('channels');
      print(response.data['data']);
      setState(() {
        _list = List<Map<String, dynamic>>.from(response.data['data']['channels']);
      });
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
  void didUpdateWidget(covariant FulState oldWidget) {
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
