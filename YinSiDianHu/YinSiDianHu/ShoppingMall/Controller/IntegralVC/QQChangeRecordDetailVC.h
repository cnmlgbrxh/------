//
//  QQChangeRecordDetailVC.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/6.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import "QQBaseVC.h"
#import "QQShoppingOrderListModel.h"

@interface QQChangeRecordDetailVC : QQBaseVC
//0:话费 1：现金红包  2：实物
@property(nonatomic,strong)NSString *status;
@property (nonatomic,strong)QQShoppingOrderListModel *model;
@property (nonatomic,copy)void(^integ_configGetGoolsBlock)();
@end
