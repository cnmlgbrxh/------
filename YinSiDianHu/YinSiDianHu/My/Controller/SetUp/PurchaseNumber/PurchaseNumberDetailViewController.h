//
//  PurchaseNumberDetailViewController.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/24.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PurchaseNumberDetailViewController : SuperViewController

@property (copy,nonatomic) NSDictionary *dicDetail;
//购买成功的消息
@property (copy,nonatomic)void (^BlockSuccess)();

@end
