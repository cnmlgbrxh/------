//
//  Tools.m
//  ShiZhiBao
//
//  Created by apple on 2017/3/28.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import "Tools.h"
#import <CommonCrypto/CommonDigest.h>
@implementation Tools

/// 验证手机格式是否正确
+ (BOOL)isValidateMobile:(NSString *)mobileNum{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString *mobile = @"^[1][3,4,5,8,7][0-9]{9}$";
    NSPredicate *regextestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",mobile];
    
    if ([regextestMobile evaluateWithObject:mobileNum] == true)
    {
        return true;
    }
    return false;
}
/// 验证密码格式是否正确
+ (BOOL)isValidatePassword:(NSString *)password{
    NSString *emailRegex = @"^[a-z0-9A-Z]{6,16}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:password];
}
///验证身份证格式是否正确
+ (BOOL)isValidateId:(NSString *)Id{
    NSString *emailRegex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:Id];
}
//验证包含特殊字符
+ (BOOL)isValidateSpecialChar:(NSString *)strChar{
    NSString *emailRegex   = @"^[\u4e00-\u9fa5_a-zA-Z0-9]+$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:strChar];
}
+(BOOL)isEmpty:(NSString *)str{
    
    if (!str) {
        return YES;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return YES;
        } else {
            return NO;
        }
    }
}
+(BOOL)isValidateNumber:(NSString *)number{
    NSString *numberRegex = @"^[0-9]+$";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegex];
    return [numberTest evaluateWithObject:number];
}
+(NSMutableAttributedString *)setUpAlertMessage:(NSString *)message{
    // 创建一个富文本
    NSMutableAttributedString *attri =[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",message]];
    
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:@"提示"];
    // 设置图片大小
    attch.bounds = CGRectMake(0, Scale(-1.5), Scale(13), Scale(13));
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
    [attri insertAttributedString:string atIndex:0];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    [attri addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [message length])];
    return attri;
}
+ (NSString *)getNumberFromString:(NSString *)string
{
    NSMutableString *strippedString = [NSMutableString
                                       stringWithCapacity:string.length];
    
    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSCharacterSet *numbers = [NSCharacterSet
                               characterSetWithCharactersInString:@"0123456789"];
    
    while ([scanner isAtEnd] == NO) {
        NSString *buffer;
        if ([scanner scanCharactersFromSet:numbers intoString:&buffer]) {
            [strippedString appendString:buffer];
        } else {
            [scanner setScanLocation:([scanner scanLocation] + 1)];
        }
    }
    return strippedString;
}
+ (NSString *)dateStringWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    // 设置日历显示格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}
+(NSString *)strTimeWithDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    return [dateFormatter stringFromDate:date];
}
+(NSString *)dayNumberWithAtTimeStr:(NSString *)atTime withEnTimeStr:(NSString *)enTime
{
    NSInteger time = [enTime integerValue] - [atTime integerValue];
    int day = floor(time / 86400) + 1;
    return [NSString stringWithFormat:@"%d",day];
}
+ (NSInteger)getTimeIntervalWithBeforeDate:(NSDate *)beforeDate{
    //首先创建格式化对象
    //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss +SSSS"];
    NSDate *date = [NSDate date];
    //计算时间间隔（单位是秒）
    NSTimeInterval time = [date timeIntervalSinceDate:beforeDate];
    //计算天数、时、分、秒
//    NSInteger days = ((int)time)/(3600*24);
//    NSInteger hours = ((int)time)%(3600*24)/3600;
//    NSInteger minutes = ((int)time)%(3600*24)%3600/60;
    NSInteger seconds = ((int)time)%(3600*24)%3600%60;
//    NSString *dateContent = [[NSString alloc] initWithFormat:@"仅剩%li天%li小时%li分%li秒",(long)days,(long)hours,(long)minutes,(long)seconds];
    return seconds;
}
+ (NSString *)dateWeekWithDateString:(NSString *)dateString
{
    NSTimeInterval time=[dateString doubleValue];
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:time];
    
    if (!date) {
        return nil;
    }
    float different = date.timeIntervalSinceNow;;
    if (different < 0) {
        different = - different;
    }
    
    int day = floor(different / 86400);
    
    if (day == 0) {
        return @"今天";
    }else if (day == 1){
        return @"昨天";
    }
    
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:date];
    NSInteger _weekday = [weekdayComponents weekday];
    NSLog(@"_weekday::%ld",_weekday);
    NSString *weekStr;
    if (_weekday == 1) {
        weekStr = @"星期日";
    }else if (_weekday == 2){
        weekStr = @"星期一";
    }else if (_weekday == 3){
        weekStr = @"星期二";
    }else if (_weekday == 4){
        weekStr = @"星期三";
    }else if (_weekday == 5){
        weekStr = @"星期四";
    }else if (_weekday == 6){
        weekStr = @"星期五";
    }else if (_weekday == 7){
        weekStr = @"星期六";
    }
    return weekStr;
}

+ (UIColor*)getUIColorFromString:(NSString*)s {
    if (!s || [s isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[s substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[s substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[s substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}

+(NSMutableAttributedString *)LabelStr:(NSString *)allStr changeStr:(NSString *)changeStr color:(UIColor *)color font:(UIFont * )font{
    NSMutableAttributedString * Mstr = [[NSMutableAttributedString alloc] initWithString:allStr];
    if (changeStr == nil || [changeStr isEqualToString:@""]) {
        return Mstr;
    }else{
        NSRange range = [allStr rangeOfString:changeStr];
        if (color&&font) {
            [Mstr addAttribute:NSForegroundColorAttributeName value:color range:range];
            
            [Mstr addAttribute:NSFontAttributeName value:font range:range];
        }else if (!color&&font){
            [Mstr addAttribute:NSFontAttributeName value:font range:range];
            
        }else{
            [Mstr addAttribute:NSForegroundColorAttributeName value:color range:range];
            
        }
        return Mstr;
    }
} 
+ (NSString *)md5:(NSString *)str
{
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *md5EncodeStr = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [md5EncodeStr appendFormat:@"%02X", result[i]];
    }
    //加密结果
    return md5EncodeStr;
    /*
     const char* input = [string UTF8String];
     unsigned char result[CC_MD5_DIGEST_LENGTH];
     CC_MD5(input, (CC_LONG)strlen(input), result);
     
     NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
     for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
     [digest appendFormat:@"%02x", result[i]];
     }
     
     return digest;
     */
}
// 图片Base64加密
+ (NSString *)base64FromImage:(UIImage *)image{
    //NSData *imagedata = UIImagePNGRepresentation(image);
    NSData *imagedata =UIImageJPEGRepresentation(image,1.0);
    NSString *image64 = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return image64;
}
// 图片Base64解密
+ (UIImage *)base64FromString:(NSString *)string{
    NSData * imageData =[[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *photo = [UIImage imageWithData:imageData ];
    return photo;
}
@end
