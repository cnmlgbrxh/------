//
//  CallView.h
//  YinSiDianHu
//
//  Created by Apple on 2017/6/9.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallView : UIView

@property (weak,nonatomic) UIViewController *viewController;
/**
 判断当前是否应该展示手机键盘
 */
@property (copy,nonatomic) NSString *strIsPhoneKeypad;

/**
 联系人列表(当联系人存储数据库完成的提示)
 */
@property (strong,nonatomic) NSArray *arrContactsSave;

@end
