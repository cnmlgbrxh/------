//
//  MessageHUG.m
//  ShiZhiBao
//
//  Created by apple on 2017/3/29.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import "MessageHUG.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIView+Toast.h"
#import "LoginViewController.h"
#import "TabBarController.h"
#import "SDShowHUDView.h"
static MBProgressHUD *progressHUD = nil;

@interface MessageHUG()

@end

@implementation MessageHUG

+(void)showSuccessAlert:(NSString *)message{
    
    [[SDShowHUDView sharedHUDView]showImage:@"QQ_yes" withTitle:message];
    
}

+(void)showSuccessAlert:(NSString *)message animateWithDuration:(NSTimeInterval)timeInterval completion:(void (^)())completion{
    
    [[SDShowHUDView sharedHUDView]showImage:@"QQ_yes" withTitle:message];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
    });
}

+(void)showWarningAlert:(NSString *)message{
    
    [[SDShowHUDView sharedHUDView]showImage:@"QQ_warning" withTitle:message];
    
}

+(void)showWarningAlert:(NSString *)message animateWithDuration:(NSTimeInterval)timeInterval completion:(void (^)())completion{
    
    [[SDShowHUDView sharedHUDView]showImage:@"QQ_warning" withTitle:message];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
    });
}

#pragma mark - 开始菊花动画
+(void)showAlert:(NSString *)message showAddedTo:(UIView *)view
{
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    //style.messageFont = [UIFont fontWithName:@"Zapfino" size:14.0];
    style.messageFont = [UIFont systemFontOfSize:14];
    style.messageColor = [UIColor whiteColor];
    style.messageAlignment = NSTextAlignmentCenter;
    style.cornerRadius = 5;
    style.backgroundColor = [UIColor colorWithWhite:0 alpha:0.45];
    
    [view makeToast:message
           duration:4.5
           position:CSToastPositionCenter
              style:style];
}
+(void)showAlert:(NSString *)message animateWithDuration:(NSTimeInterval)timeInterval showAddedTo:(UIView *)view completion:(void (^)())completion{
    
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    //style.messageFont = [UIFont fontWithName:@"Zapfino" size:14.0];
    style.messageFont = [UIFont systemFontOfSize:14];
    style.messageColor = [UIColor whiteColor];
    style.messageAlignment = NSTextAlignmentCenter;
    style.cornerRadius = 5;
    style.backgroundColor = [UIColor colorWithWhite:0 alpha:0.45];
    
    [view makeToast:message
          duration:timeInterval
          position:CSToastPositionCenter
          style:style];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completion) {
            completion();
        }
    });
}
+(void)showSystemAlert:(NSString *)message controller:(UIViewController *)viewController completion:(void (^)())completion{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"奇趣电话" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (completion) {
            completion();
        }
    }];
    
    [alertController addAction:confirmAction];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
}
+(void)showSystemAllAlert:(NSString *)message controller:(UIViewController *)viewController completion:(void (^)())completion{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"奇趣电话" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if (completion) {
            completion();
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    [viewController presentViewController:alertController animated:YES completion:nil];
}
// 登陆后淡入淡出更换rootViewController
+(void)restoreLoginViewController
{
    USERMANAGER.isLogin = NO;
    [SAMKeychain deletePasswordForService:BundleId account:USERNAME];
    typedef void (^Animation)(void);
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    LoginViewController *rootViewController = [[LoginViewController alloc]init];
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}
+(void)restoreTabbarViewController{
    USERMANAGER.isLogin = YES;
    typedef void (^Animation)(void);
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    TabBarController *rootViewController = [[TabBarController alloc]init];
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}
#pragma mark - 开始菊花动画
+(void)showAnimation:(NSString *)message showHUDAddedTo:(UIView *)view{
    progressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    progressHUD.mode = MBProgressHUDModeIndeterminate;
    progressHUD.removeFromSuperViewOnHide = YES;
    progressHUD.label.text = message;
    progressHUD.opaque = NO;
    [progressHUD showAnimated:YES];
}
#pragma mark - 结束菊花动画
+(void)hideAnimation{
    [progressHUD hideAnimated:YES];
}

@end
