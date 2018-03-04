//
//  QQShoppingJifenListCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/17.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingJifenListCell.h"
@interface QQShoppingJifenListCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@end

@implementation QQShoppingJifenListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setModel:(QQIntegConsumeDetailModel *)model {
    _model = model;
    self.nameLabel.text = model.con_type;
    self.timeLabel.text = model.con_data;
    self.countLabel.text = model.con_point;
}
@end
