//
//  ContactDetailView.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/7/6.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJPerson.h"
@interface ContactDetailView : UIView

@property (weak,nonatomic) UIViewController *viewController;

@property (strong,nonatomic) LJPerson *person;

@end
