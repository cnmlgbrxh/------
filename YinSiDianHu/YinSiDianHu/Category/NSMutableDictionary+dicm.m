//
//  NSMutableDictionary+dicm.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/8/1.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "NSMutableDictionary+dicm.h"

@implementation NSMutableDictionary (dicm)

-(void)setObj:(id)obj ForKey:(NSString *)key{
    if (!key) return;
    if (IsNilString(obj))
    {
        [self setObject:@"" forKey:key];
    }else
    {
        [self setValue:obj forKey:key];
    }
}

@end
