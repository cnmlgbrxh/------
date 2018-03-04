//
//  QQMoneyPersonalInfoVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/8/17.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQMoneyPersonalInfoVC.h"

@interface QQMoneyPersonalInfoVC ()

@end

@implementation QQMoneyPersonalInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)createUI {
    self.title = @"我的增益";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)nextBtnClick:(id)sender {
    [QQShoppingTools showAlertControllerWithTitle:@"" message:@"申请赎回成功，请耐心等待！" confirmTitle:@"确认" cancleTitle:nil vc:self confirmBlock:^{

    } cancleBlock:^{
        
    }];
}
@end
