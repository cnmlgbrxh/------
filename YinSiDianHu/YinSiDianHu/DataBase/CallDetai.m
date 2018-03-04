//
//  CallDetai.m
//  YinSiDianHu
//
//  Created by Apple on 2017/6/15.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CallDetai.h"
#import <FMDB/FMDatabaseQueue.h>
#import <FMDB/FMDB.h>
@implementation CallDetai{
    
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
            // 创建表 PRIMARY KEY AUTOINCREMENT
            NSString *sql = @"CREATE TABLE IF NOT EXISTS CallHistory (phoneNumber TEXT, type TEXT NOT NULL, placeOfAttribution TEXT NOT NULL, date TEXT NOT NULL, callNumber TEXT NOT NULL)";
            [db executeUpdate:sql];
        }];
        NSAssert(_queue != nil, @"db error when create queue using path");
    }
    return self;
}

- (void)dealloc {
    [_queue close];
}

- (BOOL)insertData:(CallDetaiModel *)record withPhoneNumber:(NSString *)phoneNumber{
    __block BOOL success = YES;
//    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
//        NSString *sql = @"insert into CallHistory (phoneNumber, type, placeOfAttribution, date ,callNumber) values (?, ?, ?, ? ,?)";
//        BOOL result = [db executeUpdate:sql, phoneNumber,record.type, record.placeOfAttribution, record.date ,record.callNumber];
//        success = result;
//        if (result == NO) {
//            *rollback = YES;
//        }
//    }];
    return success;
}
- (BOOL)updateData:(CallDetaiModel *)record withPhoneNumber:(NSString *)phoneNumber{
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

@end
