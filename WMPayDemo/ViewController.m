//
//  ViewController.m
//  WMPaySDKDemo
//
//  Created by choice-ios1 on 16/11/1.
//  Copyright © 2016年 Choice. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

#import "WMCheckstandController.h"

@interface ViewController ()<WKNavigationDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"先点提交订单再点左侧支付按钮";
    
    NSString * orderTest = @"http://dev.weimaipay.com:18692";
    
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc] init];
    WKWebView * wkWebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:config];
    [self.view addSubview:wkWebView];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:orderTest]];
    [wkWebView loadRequest:request];
    wkWebView.navigationDelegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}
/*
 * demo 流程：
 * 1. 点击页面的订单提交【金额可以自己修改，可以尝试一分钱测试支付】
 * 2. 点击左上角支付进入支付页面
 * 3. 选择支付宝/微信进行支付操作
 */
- (IBAction)gotoPayAction:(id)sender
{
    //get current app pasteboard
    UIPasteboard * currentAppBoard = [UIPasteboard generalPasteboard];
    NSLog(@"剪切板内容 = %@",currentAppBoard.string);
    
    if (currentAppBoard.string==nil) {
        return;
    }
    UIBarButtonItem * item = (UIBarButtonItem*)sender;
    if ([item isEqual:self.navigationItem.leftBarButtonItem]) {
        WMCheckstandController * checkstandVC = [[WMCheckstandController alloc] init];
        checkstandVC.orderString = currentAppBoard.string;
        [self.navigationController pushViewController:checkstandVC animated:YES];
    }else if ([item isEqual:self.navigationItem.rightBarButtonItem]){
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
