//
//  RSMBProgressHUDTool.h
//  park
//
//  Created by songdan on 16/9/20.
//  Copyright © 2016年 ruishun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSMBProgressHUDTool : NSObject
+ (instancetype)shareProgressHUDManager;

/**
 *  显示加载中
 *
 *  @param view window 当前父视图是View还是window
 *  @param text 要显示的文字
 */
- (void)showViewLoadingHUD:(UIView *)view showText:(NSString *)text;
- (void)showWindowLoadinHUD:(UIWindow *)window showText:(NSString *)text;
/**
 *  相关提示，window 宋丹
 *
 */
- (void)showWindowExplainHUD:(UIWindow *)window showText:(NSString *)text;//宋丹

- (void)showLoadingProgressHUD:(UIView *)view showText:(NSString *)text;
//- (void)showWindowLoadingProgressHUD:(UIWindow *)window showText:(NSString *)text;


/**
 *  成功或者失败提示
 *
 *  @param view <#view description#>
 *  @param text <#text description#>
 */
- (void)showLoadSuccessOrFailureHUD:(UIView *)view showText:(NSString *)text;
- (void)showLoadSuccessOrFailureHUDonWindowes:(UIWindow *)windowes showText:(NSString *)text;

/**
 *  隐藏提示
 */
- (void)hiddenHUD;


/**
 *  带图片的提示  可自动消失 （宋丹
 *
 *  @param view
 *  @param text 
 */
//- (void)showTextOnlyHUD:(UIView *)view showText:(NSString *)text;

- (void)showSuccessHUD:(UIView *)view  ImageName:(NSString *)imgName andText:(NSString *)text;
/**
 *  带图片的提示  可自动消失(windows上) （宋丹
 *
 *  @param view
 *  @param text
 */
//- (void)showTextOnlyHUD:(UIView *)view showText:(NSString *)text;
- (void)showSuccessHUDWindowsWithImageName:(NSString *)imgName andText:(NSString *)text;

/**
 *  带title的提示  可自动消失 （宋丹
 *
 *  @param view
 *  @param text
 */
//- (void)showTextOnlyHUD:(UIView *)view showText:(NSString *)text;

- (void)showSuccessHUDTitle:(NSString *)title andText:(NSString *)text;
@end
