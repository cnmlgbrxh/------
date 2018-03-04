//
//  QQShoppingAddGoolsPlace.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/13.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQBaseVC.h"
#import "QQShoppingAddressListModel.h"

@interface QQShoppingAddGoolsPlace : QQBaseVC
@property(nonatomic,strong)QQShoppingAddressListModel *model;
@property(nonatomic,copy)void(^shopping_addPlaceBlock)(QQShoppingAddressListModel *model);
@property(nonatomic,copy)void(^shopping_editPlaceBlock)(QQShoppingAddressListModel *model);
@end
