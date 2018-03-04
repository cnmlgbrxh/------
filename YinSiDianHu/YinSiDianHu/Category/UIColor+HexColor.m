//
//  UIColor+HexColor.m
//  YBRedPacket
//
//  Created by songdan on 2017/7/28.
//  Copyright © 2017年 yingBinIntelligent. All rights reserved.
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)
+ ( UIColor *)colorWithHexString:(NSString *)s {
    if (!s || [s isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[s substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[s substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[s substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}

@end
