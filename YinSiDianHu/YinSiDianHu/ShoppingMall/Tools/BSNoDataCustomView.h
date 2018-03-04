//
//  BSNoDataCustomView.h
//  BensonApp
//
//  Created by 宋丹 on 16/11/15.
//  Copyright © 2016年 ruishun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSNoDataCustomView : UIView
@property(nonatomic,copy)void(^BSNoDataCustomViewBlock)();
+(instancetype)sharedInstance;
-(void)showViewAddToTargetView:(UIView *)targetView customViewFrame:(CGRect)rect promptText:(NSString *)promptText image:(BOOL)isWait;
/**
 自定义view的frame (暂无更多数据)
 */
-(void)showCustormViewToTargetView:(UIView *)targetView promptText:(NSString *)promptText customViewFrame:(CGRect)rect;

/**
 自定义view的frame (点击重新加载)
 */
-(void)showReloadViewToTargetView:(UIView *)targetView customViewFrame:(CGRect)rect;


/**
 没有数据的提示（可自定义提示文字）
 */
-(void)showCustormViewToTargetView:(UIView *)targetView promptText:(NSString *)promptText;

/**
 没有数据的提示(默认文字：暂无相关数据~)
 */
-(void)showCustormViewToTargetView:(UIView *)targetView;
/**
 自定义图片、文字、frame、view的frame (隐私电话)
 */
-(void)showCustomViewAddToTargetView:(UIView *)targetView customViewFrame:(CGRect)rect promptText:(NSString *)promptText image:(NSString *)imageName;

-(void)hiddenNoDataView;
-(void)refreshData;
@end
