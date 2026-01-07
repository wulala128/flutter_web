# Project Context

## Purpose
这是一个使用 Flutter 构建的多端应用（Web / iOS / Android 等）的示例/业务项目，当前主要提供电商类首页、分类、购物车、个人中心等基础页面，用于快速迭代业务功能和验证前后端接口对接方案。

## Tech Stack
- Flutter 3（Dart SDK ^3.10.4）
- Flutter Web / 移动端多端构建
- UI: Material Design 组件体系
- 网络请求: `dio`
- 状态管理: 以 Widget 自带 `StatefulWidget` 为主（后续可引入更完善方案）

## Project Conventions

### Code Style
- 使用 Dart 官方格式化规范（`dart format`），并启用 `flutter_lints` 作为基础静态检查规则。
- 文件/类命名遵循 Dart/Flutter 社区约定：
  - 文件名使用下划线风格，例如：`main.dart`、`home.dart`。
  - 类名使用帕斯卡命名（PascalCase），例如：`MainPage`、`HomeView`。
- UI 组件拆分时优先关注“职责单一”，避免过度抽象；无状态组件优先使用 `StatelessWidget`。

### Architecture Patterns
- 入口在 `lib/main.dart`，通过 `routes/index.dart` 组织路由。
- 页面按业务模块分目录存放于 `lib/pages/*`，如 `Home`、`Category`、`Cart`、`Mine` 等。
- 公共组件放在 `lib/components/`，通用工具与封装（如网络请求 `DioRequest`）放在 `lib/utils/`。
- 常量在 `lib/contants/`（后续可逐步结构化，例如路由常量、接口常量等）。
- 视图模型（如首页状态）位于 `lib/viewmodels/`，用于承载简单的 UI 逻辑和数据组织。

### Testing Strategy
- 默认使用 Flutter 自带的 `flutter_test`，单元测试和 widget 测试文件统一放在 `test/` 目录下。
- 新增/修改的核心业务逻辑，优先补充至少 1 个覆盖主流程的测试用例。
- 对 UI 行为较重的页面，可通过 widget 测试验证主要交互（如 Tab 切换、导航）。

### Git Workflow
- 建议使用 feature 分支开发：`feature/<short-desc>`，再合并到主分支（如 `main` / `master`）。
- 提交信息建议采用动词开头的英文或中英文混合描述，例如：
  - `feat: add cart page bottom bar`
  - `fix: 修复首页列表滚动卡顿`
- 对应 OpenSpec 变更时，建议在分支名或 commit message 中引用 `change-id`，便于追踪。

## Domain Context
- 当前为电商场景基础骨架应用，包含：
  - 首页推荐/展示（`Home`）
  - 商品分类（`Category`）
  - 购物车（`Cart`）
  - 个人中心（`Mine`）
- 后续可能接入真实商品数据、用户登录状态、订单与支付等能力。

## Important Constraints
- 需同时支持 Web 与移动端构建，避免使用仅限某单一平台的 API（或需明确封装隔离）。
- 依赖尽量保持精简，除非有明确场景和收益再引入新的第三方库。
- 性能优先级：在 Web 端需关注首屏加载体积与渲染速度。

## External Dependencies
- 第三方 Dart 包：
  - `dio`：HTTP 网络请求封装。
  - `cupertino_icons`：iOS 风格图标（主要用于补充 UI 表达）。
- 后续如接入真实后端/API、鉴权、埋点等，需要在此补充服务名称、域名和调用约定。
