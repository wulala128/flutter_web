## ADDED Requirements

### Requirement: Main Tab Bar Shows Cart Badge
主页面底部导航栏在“购物车” Tab 上应显示购物车内商品数量的角标，以便用户快速感知当前购物车状态。

#### Scenario: No items in cart
- **WHEN** 用户打开应用或返回主页面，且购物车内商品数量为 0
- **THEN** 底部导航栏的“购物车” Tab 上不显示角标

#### Scenario: Few items in cart
- **WHEN** 购物车内商品数量大于 0 且小于等于 99
- **THEN** 底部导航栏的“购物车” Tab 上显示数量角标，文字为实际商品数量

#### Scenario: Many items in cart
- **WHEN** 购物车内商品数量大于 99
- **THEN** 底部导航栏的“购物车” Tab 上显示数量角标，文字为 `99+`

