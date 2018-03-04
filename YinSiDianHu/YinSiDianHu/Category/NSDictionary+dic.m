//
//  NSDictionary+dic.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/8/1.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "NSDictionary+dic.h"

@implementation NSDictionary (dic)

-(id)objForKey:(NSString *)key{
    if (IsNilString([self objectForKey:key])) {
        return @"";
    }else{
        return [self objectForKey:key];
    }
}
@end
