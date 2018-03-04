//
//  ContactModel.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/12.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactModel : NSObject

/**
 电话号码
 */
@property (copy,nonatomic) NSString *phoneNumber;

/**
 姓名
 */
@property (copy,nonatomic) NSString *name;

/**
 头像的缩略图 Data
 */
@property (copy,nonatomic) NSData *thumbnailImageData;

@end
