//
//  IAPManager.m
//  YinSiDianHu
//
//  Created by songdan on 2017/8/16.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "IAPManager.h"
#import <StoreKit/StoreKit.h>

@interface IAPManager()<SKPaymentTransactionObserver,SKProductsRequestDelegate>
@property (nonatomic,strong) NSString *purchID;
@property (nonnull,strong) IAPCompletionHandle handle;
@end
@implementation IAPManager
- (instancetype)init{ self = [super init];
    if (self) {
        // 购买监听写在程序入口,程序挂起时移除监听,这样如果有未完成的订单将会自动执行并回调 paymentQueue:updatedTransactions:方法
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}

- (void)dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

- (void)startPurchWithID:(NSString *)purchID completeHandle:(IAPCompletionHandle)handle{
    if (purchID) {
        if ([SKPaymentQueue canMakePayments]) {
            // 开始购买服务
            self.purchID = purchID;
            self.handle = handle;
            NSSet *nsset = [NSSet setWithArray:@[purchID]];
            SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
            request.delegate = self;
            [request start];
        }else{
            [self handleActionWithType:kIAPPurchNotArrow data:nil];
        }
    }
}

- (void)handleActionWithType:(IAPPurchType)type data:(NSData *)data{
#if DEBUG
    switch (type) {
        case kIAPPurchSuccess: NSLog(@"购买成功");
            break;
        case kIAPPurchFailed: NSLog(@"购买失败");
            break;
        case kIAPPurchCancle: NSLog(@"用户取消购买");
            break;
        case KIAPPurchVerFailed: NSLog(@"订单校验失败");
            break;
        case KIAPPurchVerSuccess: NSLog(@"订单校验成功");
            break;
        case kIAPPurchNotArrow: NSLog(@"不允许程序内付费");
            break;
        default: break; }
#endif
    if(self.handle){
        self.handle(type,data);
    }
}

// 交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    [self verifyPurchaseWithPaymentTransaction:transaction isTestServer:NO];
}

// 交易失败
- (void)failedTransaction:(SKPaymentTransaction *)transaction{
    if (transaction.error.code != SKErrorPaymentCancelled) {
        [self handleActionWithType:kIAPPurchFailed data:nil];
    }else{
        [self handleActionWithType:kIAPPurchCancle data:nil];
    }
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}


- (void)verifyPurchaseWithPaymentTransaction:(SKPaymentTransaction *)transaction isTestServer:(BOOL)flag{
    //交易验证
    NSURL *recepitURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receipt = [NSData dataWithContentsOfURL:recepitURL];
    if(!receipt){
        // 交易凭证为空验证失败
        [self handleActionWithType:KIAPPurchVerFailed data:nil];
        return;
    }
    // 购买成功将交易凭证发送给服务端进行再次校验
    [self handleActionWithType:kIAPPurchSuccess data:receipt];
    NSError *error;
    NSDictionary *requestContents = @{ @"receipt-data": [receipt base64EncodedStringWithOptions:0] };
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestContents options:0 error:&error];
    if (!requestData) {
        // 交易凭证为空验证失败
        [self handleActionWithType:KIAPPurchVerFailed data:nil];
        return; }
    //In the test environment, use https://sandbox.itunes.apple.com/verifyReceipt
    //In the real environment, use https://buy.itunes.apple.com/verifyReceipt
    NSString *serverString = @"https://buy.itunes.apple.com/verifyReceipt";
    if (flag) {
        serverString = @"https://sandbox.itunes.apple.com/verifyReceipt";
    }
    NSURL *storeURL = [NSURL URLWithString:serverString];
    NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:storeURL];
    [storeRequest setHTTPMethod:@"POST"];
    [storeRequest setHTTPBody:requestData];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:storeRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            // 无法连接服务器,购买校验失败
            [self handleActionWithType:KIAPPurchVerFailed data:nil];
        } else {
            NSError *error;
            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (!jsonResponse) {
                // 苹果服务器校验数据返回为空校验失败
                [self handleActionWithType:KIAPPurchVerFailed data:nil];
            }
            // 先验证正式服务器,如果正式服务器返回21007再去苹果测试服务器验证,沙盒测试环境苹果用的是测试服务器
            NSString *status = [NSString stringWithFormat:@"%@",jsonResponse[@"status"]];
            if (status && [status isEqualToString:@"21007"]) {
                [self verifyPurchaseWithPaymentTransaction:transaction isTestServer:YES];
            }else if(status && [status isEqualToString:@"0"]){
                [self handleActionWithType:KIAPPurchVerSuccess data:nil];
            }
#if DEBUG
            NSLog(@"----验证结果 %@",jsonResponse);
#endif
        }
    }];
    // 验证成功与否都注销交易,否则会出现虚假凭证信息一直验证不通过,每次进程序都得输入苹果账号
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    NSArray *product = response.products;
    if([product count] <= 0){
#if DEBUG
        NSLog(@"--------------没有商品------------------");
#endif
        return;
    }
    SKProduct *p = nil;
    for(SKProduct *pro in product){
        if([pro.productIdentifier isEqualToString:self.purchID]){
            p = pro;
            break;
        }
    }
#if DEBUG
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%lu",(unsigned long)[product count]);
    NSLog(@"%@",[p description]);
    NSLog(@"%@",[p localizedTitle]);
    NSLog(@"%@",[p localizedDescription]);
    NSLog(@"%@",[p price]);
    NSLog(@"%@",[p productIdentifier]);
    NSLog(@"发送购买请求");
#endif
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}
//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
#if DEBUG
    NSLog(@"------------------错误-----------------:%@", error);
#endif
}
- (void)requestDidFinish:(SKRequest *)request{
#if DEBUG
    NSLog(@"------------反馈信息结束-----------------");
#endif
}
#pragma mark - SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions{
    for (SKPaymentTransaction *tran in transactions) {
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:tran];
                break;
            case SKPaymentTransactionStatePurchasing:
#if DEBUG
                NSLog(@"商品添加进列表");
#endif
                break;
            case SKPaymentTransactionStateRestored:
#if DEBUG
                NSLog(@"已经购买过商品");
#endif
                // 消耗型不支持恢复购买
            [[SKPaymentQueue defaultQueue] finishTransaction:tran];
            break;
            case SKPaymentTransactionStateFailed:
            [self failedTransaction:tran];
            break;
            default: break;
        }
    }
}


@end
