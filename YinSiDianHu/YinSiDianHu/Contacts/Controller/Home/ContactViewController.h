//
//  ContactViewController.h
//  YinSiDianHu
//
//  Created by Apple on 2017/6/23.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactViewController : SuperViewController

///返回通知
@property (copy,nonatomic)void (^BlockNotice)();

@end
