//
//  ZeroBuyChooseNumView.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/24.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ZeroBuyChooseNumView.h"
@interface ZeroBuyChooseNumView()
@property (weak, nonatomic) IBOutlet UIButton *left1Label;
@property (weak, nonatomic) IBOutlet UIButton *left2Label;
@property (weak, nonatomic) IBOutlet UIButton *left3Label;
@property (weak, nonatomic) IBOutlet UIButton *left4Label;
@property (strong,nonatomic) UIButton *tempBtn;
@property (weak, nonatomic) IBOutlet UIView *numBgView;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@end

@implementation ZeroBuyChooseNumView
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setBtn:self.left1Label];
    [self setBtn:self.left2Label];
    [self setBtn:self.left3Label];
    [self setBtn:self.left4Label];
    self.left4Label.selected = YES;
    self.tempBtn = self.left4Label;
    self.numBgView.layer.borderWidth = 1;
    self.numBgView.layer.cornerRadius = 4;
    self.numBgView.layer.masksToBounds = YES;
    self.numBgView.borderColor = [Tools getUIColorFromString:@"e0dfdf"];
}

- (void)setBtn:(UIButton *)btn {
    btn.layer.cornerRadius = 3;
    btn.layer.borderWidth=0.5;
    btn.layer.borderColor =btn==self.left4Label? [Tools getUIColorFromString:@"ed4044"].CGColor: [Tools getUIColorFromString:@"e0dfdf"].CGColor;
    [btn setTitleColor:[Tools getUIColorFromString:@"3f3f3f"] forState:UIControlStateNormal];
    [btn setTitleColor:[Tools getUIColorFromString:@"ed4044"] forState:UIControlStateSelected];
}
- (IBAction)addNumBtnClick:(id)sender {
    NSInteger num = [self.numLabel.text integerValue];
    self.numLabel.text = [NSString stringWithFormat:@"%ld",++num];
}
- (IBAction)reduceBtnClick:(id)sender {
    NSInteger num = [self.numLabel.text integerValue];
    self.numLabel.text = num == 1?@"1":[NSString stringWithFormat:@"%ld",--num];
}

- (IBAction)buyBtnClick:(id)sender {
    [self hidden];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.zero_buyBtnClickBlock) {
            self.zero_buyBtnClickBlock();
        }
    });
}

- (IBAction)grayBtnClick:(id)sender {
    [self hidden];
}

- (void)hidden {
    self.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
    self.greyView.frame = CGRectMake(0, 0, SCREEN_W, self.greyView.height);
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, SCREEN_H, SCREEN_W, SCREEN_H-64);
        self.greyView.frame = CGRectMake(0,-SCREEN_H, SCREEN_W, self.greyView.height);
        self.greyView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (IBAction)left1BtnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    btn.selected = YES;
    btn.layer.borderColor = [Tools getUIColorFromString:@"ed4044"].CGColor;
    self.tempBtn.selected = NO;
    self.tempBtn.layer.borderColor = [Tools getUIColorFromString:@"e0dfdf"].CGColor;
    self.tempBtn = btn;
    
    if (![btn.titleLabel.text isEqualToString:@"包尾"]) {
        self.numLabel.text = btn.titleLabel.text;
    }
}

@end
