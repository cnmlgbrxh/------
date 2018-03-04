//
//  QQShoppingExchangeStyesVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingExchangeStyesVC.h"
#import "QQShoppingExchangeRedpacketVC.h"

@interface QQShoppingExchangeStyesVC ()
@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;
@property (weak, nonatomic) IBOutlet UIButton *topBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (assign,nonatomic)BOOL isZhifubao;
@property (weak, nonatomic) IBOutlet UILabel *countNumLabel;
@end

@implementation QQShoppingExchangeStyesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"积分商城";
    self.nextBtn.layer.cornerRadius = 3;
    self.nextBtn.layer.masksToBounds = YES;
    self.isZhifubao = YES;
    self.countNumLabel.attributedText = [Tools LabelStr:@"2000分" changeStr:@"2000" color:[Tools getUIColorFromString:@"ed4044"] font:[UIFont systemFontOfSize:17]];
}

- (IBAction)topBtnClick:(id)sender {
    [self.topBtn setImage:QQIMAGE(@"shopping_exchecked") forState:UIControlStateNormal];
    [self.bottomBtn setImage:QQIMAGE(@"shopping_checkednomal") forState:UIControlStateNormal];
    self.isZhifubao = YES;
}

- (IBAction)bottomBtnClick:(id)sender {
    [self.bottomBtn setImage:QQIMAGE(@"shopping_exchecked") forState:UIControlStateNormal];
    [self.topBtn setImage:QQIMAGE(@"shopping_checkednomal") forState:UIControlStateNormal];
    self.isZhifubao = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)nextBtnClick:(id)sender {
    QQShoppingExchangeRedpacketVC *vc = [[QQShoppingExchangeRedpacketVC alloc]initWithNibName:@"QQShoppingExchangeRedpacketVC" bundle:[NSBundle mainBundle]];
    vc.zhifubao = self.isZhifubao;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
