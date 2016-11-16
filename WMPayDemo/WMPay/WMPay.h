//
//  WMPay.h
//  WMPaySDKDemo
//
//  Created by choice-ios1 on 16/11/8.
//  Copyright © 2016年 Choice. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WMPayResultOption)
{
    WMPayErrorAliSuccess = 9000,
    WMPayErrorAliPaying = 8000,
    WMPayErrorAliError = 4000,
    WMPayErrorAliCancel = 6001,
    WMPayErrorAliNetworkError = 6002,
    WMPayErrorWxSuccess = 0,
    WMPayErrorWxError = -1,
    WMPayErrorWxCancel = -2,
    WMPayErrorUnkownError,
};

@interface WMPayResult : NSObject

@property (readonly,assign) WMPayResultOption status;

- (NSString *)result;

-(instancetype)initWithAttributes:(NSDictionary *)attributes;

@end

@interface WMPay : NSObject


/**
 *  初始化支付模块
 *
 *  @param appkey    微信支付平台分配给app的标识
 *  @param description    描述内容，可选
 *  @param scheme       调用支付宝的回调需传入应用的scheme
 */
+ (void)initPaySDKWithWechat:(NSString*)appkey
             withDescription:(NSString*)description
               withAppScheme:(NSString*)scheme;
/**
 *  版本号
 *
 *  @return         WMPay SDK 版本号
 */
+ (NSString *)version;

/**
 *  设置 Debug 模式，默认release模式，不开启日志
 *
 *  @param enabled    是否启用
 */
+ (void)setDebugMode:(BOOL)enabled;

/**
 *  回调结果接口(支付宝/微信/测试模式)
 *  保证跳转支付过程中，当 app 被 kill 掉时，能通过这个接口得到支付结果
 *  @param url              结果url
 *
 *  @return                 当无法处理 URL 或者 URL 格式不正确时，会返回 NO。
 */
+ (BOOL)handleOpenURL:(NSURL *)url;

@end
