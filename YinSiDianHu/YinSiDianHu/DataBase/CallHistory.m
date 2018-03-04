//
//  CallHistory.m
//  YinSiDianHu
//
//  Created by Apple on 2017/6/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CallHistory.h"
#import <FMDB/FMDatabaseQueue.h>
#import <FMDB/FMDB.h>

@implementation CallHistoryModel

@end

@implementation CallHistory{
    
    NSString *_fileName;
    
    FMDatabaseQueue *_queue;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"/CallHistory.db"];
        
        
        _queue = [FMDatabaseQueue databaseQueueWithPath:_fileName];
        
        [_queue inDatabase:^(FMDatabase *db) {
            // 创建表
            NSString *sql = @"CREATE TABLE IF NOT EXISTS CallHistory (phoneNumber TEXT, date TEXT, callNumber TEXT ,PlaceOfAttribution TEXT, type TEXT)";
            [db executeUpdate:sql];
        }];
        NSAssert(_queue != nil, @"db error when create queue using path");
    }
    return self;
}
- (BOOL)insertData:(CallHistoryModel *)record withPhoneNumber:(NSString *)phoneNumber{
    __block BOOL success = YES;
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *sql = @"insert into CallHistory (phoneNumber, date ,callNumber , PlaceOfAttribution, type) values (?, ?, ?, ?, ?)";
        BOOL result = [db executeUpdate:sql, phoneNumber, record.date ,record.callNumber,record.PlaceOfAttribution,record.type];
        success = result;
        if (result == NO) {
            *rollback = YES;
        }
    }];
    return success;
}

- (BOOL)updateData:(CallHistoryModel *)record withPhoneNumber:(NSString *)phoneNumber{
    if ([self deleteDataWithPhoneNumber:phoneNumber]) {
        return [self insertData:record withPhoneNumber:phoneNumber];
    }else return NO;
}

- (BOOL)deleteDataWithPhoneNumber:(NSString *)phoneNumber{
    __block BOOL success = YES;
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *sql = @"delete from CallHistory where phoneNumber = ?";
        BOOL result = [db executeUpdate:sql, phoneNumber];
        success = result;
        if (result == NO) {
            *rollback = YES;
        }
    }];
    return success;
}

- (BOOL)deleteAllData{
    __block BOOL success = YES;
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *sql = @"delete from CallHistory";
        BOOL result = [db executeUpdate:sql];
        success = result;
        if (result == NO) {
            *rollback = YES;
        }
    }];
    return success;
}

- (CallHistoryModel *)queryDataWith:(NSString *)phoneNumber{
    CallHistoryModel *model = [[CallHistoryModel alloc] init];
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *sql = @"select * from CallHistory where phoneNumber = ?";
        FMResultSet *resultSet = [db executeQuery:sql, phoneNumber];
        if ([resultSet next]) {
            model.phoneNumber = [resultSet stringForColumn:@"phoneNumber"];
            model.date = [resultSet stringForColumn:@"date"];
            model.callNumber = [resultSet stringForColumn:@"callNumber"];
            model.PlaceOfAttribution = [resultSet stringForColumn:@"PlaceOfAttribution"];
            model.type = [resultSet stringForColumn:@"type"];
        }
    }];
    return model.phoneNumber? model:nil;
}
-(NSUInteger)querycallNumberWith:(NSString *)phoneNumber{
    __block NSUInteger intCallNumber = 0;
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *sql = @"select * from CallHistory where phoneNumber = ?";
        FMResultSet *resultSet = [db executeQuery:sql, phoneNumber];
        if ([resultSet next]) {
            intCallNumber = [resultSet longLongIntForColumn:@"callNumber"];
        }
    }];
    return intCallNumber;
}
- (NSArray <CallHistoryModel *>*)queryAllData{
    NSMutableArray <CallHistoryModel *> *arrmAlls = [NSMutableArray array];
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        NSString *sql = @"select * from CallHistory";
        FMResultSet *resultSet = [db executeQuery:sql];
        while ([resultSet next]) {
            CallHistoryModel *model = [[CallHistoryModel alloc] init];
            model.phoneNumber = [resultSet stringForColumn:@"phoneNumber"];
            model.date = [resultSet stringForColumn:@"date"];
            model.callNumber = [resultSet stringForColumn:@"callNumber"];
            model.PlaceOfAttribution = [resultSet stringForColumn:@"PlaceOfAttribution"];
            model.type = [resultSet stringForColumn:@"type"];
            [arrmAlls addObject:model];
        }
    }];
    //按时间降序排列
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    [arrmAlls sortUsingDescriptors:@[sort]];
    
    return arrmAlls;
}
//添加新字段
- (BOOL)insertProperty:(NSString *)property {
    __block BOOL success = YES;
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if (![db columnExists:property inTableWithName:StringClass]) {//判断是否已经存在
            NSString *sql = [NSString stringWithFormat:@"ALTER TABLE CallHistory ADD %@ TEXT", property];
            success = [db executeUpdate:sql];
        }
    }];
    return success;
}
- (void)dealloc {
    [_queue close];
}
@end
