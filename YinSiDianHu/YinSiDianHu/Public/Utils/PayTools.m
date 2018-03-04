//
//  PayTools.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/27.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "PayTools.h"
#import "PaySuccessViewController.h"
#import "PayfailureViewController.h"
#import "AliPayManager.h"
@implementation PayTools

+(instancetype)sharedInstance {
    static PayTools *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[PayTools alloc]init];
    });
    return tool;
}

-(void)paymentMethod:(PaymentMethod )paymentMethod parameters:(id _Nullable )parameters currentController:(UIViewController *_Nullable)controller object:(nullable id)anObject{
    if (paymentMethod == ZhiFuBaoMethod)
    {
        [[AliPayManager sharedInstance]initWithTradeNO:parameters productName:[anObject objectForKey:@"action"] productDescription:[anObject objectForKey:@"action"] amount:[anObject objectForKey:@"price"]];
        [[AliPayManager sharedInstance] alipayRequest];
        //调用支付宝网页支付 成功的回调
        [AliPayManager sharedInstance].paySuccess = ^(BOOL success){
            if (success)
            {  //支付成功
                PaySuccessViewController *paySuccessVC =[[PaySuccessViewController alloc]init];
                [controller.navigationController pushViewController:paySuccessVC animated:YES];
            }else{
                PayfailureViewController *payfailureVC =[[PayfailureViewController alloc]init];
                [controller.navigationController pushViewController:payfailureVC animated:YES];
            }
        };
    }
}
//- (void)methodOfAliPay:(NSString *)orderNum productName:(NSString *)productName price:(NSString *)price{
//    WS(wSelf);
//    [[AliPayManager sharedInstance]initWithTradeNO:orderNum productName:productName productDescription:productName amount:@"0.01"];
//    [[AliPayManager sharedInstance] alipayRequest];
//    //调用支付宝网页支付 成功的回调
//    [AliPayManager sharedInstance].paySuccess = ^(BOOL success){
//        if (success) {  //支付成功
//            [[AliPayManager sharedInstance]clean];
//            [[NSNotificationCenter defaultCenter]postNotificationName:PaymentResults object:nil];
//            if (wSelf.shopping_alipayBlock) {
//                wSelf.shopping_alipayBlock();
//            }
//        }else{
//            [[RSMBProgressHUDTool shareProgressHUDManager]showWindowExplainHUD:[UIApplication sharedApplication].keyWindow showText:@"支付失败！"];
//        }
//    };
//}
@end
