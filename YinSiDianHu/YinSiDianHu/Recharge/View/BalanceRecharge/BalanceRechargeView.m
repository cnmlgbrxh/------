//
//  BalanceRechargeView.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/19.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "BalanceRechargeView.h"
#import "BalanceRechargeHeadView.h"
#import "FootAlertButtonView.h"
//#import "CellPayWay.h"
#import "CellSelectPayWay.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "QQAlipayManagerTool.h"
#import <StoreKit/StoreKit.h>
#import "IAPManager.h"

@interface BalanceRechargeView ()<UITableViewDelegate,UITableViewDataSource,SKPaymentTransactionObserver,SKProductsRequestDelegate>
@property (nonatomic,strong) IAPManager *iapManager;
@end
@implementation BalanceRechargeView{
    UITableView *_tableView;
    NSArray *arrData;
    NSIndexPath *beforeIndexPath;
    BalanceRechargeHeadView *balanceRechargeHeadView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HOMECOLOR;
        //,@"银行卡支付"
        arrData = @[@"微信支付",@"支付宝支付"];
        if ([USERMANAGER.level isEqualToString:@"super"]) {
            arrData = @[@"微信支付",@"支付宝支付"];
        }else{
            arrData = @[@"微信支付",@"支付宝支付",@"Apple Pay"];
        }
        [self createUI];
        
    }
    return self;
}
-(void)setIsActive:(BOOL)isActive{
    _isActive = isActive;
    if (_isActive) {
        [balanceRechargeHeadView.textFieldAmount becomeFirstResponder];
    }else{
        [balanceRechargeHeadView.textFieldAmount resignFirstResponder];
    }
    
}
#pragma mark - 创建UI
-(void)createUI{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.x,0, SCREEN_W, self.height) style:UITableViewStyleGrouped];
    }
    _tableView.backgroundColor = HOMECOLOR;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 62;
    _tableView.scrollEnabled = NO;
    [self addSubview:_tableView];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    balanceRechargeHeadView = LoadViewWithNIB(@"BalanceRechargeHeadView");
    balanceRechargeHeadView.frame = CGRectMake(0, 0, SCREEN_W, 63);
    if ([USERMANAGER.level isEqualToString:@"super"]) {
        
    }else{
        balanceRechargeHeadView.textFieldAmount.placeholder = @"请输入充值金额：98或198元.";
    }
    _tableView.tableHeaderView = balanceRechargeHeadView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    FootAlertButtonView *footView = LoadViewWithNIB(@"FootAlertButtonView");
    footView.frame = CGRectMake(0, 0, SCREEN_W, 185);
    //余额充值成功后，可以免费打电话，可以用于购买商城物品。充值后永久有效!
    footView.strAlert = @" 余额充值成功后，可以利用余额购买小号、设置号码以及购买套餐等增值服务，还可以用于内购商城物品，余额充值后永久有效！";
    footView.strButtonTitle = @"立即充值";
    footView.BlockPayWay = ^{
        
        NSString *strAmount = balanceRechargeHeadView.textFieldAmount.text;
                
        if (![Tools isValidateNumber:strAmount])
        {
            [MessageHUG showWarningAlert:@"请输入纯数字"];
            return;
        }
        if (![USERMANAGER.level isEqualToString:@"super"]&&!([strAmount isEqualToString:@"98"]||[strAmount isEqualToString:@"198"])) {
            [MessageHUG showWarningAlert:@"请输入充值金额：98或198元"];
            return;
        }
        
        //回调支付成功显示的金额
        if (_BlockAmount)
        {
            self.BlockAmount(strAmount);
        }
        if (beforeIndexPath.row == 0)
        {//微信支付
            if ([WXApi isWXAppInstalled])
            {
                NSDictionary * parameters=@{@"action":@"wxpay_ye",@"username":USERNAME,@"usermoney":strAmount};
                [DataRequest POST_TParameters:parameters showHUDAddedTo:self success:^(NSURLSessionDataTask *task, id responseObject) {
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
        }else if (beforeIndexPath.row == 1)
        {//支付宝支付
            NSDictionary *dicParameters = @{@"action":@"alipay_ye",
                                            @"username":USERNAME,
                                            @"usermoney":strAmount
                                            };
            [DataRequest POST_TParameters:dicParameters showHUDAddedTo:self success:^(NSURLSessionDataTask *task, id responseObject) {
                
                [[AlipaySDK defaultService]payOrder:[responseObject objectForKey:@"sign"] fromScheme:@"AlipaySchemes" callback:^(NSDictionary *resultDic) {
                    //NSLog(@"支付宝支付  %@",resultDic);
                }];
            }failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            }];
        }else if (beforeIndexPath.row == 2)
        {//Apple Pay
            
            if (!_iapManager) {
                _iapManager = [[IAPManager alloc]init];
            }
            
            NSString *str = @"";
            if ([strAmount isEqualToString:@"98"]) {
                str = @"com.qiqutel.iphone_98";
            }else{
                str = @"com.qiqutel.iphone_198";
            }
                [_iapManager startPurchWithID:@"com.qiqutel.iphone_198" completeHandle:^(IAPPurchType type, NSData *data) {
                    if (type != 0) {
                        [[RSMBProgressHUDTool shareProgressHUDManager]showSuccessHUDWindowsWithImageName:@"QQ_no" andText:@"充值失败"];
                    }else{
                        [[RSMBProgressHUDTool shareProgressHUDManager]showSuccessHUDWindowsWithImageName:@"QQ_yes" andText:@"充值成功"];
                    }
                }];
        }
    };
    _tableView.tableFooterView = footView;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath == beforeIndexPath) {
        return;
    }
    
    CellSelectPayWay *cellSelect = (CellSelectPayWay *)[self viewWithTag:100+indexPath.row];
    cellSelect.isSelect = YES;
    CellSelectPayWay *cellBefore =(CellSelectPayWay *)[self viewWithTag:100+beforeIndexPath.row];
    cellBefore.isSelect = NO;
    beforeIndexPath = indexPath;
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0000000000001;
}
#pragma mark 自定组的头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *lab = [[UILabel alloc]init];
    lab.text = [NSString stringWithFormat:@"   %@", @"充值方式"];
    lab.textColor = ColorHex(0xb1b1b1);
    lab.font = [UIFont systemFontOfSize:15];
    lab.backgroundColor = HOMECOLOR;
    return lab;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CellSelectPayWay *cell = LoadViewWithNIB(@"CellSelectPayWay");
    if (cell == nil) {
        cell = [[CellSelectPayWay alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellPayWay"];
    }
    if (indexPath.row == 0) {
        cell.isSelect = YES;
        beforeIndexPath = indexPath;
    }
    cell.tag = 100+indexPath.row;
    cell.strName = arrData[indexPath.row];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}
@end
