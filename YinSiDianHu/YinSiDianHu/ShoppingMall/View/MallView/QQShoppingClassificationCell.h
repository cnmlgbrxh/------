//
//  QQShoppingClassificationCell.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/5.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

#define QQShoppingClassificationCellID @"QQShoppingClassificationCellID"
#define QQShoppingClassificationCellClass @"QQShoppingClassificationCell"
#define QQShoppingActivityCellID @"QQShoppingActivityCellID"
#define QQShoppingActivityCellClass @"QQShoppingActivityCell"
@interface QQShoppingClassificationCell : UICollectionViewCell
@property(nonatomic,strong)NSDictionary *dic;
@end

@interface QQShoppingActivityCell : UICollectionViewCell
@property(nonatomic,copy)void(^shopping_ActivityBtnClickblock)(NSInteger tag);
@property(nonatomic,strong)NSString *imageName;
@end

