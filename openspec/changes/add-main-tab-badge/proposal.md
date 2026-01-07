# Change: 为主 Tab 栏购物车图标新增未读角标

## Why
当前底部导航栏的“购物车”仅是普通图标，用户无法在不进入页面的情况下感知购物车内是否有商品或有多少商品，影响电商场景下的转化和提醒能力。

## What Changes
- 在主页面底部导航栏（Main 页面）为“购物车” Tab 添加数量角标展示能力。
- 当购物车内有商品时，显示数量角标（最大显示阈值，如 `99+`），为 0 时不展示。
- 预留扩展点，以后可支持红点提醒（如有促销、优惠券等）。

## Impact
- Affected specs: `specs/navigation-main/spec.md`（新建，用于描述主导航行为）
- Affected code:
  - `lib/pages/Main/index.dart`：主 Tab 页和底部导航栏逻辑。
  - `lib/viewmodels/home.dart` 或后续新增的购物车状态管理模块。

