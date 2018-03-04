//
//  MentionDetailViewController.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/25.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MentionDetailViewController : SuperViewController

/**
 目前两种类型 银行卡支付 支付宝支付
 */
@property (copy,nonatomic) NSString *strPayStyle;

@property (copy,nonatomic) NSString *strAmount;

@end
