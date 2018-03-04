//
//  CALayer+Layer.m
//  ShiZhiBao
//
//  Created by apple on 2017/3/31.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import "CALayer+Layer.h"

@implementation CALayer (Layer)

-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
