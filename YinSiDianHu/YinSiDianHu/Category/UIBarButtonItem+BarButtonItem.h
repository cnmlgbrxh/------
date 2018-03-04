//
//  UIBarButtonItem+BarButtonItem.h
//  YinSiDianHu
//
//  Created by Apple on 2017/6/24.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LeftRightBarButton){
    RightBarButton = 0,
    LeftBarButton
};
@interface UIBarButtonItem (BarButtonItem)
/**
 *  图
 */
+ (UIBarButtonItem *)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

/**
 *  文字
 */
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title location:(LeftRightBarButton)location titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title location:(LeftRightBarButton)location target:(id)target action:(SEL)action;

@end
