//
//  QQShoppingConfirmOrderCell.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/12.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQShoppingConfirmStyleModel.h"
#import "QQShoppingCarModel.h"

#define QQShoppingConfirmOrderCellID @"QQShoppingConfirmOrderCellID"
#define QQShoppingConfirmExplineCellID @"QQShoppingConfirmExplineCellID"
#define QQShoppingConfirmChooseStyleID @"QQShoppingConfirmChooseStyleID"
@interface QQShoppingConfirmOrderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *line;
@property (nonatomic,strong)QQShoppingCarModel *model;
@end


@interface QQShoppingConfirmExplineCell : UITableViewCell

@end


@interface QQShoppingConfirmChooseStyle :UITableViewCell
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)QQShoppingConfirmStyleModel *model;
@end
