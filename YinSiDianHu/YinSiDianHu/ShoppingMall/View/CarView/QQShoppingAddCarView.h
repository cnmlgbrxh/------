//
//  QQShoppingAddCarView.h
//  YinSiDianHu
//
//  Created by songdan on 2017/7/12.
//  Copyright © 2017年 NumMayScore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQShoppingProductDetailModel.h"

@interface QQShoppingAddCarView : UIView
@property(nonatomic,strong)NSArray *productArray;
@property(nonatomic,strong)NSArray *keyArray;//放product_pd1
@property(nonatomic,strong)QQShoppingProductDetailModel *model;
@property(nonatomic,strong)NSString *pid;//商品id
@property(nonatomic,assign)BOOL addCar;//添加购物车 还是直接购买
@property(nonatomic,copy)void(^shopping_toConfirmOrderVCBlock)(NSString *product_dp,NSString *num);
- (void)show;
- (void)hide;
@end
