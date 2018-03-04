//
//  QQShoppingTools.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/7.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

#define searchRecordKey @"searchRecordKey"
@interface QQShoppingTools : NSObject
typedef void(^RSToolsAlertControllerCancleBlock)();
typedef void(^RSToolsAlertControllerConfirmBlock)();
typedef void(^RSToolsAlertControllerConfirmArrayBlock)(NSInteger);

+ (QQShoppingTools *)shareInstance;
- (NSArray *)getCacheRecord;
- (void)cacheRecord:(NSMutableArray *)recordArr;
+ (void) showAlertControllerWithTitle:(NSString *)titleStr  message:(NSString *)msg confirmTitle :(NSString *)confirmTitle cancleTitle :(NSString *)cancleTitle vc :(id)vc confirmBlock :(RSToolsAlertControllerConfirmBlock) confirmBlock cancleBlock :(RSToolsAlertControllerCancleBlock) cancleBlock;
- (CGFloat)calculateRowHeight:(NSString *)string fontSize:(NSInteger)fontSize bgViewWidth:(CGFloat)bgViewWidth;

+ (void)showSheetControllerWithTitiles:(NSArray *)titleArr vc :(id)vc confirmBlock :(RSToolsAlertControllerConfirmArrayBlock) confirmBlock;

@end
