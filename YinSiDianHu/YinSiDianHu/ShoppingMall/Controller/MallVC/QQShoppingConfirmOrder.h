//
//  QQShoppingConfirmOrder.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/12.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQBaseVC.h"
#import "QQShoppingAddressListModel.h"

@interface QQShoppingConfirmOrder : QQBaseVC
@property (nonatomic,strong)NSArray *modelArray;
@property (nonatomic,strong)QQShoppingAddressListModel *addressModel;
@property (nonatomic,strong)NSString *product_dp;
@property (nonatomic,assign)BOOL isCar;//是否是从购物车页面过来
@end
