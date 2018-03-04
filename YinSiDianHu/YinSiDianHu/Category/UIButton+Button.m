//
//  UIButton+Button.m
//  ShiZhiBao
//
//  Created by apple on 2017/4/27.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import "UIButton+Button.h"
@implementation UIButton (Button)
@dynamic space;
-(void)setSpace:(float)space{
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height + space);
    
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (totalHeight - titleSize.height),0.0);
}
- (void)centerImageAndTitle:(float)spacing
{
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    // get the height they will take up as a unit
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    
    // raise the image and push it right to center it
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    
    // lower the text and push it left to center it
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width, - (totalHeight - titleSize.height),0.0);
}

- (void)rightImageLeftTitle:(float)spacing
{
    // get the size of the elements here for readability
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    //    CGFloat totalWidth = (imageSize.width + titleSize.width + spacing);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0.0, titleSize.width+spacing, 0.0, 0.0);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width-spacing, 0.0 ,0.0);
}

- (void)centerImageAndTitle
{
    const int DEFAULT_SPACING = 6.0f;
    [self centerImageAndTitle:DEFAULT_SPACING];
}
//+(void)load {
//    //只执行一次这个方法
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = [self class];
//        // When swizzling a class method, use the following:
//        // Class class = object_getClass((id)self);
//        //替换三个方法
//        SEL originalSelector = @selector(init);
//        SEL originalSelector2 = @selector(initWithFrame:);
//        SEL originalSelector3 = @selector(awakeFromNib);
//        SEL swizzledSelector = @selector(YHBaseInit);
//        SEL swizzledSelector2 = @selector(YHBaseInitWithFrame:);
//        SEL swizzledSelector3 = @selector(YHBaseAwakeFromNib);
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method originalMethod2 = class_getInstanceMethod(class, originalSelector2);
//        Method originalMethod3 = class_getInstanceMethod(class, originalSelector3);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//        Method swizzledMethod2 = class_getInstanceMethod(class, swizzledSelector2);
//        Method swizzledMethod3 = class_getInstanceMethod(class, swizzledSelector3);
//        BOOL didAddMethod =
//        class_addMethod(class,
//                        originalSelector,
//                        method_getImplementation(swizzledMethod),
//                        method_getTypeEncoding(swizzledMethod));
//        BOOL didAddMethod2 =
//        class_addMethod(class,
//                        originalSelector2,
//                        method_getImplementation(swizzledMethod2),
//                        method_getTypeEncoding(swizzledMethod2));
//        BOOL didAddMethod3 =
//        class_addMethod(class,
//                        originalSelector3,
//                        method_getImplementation(swizzledMethod3),
//                        method_getTypeEncoding(swizzledMethod3));
//        if (didAddMethod) {
//            class_replaceMethod(class,
//                                swizzledSelector,
//                                method_getImplementation(originalMethod),
//                                method_getTypeEncoding(originalMethod));
//            
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//        if (didAddMethod2) {
//            class_replaceMethod(class,
//                                swizzledSelector2,
//                                method_getImplementation(originalMethod2),
//                                method_getTypeEncoding(originalMethod2));
//        }else {
//            method_exchangeImplementations(originalMethod2, swizzledMethod2);
//        }
//        if (didAddMethod3) {
//            class_replaceMethod(class,
//                                swizzledSelector3,
//                                method_getImplementation(originalMethod3),
//                                method_getTypeEncoding(originalMethod3));
//        }else {
//            method_exchangeImplementations(originalMethod3, swizzledMethod3);
//        }
//    });
//}
///**
// *在这些方法中将你的字体名字换进去
// */
//- (instancetype)YHBaseInit {
//    id __self = [self YHBaseInit];
//    UIFont * font = [UIFont systemFontOfSize:self.titleLabel.font.pointSize+2];;
//    if (font) {
//        self.titleLabel.font= [font fontWithSize:Scale(self.titleLabel.font.pointSize)];
//    }
//    return __self;
//}
//
//-(instancetype)YHBaseInitWithFrame:(CGRect)rect{
//    id __self = [self YHBaseInitWithFrame:rect];
//    UIFont * font = [UIFont systemFontOfSize:Scale(self.titleLabel.font.pointSize)];;
//    if (font) {
//        self.titleLabel.font=font;
//        self.titleLabel.font= [font fontWithSize:Scale(self.titleLabel.font.pointSize)];
//    }
//    return __self;
//}
//
//-(void)YHBaseAwakeFromNib{
//    [self YHBaseAwakeFromNib];
//    UIFont * font = [UIFont systemFontOfSize:Scale(self.titleLabel.font.pointSize)];
//    if (font) {
//        self.titleLabel.font=font;
//        self.titleLabel.font= [font fontWithSize:Scale(self.titleLabel.font.pointSize)];
//    }
//    
//}
@end
