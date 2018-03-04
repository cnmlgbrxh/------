//
//  QQAlipayManagerTool.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/26.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQAlipayManagerTool.h"
#import <HYBNetworking/HYBNetworking.h>
#import "RSWebServiceURL.h"
#import "AliPayManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import <WXApi.h>
#import "NSString+Custom.h"


@implementation QQAlipayManagerTool
+(instancetype)sharedInstance {
    static QQAlipayManagerTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[QQAlipayManagerTool alloc]init];
    });
    return tool;
}

- (void)shoppingAlipayWithURLStr:(NSString *)urlStr productName:(NSString *)productName Price:(NSString *)price{
    WS(wSelf);
    NSString *utf8 = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"支付宝支付的url --- %@            %@",QQ_API_CON(urlStr),QQ_API_CON(utf8));
    [HYBNetworking getWithUrl:QQ_API_CON(utf8) refreshCache:YES success:^(id response) {
        NSLog(@"支付宝支付订单编号以及签名 ------ %@",response);
        if ([response[@"sign"] isMemberOfClass:[NSNull class]] ) {
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_warning" andText:@"支付失败"];
            return ;
        }
        if (response[@"sign"]) {
            [wSelf shoppingAlipayWithsign:response[@"sign"]];
        }else{
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:@"支付失败"];
        }
    } fail:^(NSError *error) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
}

- (void)shoppingAlipayWithsign:(NSString *)sign {
    [[AlipaySDK defaultService ]payOrder:sign fromScheme:AlipaySchemeType callback:^(NSDictionary *resultDic) {
        NSLog(@"支付宝支付返回结果:  %@",resultDic);
        NSString *resultStatus =[resultDic objectForKey:@"resultStatus"];
        if (resultStatus&&[resultStatus intValue]==9000) {
            [DataManager save:@"" forKey:@"刷新用户信息"];
            [[NSNotificationCenter defaultCenter]postNotificationName:APPAlipayNotification object:@"支付成功"];
        }else if ((resultStatus&&[resultStatus intValue]==6001) || (resultStatus&&[resultStatus intValue]==6002)|| (resultStatus&&[resultStatus intValue]==4000))
        {
            [[NSNotificationCenter defaultCenter]postNotificationName:APPAlipayDEF object:@"支付失败"];
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:@"支付失败"];
        }
    }];
}


- (void)wechatPay:(NSString *)url {
    if (![WXApi isWXAppInstalled]) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_warning" andText:@"请先安装微信"];
        return;
    }
    NSString *utf8 = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",QQ_API_CON(utf8));
    [HYBNetworking getWithUrl:QQ_API_CON(utf8) refreshCache:YES success:^(id response) {
        if (response[@"msg"]) {
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:response[@"msg"]];
            return ;
        }
        NSLog(@"%@",response);
        NSString *partnerid = [response objectForKey:@"partnerid"];
        NSString *prepayid = [response objectForKey:@"prepayid"];
        if ([partnerid isMemberOfClass:[NSNull class]] || [prepayid isMemberOfClass:[NSNull class]]) {
            [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_warning" andText:@"非常抱歉、请选择其他方式支付"];
            return ;
        }
        PayReq* req             = [[PayReq alloc] init];
        req.partnerId           = [partnerid isMemberOfClass:[NSNull class]]?@"":partnerid;
        req.prepayId            = [prepayid isMemberOfClass:[NSNull class]]?@"":prepayid;
        req.nonceStr            = [response objectForKey:@"noncestr"];
        req.timeStamp           = [[response objectForKey:@"timestamp"]intValue];
        req.package             = [response objectForKey:@"package"];
        req.sign                = [response objectForKey:@"sign"];
        [WXApi sendReq:req];
        
    } fail:^(NSError *error) {
        [[RSMBProgressHUDTool shareProgressHUDManager] showSuccessHUDWindowsWithImageName:@"QQ_no" andText:error.localizedDescription];
    }];
    
}
@end
