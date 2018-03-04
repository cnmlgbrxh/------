//
//  CallManager.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/8/10.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CallManager.h"
#import "CallHistory.h"
#import "LJPerson.h"
#import "TalkingViewController.h"
#import <HYBNetworking/HYBNetworking.h>
@interface CallManager ()

@end

@implementation CallManager

+(void)enhancedCall:(UIViewController *)viewController iphone:(NSString *)iphoneNumber Status:(void (^) (BOOL authorization))completion{
    if (![self isValidateViewController:viewController iphone:iphoneNumber]) {
        return ;
    }
    //将拨打号码存入数据库
    [self databaseOperationsIphone:iphoneNumber Status:completion];
    NSDictionary * parameters=@{@"action":@"didcall",@"username":USERNAME,@"userpass":USERPASS,@"phone":iphoneNumber};
    
    [DataRequest POST_TParameters:parameters showHUDAddedTo:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[responseObject objectForKey:@"stats"] isEqualToString:@"ok"])
        {
            
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",[responseObject objectForKey:@"msg"]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }else if ([[responseObject objectForKey:@"stats"] isEqualToString:@"errorlogin"])
        {
            [MessageHUG showWarningAlert:[responseObject objectForKey:@"msg"] animateWithDuration:3.5 completion:^{
                [MessageHUG restoreLoginViewController];
            }];
        }else
        {
            [MessageHUG showWarningAlert:[responseObject objectForKey:@"msg"]];
        }
    }];
}
+(void)callbackViewController:(UIViewController *)viewController ContactModel:(ContactModel *)contactModel iphone:(NSString *)iphoneNumber Status:(void (^) (BOOL authorization))completion{
    if (![self isValidateViewController:viewController iphone:iphoneNumber]) {
        return ;
    }
    //将拨打号码存入数据库
    [self databaseOperationsIphone:iphoneNumber Status:completion];
    NSDictionary * parameters=@{@"action":@"callback",@"username":USERNAME,@"userpass":USERPASS,@"phone":iphoneNumber};
    
    [DataRequest POST_TParameters:parameters showHUDAddedTo:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if ([[responseObject objectForKey:@"stats"] isEqualToString:@"ok"])
         {
             
             TalkingViewController *talkingVC = LoadViewWithNIB(@"TalkingViewController");
             
             talkingVC.contactModel = contactModel;
             
             [viewController presentViewController:talkingVC animated:YES completion:nil];
         }else if ([[responseObject objectForKey:@"stats"] isEqualToString:@"errorlogin"])
         {
             [MessageHUG showWarningAlert:[responseObject objectForKey:@"msg"] animateWithDuration:3.5 completion:^{
                 [MessageHUG restoreLoginViewController];
             }];
         }else if ([[responseObject objectForKey:@"stats"] isEqualToString:@"errormoney"])
         {
             [MessageHUG showSystemAllAlert:[responseObject objectForKey:@"msg"] controller:viewController completion:^{
                 NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",iphoneNumber];
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
             }];
         }else
         {
             [MessageHUG showWarningAlert:[responseObject objectForKey:@"msg"]];
         }
         
     }];
}
#pragma mark - 操作数据库存储通话记录
+(void)databaseOperationsIphone:(NSString *)iphoneNumber Status:(void (^) (BOOL authorization))completion{
    CallHistoryModel *callHistoryModel = [[CallHistoryModel alloc]init];
    callHistoryModel.date = [Tools strTimeWithDate:[NSDate date]];
    
    [self getPlaceOfAttributionIphone:iphoneNumber place:^(NSString *placeOfAttribution) {
        callHistoryModel.PlaceOfAttribution = placeOfAttribution;
        CallHistory *callHistory = [[CallHistory alloc]init];
        if ([callHistory queryDataWith:iphoneNumber] != nil) {
            callHistoryModel.callNumber = [NSString stringWithFormat:@"%ld",[callHistory querycallNumberWith:iphoneNumber]+1];
            //更新数据库操作
            if (completion) {
                completion([callHistory updateData:callHistoryModel withPhoneNumber:iphoneNumber]);
            }
            
        }else{
            //存入数据库
            callHistoryModel.callNumber = @"1";
            if (completion) {
                completion([callHistory insertData:callHistoryModel withPhoneNumber:iphoneNumber]);
            }
        }
    }];
    
}
#pragma mark - 获取归属地
+(void)getPlaceOfAttributionIphone:(NSString *)iphoneNumber place:(void (^) (NSString *placeOfAttribution))place{

    [HYBNetworking setTimeout:10];
    //获取归属地
    [HYBNetworking getWithUrl:[NSString stringWithFormat:@"http://apis.juhe.cn/mobile/get?phone=%@&key=40cb776c1102f51a9932680c88238e5e",iphoneNumber] refreshCache:YES success:^(id response) {
        NSLog(@"a:%@",response);
        if ([[response objectForKey:@"resultcode"] isEqualToString:@"200"])
        {
            if (IsNilString([[response objectForKey:@"result"] objectForKey:@"city"])) {
                if (place) {
                    place([NSString stringWithFormat:@"%@",[[response objectForKey:@"result"] objectForKey:@"province"]]);
                };
            }else{
                if (place) {
                    place([NSString stringWithFormat:@"%@,%@",[[response objectForKey:@"result"] objectForKey:@"province"],[[response objectForKey:@"result"] objectForKey:@"city"]]);
                };
            }
        }else{
            if (place) {
                place(@"未知");
            };
        }
        
    } fail:^(NSError *error) {
        if (place) {
            place(@"未知");
        };
    }];
}
//判断纯数字
+(BOOL)isValidateViewController:(UIViewController *)viewController iphone:(NSString *)iphoneNumber{
    
    __block BOOL isValidate = YES;
//    //监测网络
//    [DataRequest networkStatus:^(AFNetworkReachabilityStatus status) {
//        if (status == AFNetworkReachabilityStatusNotReachable) {
//            [MessageHUG showSystemAlert:@"网络连接失败" controller:viewController completion:nil];
//            isValidate = NO;
//        }
//    }];
    
    if (iphoneNumber.length<=6||iphoneNumber.length>=18)
    {
        [MessageHUG showWarningAlert:@"号码格式错误"];
        isValidate = NO;
    }
    return isValidate;
}

