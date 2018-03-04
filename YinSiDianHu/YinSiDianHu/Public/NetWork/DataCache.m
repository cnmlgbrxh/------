//
//  DataCache.m
//  ShiZhiBao
//
//  Created by apple on 2017/5/12.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import "DataCache.h"
#import <YYCache/YYCache.h>
@implementation DataCache
static NSString *const NetworkResponseCache = @"ResponseCache";
static YYCache *yyCache;

+ (void)initialize {
    yyCache = [YYCache cacheWithName:NetworkResponseCache];
    yyCache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    yyCache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
}
+ (void)setHttpCache:(id)httpData cacheKey:(NSString *)cacheKey{
    //异步缓存,不会阻塞主线程
    [yyCache setObject:httpData forKey:cacheKey withBlock:nil];
}
+ (id)httpCacheKey:(NSString *)cacheKey{
    return [yyCache objectForKey:cacheKey];
}
+ (void)httpCacheKey:(NSString *)cacheKey withBlock:(void(^)(id<NSCoding> object))block{
    [yyCache objectForKey:cacheKey withBlock:^(NSString * _Nonnull key, id<NSCoding>  _Nonnull object) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block(object);
        });
    }];
}
/**
 返回此缓存中对象的总大小（以M为单位）。
   此方法可能阻止调用线程，直到文件读取完成。
 
 @return 总对象的大小（以M为单位）。
 */
+ (CGFloat)getAllHttpCacheSize {
    return [yyCache.diskCache totalCost]/1024.0/1024.0;
}

+ (void)removeAllHttpCache {
    [yyCache.diskCache removeAllObjects];
}

+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters {    
    NSString *cacheKey = URL;
    if (parameters) {
        if (![NSJSONSerialization isValidJSONObject:parameters]) return nil;//参数不是json类型
        NSData *data = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        NSString *paramStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        cacheKey = [URL stringByAppendingString:paramStr];
    }
    return cacheKey;
}

@end
