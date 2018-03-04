//
//  DataManager.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/5.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BlockCallBack)(id, id);

@interface Callback : NSObject

/**
 区别值的唯一标识符
 */
@property (nonatomic, copy) NSString *key;

/**
 复用标识符
 */
@property (nonatomic, copy) NSString *reuseIdentifier;

/**
 block代码块
 */
@property (nonatomic, copy) BlockCallBack blockCallBack;

@end

@interface DataManager : NSObject

/**
 存值
 
 @param object 值
 @param key 区别值的唯一标识符
 */
+ (void)save:(id)object forKey:(NSString *)key;

/**
 取值，或值发生改变时回调（并行、异步）
 
 @param key 区别值的唯一标识符
 @param reuseIdentifier 复用标识符
 @param changed 回调：并行队列、异步执行（多线程、一起执行），刷新UI请在dispatch_get_main_queue()队列中执行
 */
+ (void)valueChangedForKey:(NSString *)key reuseIdentifier:(NSString *)reuseIdentifier changed:(void(^)(id object, id oldObject))changed;

/**
 根据复用标识符放弃指定回调
 
 @param reuseIdentifier 复用标识符
 */
+ (void)resignCallbackWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
