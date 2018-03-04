//
//  QQShoppingSearchResultHeadView.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/8.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>

#define QQShoppingSearchResultHeadViewID @"QQShoppingSearchResultHeadViewID"
#define QQShoppingSearchResultHeadViewClass @"QQShoppingSearchResultHeadView"
@interface QQShoppingSearchResultHeadView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *synthesizeBtn;//综合
@property (nonatomic,copy) void(^shopping_salesBtnClickBlock)(BOOL up);//点击销量
@property (nonatomic,copy) void(^shopping_synthesizeBtnClickBlock)();//点击综合
@property (nonatomic,copy) void(^shopping_priceBtnClickBlock)(BOOL up);//点击价格
@property (nonatomic,copy) void(^shopping_productBtnClickBlock)();//点击新品
@end
