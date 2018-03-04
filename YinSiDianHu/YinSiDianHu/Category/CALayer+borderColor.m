//
//  CALayer+borderColor.m
//  BensonApp
//
//  Created by 宋丹 on 16/11/5.
//  Copyright © 2016年 ruishun. All rights reserved.
//

#import "CALayer+borderColor.h"

@implementation CALayer (borderColor)
- (void)setBorderUIColor:(UIColor *)borderUIColor {
    self.borderColor =borderUIColor.CGColor ;
}

- (UIColor *)borderUIColor {
    return self.borderUIColor;
}
@end
