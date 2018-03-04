//
//  QQShoppingAddPlaceCell.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/13.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQShoppingConfirmStyleModel.h"

#define QQShoppingAddPlaceCellID @"QQShoppingAddPlaceCellID"
#define QQShoppingAddPlaceNomalCellID @"QQShoppingAddPlaceNomalCellID"
@interface QQShoppingAddPlaceCell : UITableViewCell

@end


@interface QQShoppingAddPlaceNomalCell : UITableViewCell
@property(nonatomic,strong)UITextField *valueLabel;
@property(nonatomic,strong)QQShoppingConfirmStyleModel *model;
@property(nonatomic,copy)void(^shopping_confirmTextFieldBlcok)(NSString *valueText);
@end
