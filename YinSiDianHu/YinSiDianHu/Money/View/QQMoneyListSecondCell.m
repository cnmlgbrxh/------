//
//  QQMoneyListSecondCell.m
//  YinSiDianHu
//
//  Created by songdan on 2017/8/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQMoneyListSecondCell.h"
#import "QQShoppingTools.h"

@interface QQMoneyListSecondCell()
@property (weak, nonatomic) IBOutlet UIView *planBgView;
@property (weak, nonatomic) IBOutlet UIView *planView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *overLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *overLabelLeft;

@end
@implementation QQMoneyListSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.planBgView.layer.cornerRadius = 1.5;
    self.planBgView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(QQMoneyListProductDetailModel *)model {
    _model = model;
    self.nameLabel.text = model.pro_name;
    NSString *temp = @"%";
    self.rateLabel.attributedText = [Tools LabelStr:[NSString stringWithFormat:@"%.2f%@",[model.pro_rate floatValue],temp] changeStr:temp color:nil font:[UIFont systemFontOfSize:13]];
    self.timeLabel.attributedText = [Tools LabelStr:[NSString stringWithFormat:@"%@",model.deadline] changeStr:@"天" color:nil font:[UIFont systemFontOfSize:13] ];
    
    
    CGFloat value = [model.pro_all_price floatValue] - [model.pro_ove_price floatValue];
    NSString *t = @"%";
    //比例
    CGFloat scale = value/[model.pro_all_price floatValue];
    self.overLabel.text = [NSString stringWithFormat:@"%.2f%@",scale*100,t];
    
    CGFloat width = (SCREEN_W-20)*scale;
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10],NSFontAttributeName, nil];
    CGSize titleSize = [self.overLabel.text sizeWithAttributes:dic];
    if (SCREEN_W-width-20-3 < titleSize.width) {
        self.overLabelLeft.constant = -titleSize.width;
    }else{
        self.overLabelLeft.constant = 3;
    }
    self.progressViewWidth.constant = (SCREEN_W-20)*scale;

}
@end
