//
//  QQShoppingBannerModel.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/27.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//  商城首页banner

#import "QQShoppingBannerModel.h"

@implementation QQShoppingBannerModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"productID" : @"id",
             };
}
@end
