//
//  UserManager.h
//  ShiZhiBao
//
//  Created by apple on 2017/5/15.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject

@property (copy, nonatomic,readonly) NSString *userName;

/**
 记录自动登录状态
 */
@property (assign, nonatomic) BOOL isLogin;

/**
 目前分为 super 和 normal
 */
@property (copy, nonatomic,readonly) NSString *level;

/**
 是否开启增强呼叫
 */
@property (assign, nonatomic) BOOL isEnhancedCall;

/**
 回拨Id
 */
@property (copy, nonatomic,readonly) NSString *callerid;

/**
 绑定号码
 */
@property (copy,nonatomic,readonly) NSString *bindphone;

/**
 余额
 */
@property (copy,nonatomic,readonly) NSString *usermoney;

+ (instancetype)shareManager;

+(void)userInfoManager:(id)responseObject;

@end
