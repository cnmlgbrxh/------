//
//  CellPayWay.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/19.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CellPayWay.h"

@interface CellPayWay ()
@property (weak, nonatomic) IBOutlet UIImageView *imageVHead;
@property (weak, nonatomic) IBOutlet UILabel *labPayWay;
@property (weak, nonatomic) IBOutlet UILabel *labSubTitle;

@end
@implementation CellPayWay

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setStrName:(NSString *)strName{
    _strName = strName;
    _labPayWay.text = _strName;
    _imageVHead.image = [UIImage imageNamed:_strName];
}
-(void)setStrMention:(NSString *)strMention{
    _strMention = strMention;
    _labPayWay.text = _strMention;
    if ([_strMention containsString:@"支付宝"])
    {
        _imageVHead.image = [UIImage imageNamed:@"支付宝支付"];
        _labSubTitle.text = @"提现到支付宝";
    }else if ([_strMention containsString:@"银行卡"])
    {
        _imageVHead.image = [UIImage imageNamed:@"银行卡支付"];
        _labSubTitle.text = @"提现到银行卡";
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
