//
//  CellPurchaseNumber.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CellPurchaseNumber.h"

@interface CellPurchaseNumber ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutCenter;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBackGround;

@property (weak, nonatomic) IBOutlet UILabel *labNumber;
@property (weak, nonatomic) IBOutlet UILabel *labType;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UILabel *labMonthlyRent;

@end

@implementation CellPurchaseNumber{
    NSString *_strPrice;
    NSString *_strMoney;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    if (ISIPHONE_6P)
    {
        _layoutCenter.constant = 15;
    }
    
}
-(void)setDicDetail:(NSDictionary *)dicDetail{
    _dicDetail = dicDetail;
    _strPrice = [_dicDetail objectForKey:@"buynum"];
    _strMoney = [_dicDetail objectForKey:@"money"];
    
    
    _labNumber.text = [_dicDetail objectForKey:@"name"];
    
    _labType.text = [_dicDetail objectForKey:@"numlevel"];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"选号费%@元",_strPrice]];
    [str addAttribute:NSForegroundColorAttributeName value:COLOR(215, 15, 15) range:NSMakeRange(3,_strPrice.length)];
    _labPrice.attributedText = str;
    
    NSString *strrr;
    if ([[_dicDetail objectForKey:@"time"] isEqualToString:@"year"]) {
        strrr = [NSString stringWithFormat:@"年租费%@/年",_strMoney];
    }else
    {
        strrr = [NSString stringWithFormat:@"月租费%@/月",_strMoney];
    }
    
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:strrr];
    [str1 addAttribute:NSForegroundColorAttributeName value:COLOR(215, 15, 15) range:NSMakeRange(3,_strMoney.length)];
    _labMonthlyRent.attributedText = str1;
    
}
-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    if (_isSelect) {
        _imageViewBackGround.image = [UIImage imageNamed:@"RechargeSelect"];
        _labType.textColor = [UIColor whiteColor];
        _labPrice.textColor = [UIColor whiteColor];
        _labMonthlyRent.textColor = [UIColor whiteColor];
    }else{
        _imageViewBackGround.image = [UIImage imageNamed:@"RechargeRed"];
        _labType.textColor = COLOR(247, 126, 118);
        _labPrice.textColor = COLOR(102, 102, 102);
        _labMonthlyRent.textColor = COLOR(102, 102, 102);
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"选号费%@元",_strPrice]];
        [str addAttribute:NSForegroundColorAttributeName value:COLOR(215, 15, 15) range:NSMakeRange(3,_strPrice.length)];
        _labPrice.attributedText = str;
        
        NSString *strrr;
        if ([[_dicDetail objectForKey:@"time"] isEqualToString:@"year"]) {
            strrr = [NSString stringWithFormat:@"年租费%@/年",_strMoney];
        }else
        {
            strrr = [NSString stringWithFormat:@"月租费%@/月",_strMoney];
        }
        
        NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:strrr];
        [str1 addAttribute:NSForegroundColorAttributeName value:COLOR(215, 15, 15) range:NSMakeRange(3,_strMoney.length)];
        _labMonthlyRent.attributedText = str1;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
