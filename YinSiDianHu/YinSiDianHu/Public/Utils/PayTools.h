//
//  PayTools.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/27.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 支付方式枚举
typedef NS_ENUM(NSInteger, PaymentMethod) {
    WeiXinMethod = 0,//微信
    ZhiFuBaoMethod,//支付宝
    BalanceMethod,//余额
    UnionPayMethod,//银联
};
@interface PayTools : NSObject

+(instancetype _Nullable )sharedInstance;
/**
 支付统一处理

 @param paymentMethod 类型
 @param parameters 参数
 @param controller 控制器
 @param anObject 附带参数(@{@"action":@"",@"price":@""})
 */
-(void)paymentMethod:(PaymentMethod )paymentMethod parameters:(id _Nullable )parameters currentController:(UIViewController *_Nullable)controller object:(nullable id)anObject;


@end
