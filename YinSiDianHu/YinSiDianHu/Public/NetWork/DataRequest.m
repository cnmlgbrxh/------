//
//  DataRequest.m
//  ShiZhiBao
//
//  Created by apple on 2017/3/29.
//  Copyright © 2017年 XinFu. All rights reserved.
//

#import "DataRequest.h"
#import "DataCache.h"
#import "RequestFailedView.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "SDShowHUDView.h"
typedef NS_ENUM(NSInteger, HttpType) {
    GET = 1,
    POST,
};
//static NSString * const BaseURLString = @"http://qqtel.dciig.com/wxpay/getwxpay.php";
//static NSString * const BaseURLString = @"http://qqtel.dciig.com/interface.php";

static NSString * const BaseURLString = @"http://int.qiqutel.com/interface.php";

//static NSString * const BaseURLString = @"http://ystel.rrtel.com/interface/interface.php";
@implementation DataRequest

#pragma mark - 初始化
+ (instancetype)sharedClient {
    static DataRequest *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[DataRequest alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.requestSerializer.timeoutInterval = 30.f;
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
        // 打开状态栏的等待菊花
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    });
    
    return _sharedClient;
}
#pragma mark - 当前项目
+(NSURLSessionDataTask *)POST_Parameters:(id)parameters
                          showHUDAddedTo:(UIView *)view
                                 success:(void (^)(NSURLSessionDataTask *task, id responseObject))success{
    return [self requestMethod:POST urlString:@"" parameters:parameters showHUDAddedTo:view cachePolicy:IgnoringCacheReloadData success:success failure:nil];
}
+(NSURLSessionDataTask *)POST_Parameters:(id)parameters
                          showHUDAddedTo:(UIView *)view
                                 success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                 failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    return [self requestMethod:POST urlString:@"" parameters:parameters showHUDAddedTo:view cachePolicy:IgnoringCacheReloadData success:success failure:failure];
}
#pragma mark - GET
+(NSURLSessionDataTask *)GET:(NSString *)URLString
              showHUDAddedTo:(UIView *)view
                     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success{
    return [self requestMethod:GET urlString:URLString parameters:nil showHUDAddedTo:view cachePolicy:IgnoringCacheReloadData success:success failure:nil];
}
+(NSURLSessionDataTask *)GET:(NSString *)URLString
                  parameters:(id)parameters
              showHUDAddedTo:(UIView *)view
                 cachePolicy:(RequestCachePolicy)cachePolicy
                     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                     failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    return [self requestMethod:GET urlString:URLString parameters:parameters showHUDAddedTo:view cachePolicy:cachePolicy success:success failure:failure];
}
#pragma mark - POST
+(NSURLSessionDataTask *)POST:(NSString *)URLString
                   parameters:(id)parameters
               showHUDAddedTo:(UIView *)view
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success{
    return [self requestMethod:POST urlString:URLString parameters:parameters showHUDAddedTo:view cachePolicy:IgnoringCacheReloadData success:success failure:nil];
}
+(NSURLSessionDataTask *)POST:(NSString *)URLString
                   parameters:(id)parameters
               showHUDAddedTo:(UIView *)view
                  cachePolicy:(RequestCachePolicy)cachePolicy
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    return [self requestMethod:POST urlString:URLString parameters:parameters showHUDAddedTo:view cachePolicy:cachePolicy success:success failure:failure];
}
#pragma mark - 网络请求Private
+ (NSURLSessionDataTask *)requestMethod:(HttpType)type
                              urlString:(NSString *)URLString
                             parameters:(id)parameters
                         showHUDAddedTo:(UIView *)view
                            cachePolicy:(RequestCachePolicy)cachePolicy
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    if (URLString==nil) {
        return nil;
    }

    NSString *cacheKey = [DataCache cacheKeyWithURL:URLString parameters:parameters];
    NSLog(@"URL:%@,parameters:%@",URLString,parameters);
    id object = [DataCache httpCacheKey:cacheKey];
    
    switch (cachePolicy) {
        case CacheDataThenLoad: {//有缓存就先返回缓存，同步请求数据
            if (object) {
                success(nil,object);
            }
            break;
        }
        case IgnoringCacheReloadData: {//忽略缓存，重新请求
            //不做处理，直接请求
            break;
        }
        case CacheDataElseLoad: {//有缓存就用缓存，没有缓存就重新请求(用于数据不变时
            if (object) {
                success(nil,object);
                return nil;
            }
            break;
        }
        case OnlyCacheData: {//有缓存就用缓存，没有缓存就不发请求，当做请求出错处理（用于离线模式）
            if (object) {
                success(nil,object);
            }
            return nil;
        }
        default: {
            break;
        }
    }
    return [self requestMethod:type urlString:URLString parameters:parameters showHUDAddedTo:view cacheKey:cacheKey cachePolicy:cachePolicy success:success failure:failure];
}
+ (NSURLSessionDataTask *)requestMethod:(HttpType)type
                              urlString:(NSString *)URLString
                             parameters:(id)parameters
                         showHUDAddedTo:(UIView *)view
                               cacheKey:(NSString *)cacheKey
                            cachePolicy:(RequestCachePolicy)cachePolicy
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    if (view != nil) {
        [[SDShowHUDView sharedHUDView]showLoading];
    }
    __block RequestFailedView *requestFailedView;
    switch (type) {
        case GET:{
            return [[DataRequest sharedClient] GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //if ([responseObject isKindOfClass:[NSData class]]) {
                //    responseObject = [NSJSONSerialization objectWithJSONData:responseObject];
                //}
                //NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                [DataCache setHttpCache:responseObject cacheKey:cacheKey];
                if (success) {
                    success(task,responseObject);
                }
                [[SDShowHUDView sharedHUDView]hidden];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(task, error);
                }
                [[SDShowHUDView sharedHUDView]hidden];
                [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
            }];
            break;
        }
        case POST:{
            return [[DataRequest sharedClient] POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [[view viewWithTag:66666] removeFromSuperview];
                [DataCache setHttpCache:responseObject cacheKey:cacheKey];
                [[SDShowHUDView sharedHUDView]hidden];
                //DELog(@"数据请求类:%@",responseObject);
                if ([[responseObject objectForKey:@"stats"] isEqualToString:@"ok"]&&success){
                    success(task,responseObject);
                }else if ([[responseObject objectForKey:@"stats"] isEqualToString:@"errorlogin"])
                {
                    [MessageHUG showWarningAlert:[responseObject objectForKey:@"msg"] animateWithDuration:3.5 completion:^{
                        [MessageHUG restoreLoginViewController];
                    }];
                }else{
                    [MessageHUG showWarningAlert:[responseObject objectForKey:@"msg"]];
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [[SDShowHUDView sharedHUDView]hidden];
                if ([view viewWithTag:66666]==nil) {
                    requestFailedView = LoadViewWithNIB(@"RequestFailedView");
                    requestFailedView.frame = CGRectMake(0, 0, SCREEN_W, view.height);
                    requestFailedView.tag = 66666;
                }
                requestFailedView.blockRefreshData = ^{
                   [self requestMethod:type urlString:URLString parameters:parameters showHUDAddedTo:view cachePolicy:cachePolicy success:success failure:failure];
                };
                [view addSubview:requestFailedView];
                [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
                if (failure) {
                    failure(task, error);
                }
            }];
            break;
        }
        default:
            break;
    }
    
}
#pragma mark - 当前项目特殊处理
+(NSURLSessionDataTask *)POST_TParameters:(id)parameters
                           showHUDAddedTo:(UIView *)view
                                  success:(void (^)(NSURLSessionDataTask *task, id responseObject))success{
    if (view != nil) {
        [[SDShowHUDView sharedHUDView]showLoading];
    }
    __block RequestFailedView *requestFailedView;
    return [[DataRequest sharedClient] POST:BaseURLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //DELog(@"数据请求类:%@",responseObject);
        [[SDShowHUDView sharedHUDView]hidden];
        [[view viewWithTag:66666] removeFromSuperview];
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[SDShowHUDView sharedHUDView]hidden];
        if ([view viewWithTag:66666]==nil) {
            requestFailedView = LoadViewWithNIB(@"RequestFailedView");
            requestFailedView.frame = CGRectMake(0, 0, SCREEN_W, view.height);
            requestFailedView.tag = 66666;
        }
        requestFailedView.blockRefreshData = ^{
            [self POST_TParameters:parameters showHUDAddedTo:view success:success failure:nil];
        };
        [view addSubview:requestFailedView];
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}
+(NSURLSessionDataTask *)POST_TParameters:(id)parameters
                           showHUDAddedTo:(UIView *)view
                                  success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    if (view != nil) {
        [[SDShowHUDView sharedHUDView]showLoading];
    }
    __block RequestFailedView *requestFailedView;
    return [[DataRequest sharedClient] POST:BaseURLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //DELog(@"数据请求类:%@",responseObject);
        [[SDShowHUDView sharedHUDView]hidden];
        [[view viewWithTag:66666] removeFromSuperview];
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[SDShowHUDView sharedHUDView]hidden];
        if ([view viewWithTag:66666]==nil) {
            requestFailedView = LoadViewWithNIB(@"RequestFailedView");
            requestFailedView.frame = CGRectMake(0, 0, SCREEN_W, view.height);
            requestFailedView.tag = 66666;
        }
        requestFailedView.blockRefreshData = ^{
            [self POST_TParameters:parameters showHUDAddedTo:view success:success failure:failure];
        };
        [view addSubview:requestFailedView];
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
        if (failure) {
            failure(task, error);
        }
    }];
}
+(NSURLSessionDataTask *)GET_TParameters:(id)parameters
                          showHUDAddedTo:(UIView *)view
                                 success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                 failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    if (view != nil) {
        [[SDShowHUDView sharedHUDView]showLoading];
    }
    __block RequestFailedView *requestFailedView;
    return [[DataRequest sharedClient] GET:BaseURLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //DELog(@"数据请求类:%@",responseObject);
        [[SDShowHUDView sharedHUDView]hidden];
        [[view viewWithTag:66666] removeFromSuperview];
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[SDShowHUDView sharedHUDView]hidden];
        if ([view viewWithTag:66666]==nil) {
            requestFailedView = LoadViewWithNIB(@"RequestFailedView");
            requestFailedView.frame = CGRectMake(0, 0, SCREEN_W, view.height);
            requestFailedView.tag = 66666;
        }
        requestFailedView.blockRefreshData = ^{
            [self GET_TParameters:parameters showHUDAddedTo:view success:success failure:failure];
        };
        [view addSubview:requestFailedView];
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
        if (failure) {
            failure(task, error);
        }
    }];
}
#pragma mark - 上传Base64图片
+ (NSURLSessionDataTask *)uploadImageParameters:(id)parameters
                                       progress:(void (^)(NSProgress *progress))progress
                                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    return [[DataRequest sharedClient] POST:BaseURLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            //progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}
#pragma mark - 上传多张图片
+ (NSURLSessionDataTask *)uploadImagesWithURL:(NSString *)URLString
                               parameters:(id)parameters
                                     name:(NSString *)name
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                               imageScale:(CGFloat)imageScale
                                imageType:(NSString *)imageType
                           showHUDAddedTo:(UIView *)view
                                 progress:(void (^)(NSProgress *progress))progress
                                  success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                  failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    if (URLString==nil) {
        return nil;
    }
    
    if (view != nil) {
        [MessageHUG showAnimation:@"上传中···" showHUDAddedTo:view];
    }
    //NSDictionary * dic  =@{@"verbId":@"modifyUserInfo",@"deviceType":@"iOS",@"userId":@"",@"photo":[Tools base64FromImage:]};
    //[DataRequest sharedClient].responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionDataTask *sessionTask = [[DataRequest sharedClient] POST:BaseURLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 图片经过等比压缩后得到的二进制文件
            NSData *imageData = UIImageJPEGRepresentation(obj, imageScale ?: 1.f);
            // 默认图片的文件名, 若fileNames为nil就使用
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName = [NSString stringWithFormat:@"%@%ld.%@",str,idx,imageType?:@"jpg"];
            
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileNames ? [NSString stringWithFormat:@"%@.%@",fileNames[idx],imageType?:@"jpg"]: imageFileName
                                    mimeType:[NSString stringWithFormat:@"image/%@",imageType ?: @"jpg"]];
        }];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            //progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(task,responseObject);
        }
        [MessageHUG hideAnimation];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
        [MessageHUG hideAnimation];
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
    
    return sessionTask;
}

