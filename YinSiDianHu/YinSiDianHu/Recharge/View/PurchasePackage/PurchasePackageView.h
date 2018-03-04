//
//  PurchasePackageView.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/19.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchasePackageView : UIView

@property (weak,nonatomic) UIViewController *viewController;

@property (copy,nonatomic)void (^BlockAmount)(NSString *);

@end
