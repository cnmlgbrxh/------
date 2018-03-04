//
//  PaymentMethodView.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/20.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentMethodView : UIView

@property (copy,nonatomic) NSString *strAmount;

@property (copy,nonatomic)void (^BlockClose)();

@end
