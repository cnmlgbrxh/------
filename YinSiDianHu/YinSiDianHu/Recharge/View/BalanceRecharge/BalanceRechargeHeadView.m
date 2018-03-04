//
//  BalanceRechargeHeadView.m
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/19.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "BalanceRechargeHeadView.h"

@interface BalanceRechargeHeadView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutWidth;

@end

@implementation BalanceRechargeHeadView

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        if (ISIPHONE_6) {
            _layoutWidth.constant = 88;
        }else if (ISIPHONE_6P){
            _layoutWidth.constant = 180;
        }
    }
    return self;
}

@end
