# WMPay iOS SDK

## 简介

一个web收银台，集成了支付宝 or 微信支付。在手机端可以调起微信/支付宝应用进行支付操作。

## 版本要求
iOS SDK 要求 iOS 7.0 及以上版本

## 接入方法

### 安装

#### 手动导入
1. 获取 WMPaySDK
   
   下载 SDK 例子工程，把 `WMPaySDK` 文件夹拖进自己的项目中。
   
2. 导入依赖的 Frameworks：
   
   ```objc
   //支付宝
   libc++.tbd
   libz.tbd
   SystemConfiguration.framework
   CoreTelephony.framework
   QuartzCore.framework
   CoreText.framework
   CoreGraphics.framework
   UIKit.framework
   Foundation.framework
   CFNetwork.framework
   CoreMotion.framework
   //微信
   Security.framework
   libsqlite3.0.tbd
   ```
3. 添加 URL Schemes：在 Xcode 中，选择你的工程设置项，选中 "TARGETS" 一栏，在 "Info" 标签栏的 "URL Types" 添加 "URL Schemes"，如果使用微信，填入所注册的微信应用程序 id，如果不使用微信，则自定义，允许英文字母和数字，首字母必须是英文字母，建议起名稍复杂一些，尽量避免与其他程序冲突。


#### cocoaPods
暂未支持

### 额外配置
1. iOS 9 以上版本如果需要使用支付宝和微信渠道，需要在 Info.plist 添加以下代码：

 ```objc
 <key>LSApplicationQueriesSchemes</key>
<array>
    <string>weixin</string>
    <string>wechat</string>
    <string>alipay</string>
    <string>alipays</string>
    <string>mqq</string>
</array>
 ```
2. iOS 9 限制了 http 协议的访问，如果 App 需要访问 http://，需要在 Info.plist 添加如下代码：
3. 
 ```objc
 <key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
 ```
 
## 功能介绍
1. 初始化SDK（这一步必须进行）

 ```objc
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //向微信注册wxd930ea5d5a258f4f
    [WMPay initPaySDKWithWechat:@"wx5501550d486be49b" withDescription:@"wemay" withAppScheme:@"wmpaydemo"];
    
    return YES;
}
 ```
2. 设置支付宝/微信的回调

 ```objc
 //iOS 9 以上调用该方法
 - (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options NS_AVAILABLE_IOS(9_0)
{
    [WMPay handleOpenURL:url];
    return YES;
}
//iOS 9 以下调用该方法
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation {
    
    [WMPay handleOpenURL:url];

    return YES;
}
 ```
3. 可以开启debug模式，查看日志输出

 ```objc
 + (void)setDebugMode:(BOOL)enabled;
 ```
 
4. 调用 web 收银台

 ```objc
WMPayListController * paylistVC = [[WMPayListController alloc] init];
 paylistVC.orderString = currentAppBoard.string;
 [self.navigationController pushViewController:paylistVC animated:YES];
 ```
 其中 orderString 为加密过的订单数据
## 注意事项
