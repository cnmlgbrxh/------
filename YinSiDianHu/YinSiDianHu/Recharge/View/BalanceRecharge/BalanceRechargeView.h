//
//  BalanceRechargeView.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/19.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BalanceRechargeView : UIView

@property (weak,nonatomic) UIViewController *viewController;
@property (assign,nonatomic) BOOL isActive;
//余额充值的金额
@property (copy,nonatomic)void (^BlockAmount)(NSString *);

@end
