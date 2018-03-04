//
//  QQShoppingIntegralDetailHeadView.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/15.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQShoppingProductDetailModel.h"
#import "QQIntegListModel.h"

#define QQShoppingIntegraDetailTitleCellID @"QQShoppingIntegraDetailTitleCellID"
@interface QQShoppingIntegralDetailHeadView : UIView
@property (nonatomic,strong)QQShoppingProductDetailModel *detailModel;
@property (nonatomic,strong)QQIntegListModel *model;
@end

@interface QQShoppingIntegraDetailTitleCell : UITableViewCell
@property (nonatomic,strong)UILabel *nameLabel;
@end
