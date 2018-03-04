//
//  QQShoppingIntegralDetailVC.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/15.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQBaseVC.h"
#import "QQIntegListModel.h"

@interface QQShoppingIntegralDetailVC : QQBaseVC
@property(nonatomic,strong)QQIntegListModel *model;
@property (nonatomic,strong)NSString *score;//积分
@property (nonatomic,strong)NSString *pid;
@end
