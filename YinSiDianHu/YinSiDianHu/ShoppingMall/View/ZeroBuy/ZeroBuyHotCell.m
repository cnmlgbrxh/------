//
//  ZeroBuyHotCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/21.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ZeroBuyHotCell.h"

@interface ZeroBuyHotCell()
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@end

@implementation ZeroBuyHotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.buyBtn.layer.cornerRadius = 3;
    self.buyBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (IBAction)buyBtnClick:(id)sender {
}

@end
