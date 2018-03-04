//
//  CallDetai.h
//  YinSiDianHu
//
//  Created by Apple on 2017/6/15.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

//通话详情
@interface CallDetaiModel : NSObject

///电话号码
@property (nonatomic,copy) NSString *phoneNumber;

///拨打日期
@property (nonatomic,copy) NSString *date;

///通话时间
@property (nonatomic,copy) NSString *callTime;

///回拨类型（回拨，直拨）
@property (nonatomic,copy) NSString *callbackType;

@end


@interface CallDetai : NSObject

@end
