## ADDED Requirements

### Requirement: Home Page Has Top Carousel Area
首页页面在主内容区域上方 MUST 预留一个顶部轮播图区域，用于展示一组可横向切换的 Banner，并通过小圆点指示器和自动轮播提升曝光效率。

#### Scenario: Home page first loaded
- **WHEN** 用户首次进入应用的首页
- **THEN** 在可视区域顶部看到轮播图区域
- **AND** 如果有可用的轮播数据，则展示至少一张 Banner 图片

#### Scenario: Swipe to change carousel item
- **WHEN** 用户在轮播图区域左右滑动
- **THEN** 当前展示的 Banner 按滑动方向切换到相邻的一张
- **AND** 当前指示器（小圆点）同步更新，反映当前展示项

#### Scenario: Auto-play every 3 seconds
- **WHEN** 首页处于可见状态且轮播图区域存在至少 2 张可用 Banner
- **THEN** 系统 MUST 以约 3 秒的间隔自动切换到下一张 Banner
- **AND** 当前指示器（小圆点）同步更新，反映当前展示项

#### Scenario: No carousel data available
- **WHEN** 首页加载完成但当前无可用轮播数据（例如接口返回空列表）
- **THEN** 系统 MAY 隐藏轮播区域或展示占位内容
- **AND** 不影响首页其他内容（如商品列表、推荐内容）的正常展示

