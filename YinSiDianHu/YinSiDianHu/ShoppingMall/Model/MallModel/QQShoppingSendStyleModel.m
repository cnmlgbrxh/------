//
//  QQShoppingSendStyleModel.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/19.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingSendStyleModel.h"

@implementation QQShoppingSendStyleModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"sendDescription" : @"description",
             @"sendID" : @"id",
             };
}
@end
