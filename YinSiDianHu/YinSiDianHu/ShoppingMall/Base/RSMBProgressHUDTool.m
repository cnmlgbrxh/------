//
//  RSMBProgressHUDTool.m
//  park
//
//  Created by songdan on 16/9/20.
//  Copyright © 2016年 ruishun. All rights reserved.
//

#import "RSMBProgressHUDTool.h"
#import "MBProgressHUD.h"
#import "SDShowHUDView.h"

@interface RSMBProgressHUDTool ()<MBProgressHUDDelegate>{
    MBProgressHUD *HUD;
}

@end

@implementation RSMBProgressHUDTool

+ (instancetype)shareProgressHUDManager {
    static id _progressHUD = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _progressHUD = [[self alloc] init];
    });
    
    return _progressHUD;
}

/**
 *  加载在当前view上
 */
- (void)showViewLoadingHUD:(UIView *)view showText:(NSString *)text
{
//    if (!view) {
//        return;
//    }
//    HUD = [[MBProgressHUD alloc] initWithView:view];
//    [view addSubview:HUD];
//    HUD.delegate = self;
//    HUD.label.text = text;
//    HUD.userInteractionEnabled = NO;
//    [HUD showAnimated:YES];
    [[SDShowHUDView sharedHUDView]showLoading];
}
/**
 *  加载在windowes 需要self.navationcontroller.view.windowes
 */
- (void)showWindowLoadinHUD:(UIWindow *)window showText:(NSString *)text
{

    HUD = [[MBProgressHUD alloc] initWithView:window];
    [window addSubview:HUD];
    HUD.delegate = self;
    HUD.label.text = text;
    [HUD showAnimated:YES];
}

- (void)showWindowExplainHUD:(UIWindow *)window showText:(NSString *)text {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    [window addSubview:HUD];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.5];
}
/**
 *  隐藏
 */

- (void)hiddenHUD
{
    if (HUD) {
        [HUD hideAnimated:YES];
    }
    [[SDShowHUDView sharedHUDView]hidden];
}
/**
 *  代理移除HUD
 *
 *  @param hud <#hud description#>
 */
- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    HUD = nil;
}


/**
 *  加载成功或者网路连接失败 可以自定义图片
 */
- (void)showLoadSuccessOrFailureHUD:(UIView *)view showText:(NSString *)text
{
    //    HUD = [[MBProgressHUD alloc] initWithView:view];
    //    [view addSubview:HUD];
    //    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    //
    //    // Set custom view mode
    //    HUD.mode = MBProgressHUDModeCustomView;
    //
    //    HUD.delegate = self;
    //    HUD.labelText = text;
    //
    //    [HUD show:YES];
    //    [HUD hide:YES afterDelay:5];
    if (HUD) {
        [self hiddenHUD];
    }
    if (!text || text.length == 0) {
        return;
    }
    if (!view) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hideAnimated:YES afterDelay:2];
}


- (void)showSuccessHUD:(UIView *)view  ImageName:(NSString *)imgName andText:(NSString *)text {
    if (HUD) {
        [self hiddenHUD];
    }
    if (!view) {
        return;
    }
    HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
    
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.label.text = text;
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:1.5];

}

- (void)showSuccessHUDWindowsWithImageName:(NSString *)imgName andText:(NSString *)text {
//    if (HUD) {
//        [self hiddenHUD];
//    }
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
//    hud.mode = MBProgressHUDModeCustomView;
//    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
//    hud.delegate = self;
//    hud.label.text = text;
//    [hud showAnimated:YES];
//    hud.userInteractionEnabled= NO;
//    hud.removeFromSuperViewOnHide = YES;
//    [hud hideAnimated:YES afterDelay:3];
    [[SDShowHUDView sharedHUDView]showImage:imgName withTitle:text];
}

- (void)showSuccessHUDTitle:(NSString *)title andText:(NSString *)text {
    if (HUD) {
        [self hiddenHUD];
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 100)];
    label.text = @"提示";
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textColor = [Tools getUIColorFromString:@"e7a007"];
    label.textAlignment = NSTextAlignmentCenter;
    hud.customView = label;
    hud.customView.frame = CGRectMake(0, 0, 50, 50);
    hud.delegate = self;
    hud.label.text = text;
    [hud showAnimated:YES];
    [hud hideAnimated:YES afterDelay:2.5];
}

- (void)showLoadSuccessOrFailureHUDonWindowes:(UIWindow *)windowes showText:(NSString *)text{
    
    if (HUD) {
        [self hiddenHUD];
    }
    if (!text || text.length == 0) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:windowes animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.5];
}



- (void)showLoadingProgressHUD:(UIView *)view showText:(NSString *)text{
    HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeDeterminate;
}
- (void)showProgressWithProgress:(CGFloat)progress{
    HUD.progress = progress;
    if (progress == 1) {
        [self hudWasHidden:HUD];
    }
}
- (void)showWindowLoadingProgressHUD:(UIWindow *)window showText:(NSString *)text{
    
}

- (void)showTextOnlyHUD:(UIView *)view showText:(NSString *)text{
    
}

@end
