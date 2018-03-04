//
//  UITextField+TextField.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/8/9.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "UITextField+TextField.h"

@implementation UITextField (TextField)
@dynamic placeHolderColor;
-(void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    
    //[self setValue:placeHolderColor forKey:@"placeholderLabel.textColor"];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = placeHolderColor;
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict];
    [self setAttributedPlaceholder:attribute];
}

@end
