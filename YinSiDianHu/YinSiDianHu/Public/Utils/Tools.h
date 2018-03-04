//
//  Tools.h
//  ShiZhiBao
//
//  Created by apple on 2017/3/28.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

/// 验证手机格式是否正确
+ (BOOL)isValidateMobile:(NSString *)mobileNum;
/// 验证密码格式是否正确
+ (BOOL)isValidatePassword:(NSString *)password;
///验证身份证格式是否正确
+ (BOOL)isValidateId:(NSString *)Id;
///验证包含特殊字符
+ (BOOL)isValidateSpecialChar:(NSString *)strChar;
//是否全是空格
+(BOOL)isEmpty:(NSString *)str;
//判断纯数字
+(BOOL)isValidateNumber:(NSString *)number;
//提示信息图文处理
+(NSMutableAttributedString *)setUpAlertMessage:(NSString *)message;

/**
 *  将NSDate转换为标准的yyyy-MM-dd格式
 *
 *  @param date 要转换的时间
 *
 *  @return 返回字符串类型的标准格式时间
 */
+ (NSString *)dateStringWithDate:(NSDate *)date;
/**
 *  将NSDate转为yyyy年MM月dd日 HH时mm分 格式字符串
 *
 *  @param date 要转换的时间NSDate
 *
 *  @return 返回字符串类型
 */
+(NSString *)strTimeWithDate:(NSDate *)date;
/**
 获取字符串中的数字
 
 @param string 包含文字数字的字符串
 
 @return 纯数字的字符串
 */
+(NSString *)getNumberFromString:(NSString *)string;
/**
 获取两个时间戳之间是几天
 
 @param atTime 开始时间
 @param enTime 结束时间
 
 @return 2天
 */
+ (NSString *)dayNumberWithAtTimeStr:(NSString *)atTime withEnTimeStr:(NSString *)enTime;

/**
 获取时间间隔（精确到秒）

 @param beforeDate 之前的时间
 @return 时间间隔
 */
+ (NSInteger)getTimeIntervalWithBeforeDate:(NSDate *)beforeDate;
/**
 根据时间戳获取星期几
 
 @param dateString 时间戳
 @return 星期几
 */
+ (NSString *)dateWeekWithDateString:(NSString *)dateString;

/**
 * 得到RGB颜色: UIColor
 */
+ (UIColor*)getUIColorFromString:(NSString *)s;
/**
 *  得到一个可变颜色，文字大小不同的字符串
 */
+ (NSMutableAttributedString *)LabelStr:(NSString *)allStr
                              changeStr:(NSString *)changeStr
                                  color:(UIColor *)color
                                   font:(UIFont * )font;

/**
 MD5加密

 @param str 加密前
 @return 加密后的字符串
 */
+ (NSString *)md5:(NSString *)str;

/**
 图片Base64加密

 @param image 图片
 @return 加密结果
 */
+ (NSString *)base64FromImage:(UIImage *)image;

/**
 图片Base64解密

 @param string 解密的字符串
 @return 解密的结果
 */
+ (UIImage *)base64FromString:(NSString *)string;

@end


