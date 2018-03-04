//
//  QQShoppingOrderListCell.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQShoppingOrderListModel.h"

#define QQShoppingOrderListCellId @"QQShoppingOrderListCellId"
@interface QQShoppingOrderListCell : UITableViewCell
@property (nonatomic,strong)QQShoppingOrderListModel *model;
@property (nonatomic,copy)void(^shopping_orderListCancleBlock)(NSString *titleStr);
@property (nonatomic,copy)void(^shopping_orderListYesBlock)(NSString *titleStr);
@end
