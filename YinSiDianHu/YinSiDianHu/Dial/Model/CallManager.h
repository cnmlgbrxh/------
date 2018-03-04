//
//  CallManager.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/8/10.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactModel.h"
@interface CallManager : NSObject

+(void)enhancedCall:(UIViewController *)viewController iphone:(NSString *)iphoneNumber Status:(void (^) (BOOL authorization))completion;

+(void)callbackViewController:(UIViewController *)viewController ContactModel:(ContactModel *)contactModel iphone:(NSString *)iphoneNumber Status:(void (^) (BOOL authorization))completion;

+(NSArray*)search:(NSArray *)arrmPinYin arrContacts:(NSArray<ContactModel *> *)arrContacts arrContactsSave:(NSArray *)arrContactsSave Iphone:(NSString *)iphoneNumber;

@end
