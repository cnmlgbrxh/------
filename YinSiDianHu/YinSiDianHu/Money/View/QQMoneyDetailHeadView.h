//
//  QQMoneyDetailHeadView.h
//  YinSiDianHu
//
//  Created by songdan on 2017/8/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQMoneyListModel.h"
#define QQMoneyDetailHeadViewID @"QQMoneyDetailHeadViewID"

@interface QQMoneyDetailHeadView : UITableViewCell
@property (nonatomic,strong)QQMoneyListProductDetailModel *model;
@end
