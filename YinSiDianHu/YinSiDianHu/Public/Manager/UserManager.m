//
//  UserManager.m
//  ShiZhiBao
//
//  Created by apple on 2017/5/15.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import "UserManager.h"

#define user_name @"username"
#define is_login @"isLogin"
#define _level @"level"
#define _balance @"balance"
#define is_EnhancedCall @"isEnhancedCall"
#define caller_id @"callerid"
#define bind_phone @"bindphone"
#define user_money @"usermoney"
@implementation UserManager

static UserManager *_manager = nil;
+ (instancetype)shareManager {
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}
+(void)userInfoManager:(id)responseObject{
    //存储userName
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:[responseObject objectForKey:@"username"] forKey:user_name];
    
    [userDefaults setObject:[responseObject objectForKey:@"model"] forKey:_level];
    
    [userDefaults setObject:[responseObject objectForKey:@"callerid"] forKey:caller_id];
    
    [userDefaults setObject:[responseObject objectForKey:@"bindphone"] forKey:bind_phone];
    
    [userDefaults setObject:[responseObject objectForKey:@"usermoney"] forKey:user_money];
    
    [userDefaults synchronize];
}
-(NSString *)userName{
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:user_name];
    return userName;
}
-(void)setIsLogin:(BOOL)isLogin{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isLogin forKey:is_login];
    [userDefaults synchronize];
}
-(BOOL)isLogin{
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:is_login];
    return isLogin;
}
-(NSString *)level{
    NSString *level = [[NSUserDefaults standardUserDefaults] objectForKey:_level];
    return level;
}
-(void)setIsEnhancedCall:(BOOL)isEnhancedCall{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:isEnhancedCall forKey:is_EnhancedCall];
    [userDefaults synchronize];
}
-(BOOL)isEnhancedCall{
    BOOL is = [[NSUserDefaults standardUserDefaults] boolForKey:is_EnhancedCall];
    return is;
}
-(NSString *)callerid{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:caller_id];
    return str;
}
-(NSString *)bindphone{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:bind_phone];
    return str;
}
-(NSString *)usermoney{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:user_money];
    return str;
}
@end
