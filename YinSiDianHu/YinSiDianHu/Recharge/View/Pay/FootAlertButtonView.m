//
//  FootAlertButtonView.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/8/4.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "FootAlertButtonView.h"

@interface FootAlertButtonView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layLabHeight;

@property (weak, nonatomic) IBOutlet UILabel *lab;

@property (weak, nonatomic) IBOutlet UIButton *btnRecharge;

@end

@implementation FootAlertButtonView
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self layout];
    }
    return self;
}
-(void)setStrAlert:(NSString *)strAlert{
    _strAlert = strAlert;
    _lab.font = [UIFont systemFontOfSize:12];
    if (ISIPHONE_6P){
        _lab.font = [UIFont systemFontOfSize:13];
    }
    // 用label的attributedText属性来使用富文本
    _lab.attributedText = [Tools setUpAlertMessage:_strAlert];
    _lab.textColor = ColorHex(0x858585);
    

}
-(void)setStrButtonTitle:(NSString *)strButtonTitle{
    _strButtonTitle = strButtonTitle;
    [_btnRecharge setTitle:_strButtonTitle forState:UIControlStateNormal];
    if ([_strButtonTitle isEqualToString:@"立即充值"]) {
        _layLabHeight.constant = 50;
    }else{
        _layLabHeight.constant = 32;
    }
    if (ISIPHONE_6P) {
        _layLabHeight.constant = 35;
    }
}
- (IBAction)goRecharge:(UIButton *)sender {
    
    if (_BlockPayWay) {
        self.BlockPayWay();
    }
    
}
-(void)layout{
    _layTop.constant = Sc(42);
    _layTop1.constant = Sc(60);
    _layLeft.constant = Sc(123);
    _layHeight.constant = Sc(90);
}

@end
