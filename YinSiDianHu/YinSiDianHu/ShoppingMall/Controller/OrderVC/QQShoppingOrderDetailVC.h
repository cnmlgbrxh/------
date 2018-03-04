//
//  QQShoppingOrderDetailVC.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQBaseVC.h"
#import "QQShoppingOrderListModel.h"

@interface QQShoppingOrderDetailVC : QQBaseVC
@property(nonatomic,strong)QQShoppingOrderListModel *model;
@property(nonatomic,copy)void(^shopping_deleteOrderBlock)();
@end
