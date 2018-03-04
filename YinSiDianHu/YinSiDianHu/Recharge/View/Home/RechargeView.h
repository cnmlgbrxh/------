//
//  RechargeView.h
//  YinSiDianHu
//
//  Created by 海鸥 on 17/7/3.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RechargeView : UIView

@property (weak,nonatomic) UIViewController *viewController;

@property (assign,nonatomic) NSInteger intArc4random;

@property (copy,nonatomic)void (^BlockAmount)(NSString *);

@end
