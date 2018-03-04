//
//  QQMoneyConfirmCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/8/15.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQMoneyConfirmCell.h"
@interface QQMoneyConfirmCell()
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet UIImageView *payImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@end

@implementation QQMoneyConfirmCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(QQMoneyConfimPayModel *)model {
    _model = model;
    self.selectImageView.image = model.isSelect?QQIMAGE(@"SelectButton"):QQIMAGE(@"NormalButton");
    self.payImageView.image = QQIMAGE(model.imageName);
    self.nameLabel.text = model.titleName;
    self.detailLabel.text = model.detailName;
}

@end