#pragma mark - 谓词筛选数据
+(NSArray*)huoqujieguo:(NSArray*)allresut first:(NSArray*)first last:(NSArray*)last{
    
    NSMutableArray * arrPinYin = [NSMutableArray array];
    if (first != nil) {
        [arrPinYin addObject:first];
    }
    if (last != nil) {
        [arrPinYin addObject:last];
    }
    NSMutableArray *arrm = [NSMutableArray array];
    NSMutableArray * number = [NSMutableArray array];
    NSMutableArray * hasResutStr = [NSMutableArray array];
    int allCount = 1;
    for (NSArray * arr in arrPinYin) {
        [number addObject:@0];
        allCount *= arr.count;
    }
    if (number.count != 0) {
        number[0] = [NSNumber numberWithInt:-1];
    }
    for (int index = 0; index != allCount; index++) {
        for (int numberIndex = 0;numberIndex != number.count; numberIndex++) {
            NSNumber * numberValue = number[numberIndex];
            int value = [numberValue intValue];
            NSArray * neiArrmPinYin = arrPinYin[numberIndex];
            if (value != neiArrmPinYin.count - 1) {
                number[numberIndex] = [NSNumber numberWithInt:value + 1];
                break;
            }else{
                number[numberIndex] = [NSNumber numberWithInt:0];
            }
        }
        NSMutableString * targetStr = [NSMutableString string];
        for (int indeee = 0; indeee != number.count; indeee ++) {
            NSArray * arr = arrPinYin[indeee];
            NSNumber * strNumIndex = number[indeee];
            int strIndex = [strNumIndex intValue];
            [targetStr appendString:arr[strIndex]];
        }
        
        NSPredicate *preicate = [NSPredicate predicateWithFormat:@"firstZmName CONTAINS[c] %@ or pinyinName CONTAINS[cd] %@",targetStr,targetStr];
        NSArray * oneResut = [allresut filteredArrayUsingPredicate:preicate];
        if (oneResut.count != 0) {
            [hasResutStr addObject:targetStr];
            [arrm addObjectsFromArray:oneResut];
        }
    }
    
    return @[arrm,hasResutStr];
}
+(NSArray*)search:(NSArray *)arrmPinYin arrContacts:(NSArray<ContactModel *> *)arrContacts arrContactsSave:(NSArray *)arrContactsSave Iphone:(NSString *)iphoneNumber {
    NSArray * backValue = @[];
    if (arrmPinYin == nil || arrmPinYin.count == 0) {
        NSPredicate * preicate = [NSPredicate predicateWithFormat:@"phoneNumber CONTAINS[cd] %@",iphoneNumber];
        NSArray *arr = [arrContacts filteredArrayUsingPredicate:preicate];
        return arr;
    }else if (arrmPinYin.count == 1) {
        NSArray * arr = [self huoqujieguo:arrContactsSave first:arrmPinYin.firstObject last:nil];
        backValue = arr.firstObject;
    }else{
        NSArray * first = arrmPinYin.firstObject;
        NSArray * resuse = arrContactsSave;
        for (int index = 1; index != arrmPinYin.count; index++) {
            NSArray * arr = [self huoqujieguo:resuse first:first last:arrmPinYin[index]];
            if (index == arrmPinYin.count - 1) {
                backValue = arr.firstObject;
            }else{
                resuse = arr.firstObject;
                first = arr.lastObject;
                if (resuse.count == 0) {
                    break;
                }
            }
        }
    }
    
    NSMutableArray *arrm1 = [NSMutableArray array];
    NSMutableArray * newbackValue = [NSMutableArray array];
    [backValue enumerateObjectsUsingBlock:^(LJPerson * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![newbackValue containsObject:obj]) {
            [newbackValue addObject:obj];
            for (LJPhone *num in obj.phones) {
                ContactModel *model1 = [[ContactModel alloc]init];
                model1.phoneNumber = num.phone;
                model1.name = obj.fullName;
                model1.thumbnailImageData = obj.thumbnailImageData;
                [arrm1 addObject:model1];
            }
        }
    }];
    
    NSPredicate * preicate = [NSPredicate predicateWithFormat:@"phoneNumber CONTAINS[c] %@",iphoneNumber];
    NSArray *arr = [arrContacts filteredArrayUsingPredicate:preicate];
    [arrm1 addObjectsFromArray:arr];
    
    return arrm1;
}

@end
