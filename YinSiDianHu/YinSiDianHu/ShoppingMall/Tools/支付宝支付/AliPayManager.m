//
//  AliPayManager.m
//  LittleDoctor
//
//  Created by jianglei on 15/9/2.
//  Copyright (c) 2015年 XiaoShenYi. All rights reserved.
//

#import "AliPayManager.h"
#import "HYBNetworking.h"
#import "RSWebServiceURL.h"
#import "RSMBProgressHUDTool.h"

@implementation AliPayManager

/*
 支付宝管理单例类
 */
+ (instancetype)sharedInstance{

    static AliPayManager *manager =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager =[[AliPayManager alloc]init];
    });

    return manager;
}

//清除订单信息
- (void)clean
{
    self.tradeNO = nil;
    self.productName = nil;
    self.productDescription = nil;
    self.amount = nil;
}

//初始化订单信息
- (void)initWithTradeNO:(NSString *)tradeNO productName:(NSString *)productName productDescription:(NSString *)productDescription amount:(NSString *)amount
{
    self.tradeNO = tradeNO;
    self.productName = productName;
    self.productDescription = productDescription;
    self.amount = amount;
}

//支付签名调用
- (void)alipayRequest
{
     //生成订单信息及签名
     //由于demo的局限性，采用了将私钥放在本地签名的方法，商户可以根据自身情况选择签名方法(为安全起见，在条件允许的前提下，我们推荐从商户服务器获取完整的订单信息)
 
        NSString *appScheme = AlipaySchemeType;
        NSString* orderInfo = [self getOrderInfo];
        NSString* signedStr = [self doRsa:orderInfo];
        
        //将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = nil;
        
        if (signedStr != nil) {
            orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                           orderInfo, signedStr, @"RSA"];
            
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                
                NSLog(@"--11111-支付宝支付返回数据-------%@",resultDic);
                //取出支付结果
                
                NSString *resultStatus =[resultDic objectForKey:@"resultStatus"];
                //支付结果状态码
                if (resultStatus&&[resultStatus intValue]==9000) {
                    
                    NSLog(@"----111111---支付宝支付成功");
                    
                    if (self.paySuccess) {
                        
                        self.paySuccess(YES);
                    }
                    
                }else if (resultStatus&&[resultStatus intValue]==6001){
                    
                    if (self.paySuccess) {
                        
                        self.paySuccess(NO);
                    }
                    
                }
            }];
            
        }
    
  }

#pragma mark ============================支付宝配置接口=========================================
#pragma mark - Private Methods
-(NSString*)getOrderInfo
{
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    AliPayOrder *order = [[AliPayOrder alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    order.tradeNO = self.tradeNO; //订单ID（由商家自行制定）
    order.productName = self.productName; //商品标题
    order.productDescription = self.productDescription; //商品描述
    order.amount = self.amount; //商品价格
//    order.appID = @"2017051807274060";
    order.notifyURL = AliPayNotifyURL ; //回调URL
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    return [order description];
}


#pragma mark---生成订单签名
-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}


#pragma mark----客服端回调
- (void)parse:(NSURL *)url application:(UIApplication *)application{
    
    [[AlipaySDK defaultService]processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        
        //取出支付结果
        NSString *resultStatus =[resultDic objectForKey:@"resultStatus"];
        
        //支付结果状态码
        if (resultStatus&&[resultStatus intValue]==9000) {
            
            //支付成功、清除订单信息
            [self clean];
            
            if (self.paySuccess) {
                
                self.paySuccess(YES);
            }
        }else if (resultStatus&&[resultStatus intValue]==6001){
            
            if (self.paySuccess) {
                
                self.paySuccess(NO);
            }
            
        }
        
    }];
    
}

@end
