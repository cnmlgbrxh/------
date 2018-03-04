//
//  UIImage+image.h
//  ShiZhiBao
//
//  Created by apple on 2017/5/11.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (image)
/**
 *  根据图片名参数创建一个UIImage对象，并返回不渲染的原图
 *
 *  @param imageName 图片路径名
 *
 *  @return 没有经过渲染的原图
 */
+ (instancetype)originalImageNamed:(NSString *)imageName;


+(UIImage*) createImageWithColor:(UIColor*) color;

@end
