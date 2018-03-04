//
//  CallHistory.h
//  YinSiDianHu
//
//  Created by Apple on 2017/6/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

//通话记录Model
@interface CallHistoryModel : NSObject

///电话号码
@property (copy,nonatomic) NSString *phoneNumber;
///拨打日期
@property (copy,nonatomic) NSString *date;
///拨打次数
@property (copy,nonatomic) NSString *callNumber;
///归属地
@property (copy,nonatomic) NSString *PlaceOfAttribution;
///类型（拨入，拨出，未接）
@property (copy,nonatomic) NSString *type;

@end

@interface CallHistory : NSObject

/**
 插入一条数据
 
 @param record 数据
 @param phoneNumber 动态ID
 */
- (BOOL)insertData:(CallHistoryModel *)record withPhoneNumber:(NSString *)phoneNumber;

/**
 更新一条数据
 
 @param record 数据
 @param phoneNumber 动态ID
 */
- (BOOL)updateData:(CallHistoryModel *)record withPhoneNumber:(NSString *)phoneNumber;

/**
 删除指定动态下的数据
 
 @param phoneNumber 动态ID
 */
- (BOOL)deleteDataWithPhoneNumber:(NSString *)phoneNumber;

/**
 删除全部数据
 */
- (BOOL)deleteAllData;

/**
 查询指定动态下的数据
 
 @param phoneNumber 评论ID
 @return 数据
 */
- (CallHistoryModel *)queryDataWith:(NSString *)phoneNumber;

/**
 查询之前拨打次数

 @param phoneNumber 电话号码
 @return 拨打次数
 */
-(NSUInteger)querycallNumberWith:(NSString *)phoneNumber;

/**
 查询全部数据
 
 @return 数据
 */
- (NSArray <CallHistoryModel *>*)queryAllData;


/**
 数据库添加字段

 @param property 添加属性
 @return 是否添加成功
 */
- (BOOL)insertProperty:(NSString *)property;

@end
