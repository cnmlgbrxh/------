//
//  ContactView.h
//  YinSiDianHu
//
//  Created by Apple on 2017/6/23.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactView : UIView

@property (nonatomic, copy) NSArray *dataSource;

@property (nonatomic, copy) NSArray *keys;

@property (nonatomic,weak) UIViewController *viewController;

@property (assign,nonatomic) NSInteger intHeight;

///刷新数据
@property (copy,nonatomic)void (^block)();

@end
