//
//  paymentMethodViewController.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/20.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "PayWayViewController.h"
#import "PaymentMethodView.h"
#import "PayWayCell.h"
#import "QQAlipayManagerTool.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "IAPManager.h"

@interface PayWayViewController ()
@property (nonatomic,strong) IAPManager *iapManager;

@end

@implementation PayWayViewController{
    PaymentMethodView *paymentMethodView;
    NSArray *arrData;
    NSInteger PayHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //背景
    UIView *alphaView = [[UIView alloc] initWithFrame:self.view.bounds];
    UIView *baseView = [[UIView alloc] initWithFrame:self.view.bounds];
    alphaView.backgroundColor = [UIColor clearColor];
    baseView.backgroundColor = [UIColor blackColor];
    baseView.alpha = 0.5;
    [self.view addSubview:baseView];
    [self.view addSubview:alphaView];
    
    if ([USERMANAGER.level isEqualToString:@"super"]) {
        PayHeight = 270;
        arrData = @[@"支付宝支付",@"微信支付",@"余额支付"];
    }else{
        PayHeight = 324;
        arrData = @[@"支付宝支付",@"微信支付",@"余额支付",@"Apple Pay"];
    }
    
    paymentMethodView = LoadViewWithNIB(@"PaymentMethodView");
    paymentMethodView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, PayHeight);
    paymentMethodView.strAmount = [NSString stringWithFormat:@"%@元",_strAmount];
    WeakSelf
    paymentMethodView.BlockClose = ^{
        [weakSelf tapGes:nil];
    };
    [alphaView addSubview:paymentMethodView];
    //点击板
    UIView *viewTap = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-PayHeight)];
    viewTap.backgroundColor = [UIColor clearColor];
    [alphaView addSubview:viewTap];
    //增加手势
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGes:)];
    tapGes.numberOfTapsRequired = 1;
    [viewTap addGestureRecognizer:tapGes];
    
    //appdelegate 传过来的支付结果
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(objectPayResult:) name:PaymentResults object:nil];
}
-(void)setStrAmount:(NSString *)strAmount{
    _strAmount = strAmount;
}
#pragma mark - 观察者方法
-(void)objectPayResult:(NSNotification *)sender{
    if ([sender.object isEqualToString:@"支付成功"]) {
        if (self.BlockClose) {
            self.BlockClose();
        }
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PaymentResults object:nil];
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0)
    {//支付宝支付
        NSDictionary *dicParameters = @{@"action":@"alipay_tc",
                                        @"username":USERNAME,
                                        @"usermoney":_strAmount
                                        };
        [DataRequest POST_TParameters:dicParameters showHUDAddedTo:self.view success:^(NSURLSessionDataTask *task, id responseObject) {
            
            [[AlipaySDK defaultService]payOrder:[responseObject objectForKey:@"sign"] fromScheme:@"AlipaySchemes" callback:^(NSDictionary *resultDic) {
                //NSLog(@"支付宝支付  %@",resultDic);
            }];
        }failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }else if (indexPath.row == 1)
    {//微信支付
        if ([WXApi isWXAppInstalled])
        {
            NSDictionary * parameters=@{@"action":@"wxpay_tc",@"username":USERNAME,@"usermoney":_strAmount};
            [DataRequest POST_TParameters:parameters showHUDAddedTo:self.view success:^(NSURLSessionDataTask *task, id responseObject) {
                //NSLog(@"微信参数:%@",responseObject);
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = [responseObject objectForKey:@"partnerid"];
                req.prepayId            = [responseObject objectForKey:@"prepayid"];
                req.nonceStr            = [responseObject objectForKey:@"noncestr"];
                
                req.timeStamp           = [[responseObject objectForKey:@"timestamp"]intValue];
                req.package             = [responseObject objectForKey:@"package"];
                req.sign                = [responseObject objectForKey:@"sign"];
                [WXApi sendReq:req];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
            }];
        }else{
            [MessageHUG showWarningAlert:@"未安装微信,安装后再试"];
        }
    }else if (indexPath.row == 2)
    {//余额支付
        NSDictionary *dicParameters = @{@"action":@"yuepay",
                                        @"username":USERNAME,
                                        @"userpass":USERPASS,
                                        @"money":_strAmount
                                        };
        [DataRequest POST_Parameters:dicParameters showHUDAddedTo:self.view success:^(NSURLSessionDataTask *task, id responseObject) {
            
            [DataManager save:@"" forKey:@"刷新用户信息"];
            [[NSNotificationCenter defaultCenter] postNotificationName:PaymentResults object:@"支付成功"];
        }failure:^(NSURLSessionDataTask *task, NSError *error) {
            [[self.view viewWithTag:66666] removeFromSuperview];
        }];
    }else if (indexPath.row == 3)
    {//内购
        if (!_iapManager) {
            _iapManager = [[IAPManager alloc]init];
        }
        
        NSString *str = @"";
        if ([_strAmount isEqualToString:@"300"]) {
            str = @"com.qiqutel.iphone_oneMonth";
        }else if ([_strAmount isEqualToString:@"800"]){
            str = @"com.qiqutel.iphone_eight";
        }else if ([_strAmount isEqualToString:@"2000"]){
            str = @"com.qiqutel.iphone_twoYear";
        }else{
            str = @"com.qiqutel.iphone_5000";
        }
        [_iapManager startPurchWithID:@"com.qiqutel.iphone_198" completeHandle:^(IAPPurchType type, NSData *data) {
            if (type != 0) {
                [[RSMBProgressHUDTool shareProgressHUDManager]showSuccessHUDWindowsWithImageName:@"QQ_no" andText:@"购买失败"];
            }else{
                [[RSMBProgressHUDTool shareProgressHUDManager]showSuccessHUDWindowsWithImageName:@"QQ_yes" andText:@"购买成功"];
                paymentMethodView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, PayHeight);
            }
        }];

    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PayWayCell *cell = LoadViewWithNIB(@"PayWayCell");
    if (cell == nil) {
        cell = [[PayWayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PayWayCell"];
    }
    cell.strAmount = _strAmount;
    cell.strName = arrData[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [UIView animateWithDuration:0.4 animations:^{
        paymentMethodView.frame = CGRectMake(0, SCREEN_H-PayHeight, SCREEN_W, PayHeight);
    }];
}
#pragma mark - 点击手势进入此方法
-(void)tapGes:(UITapGestureRecognizer *)sender{
    [UIView animateWithDuration:0.4 animations:^{
        paymentMethodView.frame = CGRectMake(0, SCREEN_H, SCREEN_W, PayHeight);
    } completion:^(BOOL finished) {
        if (self.BlockClose) {
            self.BlockClose();
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
