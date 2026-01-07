import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_web/viewmodels/home.dart';

/// 首页顶部轮播图组件
/// 支持3秒自动轮播、左右滑动切换、小圆点指示器
class CarouselWidget extends StatefulWidget {
  final List<BannerItem> banners;
  final double height;
  final double? aspectRatio;

  const CarouselWidget({
    super.key,
    required this.banners,
    this.height = 200.0,
    this.aspectRatio,
  });

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  late PageController _pageController;
  late Timer _autoPlayTimer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoPlay();
  }

  @override
  void dispose() {
    _autoPlayTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  /// 启动自动轮播（3秒间隔）
  void _startAutoPlay() {
    // 只有至少2张Banner时才自动轮播
    if (widget.banners.length < 2) return;

    _autoPlayTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      _nextPage();
    });
  }

  /// 切换到下一页
  void _nextPage() {
    if (!_pageController.hasClients) return;
    int nextIndex = (_currentIndex + 1) % widget.banners.length;
    _pageController.animateToPage(
      nextIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// 处理页面切换
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 无数据时返回空容器（不显示轮播区域）
    if (widget.banners.isEmpty) {
      return const SizedBox.shrink();
    }

    // 只有一张Banner时，不显示指示器，也不自动轮播
    bool showIndicator = widget.banners.length > 1;

    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          // 轮播图主体
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: widget.banners.length,
            itemBuilder: (context, index) {
              final banner = widget.banners[index];
              return _buildBannerItem(banner);
            },
          ),
          // 小圆点指示器（仅在有多张Banner时显示）
          if (showIndicator)
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: _buildIndicator(),
            ),
        ],
      ),
    );
  }

  /// 构建单个Banner项
  Widget _buildBannerItem(BannerItem banner) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: Image.network(
        banner.imgUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: const Center(
              child: Icon(Icons.broken_image, size: 48, color: Colors.grey),
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: Colors.grey[200],
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }

  /// 构建小圆点指示器
  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.banners.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index
                ? Colors.white
                : Colors.white.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
