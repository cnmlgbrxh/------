//
//  QQMoneyListModel.m
//  YinSiDianHu
//
//  Created by songdan on 2017/8/18.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQMoneyListModel.h"


@implementation QQMoneyListProductDetailModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"pid" : @"id"};
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"%@",value);
}

@end

@implementation QQMoneyListModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"%@",value);
}
@end
