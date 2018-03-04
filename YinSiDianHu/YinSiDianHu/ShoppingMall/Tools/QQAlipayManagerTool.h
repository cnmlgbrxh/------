//
//  QQAlipayManagerTool.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/26.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QQAlipayManagerTool : NSObject
@property(nonatomic,copy)void(^shopping_alipayBlock)();
+(instancetype)sharedInstance;
- (void)shoppingAlipayWithURLStr:(NSString *)urlStr productName:(NSString *)productName Price:(NSString *)price;

- (void)wechatPay:(NSString *)url;

@end
