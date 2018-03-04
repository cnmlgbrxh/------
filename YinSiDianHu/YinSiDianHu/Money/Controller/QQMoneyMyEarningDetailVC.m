//
//  QQMoneyMyEarningDetailVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/8/17.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQMoneyMyEarningDetailVC.h"
#import "QQMoneyPersonalInfoVC.h"

@interface QQMoneyMyEarningDetailVC ()
@property (weak, nonatomic) IBOutlet UIView *headBGView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headBGViewWidth;

@end

@implementation QQMoneyMyEarningDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)createUI {
    //记得传值
    self.title = @"月月高";
    self.headBGViewWidth.constant = 118*QQAdapter;
    self.headBGView.layer.cornerRadius = 118*QQAdapter/2;
    self.headBGView.layer.masksToBounds = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)nextBtnClick:(id)sender {
    WS(wSelf);
    [QQShoppingTools showAlertControllerWithTitle:@"提示" message:@"提前赎回将不在计算利息，并且若未到期，利息将被扣除！" confirmTitle:@"确认赎回" cancleTitle:@"取消" vc:self confirmBlock:^{
        QQMoneyPersonalInfoVC *vc = [[QQMoneyPersonalInfoVC alloc]initWithNibName:@"QQMoneyPersonalInfoVC" bundle:nil];
        [wSelf.navigationController pushViewController:vc animated:YES];
    } cancleBlock:^{
    }];
}

@end
