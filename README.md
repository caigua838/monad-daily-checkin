# DailyCheckIn — 链上每日打卡合约

## 这是什么
一个部署在 Monad Testnet 上的极简每日打卡合约。任何地址每天(UTC)可打卡一次,合约记录累计打卡次数与连续天数,断签后连续数重置为 1。无管理员、无外部依赖,每个地址只能修改自己的记录。

## 合约信息
- 网络:Monad Testnet (Chain ID 10143)
- 合约地址:`0xC4E5F1D3d4A0Fe87A515d4C9bAE2B25B0E03bC57`
- 部署交易:`0x26434ef07b356ef86ef0297fb06874f0b5926bd3338357a82fe7164ab3301748`
- 打卡交易:`0x2f307cbee3be3f1ad3ef95bb85a4ab1d3ea71bcf5557c064da32d44da177284a`
- 源码:DailyCheckIn.sol(Solidity ^0.8.20)

## 如何部署
1. 在 Remix 中打开 DailyCheckIn.sol,使用 0.8.20+ 编译器编译
2. Deploy & Run 中 Environment 选择 Browser Extension - MetaMask,确认网络为 Monad Testnet
3. 点击 Deploy 并在钱包中签名,记录合约地址与交易 hash

## 如何交互
- **打卡(写入,消耗 gas)**:调用 `checkIn()`。每地址每 UTC 日限一次,重复调用会回滚并提示 "Already checked in today"
- **查询今日是否已打卡(只读,免费)**:调用 `hasCheckedInToday(address)`,返回 bool
- **查询打卡档案(只读,免费)**:调用 `records(address)`,返回累计次数、当前连续天数、上次打卡天数编号

## 已知边界
- 按 UTC 日切换打卡周期,东八区用户每日 08:00 进入新周期。属设计取舍,建议由前端做本地时间提示
- `lastCheckInDay` 存储的是天数编号(如 20643)而非日期,命名可优化为 `lastCheckInDayIndex`
- 合约已通过 Sourcify 验证,但 MonadVision 使用独立的验证服务,故浏览器上仍显示未验证
