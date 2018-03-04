//
//  DataManager.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/5.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "DataManager.h"

@implementation Callback

@end

@interface DataManager ()

/**
 新值
 */
@property (nonatomic, strong) NSMutableDictionary *valueContainer;

/**
 旧值
 */
@property (nonatomic, strong) NSMutableDictionary *oldValueContainer;

@property (nonatomic, strong) NSMutableArray <Callback *>*callbacks;

@end

@implementation DataManager

+ (DataManager *)dataManager {
    static DataManager *dataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataManager = [[DataManager alloc] init];
    });
    return dataManager;
}


+ (void)save:(id)object forKey:(NSString *)key {
    //设置新值前更新旧值
    id newValue = [[DataManager dataManager].valueContainer objectForKey:key];
    if (newValue) {
        [[DataManager dataManager].oldValueContainer setObject:newValue forKey:key];
    }
    //添加新值
    [[DataManager dataManager].valueContainer setObject:object forKey:key];
    //分发
    [[DataManager dataManager] callbackActionForKey:key];
}

+ (void)valueChangedForKey:(NSString *)key reuseIdentifier:(NSString *)reuseIdentifier changed:(void (^)(id, id))changed {
    //去除重复的回调
    [[DataManager dataManager] resignCallbackWithReuseIdentifier:reuseIdentifier];
    
    //加入回调
    Callback *model = [[Callback alloc] init];
    model.key = key;
    model.reuseIdentifier = reuseIdentifier;
    model.blockCallBack = changed;
    [[DataManager dataManager].callbacks addObject:model];
    
    //取值并回调
    id newValue = [[DataManager dataManager].valueContainer objectForKey:key];
    id oldValue = [[DataManager dataManager].oldValueContainer objectForKey:key];
    if (newValue) {
        dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(queue, ^{
            changed(newValue, oldValue);
        });
    }
}

+ (void)resignCallbackWithReuseIdentifier:(NSString *)reuseIdentifier {
    [[DataManager dataManager] resignCallbackWithReuseIdentifier:reuseIdentifier];
}

#pragma mark - private methods

/**
 根据reuseIdentifier去除回调
 
 @param reuseIdentifier 复用标识符
 */
- (void)resignCallbackWithReuseIdentifier:(NSString *)reuseIdentifier {
    NSString *str = [NSString stringWithFormat:@"reuseIdentifier != '%@'",reuseIdentifier];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:str];
    [self.callbacks filterUsingPredicate:predicate];
}

/**
 根据key取出对应的回调数组
 
 @param key 标识符
 @return 数组
 */
- (NSArray <Callback *>*)callbacksForKey:(NSString *)key {
    NSString *str = [NSString stringWithFormat:@"key = '%@'",key];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:str];
    NSArray *results = [self.callbacks filteredArrayUsingPredicate:predicate];
    return results;
}

/**
 根据key分发
 
 @param key 标识符
 */
- (void)callbackActionForKey:(NSString *)key {
    NSArray *callbacks = [[DataManager dataManager] callbacksForKey:key];
    id newValue = [[DataManager dataManager].valueContainer objectForKey:key];
    id oldValue = [[DataManager dataManager].oldValueContainer objectForKey:key];
    
    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
    
    for (Callback *model in callbacks) {
        dispatch_async(queue, ^{
            model.blockCallBack(newValue, oldValue);
        });
    }
}

#pragma mark - getter
- (NSMutableDictionary *)valueContainer {
    if (_valueContainer == nil) {
        _valueContainer = [NSMutableDictionary dictionary];
    }
    return _valueContainer;
}

- (NSMutableDictionary *)oldValueContainer {
    if (_oldValueContainer == nil) {
        _oldValueContainer = [NSMutableDictionary dictionary];
    }
    return _oldValueContainer;
}

- (NSMutableArray<Callback *> *)callbacks {
    if (_callbacks == nil) {
        _callbacks = [NSMutableArray array];
    }
    return _callbacks;
}

@end
