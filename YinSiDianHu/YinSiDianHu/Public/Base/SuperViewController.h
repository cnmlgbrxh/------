//
//  SuperViewController.h
//  ShiZhiBao
//
//  Created by apple on 2017/3/28.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSNoDataCustomView.h"

@interface SuperViewController : UIViewController

@property (copy,nonatomic) NSString *navTitle;

/**
 创建导航栏右边按钮

 @param title 标题
 */
-(void)creatRightBarBtnTitle:(NSString *)title;
/**
 导航栏左边按钮事件
 */
-(void)backClick;

/**
 导航栏右边按钮事件
 */
-(void)RightBarBtnClick;

@end
