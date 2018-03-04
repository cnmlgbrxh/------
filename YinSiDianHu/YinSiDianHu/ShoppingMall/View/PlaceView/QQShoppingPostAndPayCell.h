//
//  QQShoppingPostAndPayCell.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/14.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

#define QQShoppingPostAndPayCellID @"QQShoppingPostAndPayCellID"
#define QQShoppingPostAndPayHeadCellID @"QQShoppingPostAndPayHeadCellID"
@interface QQShoppingPostAndPayCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineLeading;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end


@interface QQShoppingPostAndPayHeadCell : UITableViewCell
@property(nonatomic,copy)void(^shopping_payHeadViewBlock)();
@end
