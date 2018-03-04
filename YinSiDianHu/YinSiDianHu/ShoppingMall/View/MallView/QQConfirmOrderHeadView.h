//
//  QQConfirmOrderHeadView.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/12.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQShoppingAddressListModel.h"
#define QQConfirmOrderHeadViewID @"QQConfirmOrderHeadViewID"
@interface QQConfirmOrderHeadView : UITableViewCell
@property(nonatomic,copy)void(^shopping_addPlaceBlock)();
@property (assign,nonatomic)BOOL hiddenTapLabel;
@property(nonatomic,strong)QQShoppingAddressListModel *model;
@property (weak, nonatomic) IBOutlet UIView *orderNumView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderNumViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *arrowBtn;
@property (weak, nonatomic) IBOutlet UILabel *orderNumKeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
