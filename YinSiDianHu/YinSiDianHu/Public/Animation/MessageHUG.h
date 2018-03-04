//
//  MessageHUG.h
//  ShiZhiBao
//
//  Created by apple on 2017/3/29.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageHUG : NSObject

+(void)showSuccessAlert:(NSString *)message;

+(void)showSuccessAlert:(NSString *)message animateWithDuration:(NSTimeInterval)timeInterval completion:(void (^)())completion;

+(void)showWarningAlert:(NSString *)message;

+(void)showWarningAlert:(NSString *)message animateWithDuration:(NSTimeInterval)timeInterval completion:(void (^)())completion;

/**
 消息提示

 @param message 信息
 @param view 当前View
 */
//+(void)showAlert:(NSString *)message showAddedTo:(UIView *)view;


/**
 消息提示完成之后Block

 @param message 提示信息
 @param timeInterval 时间
 @param view 当前View
 @param completion 完成之后的Block
 */
//+(void)showAlert:(NSString *)message animateWithDuration:(NSTimeInterval)timeInterval showAddedTo:(UIView *)view completion:(void (^)())completion;

+(void)showSystemAlert:(NSString *)message controller:(UIViewController *)viewController completion:(void (^)())completion;
+(void)showSystemAllAlert:(NSString *)message controller:(UIViewController *)viewController completion:(void (^)())completion;

/**
 到登录界面
 */
+(void)restoreLoginViewController;
/**
 到主界面
 */
+(void)restoreTabbarViewController;
//显示菊花等待动画
+(void)showAnimation:(NSString *)message showHUDAddedTo:(UIView *)view;
//隐藏菊花动画
+(void)hideAnimation;


@end
