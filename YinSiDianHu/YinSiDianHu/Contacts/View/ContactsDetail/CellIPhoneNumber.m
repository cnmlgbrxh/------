//
//  CellIPhoneNumber.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/6.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "CellIPhoneNumber.h"

@interface CellIPhoneNumber ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UILabel *labIponeNumber;

@end

@implementation CellIPhoneNumber

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setPhoneNumber:(LJPhone *)phoneNumber{
    _phoneNumber = phoneNumber;
    _labIponeNumber.text = _phoneNumber.phone;
    if (_phoneNumber.label) {
        _label.text = _phoneNumber.label;
    }else{
        _label.text = @"电话";
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
