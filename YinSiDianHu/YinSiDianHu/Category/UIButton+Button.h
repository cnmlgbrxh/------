//
//  UIButton+Button.h
//  ShiZhiBao
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Button)

@property (nonatomic) IBInspectable float space;

/**
 *  设置上图下文字,指定间距
 *
 *  @param space 行间距
 */
- (void)centerImageAndTitle:(float)space;

/**
 *  设置上图下文,默认间距
 */
- (void)centerImageAndTitle;

- (void)rightImageLeftTitle:(float)spacing;

@end
