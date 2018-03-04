//
//  QQShoppingPlaceManagerCell.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQShoppingAddressListModel.h"
#define QQShoppingPlaceManagerCellID @"QQShoppingPlaceManagerCellID"
@interface QQShoppingPlaceManagerCell : UITableViewCell

@property (nonatomic,strong)QQShoppingAddressListModel *model;
@property (nonatomic,copy)void(^shopping_editPlaceBlock)();
@property (nonatomic,copy)void(^shopping_delPlaceBlock)();
@property (nonatomic,copy)void(^shopping_defultPlaceBlock)();
@end
