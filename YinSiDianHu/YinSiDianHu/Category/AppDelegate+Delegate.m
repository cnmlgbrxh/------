//
//  AppDelegate+Delegate.m
//  
//
//  Created by apple on 2017/4/25.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import "AppDelegate+Delegate.h"
#import <UMSocialCore/UMSocialCore.h>//分享

@implementation AppDelegate (Delegate)

- (void)loadLibsWithApplication:(UIApplication *)application WithOptions:(NSDictionary *)launchOptions{

    [[UMSocialManager defaultManager] openLog:NO];
    //友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5976bef75312dd5462000252"];
    //微信
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxa46f15813aa168f5" appSecret:@"9c7393c783ddbb84737c2d257e4ed3f4" redirectURL:@"http://mobile.umeng.com/social"];
    //向微信注册(微信支付)
    [WXApi registerApp:@"wxa46f15813aa168f5"];
    
    //QQ
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106243433" appSecret:@"pYgZRtnEVLz7ZYz7" redirectURL:@"http://mobile.umeng.com/social"];
    
    //新浪微博
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"323720428"  appSecret:@"472693396c95b4e709e08141ed6586dc" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    //缓存
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024
                                                         diskCapacity:20 * 1024 * 1024
                                                             diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    //控制键盘
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.enableAutoToolbar = YES;
}
@end
