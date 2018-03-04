//
//  Check.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/18.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "Check.h"

@interface Check ()

/**
 当前输入项名称
 */
@property (nonatomic, copy) NSString *nameS;

/**
 当前校验的输入框
 */
@property (nonatomic, strong) UITextField *_textField;

/**
 完成校验的回调
 */
@property (nonatomic, copy) void (^completion) (CheckResult result, NSString *message, UITextField *textField);

/**
 错误码
 */
@property (nonatomic, assign) CheckResult result;

/**
 错误提示信息
 */
@property (nonatomic, copy) NSString *message;

/**
 校验失败的输入框
 */
@property (nonatomic, strong) UITextField *errorTextField;

@end

@implementation Check
#pragma mark - 正则表达式
CheckRegular const CheckRegularPhone = @"^((13[0-9])|(15[^4,\\D])|(14[579])|(17[0-9])|(18[0,0-9]))\\d{8}$";//手机号
CheckRegular const CheckRegularPassword = @"^[a-zA-Z0-9]{6,16}$";//密码 至少6位字母/数字/符号混合  ^(?![A-Z]+$)(?![a-z]+$)(?!\\d+$)(?![\\W_]+$)\\S{6,16}$
CheckRegular const CheckRegularCaptcha = @"^[a-zA-Z0-9]{4,8}";//验证码
CheckRegular const CheckRegularIdentityCardNumber = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";//身份证号码
CheckRegular const CheckRegularEmail = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";//邮箱
CheckRegular const CheckRegularLicensePlateNumber = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";//车牌号
CheckRegular const CheckRegularMoney = @"^([0-9]+|[0-9]{1,3}(,[0-9]{3})*)(.[0-9]{1,2})?$";//金额

#pragma mark - 全局配置提示信息的key
CheckMessage const CheckMessagePhone = @"CheckMessagePhone";//手机号
CheckRegular const CheckMessagePassword = @"CheckMessagePassword";//密码
CheckRegular const CheckMessageCaptcha = @"CheckMessageCaptcha";//验证码
CheckRegular const CheckMessageIdentityCardNumber = @"CheckMessageIdentityCardNumber";//身份证号码
CheckRegular const CheckMessageEmail = @"CheckMessageEmail";//邮箱
CheckRegular const CheckMessageLicensePlateNumber = @"CheckMessageLicensePlateNumber";//车牌号
CheckRegular const CheckMessageMoney = @"CheckMessageMoney";//金额

+ (Check *)check {
    static Check *check = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        check = [[Check alloc] init];
    });
    return check;
}

+ (void)checkWith:(void (^)(Check *))block completion:(void (^)(CheckResult, NSString *, UITextField *))completion {
    Check *check = [[Check alloc] init];
    check.completion = completion;
    block(check);
}

- (Check *)with {
    return self;
}

- (Check *(^)(NSString *))name {
    return ^ id (NSString *name) {
        self.nameS = name;
        return self;
    };
}

- (Check *(^)(UITextField *))textField {
    return ^ id (UITextField *textField) {
        self._textField = textField;
        self.message = nil;
        self.nameS = nil;
        self.errorTextField = nil;
        return self;
    };
}

/**
 判空
 */
- (Check *(^)())null {
    return ^ id () {
        if (self.result == CheckResultValidated) {
            NSString *text = self._textField.text;
            text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
            if ([text isEqualToString:@""] || text == nil) {
                self.result = CheckResultNull;
                self.message = [self.nameS stringByAppendingString:@"不能为空"];
                self.errorTextField = self._textField;
                self.completion(self.result, self.message, self.errorTextField);
            }
        }
        return self;
    };
}

/**
 校验
 */
- (Check *(^)(CheckRegular, NSString *))validate {
    return ^ id (CheckRegular regular, NSString *message) {
        if (self.result == CheckResultValidated) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
            if ([predicate evaluateWithObject:self._textField.text] == NO) {
                self.result = CheckResultUnValidated;
                
                NSString *configureMessage = [[Check check].messageConfigure valueForKey:[self configureMessage:regular]];
                self.message = message ? message : (configureMessage ? configureMessage : [self.nameS stringByAppendingString:@"格式错误"]);
                self.errorTextField = self._textField;
                self.completion(self.result, self.message, self.errorTextField);
            }
        }
        return self;
    };
}

- (Check *(^)(NSString *, NSString *))equal {
    return ^ id (NSString *text, NSString *message) {
        if (self.result == CheckResultValidated) {
            if ([self._textField.text isEqualToString:text] == NO) {
                self.result = CheckResultUnValidated;
                self.errorTextField = self._textField;
                self.message = message ? message : @"前后不一致";
                self.completion(self.result, self.message, self.errorTextField);
            }
        }
        return self;
    };
}

- (Check *(^)())end {
    return ^ id () {
        if (self.result == CheckResultValidated) {
            self.completion(CheckResultSuccess, nil, nil);
        }
        return self;
    };
}

/**
 根据正则表达式获取全局配置提示信息的key
 
 @param regular 正则表达式
 @return 全局配置提示信息的key
 */
- (CheckMessage)configureMessage:(CheckRegular)regular {
    if ([regular isEqualToString:CheckRegularPhone]) {
        return CheckMessagePhone;
    } else if ([regular isEqualToString:CheckRegularPassword]) {
        return CheckMessagePassword;
    } else if ([regular isEqualToString:CheckRegularCaptcha]) {
        return CheckMessageCaptcha;
    } else if ([regular isEqualToString:CheckRegularIdentityCardNumber]) {
        return CheckMessageIdentityCardNumber;
    } else if ([regular isEqualToString:CheckRegularEmail]) {
        return CheckMessageEmail;
    } else if ([regular isEqualToString:CheckRegularLicensePlateNumber]) {
        return CheckMessageLicensePlateNumber;
    } else if ([regular isEqualToString:CheckRegularMoney]) {
        return CheckMessageMoney;
    }
    return regular;
}

- (NSMutableDictionary<CheckMessage,NSString *> *)messageConfigure {
    if (_messageConfigure == nil) {
        _messageConfigure = [NSMutableDictionary dictionary];
    }
    return _messageConfigure;
}

@end
