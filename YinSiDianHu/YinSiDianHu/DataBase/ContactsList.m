//
//  ContactsList.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/12.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ContactsList.h"
#import <FMDB/FMDatabaseQueue.h>
#import <FMDB/FMDB.h>

@implementation ContactsList{
    NSString *_fileName;
    FMDatabaseQueue *_queue;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"/ContactsList.db"];
        
        
        _queue = [FMDatabaseQueue databaseQueueWithPath:_fileName];
        
        [_queue inDatabase:^(FMDatabase *db) {
            // 创建表
            NSString *sql = @"CREATE TABLE IF NOT EXISTS ContactsList (phoneNumber TEXT,name TEXT, thumbnailImageData TEXT)";
            [db executeUpdate:sql];
        }];
        NSAssert(_queue != nil, @"db error when create queue using path");
    }
    return self;
}
/**
 插入一条数据
 
 @param contacts 数据
 @return 结果
 */
-(BOOL)insertContacts:(NSArray<LJPerson *> *)contacts{
    __block BOOL success = YES;
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *sql = @"insert into ContactsList (phoneNumber, name ,thumbnailImageData) values (?, ?, ?)";
        [contacts enumerateObjectsUsingBlock:^(LJPerson * _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [obj1.phones enumerateObjectsUsingBlock:^(LJPhone * _Nonnull obj2, NSUInteger idx, BOOL * _Nonnull stop) {
                BOOL result = [db executeUpdate:sql, obj2.phone, obj1.fullName ,obj1.thumbnailImageData];
                success = result;
                if (result == NO) {
                    *rollback = YES;
                }
            }];
            
        }];
    }];
    return success;
}
/**
 查询指定动态下的数据
 
 @param phoneNumber 评论ID
 @return 数据
 */
- (ContactModel *)queryDataWith:(NSString *)phoneNumber{
    ContactModel *model = [[ContactModel alloc] init];
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *sql = @"select * from ContactsList where phoneNumber = ?";
        FMResultSet *resultSet = [db executeQuery:sql, phoneNumber];
        if ([resultSet next]) {
            model.phoneNumber = [resultSet stringForColumn:@"phoneNumber"];
            model.name = [resultSet stringForColumn:@"name"];
            model.thumbnailImageData = [resultSet dataForColumn:@"thumbnailImageData"];
        }
    }];
    return model;
}
/**
 查询全部数据
 @return 数据
 */
- (NSArray <ContactModel *>*)queryAllData{
    NSMutableArray <ContactModel *> *arrmAlls = [NSMutableArray array];
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *sql = @"select * from ContactsList";
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            ContactModel *model = [[ContactModel alloc] init];
            model.phoneNumber = [resultSet stringForColumn:@"phoneNumber"];
            model.name = [resultSet stringForColumn:@"name"];
            model.thumbnailImageData = [resultSet dataForColumn:@"thumbnailImageData"];
            [arrmAlls addObject:model];
        }
    }];
    return arrmAlls;
}
/**
 删除全部数据
 */
- (BOOL)deleteAllData{
    __block BOOL success = YES;
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *sql = @"delete from ContactsList";
        BOOL result = [db executeUpdate:sql];
        success = result;
        if (result == NO) {
            *rollback = YES;
        }
    }];
    return success;
}
@end
