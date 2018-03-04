//
//  PurchasePackageFootView.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/19.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "PurchasePackageFootView.h"

@interface PurchasePackageFootView ()

@property (weak, nonatomic) IBOutlet UILabel *lab;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layTop;

@end
@implementation PurchasePackageFootView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _layTop.constant = Sc(21);
}
-(void)setStrLayout:(NSString *)strLayout{
    _strLayout = strLayout;
    _layTop.constant = Sc(56);
}
-(void)setStrAlert:(NSString *)strAlert{
    _strAlert = strAlert;
    
    // 用label的attributedText属性来使用富文本
    _lab.attributedText = [Tools setUpAlertMessage:_strAlert];
    _lab.textColor = ColorHex(0x858585);
    
    if (ISIPHONE_6P){
        _lab.font = [UIFont systemFontOfSize:13];
    }
}
@end
