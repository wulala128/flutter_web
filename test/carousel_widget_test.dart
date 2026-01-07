import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_web/components/CarouselWidget.dart';
import 'package:flutter_web/viewmodels/home.dart';

void main() {
  group('CarouselWidget Tests', () {
    testWidgets('无数据时不显示轮播图区域', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CarouselWidget(banners: []),
          ),
        ),
      );

      // 无数据时应该返回空容器，不显示任何内容
      expect(find.byType(CarouselWidget), findsOneWidget);
      expect(find.byType(PageView), findsNothing);
    });

    testWidgets('有数据时显示轮播图和指示器', (WidgetTester tester) async {
      final banners = [
        BannerItem(id: '1', imgUrl: 'https://example.com/banner1.jpg'),
        BannerItem(id: '2', imgUrl: 'https://example.com/banner2.jpg'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarouselWidget(banners: banners),
          ),
        ),
      );

      // 应该显示 PageView
      expect(find.byType(PageView), findsOneWidget);
      // 应该显示指示器（小圆点）
      expect(find.byType(Row), findsWidgets);
    });

    testWidgets('单张Banner时不显示指示器', (WidgetTester tester) async {
      final banners = [
        BannerItem(id: '1', imgUrl: 'https://example.com/banner1.jpg'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarouselWidget(banners: banners),
          ),
        ),
      );

      // 应该显示 PageView
      expect(find.byType(PageView), findsOneWidget);
      // 单张Banner时不应该显示指示器（Row 应该只用于布局，不用于指示器）
      // 这里我们检查指示器的特定结构
      final stack = tester.widget<Stack>(find.byType(Stack));
      // Stack 应该只有 PageView，没有指示器
      expect(stack.children.length, 1);
    });

    testWidgets('多张Banner时显示指示器', (WidgetTester tester) async {
      final banners = [
        BannerItem(id: '1', imgUrl: 'https://example.com/banner1.jpg'),
        BannerItem(id: '2', imgUrl: 'https://example.com/banner2.jpg'),
        BannerItem(id: '3', imgUrl: 'https://example.com/banner3.jpg'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarouselWidget(banners: banners),
          ),
        ),
      );

      // 应该显示 PageView
      expect(find.byType(PageView), findsOneWidget);
      // 应该显示 Stack（包含 PageView 和指示器）
      final stack = tester.widget<Stack>(find.byType(Stack));
      expect(stack.children.length, 2); // PageView + 指示器
    });

    testWidgets('轮播图组件有正确的高度', (WidgetTester tester) async {
      final banners = [
        BannerItem(id: '1', imgUrl: 'https://example.com/banner1.jpg'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CarouselWidget(banners: banners, height: 200),
          ),
        ),
      );

      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
      expect(sizedBox.height, 200);
    });
  });
}
