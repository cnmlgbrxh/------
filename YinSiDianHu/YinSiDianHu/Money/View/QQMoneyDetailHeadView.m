//
//  QQMoneyDetailHeadView.m
//  YinSiDianHu
//
//  Created by songdan on 2017/8/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQMoneyDetailHeadView.h"
#import "QQShoppingTools.h"
@interface QQMoneyDetailHeadView()
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UIView *timeView;//投资期限的背景view
@property (weak, nonatomic) IBOutlet UILabel *midLabel;//体验专区的起投金额
@property (weak, nonatomic) IBOutlet UIView *progressBGView;//进度的背景view
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressBGViewHeight;//进度背景view的高度
@property (weak, nonatomic) IBOutlet UILabel *giftLabel;//赠礼
@property (weak, nonatomic) IBOutlet UILabel *accrualTimeLabel;//计息日期
@property (weak, nonatomic) IBOutlet UILabel *expireTimeLabel;//到期日期
@property (weak, nonatomic) IBOutlet UILabel *getTypeLabel;//领取方式
@property (weak, nonatomic) IBOutlet UILabel *buyTypeLabel;//购买方式
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *giftLabelHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *giftLabelTop;


@end
@implementation QQMoneyDetailHeadView
- (void)setModel:(QQMoneyListProductDetailModel *)model {
//    _model = model;
//    NSString *temp = @"%";
//    self.rateLabel.attributedText = [Tools LabelStr:[NSString stringWithFormat:@"%.2f%@",[model.pro_rate floatValue],temp] changeStr:temp color:nil font:[UIFont systemFontOfSize:13]];
//    if (model.isExperience) {
//        //体验专区
//        self.timeView.hidden = YES;
//        self.midLabel.hidden = NO;
//        NSString *str = [NSString stringWithFormat:@"起投金额 %@元",model.pro_price];
//        self.midLabel.attributedText = [Tools LabelStr:str changeStr:model.pro_price color:[UIColor colorWithHexString:@"f5f5f5"] font:nil];
//    }else{
//        self.midLabel.hidden = YES;
//        self.timeView.hidden = NO;
//    }
//    if ([model.pro_gift isEqualToString:@""]) {
//        self.giftLabelTop.constant = 0;
//    }
//    self.giftLabelHeight.constant = [[QQShoppingTools shareInstance] calculateRowHeight:model.pro_gift fontSize:13 bgViewWidth:SCREEN_W-20];
//    self.giftLabel.text = model.pro_gift;
//    self.accrualTimeLabel.text = model.accrual_time;
//    self.expireTimeLabel.text = model.expire;
//    self.getTypeLabel.text = model.cash_type;
//    self.buyTypeLabel.text = model.remit_type;
}

@end





















