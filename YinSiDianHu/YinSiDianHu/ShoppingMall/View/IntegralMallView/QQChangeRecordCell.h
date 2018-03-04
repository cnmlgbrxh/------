//
//  QQChangeRecordCell.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/6.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQShoppingOrderListModel.h"

#define QQChangeRecordCellID @"QQChangeRecordCellID"
#define QQChangeRecordCellClass @"QQChangeRecordCell"
#define QQChangeTimeCellID @"QQChangeTimeCellID"
#define QQChangeExplianCellID @"QQChangeExplianCellID"
#define QQChangeRecordHeadViewID @"QQChangeRecordHeadViewID"
@interface QQChangeRecordCell : UITableViewCell
@property (nonatomic,strong)QQShoppingOrderListModel *model;
@property (nonatomic,assign)BOOL hiddenBtn;
@property (nonatomic,assign)BOOL hiddenRightBtn;
@property (nonatomic,copy)void(^shopping_changeRecordBlock)();
@end

@interface QQChangeTimeCell : UITableViewCell
@property (nonatomic,strong)NSString *leftLabelStr;
@property (nonatomic,strong)NSString *rightLabelStr;
@end


@interface QQChangeExplianCell : UITableViewCell

@end


@interface QQChangeRecordHeadView : UIView
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *phoneLabel;
@property(nonatomic,strong)UILabel *placeLabel;
@end
