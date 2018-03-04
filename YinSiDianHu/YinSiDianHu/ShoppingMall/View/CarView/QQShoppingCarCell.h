//
//  QQShoppingCarCell.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/11.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQShoppingCarModel.h"

#define QQShoppingCarCellID @"QQShoppingCarCellID"
@interface QQShoppingCarCell : UITableViewCell
@property(nonatomic,strong)QQShoppingCarModel *model;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;//左侧选中按钮
@property(nonatomic,copy)void(^shopping_carNumChangeBlock)(BOOL add);
@property(nonatomic,copy)void(^shopping_carLeftSectedBlock)();
@end


@interface QQShoppingCarFootView : UIView
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,assign)NSInteger numCount;
@property(nonatomic,assign)CGFloat priceCount;

@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UIButton *nextBtn;
@property(nonatomic,strong)UILabel *chargesLabel;//运费
@property(nonatomic,strong)UIButton *deleteBtn;
@property(nonatomic,copy)void(^shopping_allSelectedBlock)();
@property(nonatomic,copy)void(^shopping_nextBtnBlock)();
@property(nonatomic,copy)void(^shopping_deleteBtnBlock)();

@end
