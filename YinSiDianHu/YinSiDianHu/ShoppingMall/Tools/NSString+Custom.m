//
//  NSString+Custom.m
//  YinSiDianHu
//
//  Created by songdan on 2017/8/3.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "NSString+Custom.h"

@implementation NSString (Custom)
- (BOOL)judgeStringLength {
    if ([self isMemberOfClass:[NSNull class]] || self.length == 0 || self==nil) {
        return YES;
    }
    return NO;
}
@end
