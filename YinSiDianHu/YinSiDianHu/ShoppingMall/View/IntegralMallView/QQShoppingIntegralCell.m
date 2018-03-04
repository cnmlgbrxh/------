//
//  QQShoppingIntegralCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/7/6.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQShoppingIntegralCell.h"

@interface QQShoppingIntegralCell()
@property (weak, nonatomic) IBOutlet UILabel *integralPriceLabel;//需要的积分
@property (weak, nonatomic) IBOutlet UILabel *countLabel;//剩余数量
@property (weak, nonatomic) IBOutlet UIImageView *producImageView;
@property (weak, nonatomic) IBOutlet UIView *sellAllView;
@property (weak, nonatomic) IBOutlet UILabel *marketPrice;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
@implementation QQShoppingIntegralCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.sellAllView.layer.cornerRadius = 82/2;
    self.sellAllView.layer.masksToBounds = YES;
}

- (void)setModel:(QQIntegListModel *)model {
    _model = model;
    self.integralPriceLabel.attributedText = [Tools LabelStr:[NSString stringWithFormat:@"%@ 积分",model.producting]changeStr:model.producting color:[UIColor redColor] font:[UIFont systemFontOfSize:18]];
    self.countLabel.attributedText = [Tools LabelStr:[NSString stringWithFormat:@"最后 %@ 件",model.productAmount]changeStr:model.productAmount color:[UIColor redColor] font:nil];
    [self.producImageView sd_setImageWithURL:[NSURL URLWithString:model.productPic] placeholderImage:QQIMAGE(@"shopping_placeHolderImage")];
    NSInteger num = [model.productAmount integerValue];
    self.sellAllView.hidden = num == 0?NO:YES;
    self.marketPrice.text = [NSString stringWithFormat:@"￥%@",model.productMarket];
    self.nameLabel.text = model.productName;
}
@end
