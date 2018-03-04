//
//  QQMoneyPartChooseView.h
//  YinSiDianHu
//
//  Created by songdan on 2017/8/16.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QQMoneyPartChooseView : UIView
@property(nonatomic,strong)void(^money_chooseNumBlock)(NSString *price);
- (void)show;
- (void)hide;
@end
