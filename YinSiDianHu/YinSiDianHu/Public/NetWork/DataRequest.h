//
//  DataRequest.h
//  ShiZhiBao
//
//  Created by apple on 2017/3/29.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

#pragma mark - 缓存策略
typedef NS_ENUM(NSUInteger, RequestCachePolicy){
    CacheDataThenLoad = 0,///< 有缓存就先返回缓存，同步请求数据
    IgnoringCacheReloadData, ///< 忽略缓存，重新请求
    CacheDataElseLoad,///< 有缓存就用缓存，没有缓存就重新请求(用于数据不变时)
    OnlyCacheData,///< 有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
};

@interface DataRequest : AFHTTPSessionManager

#pragma mark - 当前项目
///简
+(NSURLSessionDataTask *)POST_Parameters:(id)parameters
                          showHUDAddedTo:(UIView *)view
                                 success:(void (^)(NSURLSessionDataTask *task, id responseObject))success;
//／全
+(NSURLSessionDataTask *)POST_Parameters:(id)parameters
                          showHUDAddedTo:(UIView *)view
                                 success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                 failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
///特殊简
+(NSURLSessionDataTask *)POST_TParameters:(id)parameters
                           showHUDAddedTo:(UIView *)view
                                  success:(void (^)(NSURLSessionDataTask *task, id responseObject))success;
///特殊全
+(NSURLSessionDataTask *)POST_TParameters:(id)parameters
                          showHUDAddedTo:(UIView *)view
                                 success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                 failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
#pragma mark - GET
+(NSURLSessionDataTask *)GET_TParameters:(id)parameters
                          showHUDAddedTo:(UIView *)view
                                 success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                 failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
#pragma mark - 上传Base64图片
///上传Base64图片
+ (NSURLSessionDataTask *)uploadImageParameters:(id)parameters
                                     progress:(void (^)(NSProgress *progress))progress
                                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
#pragma mark - 项目封装类
#pragma mark - GET
///简
+(NSURLSessionDataTask *)GET:(NSString *)URLString
              showHUDAddedTo:(UIView *)view
                     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success;
///全
+(NSURLSessionDataTask *)GET:(NSString *)URLString
                  parameters:(id)parameters
              showHUDAddedTo:(UIView *)view
                 cachePolicy:(RequestCachePolicy)cachePolicy
                     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
#pragma mark - POST
///简
+(NSURLSessionDataTask *)POST:(NSString *)URLString
                   parameters:(id)parameters
               showHUDAddedTo:(UIView *)view
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success;
///全
+(NSURLSessionDataTask *)POST:(NSString *)URLString
                   parameters:(id)parameters
               showHUDAddedTo:(UIView *)view
                  cachePolicy:(RequestCachePolicy)cachePolicy
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
#pragma mark - 上传多张图片
+(NSURLSessionDataTask *)uploadImagesWithURL:(NSString *)URLString
                               parameters:(id)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                           showHUDAddedTo:(UIView *)view
                                 progress:(void (^)(NSProgress *progress))progress
                                  success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

#pragma mark -  实时监测网络状态
///通过Block回调获取
+ (void)networkStatus:(void (^)(AFNetworkReachabilityStatus status))AFNetStatus;
///是否有网
+ (BOOL)isNetwork;
///蜂窝网
+ (BOOL)isIphone;
///IS_WIFI
+ (BOOL)isWiFi;

@end
