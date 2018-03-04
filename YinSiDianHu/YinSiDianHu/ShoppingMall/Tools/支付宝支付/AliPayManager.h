//
//  AliPayManager.h
//  LittleDoctor
//
//  Created by jianglei on 15/9/2.
//  Copyright (c) 2015年 XiaoShenYi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>
#import "AliPayOrder.h"
#import "PartnerConfig.h"

#import "DataSigner.h"
#import "DataVerifier.h"

/*
 支付宝支付管理单例类
 */

@interface AliPayManager : NSObject
/**
 *  订单ID（由商家自行制定）
 */

@property (nonatomic, strong) NSString *tradeNO;

/**
 *  商品标题
 */

@property (nonatomic, strong) NSString *productName;

/**
 *  商品描述
 */

@property (nonatomic, strong) NSString *productDescription;

/**
 *  商品价格(必须小数点后2位)
 */
@property (nonatomic, strong) NSString *amount;

/*
 支付结果回调
 */

@property (nonatomic,copy)void(^paySuccess)(BOOL success);

/**
 *  单例对象
 *
 *  @return 返回manager单例
 */
+ (instancetype)sharedInstance;

/**
 *  初始化数据
 *
 *  @param tradeNO            订单ID（由商家自行制定）
 *  @param productName        商品标题
 *  @param productDescription 商品描述
 *  @param amount             商品价格(必须小数点后2位)
 */

- (void)initWithTradeNO:(NSString *)tradeNO productName:(NSString *)productName productDescription:(NSString *)productDescription amount:(NSString *)amount;

/**
 *  实施支付操作，执行此方法之前，必须先初始化tradeNO，productName，productDescription，amount
 */

- (void)alipayRequest;

/**
 *  清空单例中的缓存数据，包括tradeNO，productName，productDescription，amount
 */

- (void)clean;
/**
 *  独立客户端回调函数（如果采用了跳转支付）
 *
 *  @param url         scheme url，从UIApplicationDelegate方法中获得
 *  @param application 从AppDelegate中传入
 */

- (void)parse:(NSURL *)url application:(UIApplication *)application;

@end
