//
//  QQMoneyDetaiSecondTitleView.h
//  YinSiDianHu
//
//  Created by songdan on 2017/8/15.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQMoneyListDetailModel.h"

#define QQMoneyDetailExplainID @"QQMoneyDetailExplainID"
@interface QQMoneyDetaiSecondTitleView : UITableViewHeaderFooterView
@property (nonatomic,strong)QQMoneyListDetailModel *model;
@property (nonatomic,strong)void(^money_detailShowMoreBlock)(NSString *rightTitle);
@end



@interface QQMoneyDetailExplain : UITableViewCell
@property(nonatomic,strong)UILabel *titleLabel;
@end
