//
//  UITextView+AdjustFont.m
//  dinergate
//
//  Created by 伯明利 on 2017/8/23.
//  Copyright © 2017年 伯明利. All rights reserved.
//

#import "UITextView+AdjustFont.h"
#import "LCAdjustFont.h"

@implementation UITextView (AdjustFont)

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    CGFloat width = LCAdjustFontWithScreentWidth;
    if (width == 0) {
        return ;
    } else if (width < 320) {
        width = 320.f;
    } else if (width > 414) {
        width = 414.f;
    }
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat number = width / (self.font.pointSize + 0.3);
    CGFloat size = floorf(screenWidth / number - 0.3);
    self.font = [UIFont systemFontOfSize:size];
}

@end
