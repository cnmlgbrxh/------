//
//  IAPManager.h
//  YinSiDianHu
//
//  Created by songdan on 2017/8/16.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum { kIAPPurchSuccess = 0,
    // 购买成功
    kIAPPurchFailed = 1,
    // 购买失败
    kIAPPurchCancle = 2,
    // 取消购买
    KIAPPurchVerFailed = 3,
    // 订单校验失败
    KIAPPurchVerSuccess = 4,
    // 订单校验成功
    kIAPPurchNotArrow = 5,
    // 不允许内购
}IAPPurchType;
typedef void (^IAPCompletionHandle)(IAPPurchType type,NSData *data);

@interface IAPManager : NSObject
- (void)startPurchWithID:(NSString *)purchID completeHandle:(IAPCompletionHandle)handle;
@end







