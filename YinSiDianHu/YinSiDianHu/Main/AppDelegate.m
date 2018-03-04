//
//  AppDelegate.m
//  ShiZhiBao
//
//  Created by apple on 2017/3/28.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"
#import "NavigationViewController.h"
#import "AppDelegate+Delegate.h"
#import <AlipaySDK/AlipaySDK.h>
#import "LoginViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "QQShoppingMallVC.h"
@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //配置三方
    [self loadLibsWithApplication:application WithOptions:launchOptions];
    //登录处理
    //[self loadLoginWithApplication:application WithOptions:launchOptions];
    TabBarController *tab = [[TabBarController alloc]init];
    self.window.rootViewController = tab;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}
#pragma mark - 自动登录处理
- (void)loadLoginWithApplication:(UIApplication *)application WithOptions:(NSDictionary *)launchOptions{
    //登录
    if (USERMANAGER.isLogin && USERNAME &&USERPASS) {
        NSDictionary *dicParameters = @{
                                        @"action":@"login",
                                        @"username":USERNAME,
                                        @"userpass":USERPASS,
                                        @"version":APP_VERSION
                                        };
        [DataRequest POST_TParameters:dicParameters showHUDAddedTo:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[responseObject objectForKey:@"stats"] isEqualToString:@"ok"])
            {
                [UserManager userInfoManager:responseObject];
            }
            
        }];
        TabBarController *tab = [[TabBarController alloc]init];
        tab.delegate = self;
        self.window.rootViewController = tab;
        
    }else
    {
        self.window.rootViewController = [[LoginViewController alloc]init];
    }
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.[[UMSocialManager defaultManager] handleO
}
#pragma mark - 注意：收到内存警告时调用，
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 1. 停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
    // 2. 清除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    //客服缓存,网络缓存
}
#pragma mark - 微信支付结果回调
-(void)onResp:(BaseResp*)resp{
    //启动微信支付的response
    PayResp*response=(PayResp*)resp;
    
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (response.errCode) {
            case 0:
                [DataManager save:@"" forKey:@"刷新用户信息"];
                [[NSNotificationCenter defaultCenter] postNotificationName:APPAlipayNotification object:@"支付成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:PaymentResults object:@"支付成功"];
                break;
            case -1:
                [[NSNotificationCenter defaultCenter] postNotificationName:APPAlipayDEF object:@"支付失败"];
                [[NSNotificationCenter defaultCenter] postNotificationName:PaymentResults object:@"支付失败"];
                [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:@"支付失败"];
                break;
            case -2:
                [[NSNotificationCenter defaultCenter] postNotificationName:APPAlipayDEF object:@"退出支付"];
                [[NSNotificationCenter defaultCenter] postNotificationName:PaymentResults object:@"退出支付"];
                [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:@"支付失败"];
                break;
            default:
                [[NSNotificationCenter defaultCenter] postNotificationName:APPAlipayDEF object:@"支付失败"];
                [[NSNotificationCenter defaultCenter] postNotificationName:PaymentResults object:@"支付失败"];
                break;
        }
    }
}
#pragma mark - 微信支付~第三方登录
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (result) {
        //调用其他SDK，例如支付宝SDK等
        return  [WXApi handleOpenURL:url delegate:self];
    }
    return result;
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (result) {
        if ([url.host isEqualToString:@"safepay"]) {
            // 支付跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"支付宝支付成功 --- result = %@",resultDic);
                NSString *resultStatus =[resultDic objectForKey:@"resultStatus"];
                if (resultStatus&&[resultStatus intValue]==9000) {
                    [DataManager save:@"" forKey:@"刷新用户信息"];
                    [[NSNotificationCenter defaultCenter]postNotificationName:APPAlipayNotification object:@"支付成功"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:PaymentResults object:@"支付成功"];
                    [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_yes" andText:@"订单支付成功~"];
                }else if ((resultStatus&&[resultStatus intValue]==6001) || (resultStatus&&[resultStatus intValue]==6002)|| (resultStatus&&[resultStatus intValue]==4000)){
                    [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:@"支付失败"];
                    [[NSNotificationCenter defaultCenter]postNotificationName:APPAlipayDEF object:@"支付失败"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:PaymentResults object:@"支付失败"];
                }
            }];
            
            // 授权跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                // 解析 auth code
                NSString *result = resultDic[@"result"];
                NSString *authCode = nil;
                if (result.length>0) {
                    NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                    for (NSString *subResult in resultArr) {
                        if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                            authCode = [subResult substringFromIndex:10];
                            break;
                        }
                    }
                }
                NSLog(@"授权结果 authCode  = %@", authCode?:@"");
            }];
        }
        // 微信支付SDK的回调
        return [WXApi handleOpenURL:url delegate:self];
    }
    return result;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //NSLog(@"支付宝支付-----------result = %@",resultDic);
            NSString *resultStatus =[resultDic objectForKey:@"resultStatus"];
            if (resultStatus&&[resultStatus intValue]==9000)
            {
                [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_yes" andText:@"订单支付成功~"];
                [DataManager save:@"" forKey:@"刷新用户信息"];
                [[NSNotificationCenter defaultCenter]postNotificationName:APPAlipayNotification object:@"支付成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:PaymentResults object:@"支付成功"];
            }else if ((resultStatus&&[resultStatus intValue]==6001) || (resultStatus&&[resultStatus intValue]==6002)|| (resultStatus&&[resultStatus intValue]==4000))
            {
                [[NSNotificationCenter defaultCenter]postNotificationName:APPAlipayDEF object:@"支付失败"];
                [[NSNotificationCenter defaultCenter] postNotificationName:PaymentResults object:@"支付失败"];
                [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:@"支付失败"];
            }
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
        return YES;
    }else if ([options[UIApplicationOpenURLOptionsSourceApplicationKey] isEqualToString:@"com.tencent.xin"] && [url.absoluteString containsString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:self];
    }else{
        return [[UMSocialManager defaultManager] handleOpenURL:url];
    }
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    UINavigationController *nav = (UINavigationController *)viewController;
    UINavigationController *nav2 = tabBarController.selectedViewController;
    if (nav.viewControllers.count == 0)return NO;
    UIViewController *vc = [nav.viewControllers firstObject];
    if ([vc isKindOfClass:[QQShoppingMallVC class]]) {
        QQShoppingMallVC *mallvc = (QQShoppingMallVC *)vc;
        if ([nav.topViewController isKindOfClass:[nav2.topViewController class]]) {
            [mallvc refreshData];
        }
    }
    return YES;
}

@end
