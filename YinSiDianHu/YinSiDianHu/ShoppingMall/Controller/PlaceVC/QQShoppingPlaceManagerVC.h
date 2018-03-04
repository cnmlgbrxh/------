//
//  QQShoppingPlaceManagerVC.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQBaseVC.h"
#import "QQShoppingAddressListModel.h"

@interface QQShoppingPlaceManagerVC : QQBaseVC
@property(nonatomic,copy)void(^shopping_goolsPlaceBlock)(QQShoppingAddressListModel *model);
@end
