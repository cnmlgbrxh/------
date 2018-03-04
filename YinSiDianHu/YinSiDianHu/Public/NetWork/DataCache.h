//
//  DataCache.h
//  ShiZhiBao
//
//  Created by apple on 2017/5/12.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import <Foundation/Foundation.h>
// 过期提醒
#define PPDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

#pragma mark - 网络数据缓存类
@interface DataCache : NSObject

+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters;

+ (void)setHttpCache:(id)httpData cacheKey:(NSString *)cacheKey;

/**
 *  根据请求的 URL与parameters 取出缓存数据
 *  @return 缓存的服务器数据
 */
+ (id)httpCacheKey:(NSString *)cacheKey;

/**
 *  根据请求的 URL与parameters 异步取出缓存数据
 *
 *  @param block      异步回调缓存的数据
 *
 */
+ (void)httpCacheKey:(NSString *)cacheKey withBlock:(void(^)(id<NSCoding> object))block;

/**
 *  获取网络缓存的总大小 bytes(字节)
 */
+ (CGFloat)getAllHttpCacheSize;


/**
 *  删除所有网络缓存,
 */
+ (void)removeAllHttpCache;

@end
