//
//  PurchasePackageCell.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/19.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "PurchasePackageCell.h"

@interface PurchasePackageCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutLevel;

@property (weak, nonatomic) IBOutlet UILabel *labPrice;

@property (weak, nonatomic) IBOutlet UILabel *labLevel;

@property (weak, nonatomic) IBOutlet UILabel *labSubtitle;

@end
@implementation PurchasePackageCell{
    NSString *strPrice;
    NSString *strLevel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if (ISIPHONE_6) {
        _layoutLevel.constant = 31.5;
    }else if (ISIPHONE_6P){
        _layoutLevel.constant = 38;
        _labPrice.font = [UIFont systemFontOfSize:37];
        _labLevel.font = [UIFont systemFontOfSize:14];
        _labSubtitle.font = [UIFont systemFontOfSize:12];
    }
    
    self.cornerRadius = Scale(2.5);
    self.borderColor = [UIColor blackColor];
    self.borderWidth = Scale(0.5);
}
-(void)setDicValue:(NSDictionary *)dicValue{
    _dicValue = dicValue;
    strPrice = [NSString stringWithFormat:@"%@元",[_dicValue.allKeys firstObject]];
    strLevel = [_dicValue.allValues firstObject];
    if ([[_dicValue.allKeys firstObject] integerValue] == 300) {
        _labSubtitle.text = @"仅限中国大陆手机";
    }
    [self defaultState];
    
}
-(void)setSelected:(BOOL)selected{
    _isSelect = selected;
    if (_isSelect)
    {
        _labPrice.textColor = WHITECOLOR;
        _labLevel.textColor = WHITECOLOR;
        _labSubtitle.textColor = WHITECOLOR;
        self.backgroundColor = ColorHex(0xfe9d47);
    }else{
        self.backgroundColor = WHITECOLOR;
        _labSubtitle.textColor = ColorHex(0xc5c4c4);
        [self defaultState];
    }
    
}
-(void)defaultState{
    // 创建一个富文本
    NSMutableAttributedString *attriPrice =     [[NSMutableAttributedString alloc] initWithString:strPrice];
    
    [attriPrice addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:36] range:NSMakeRange(0, attriPrice.length-1)];
    [attriPrice addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(attriPrice.length-1, 1)];
    // 用label的attributedText属性来使用富文本
    _labPrice.attributedText = attriPrice;
    _labPrice.textColor = ColorHex(0xf77e76);
    
    if (strLevel.length>10) {
        // 创建一个富文本
        NSMutableAttributedString *attriLevel = [[NSMutableAttributedString alloc] initWithString:strLevel];
        [attriLevel addAttribute:NSForegroundColorAttributeName value:ColorHex(0x444444) range:NSMakeRange(0, attriLevel.length-4)];
        [attriLevel addAttribute:NSForegroundColorAttributeName value:ColorHex(0xfe9d47) range:NSMakeRange(attriLevel.length-4, 4)];
        _labLevel.attributedText = attriLevel;
    }else{
        _labLevel.text = strLevel;
        _labLevel.textColor = ColorHex(0x444444);
    }
    
}
@end
