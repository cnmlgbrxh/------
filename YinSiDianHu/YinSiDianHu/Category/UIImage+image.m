//
//  UIImage+image.m
//  ShiZhiBao
//
//  Created by apple on 2017/5/11.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import "UIImage+image.h"

@implementation UIImage (image)

+ (instancetype)originalImageNamed:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+(UIImage*) createImageWithColor:(UIColor*) color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
//    CGMutablePathRef patch = CGPathCreateMutable();
//    CGPathAddArc(patch, &CGAffineTransformIdentity, 0.5, 0.5, 0.5, 0, M_PI * 2, NO);
//    CGContextClip(context);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

@end
