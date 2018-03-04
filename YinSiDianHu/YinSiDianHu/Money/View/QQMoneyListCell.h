//
//  QQMoneyListCell.h
//  YinSiDianHu
//
//  Created by songdan on 2017/8/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQMoneyListModel.h"

#define QQMoneyListCellID @"QQMoneyListCellID"
#define QQMoneyTableHeadViewID @"QQMoneyTableHeadViewID"
@interface QQMoneyListCell : UITableViewCell
@property (nonatomic,strong)QQMoneyListProductDetailModel *model;
@end


@interface QQMoneyHeadView : UIView
@property(nonatomic,strong)UILabel *titleLabel;
@end


@interface QQMoneyTableHeadView : UIView
@property(nonatomic,strong)UIImageView *headImage;

@end
