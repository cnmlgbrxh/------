//
//  QQAddCarNumChangeCell.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/12.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

#define QQAddCarNumChangeCellID @"QQAddCarNumChangeCellID"
@interface QQAddCarNumChangeCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UIButton *numBtn;
@property (copy,nonatomic) void(^shopping_addCarNumBlock)(NSString *numStr);

@end
