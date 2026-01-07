## 1. Specification & Design
- [x] 1.1 新建首页布局能力 spec：`openspec/specs/home-layout/spec.md`，描述首页结构及顶部轮播区域的存在
- [x] 1.2 在本变更目录下编写首页轮播相关 delta：`openspec/changes/add-home-top-carousel/specs/home-layout/spec.md`
- [x] 1.3 与产品/设计确认轮播的基础行为（是否自动轮播、轮播间隔、指示器样式的最小要求），如有需要在 spec 中补充场景

## 2. Implementation
- [x] 2.1 在首页页面（`lib/pages/Home/`）中预留顶部轮播图组件占位，并保证页面其他内容正常布局
- [x] 2.2 定义用于承载轮播数据的模型与数据源（复用 `BannerItem` 模型，通过 `dioRequest.get('home/banner')` 获取数据）
- [x] 2.3 实现轮播组件的基本交互：左右滑动切换、当前项指示器（使用 `PageView` + `Timer` 实现3秒自动轮播）
- [x] 2.4 处理无数据场景（无数据时返回 `SizedBox.shrink()` 隐藏轮播区域）

## 3. Testing & Validation
- [x] 3.1 为首页编写或更新 widget 测试，验证顶部轮播区域在有/无数据时的展示逻辑（`test/carousel_widget_test.dart`）
- [x] 3.2 补充至少一个交互路径测试（测试了无数据、单张Banner、多张Banner、指示器显示等场景）
- [ ] 3.3 运行 `openspec validate add-home-top-carousel --strict` 并确保通过（本地未安装 openspec CLI，需在有 CLI 的环境中执行）

