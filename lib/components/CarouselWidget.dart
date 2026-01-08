import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_web/viewmodels/home.dart';

/// 首页顶部轮播图组件
/// 支持1秒自动轮播、左右滑动切换、小圆点指示器
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
  Timer? _autoPlayTimer;
  int _currentIndex = 0;
  static const int _initialPage = 10000; // 设置一个很大的初始页面索引以实现无限循环

  @override
  void initState() {
    super.initState();
    // 从中间位置开始，实现无限循环
    _pageController = PageController(initialPage: _initialPage);
    // 延迟启动自动轮播，确保 PageController 已就绪
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoPlay();
    });
  }

  @override
  void didUpdateWidget(CarouselWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 当 banners 列表变化时，重新启动自动轮播
    if (oldWidget.banners.length != widget.banners.length) {
      _stopAutoPlay();
      // 延迟启动，确保 PageController 已就绪
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _startAutoPlay();
        }
      });
    }
  }

  /// 将页面索引转换为实际索引
  int _getRealIndex(int pageIndex) {
    if (widget.banners.isEmpty) return 0;
    return pageIndex % widget.banners.length;
  }

  @override
  void dispose() {
    _stopAutoPlay();
    _pageController.dispose();
    super.dispose();
  }

  /// 停止自动轮播
  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = null;
  }

  /// 启动自动轮播（1秒间隔）
  void _startAutoPlay() {
    // 先停止之前的定时器
    _stopAutoPlay();
    // 只有至少2张Banner时才自动轮播
    if (widget.banners.length < 2) return;

    _autoPlayTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      _nextPage();
    });
  }

  /// 切换到下一页
  void _nextPage() {
    if (!mounted || !_pageController.hasClients) return;
    if (widget.banners.isEmpty) return;
    // 直接跳到下一页，实现无限循环
    double? currentPage = _pageController.page;
    if (currentPage == null) return;
    int nextPage = currentPage.round() + 1;
    _pageController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  /// 处理页面切换
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = _getRealIndex(index);
    });
    
    // 当接近边界时，无缝跳转到中间位置（实现无限循环）
    if (widget.banners.isNotEmpty && widget.banners.length > 1) {
      // 如果当前页面距离初始位置太远，跳回中间位置
      int distanceFromInitial = (index - _initialPage).abs();
      if (distanceFromInitial > widget.banners.length * 10) {
        int realIndex = _getRealIndex(index);
        int targetPage = _initialPage + realIndex;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && _pageController.hasClients) {
            _pageController.jumpToPage(targetPage);
          }
        });
      }
    }
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
            itemCount: widget.banners.isEmpty ? 0 : null, // 设置为 null 实现无限循环
            itemBuilder: (context, index) {
              final realIndex = _getRealIndex(index);
              final banner = widget.banners[realIndex];
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
        (index) => GestureDetector(
          onTap: () {
            if (_pageController.hasClients) {
              // 计算目标页面索引（基于当前页面位置）
              double? currentPage = _pageController.page;
              if (currentPage != null) {
                int currentPageInt = currentPage.round();
                int currentRealIndex = _getRealIndex(currentPageInt);
                int targetPage = currentPageInt - currentRealIndex + index;
                _pageController.animateToPage(
                  targetPage,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            }
          },
          child: Container(
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
      ),
    );
  }
}