#pragma mark - 监测当前网络状态（网络监听）
+ (void)networkStatus:(void (^)(AFNetworkReachabilityStatus status))AFNetStatus{
    //开启网络监测
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    //关闭网络监测
    //[[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown://未知网络状态
                AFNetStatus ? AFNetStatus(AFNetworkReachabilityStatusUnknown) : nil;
                break;
            case AFNetworkReachabilityStatusNotReachable://未知网络状态
                AFNetStatus ? AFNetStatus(AFNetworkReachabilityStatusNotReachable) : nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN://蜂窝数据网
                AFNetStatus ? AFNetStatus(AFNetworkReachabilityStatusReachableViaWWAN) : nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi://WiFi网络
                //[DataRequest defaultManager].failureBlock(YES,nil);
                AFNetStatus ? AFNetStatus(AFNetworkReachabilityStatusReachableViaWiFi) : nil;
                break;
        }
    }];
}

+ (BOOL)isNetwork{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}
+ (BOOL)isIphone{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}
+ (BOOL)isWiFi{
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

/**
 *  返回当前视图的控制器
 */
+(UIViewController *)viewController:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


/*
 
 __block RequestFailedView *requestFailedView;
 return [[DataRequest sharedClient] POST:BaseURLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
 
 } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
 //DELog(@"数据请求类:%@",responseObject);
 [requestFailedView removeFromSuperview];
 if (success) {
 success(task,responseObject);
 }
 [MessageHUG hideAnimation];
 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
 if (failure) {
 failure(task, error);
 }
 if ([view viewWithTag:6666]==nil) {
 requestFailedView = LoadViewWithNIB(@"RequestFailedView");
 requestFailedView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
 requestFailedView.tag = 66666;
 }
 requestFailedView.blockRefreshData = ^{
 [self POST_TParameters:parameters showHUDAddedTo:view success:success failure:failure];
 };
 [view addSubview:requestFailedView];
 
 [MessageHUG hideAnimation];
 [MessageHUG showAlert:@"网络请求超时" showAddedTo:view];
 
 配置自建证书的Https请求, 参考链接: http://blog.csdn.net/syg90178aw/article/details/52839103
 
 @param cerPath 自建Https证书的路径
 @param validatesDomainName 是否需要验证域名，默认为YES. 如果证书的域名与请求的域名不一致，需设置为NO; 即服务器使用其他可信任机构颁发
 的证书，也可以建立连接，这个非常危险, 建议打开.validatesDomainName=NO, 主要用于这种情况:客户端请求的是子域名, 而证书上的是另外
 一个域名。因为SSL证书上的域名是独立的,假如证书上注册的域名是www.google.com, 那么mail.google.com是无法验证通过的.
 + (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName {
 NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
 // 使用证书验证模式
 AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
 // 如果需要验证自建证书(无效证书)，需要设置为YES
 securityPolicy.allowInvalidCertificates = YES;
 // 是否需要验证域名，默认为YES;
 securityPolicy.validatesDomainName = validatesDomainName;
 securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
 
 [_sessionManager setSecurityPolicy:securityPolicy];
 }
 
 */
@end
