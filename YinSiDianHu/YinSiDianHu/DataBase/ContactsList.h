//
//  ContactsList.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/12.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactModel.h"
#import "LJPerson.h"
@interface ContactsList : NSObject

/**
 插入一条数据

 @param contacts 数据
 @return 结果
 */
-(BOOL)insertContacts:(NSArray<LJPerson *> *)contacts;
/**
 查询指定动态下的数据
 
 @param phoneNumber 评论ID
 @return 数据
 */
- (ContactModel *)queryDataWith:(NSString *)phoneNumber;
/**
 查询全部数据
 
 @return 数据
 */
- (NSArray <ContactModel *>*)queryAllData;
/**
 删除全部数据
 */
- (BOOL)deleteAllData;

@end
