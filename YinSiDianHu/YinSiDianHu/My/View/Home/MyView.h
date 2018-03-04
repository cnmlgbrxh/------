//
//  MyView.h
//  YinSiDianHu
//
//  Created by 海鸥 on 17/7/3.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyView : UIView

@property (weak,nonatomic) UIViewController *viewController;

@property (copy,nonatomic) NSDictionary *dicDetail;


/**
 设置号码

 @param viewController 当前控制器
 @param view 提示作用于的视图
 */
-(void)setUpShowNumber:(UIViewController *)viewController alertAddedTo:(UIView *)view;

/**
 设置通话变音

 @param viewController 当前控制器
 @param view 提示作用于的视图
 */
-(void)setUpCallTone:(UIViewController *)viewController alertAddedTo:(UIView *)view;

@end
