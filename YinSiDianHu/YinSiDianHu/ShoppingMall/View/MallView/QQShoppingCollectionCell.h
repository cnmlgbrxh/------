//
//  QQShoppingCollectionCell.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/5.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQShoppingMallModel.h"
#define QQShoppingCollectionCellID @"QQShoppingCollectionCellID"
#define QQShoppingCollectionCellClass @"QQShoppingCollectionCell"
@interface QQShoppingCollectionCell : UICollectionViewCell
@property (nonatomic,strong)QQShoppingMallModel *model;
@end
