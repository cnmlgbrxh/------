//
//  PurchaseNumberView.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchaseNumberView : UIView

@property (weak,nonatomic) UIViewController *viewController;

@property (copy,nonatomic) NSArray *arrData;
//购买成功的消息
@property (copy,nonatomic)void (^BlockSuccess)();

@end
