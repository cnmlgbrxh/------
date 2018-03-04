//
//  QQAddCarNamePriceCell.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/12.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQShoppingProductDetailModel.h"
#define QQAddCarNamePriceCellID @"QQAddCarNamePriceCellID"
#define QQAddCarHeadViewID @"QQAddCarHeadViewID"
#define QQAddCarPropertyCellID @"QQAddCarPropertyCell"
@interface QQAddCarNamePriceCell : UIView
@property(nonatomic,strong)QQShoppingProductDetailModel *model;
@property(nonatomic,copy)void(^shopping_hiddenGrayViewBlock)();
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewWidth;
@end


@interface QQAddCarHeadView : UICollectionReusableView
@property (nonatomic,strong)UILabel *titleLabel;
@end


@interface QQAddCarPropertyCell : UICollectionViewCell
@property (nonatomic,strong)UILabel *propertyLabel;
@property(nonatomic,strong)NSString *colorStr;
@end
