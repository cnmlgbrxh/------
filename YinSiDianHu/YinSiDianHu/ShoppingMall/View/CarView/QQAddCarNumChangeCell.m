//
//  QQAddCarNumChangeCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/12.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQAddCarNumChangeCell.h"
@interface QQAddCarNumChangeCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@end
@implementation QQAddCarNumChangeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.borderColor = [Tools getUIColorFromString:@"b9b9b9"].CGColor;
}

- (IBAction)reduceBtnClick:(id)sender {
    if ([self.numBtn.titleLabel.text integerValue]<=2) {
        [self.reduceBtn setImage:QQIMAGE(@"shopping_reduce_nomal") forState:UIControlStateNormal];
        [self.numBtn setTitle:@"1" forState:UIControlStateNormal];
    }else{
        NSInteger num = [self.numBtn.titleLabel.text integerValue]-1;
        [self.numBtn setTitle:[NSString stringWithFormat:@"%ld",num] forState:UIControlStateNormal];
    }
    if (self.shopping_addCarNumBlock) {
        self.shopping_addCarNumBlock(self.numBtn.titleLabel.text);
    }
}

- (IBAction)addBtnClick:(id)sender {
    if ([self.numBtn.titleLabel.text isEqualToString:@"1"]) {
        [self.reduceBtn setImage:QQIMAGE(@"shopping_reduce") forState:UIControlStateNormal];
    }
    NSInteger num = [self.numBtn.titleLabel.text integerValue]+1;
    [self.numBtn setTitle:[NSString stringWithFormat:@"%ld",num] forState:UIControlStateNormal];
    if (self.shopping_addCarNumBlock) {
        self.shopping_addCarNumBlock(self.numBtn.titleLabel.text);
    }
}

@end
