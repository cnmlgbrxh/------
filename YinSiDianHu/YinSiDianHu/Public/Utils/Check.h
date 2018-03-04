//
//  Check.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/18.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - 校验结果枚举
typedef NS_ENUM(NSInteger, CheckResult) {
    CheckResultValidated = 0,//校验通过
    CheckResultNull = 1,//输入为空
    CheckResultUnValidated = 2,//格式非法
    CheckResultSuccess = 3,//全部校验通过
};

//校验结束时调用
#define END end()

#pragma mark - 正则表达式
typedef NSString *CheckRegular NS_EXTENSIBLE_STRING_ENUM;
UIKIT_EXTERN CheckRegular const CheckRegularPhone;//手机号
UIKIT_EXTERN CheckRegular const CheckRegularPassword;//密码 至少6位字母/数字/符号混合
UIKIT_EXTERN CheckRegular const CheckRegularCaptcha;//验证码
UIKIT_EXTERN CheckRegular const CheckRegularIdentityCardNumber;//身份证号码
UIKIT_EXTERN CheckRegular const CheckRegularEmail;//邮箱
UIKIT_EXTERN CheckRegular const CheckRegularLicensePlateNumber;//车牌号
UIKIT_EXTERN CheckRegular const CheckRegularMoney;//金额

#pragma mark - 全局配置提示信息的key
typedef NSString *CheckMessage NS_EXTENSIBLE_STRING_ENUM;
UIKIT_EXTERN CheckMessage const CheckMessagePhone;//手机号
UIKIT_EXTERN CheckRegular const CheckMessagePassword;//密码
UIKIT_EXTERN CheckRegular const CheckMessageCaptcha;//验证码
UIKIT_EXTERN CheckRegular const CheckMessageIdentityCardNumber;//身份证号码
UIKIT_EXTERN CheckRegular const CheckMessageEmail;//邮箱
UIKIT_EXTERN CheckRegular const CheckMessageLicensePlateNumber;//车牌号
UIKIT_EXTERN CheckRegular const CheckMessageMoney;//金额

@interface Check : NSObject

/********************************** 全局配置 **********************************/

+ (Check *)check;

/**
 配置提示信息
 */
@property (nonatomic, strong) NSMutableDictionary <CheckMessage, NSString *>*messageConfigure;

/********************************** 校验 **********************************/

/**
 校验输入框输入是否合法
 
 @param block 回调函数，链式语法
 @param completion 回调函数，根据result和textField可以获取每一次校验的结果。当某一步校验失败后不会继续往下校验。result == CheckResultValidated 或 result == CheckResultNonnull 时，message为nil
 */
+ (void)checkWith:(void(^)(Check *check))block completion:(void(^)(CheckResult result, NSString *message, UITextField *textField))completion;

/**
 连接符
 */
- (Check *)with;

/**
 输入框
 */
- (Check *(^)(UITextField *))textField;

/**
 输入项名称
 */
- (Check *(^)(NSString *name))name;

/**
 判空：(空)
 */
- (Check *(^)())null;

/**
 校验：(正则表达式, 错误信息)
 */
- (Check *(^)(CheckRegular regular, NSString *message))validate;

/**
 比较：(比较对象, 错误信息)
 */
- (Check *(^)(NSString *text, NSString *message))equal;

/**
 校验结束时调用，使用宏定义END
 */
- (Check *(^)())end;
@end

/*
 使用示例
 
 //全局配置提示信息
 [[Check check].messageConfigure setValue:@"密码为6-16位数字、字母、符号组成" forKey:CheckMessagePassword];
 
 //依次校验手机号、密码
 [Check _checkWith:^(Check *check) {
 check.textField(self.phoneTextField).name(@"手机号").null().validate(CheckRegularPhone, nil);
 check.textField(self.passwordTextField).name(@"密码").null().validate(CheckRegularPassword, nil).END;
 //也可以按如下方式写
 //check.textField(self.phoneTextField).name(@"手机号").null().validate(CheckRegularPhone, nil).with.textField(self.passwordTextField).name(@"密码").null().validate(CheckRegularPassword, nil).END;
 
 } completion:^(CheckResult result, NSString *message, UITextField *textField) {
 if (result == CheckResultUnValidated || result == CheckResultNull) {
 [self toastWith:message];
 } else if (result == CheckResultSuccess) {
 NSLog(@"校验成功");
 }
 }];
 */
