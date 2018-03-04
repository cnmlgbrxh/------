//
//  FootAlertButtonView.h
//  YinSiDianHu
//
//  Created by 海鸥 on 2017/8/4.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FootAlertButtonView : UICollectionReusableView

@property (copy,nonatomic) NSString *strAlert;

@property (copy,nonatomic) NSString *strButtonTitle;

//支付方式
@property (copy,nonatomic)void (^BlockPayWay)();

@end
