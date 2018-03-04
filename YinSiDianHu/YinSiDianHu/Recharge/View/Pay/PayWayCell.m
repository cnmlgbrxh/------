//
//  PayWayCell.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/20.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "PayWayCell.h"
@interface PayWayCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *labPayWay;

@end

@implementation PayWayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setStrName:(NSString *)strName{
    _strName = strName;
    if ([_strName isEqualToString:@"余额支付"]&&[[UserManager shareManager].usermoney integerValue]<[_strAmount integerValue]) {
         _imageV.image = [UIImage imageNamed:@"shopping_yeb_nor"];
    }else{
        _imageV.image = [UIImage imageNamed:_strName];
    }
    _labPayWay.text = _strName;
}
-(void)setStrAmount:(NSString *)strAmount{
    _strAmount = strAmount;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
