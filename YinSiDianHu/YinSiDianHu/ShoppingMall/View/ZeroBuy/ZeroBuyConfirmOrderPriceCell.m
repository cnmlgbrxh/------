//
//  ZeroBuyConfirmOrderPriceCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/28.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ZeroBuyConfirmOrderPriceCell.h"
@interface ZeroBuyConfirmOrderPriceCell()
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@end

@implementation ZeroBuyConfirmOrderPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.selectBtn setImage:QQIMAGE(@"shopping_Checked") forState:UIControlStateSelected];
    [self.selectBtn setImage:QQIMAGE(@"shopping_Unchecked") forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)selectBtnClick:(id)sender {
    self.selectBtn.selected = !self.selectBtn.isSelected;
    if (self.zero_confirmPriceBlock) {
        self.zero_confirmPriceBlock(@"11");
    }
}

@end
