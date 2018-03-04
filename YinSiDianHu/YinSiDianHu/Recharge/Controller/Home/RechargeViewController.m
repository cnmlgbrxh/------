//
//  RechargeViewController.m
//  YinSiDianHu
//
//  Created by Apple on 2017/6/9.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "RechargeViewController.h"
#import "PaySuccessViewController.h"
#import "RechargeView.h"
@interface RechargeViewController ()

@property (copy,nonatomic) NSString *strPayAmount;

@end

@implementation RechargeViewController{
    RechargeView *view;
    BOOL isAppear;//避免其他界面支付成功,做异常处理.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WHITECOLOR;
    
    //appdelegate 传过来的支付结果
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(objectPayResult:) name:PaymentResults object:nil];
    
    [self loadUI];
}
#pragma mark - 观察者方法
-(void)objectPayResult:(NSNotification *)sender{
    if ([sender.object isEqualToString:@"支付成功"]&&isAppear) {
        PaySuccessViewController *paySuccessVC =[[PaySuccessViewController alloc]init];
        paySuccessVC.strAmount = _strPayAmount;
        paySuccessVC.navTitle = @"充值中心";
        [self.navigationController pushViewController:paySuccessVC animated:YES];
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:PaymentResults object:nil];
}
#pragma mark - 创建UI
-(void)loadUI{
    if (!view) {
        view = [[RechargeView alloc]initWithFrame:self.view.frame];
    }
    view.viewController = self;
    WeakSelf
    view.BlockAmount = ^(NSString *str) {
        weakSelf.strPayAmount = str;
    };
    [self.view addSubview:view];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    isAppear = YES;
    if ([USERMANAGER.level isEqualToString:@"super"]) {
        view.intArc4random = arc4random() % 2;
    }else{
        view.intArc4random = 0;
    }
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    isAppear = NO;
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
