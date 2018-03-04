//
//  ZeroBuyAwardRecordCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/24.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "ZeroBuyAwardRecordCell.h"

@interface ZeroBuyAwardRecordCell()
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@end
@implementation ZeroBuyAwardRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.buyBtn.layer.cornerRadius = 3;
    self.buyBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
