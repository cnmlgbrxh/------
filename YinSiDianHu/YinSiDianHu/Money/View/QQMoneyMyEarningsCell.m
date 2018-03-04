//
//  QQMoneyMyEarningsCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/8/17.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQMoneyMyEarningsCell.h"

@interface QQMoneyMyEarningsCell()
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *getBtn;
@property (weak, nonatomic) IBOutlet UIView *proView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *proViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *proViewHeight;
@property (weak, nonatomic) IBOutlet UIView *btnBGView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnBGViewTop;
@property (weak, nonatomic) IBOutlet UILabel *explainLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnBGViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnBGViewBottom;

@end
@implementation QQMoneyMyEarningsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backBtn.layer.cornerRadius = 3;
    self.backBtn.layer.masksToBounds = YES;
    self.getBtn.layer.cornerRadius = 3;
    self.getBtn.layer.borderWidth = 0.5;
    self.getBtn.layer.borderColor = [UIColor colorWithHexString:@"4d4d4d"].CGColor;
    self.getBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setRow:(NSInteger)row {
    _row = row;
    if (row == 0) {
        self.proView.hidden = YES;
        self.proViewTop.constant = 0;
        self.proViewHeight.constant = 0;
        
        self.explainLabel.hidden = YES;
        
        self.btnBGView.hidden = NO;
        self.btnBGViewHeight.constant = 39;
        self.btnBGViewBottom.constant = 14;
    }else if (row == 1) {
        self.proView.hidden = NO;
        self.proViewTop.constant = 20;
        self.proViewHeight.constant = 17;

        self.getBtn.hidden = YES;
        self.backBtn.hidden = YES;
        self.btnBGViewHeight.constant = 17;
        self.btnBGViewBottom.constant = 18;
        self.explainLabel.hidden = NO;
    }else{
        self.proView.hidden = NO;
        self.proViewTop.constant = 20;
        self.proViewHeight.constant = 17;
        
        self.btnBGView.hidden = NO;
        self.btnBGViewHeight.constant = 39;
        self.btnBGViewBottom.constant = 14;
        self.explainLabel.hidden = YES;
    }
}
@end
