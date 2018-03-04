//
//  QQMoneyConfirmCell.h
//  YinSiDianHu
//
//  Created by songdan on 2017/8/15.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQMoneyConfimPayModel.h"

#define QQMoneyConfirmCellID @"QQMoneyConfirmCellID"
@interface QQMoneyConfirmCell : UITableViewCell
@property (nonatomic,strong)QQMoneyConfimPayModel *model;
@property (nonatomic,assign)BOOL isSeleted;
@end
