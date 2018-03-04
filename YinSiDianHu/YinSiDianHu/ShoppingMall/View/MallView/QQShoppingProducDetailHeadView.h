//
//  QQShoppingProducDetailHeadView.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/8.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQShoppingProductDetailModel.h"

#define QQShoppingProducDetailCellID @"QQShoppingProducDetailCellID"
#define QQShoppingDetailDescribeCellID @"QQShoppingDetailDescribeCellID"

@interface QQShoppingProducDetailHeadView : UIView
@property (nonatomic,strong)QQShoppingProductDetailModel *model;
@end

@interface QQShoppingProducDetailCell : UITableViewCell
@property(nonatomic,strong)NSString *urlStr;
@property(nonatomic,strong)UIImageView *detailImageView;
@end


@interface QQShoppingDetailDescribeCell : UITableViewCell
@property (nonatomic,strong)QQShoppingProductDetailModel *model;
@property (nonatomic,strong)UILabel *describeLabel;
@end
