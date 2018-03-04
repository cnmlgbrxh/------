//
//  QQShoppingOrderDetailGoolsPriceCell.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/17.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQShoppingOrderDetailModel.h"

#define QQShoppingOrderDetailFirstCellID @"QQShoppingOrderDetailFirstCellID"
#define QQShoppingOrderDetailGoolsPriceCellID @"QQShoppingOrderDetailGoolsPriceCellID"
@interface QQShoppingOrderDetailGoolsPriceCell : UITableViewCell
@property(nonatomic,strong)QQShoppingOrderDetailModel *model;
@end


@interface QQShoppingOrderDetailFirstCell : UITableViewCell
@property(nonatomic,strong)NSString *statesStr;
@end
