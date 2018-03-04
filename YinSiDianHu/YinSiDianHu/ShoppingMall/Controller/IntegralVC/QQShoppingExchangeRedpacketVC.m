//
//  QQShoppingExchangeRedpacketVC.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//红包体现到银行卡或者支付宝页面

#import "QQShoppingExchangeRedpacketVC.h"

@interface QQShoppingExchangeRedpacketVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *leftIamgeBtn;
@property (weak, nonatomic) IBOutlet UILabel *rightTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *cardNumView;//卡号View
@property (weak, nonatomic) IBOutlet UIView *peopleView;//持卡人view
@property (weak, nonatomic) IBOutlet UILabel *huhangLabel;//户行
@property (weak, nonatomic) IBOutlet UITextField *huhangTextField;//开户银行
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;//支开户行名称
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation QQShoppingExchangeRedpacketVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)resetView {
    if (self.zhifubao) {
        self.bgViewHeight.constant = 104;
        [self.leftIamgeBtn setImage:QQIMAGE(@"shopping_zfb") forState:UIControlStateNormal];
        self.rightTitleLabel.text = @"支付宝";
        self.cardNumView.hidden = YES;
        self.peopleView.hidden = YES;
        self.huhangLabel.text = @"账户";
        self.huhangTextField.placeholder = @"请输入您的支付宝账户";
        self.nameTextField.placeholder = @"请输入您的支付宝名称";
    }
    self.nextBtn.layer.cornerRadius = 3;
    self.nextBtn.layer.masksToBounds = YES;
    self.timeLabel.attributedText = [Tools LabelStr:@"预计到账时间:2017-4-28 24:00" changeStr:@"预计到账时间" color:[Tools getUIColorFromString:@"9b9b9b"] font:nil];

}

- (void)createUI {
    self.title = @"积分商城";
    [self resetView];
}
- (IBAction)naxtBtnClick:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
